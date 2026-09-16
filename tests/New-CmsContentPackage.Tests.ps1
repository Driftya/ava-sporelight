$ErrorActionPreference = "Stop"

Describe "New-CmsContentPackage" {
    $repositoryRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
    $scriptPath = Join-Path $repositoryRoot "scripts/New-CmsContentPackage.ps1"
    $outputPath = Join-Path $TestDrive "ava-sporelight.cms-package.zip"

    It "builds a complete checksummed package for the collection and 35 chapters" {
        $result = & $scriptPath -OutputPath $outputPath

        $result.PageCount | Should Be 36
        $result.MediaCount | Should BeGreaterThan 0
        $result.MediaFormat | Should Be "webp"
        $result.MediaQuality | Should Be 96
        Test-Path -LiteralPath $outputPath | Should Be $true
        (Get-Item -LiteralPath $outputPath).Length | Should BeLessThan (25 * 1024 * 1024)

        Add-Type -AssemblyName System.IO.Compression.FileSystem
        $extractPath = Join-Path $TestDrive "package"
        [System.IO.Compression.ZipFile]::ExtractToDirectory($outputPath, $extractPath)
        $manifest = Get-Content -LiteralPath (Join-Path $extractPath "manifest.json") -Raw | ConvertFrom-Json
        $checksums = Get-Content -LiteralPath (Join-Path $extractPath "checksums.json") -Raw | ConvertFrom-Json

        $manifest.packageKey | Should Be "ava-sporelight"
        $manifest.pages.Count | Should Be 35
        $manifest.pages[0].slug | Should Be "ava-sporelight-chapter-001"
        $manifest.pages[34].slug | Should Be "ava-sporelight-chapter-035"
        @($manifest.pages | Where-Object pageType -ne "page").Count | Should Be 0
        $manifest.pages[0].summary | Should Be "Before the world learns to fear the spores, a young botanist follows her curiosity into the jungle. Ava’s search for an extraordinary specimen begins with wonder and a quiet sense that she is not alone."
        $manifest.collection.coverMedia | Should Be "media/000/01-cover-image.webp"
        $manifest.collection.pageType | Should Be "collection"
        $manifest.pages[0].coverMedia | Should Be "media/001/01-ava-discovers-bioluminescent-fungus.webp"
        $manifest.media.Count | Should Be $result.MediaCount
        @($manifest.media | Where-Object { $_.source -notlike "*.webp" }).Count | Should Be 0
        ($manifest.psobject.Properties.Name -notcontains "publish") | Should Be $true
        Test-Path -LiteralPath (Join-Path $extractPath "manuscript/back-cover.md") | Should Be $false
        $packagedCollection = Get-Content -LiteralPath (Join-Path $extractPath "pages/collection.md") -Raw
        $packagedCollection | Should Not Match "01-cover-image"
        $packagedCollection | Should Not Match "(?im)^## Table of Contents\s*$"
        $packagedCollection | Should Not Match "001-a-botanists-world\.md"
        (Get-Content -LiteralPath (Join-Path $extractPath "pages/001.md") -Raw) | Should Not Match "01-ava-discovers-bioluminescent-fungus"

        $mediaSources = @($manifest.media | ForEach-Object { $_.source })
        foreach ($page in (@($manifest.collection) + @($manifest.pages))) {
            [string]::IsNullOrWhiteSpace($page.summary) | Should Be $false
            $page.summary.Length | Should BeLessThan 321
            [string]::IsNullOrWhiteSpace($page.seoTitle) | Should Be $false
            $page.seoTitle.Length | Should BeLessThan 52
            [string]::IsNullOrWhiteSpace($page.metaDescription) | Should Be $false
            $page.metaDescription.Length | Should BeLessThan 166
            Test-Path -LiteralPath (Join-Path $extractPath ($page.source -replace '/', [System.IO.Path]::DirectorySeparatorChar)) | Should Be $true
            if ($null -ne $page.coverMedia) {
                ($mediaSources -contains $page.coverMedia) | Should Be $true
                [string]::IsNullOrWhiteSpace($page.coverImageAlt) | Should Be $false
                $page.coverImageAlt.Length | Should BeLessThan 166
            }
            foreach ($relatedMedia in @($page.relatedMedia | Where-Object { $null -ne $_ })) { ($mediaSources -contains $relatedMedia) | Should Be $true }
        }
        foreach ($mediaSource in $mediaSources) {
            $mediaPath = Join-Path $extractPath ($mediaSource -replace '/', [System.IO.Path]::DirectorySeparatorChar)
            Test-Path -LiteralPath $mediaPath | Should Be $true
            $bytes = [System.IO.File]::ReadAllBytes($mediaPath)
            [System.Text.Encoding]::ASCII.GetString($bytes, 0, 4) | Should Be "RIFF"
            [System.Text.Encoding]::ASCII.GetString($bytes, 8, 4) | Should Be "WEBP"
        }

        $packagedFiles = @(Get-ChildItem -LiteralPath $extractPath -File -Recurse | Where-Object Name -ne "checksums.json")
        $checksumProperties = @($checksums.psobject.Properties)
        $checksumProperties.Count | Should Be $packagedFiles.Count
        foreach ($file in $packagedFiles) {
            $relativePath = $file.FullName.Substring($extractPath.Length + 1).Replace([System.IO.Path]::DirectorySeparatorChar, '/')
            $expectedHash = $checksums.$relativePath
            $expectedHash | Should Not BeNullOrEmpty
            (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant() | Should Be $expectedHash
        }
    }

    It "does not overwrite an existing package without Force" {
        & $scriptPath -OutputPath $outputPath -Force | Out-Null
        { & $scriptPath -OutputPath $outputPath } | Should Throw
    }

    It "promotes image 01 to the cover and keeps later ordered images inline" {
        $fixtureRoot = Join-Path $TestDrive "multi-image-repository"
        foreach ($directory in @("scripts", "publishing/cms/pages", "manuscript/images/001")) {
            New-Item -ItemType Directory -Path (Join-Path $fixtureRoot $directory) -Force | Out-Null
        }
        Copy-Item -LiteralPath $scriptPath -Destination (Join-Path $fixtureRoot "scripts/New-CmsContentPackage.ps1")

        $utf8 = New-Object System.Text.UTF8Encoding($false)
        $configuration = [ordered]@{
            schemaVersion = 1
            kind = "book"
            packageKey = "ordered-images"
            culture = "en"
            metadata = [ordered]@{ directory = "publishing/cms/pages"; limits = [ordered]@{ summary = 320; seoTitle = 51; metaDescription = 165; coverImageAlt = 165 } }
            collection = [ordered]@{ source = "manuscript/000-front-matter.md"; slug = "ordered-images"; title = "Ordered Images"; author = "Test Author"; metaKeywords = "ordered images"; robotsPolicy = "noindex" }
            pages = [ordered]@{ sourceDirectory = "manuscript"; expectedCount = 1; slugTemplate = "ordered-images-{chapter:000}"; titleTemplate = "Chapter {chapter}: {title}"; author = "Test Author"; robotsPolicy = "noindex" }
            media = [ordered]@{ outputFormat = "original"; quality = 96 }
        }
        [System.IO.File]::WriteAllText((Join-Path $fixtureRoot "publishing/cms-collection.json"), ($configuration | ConvertTo-Json -Depth 12), $utf8)
        [System.IO.File]::WriteAllText((Join-Path $fixtureRoot "manuscript/000-front-matter.md"), "---`nid: ava-sporelight-front-matter`ntitle: Ordered Images`ntype: front-matter`n---`n# Ordered Images`n`n## Table of Contents`n`n1. [Example](001-example.md)`n`n## Copyright`n`nKeep this section.", $utf8)
        [System.IO.File]::WriteAllText((Join-Path $fixtureRoot "manuscript/001-example.md"), "---`nid: ava-sporelight-chapter-001`nchapter: 1`ntitle: Example`n---`n# Chapter 1`n`n![Cover](images/001/01-cover.png)`n`nOpening text.`n`n![Second scene](images/001/02-second-scene.png)`n`nClosing text.`n`n![Third scene](images/001/03-third-scene.png)`n", $utf8)
        [System.IO.File]::WriteAllText((Join-Path $fixtureRoot "publishing/cms/pages/000-front-matter.json"), '{"schemaVersion":1,"id":"ava-sporelight-front-matter","summary":"Collection summary","seoTitle":"Ordered Images","metaDescription":"An ordered image package."}', $utf8)
        [System.IO.File]::WriteAllText((Join-Path $fixtureRoot "publishing/cms/pages/001-example.json"), '{"schemaVersion":1,"id":"ava-sporelight-chapter-001","summary":"Chapter summary","seoTitle":"Example | Ordered Images","metaDescription":"A chapter with ordered images.","coverImageAlt":"The chapter cover."}', $utf8)
        [System.IO.File]::WriteAllBytes((Join-Path $fixtureRoot "manuscript/images/001/01-cover.png"), [byte[]](1, 2, 3))
        [System.IO.File]::WriteAllBytes((Join-Path $fixtureRoot "manuscript/images/001/02-second-scene.png"), [byte[]](4, 5, 6))
        [System.IO.File]::WriteAllBytes((Join-Path $fixtureRoot "manuscript/images/001/03-third-scene.png"), [byte[]](7, 8, 9))

        $fixtureScript = Join-Path $fixtureRoot "scripts/New-CmsContentPackage.ps1"
        $fixturePackage = Join-Path $TestDrive "ordered-images.zip"
        & $fixtureScript -Manifest (Join-Path $fixtureRoot "publishing/cms-collection.json") -OutputPath $fixturePackage | Out-Null

        $fixtureExtract = Join-Path $TestDrive "ordered-images-package"
        [System.IO.Compression.ZipFile]::ExtractToDirectory($fixturePackage, $fixtureExtract)
        $fixtureManifest = Get-Content -LiteralPath (Join-Path $fixtureExtract "manifest.json") -Raw | ConvertFrom-Json
        $packagedCollection = Get-Content -LiteralPath (Join-Path $fixtureExtract "pages/collection.md") -Raw
        $packagedChapter = Get-Content -LiteralPath (Join-Path $fixtureExtract "pages/001.md") -Raw

        $packagedCollection | Should Not Match "Table of Contents"
        $packagedCollection | Should Not Match "001-example\.md"
        $packagedCollection | Should Match "## Copyright"
        $packagedCollection | Should Match "Keep this section\."
        $fixtureManifest.pages[0].coverMedia | Should Be "media/001/01-cover.png"
        $fixtureManifest.pages[0].pageType | Should Be "page"
        @($fixtureManifest.pages[0].relatedMedia).Count | Should Be 2
        $fixtureManifest.pages[0].relatedMedia[0] | Should Be "media/001/02-second-scene.png"
        $fixtureManifest.pages[0].relatedMedia[1] | Should Be "media/001/03-third-scene.png"
        @($fixtureManifest.media).Count | Should Be 3
        $packagedChapter | Should Not Match "01-cover.png"
        $packagedChapter | Should Match "!\[Second scene\]\(\.\./media/001/02-second-scene.png\)"
        $packagedChapter | Should Match "!\[Third scene\]\(\.\./media/001/03-third-scene.png\)"

        $fixtureChapterPath = Join-Path $fixtureRoot "manuscript/001-example.md"
        $invalidChapter = [System.IO.File]::ReadAllText($fixtureChapterPath, [System.Text.Encoding]::UTF8).Replace("03-third-scene.png", "04-third-scene.png")
        [System.IO.File]::WriteAllText($fixtureChapterPath, $invalidChapter, $utf8)
        Move-Item -LiteralPath (Join-Path $fixtureRoot "manuscript/images/001/03-third-scene.png") -Destination (Join-Path $fixtureRoot "manuscript/images/001/04-third-scene.png")
        { & $fixtureScript -Manifest (Join-Path $fixtureRoot "publishing/cms-collection.json") -OutputPath (Join-Path $TestDrive "invalid-order.zip") } | Should Throw

        [System.IO.File]::WriteAllText($fixtureChapterPath, $invalidChapter.Replace("04-third-scene.png", "03-third-scene.png") + "`n![Remote](https://images.example/remote.png)`n", $utf8)
        Move-Item -LiteralPath (Join-Path $fixtureRoot "manuscript/images/001/04-third-scene.png") -Destination (Join-Path $fixtureRoot "manuscript/images/001/03-third-scene.png")
        { & $fixtureScript -Manifest (Join-Path $fixtureRoot "publishing/cms-collection.json") -OutputPath (Join-Path $TestDrive "external-image.zip") } | Should Throw
    }

    It "rejects a publishing configuration whose chapter count does not match the manuscript" {
        $configuration = Get-Content -LiteralPath (Join-Path $repositoryRoot "publishing/cms-collection.json") -Raw | ConvertFrom-Json
        $configuration.pages.expectedCount = 34
        $invalidManifest = Join-Path $TestDrive "invalid-count.json"
        [System.IO.File]::WriteAllText($invalidManifest, ($configuration | ConvertTo-Json -Depth 12), (New-Object System.Text.UTF8Encoding($false)))

        { & $scriptPath -Manifest $invalidManifest -OutputPath (Join-Path $TestDrive "invalid.zip") } | Should Throw
    }

    It "can build JPEG package media when configured" {
        $configuration = Get-Content -LiteralPath (Join-Path $repositoryRoot "publishing/cms-collection.json") -Raw | ConvertFrom-Json
        $configuration.media.outputFormat = "jpeg"
        $configuration.media.quality = 96
        $jpegManifest = Join-Path $TestDrive "jpeg.json"
        $jpegPackage = Join-Path $TestDrive "jpeg.zip"
        [System.IO.File]::WriteAllText($jpegManifest, ($configuration | ConvertTo-Json -Depth 12), (New-Object System.Text.UTF8Encoding($false)))

        & $scriptPath -Manifest $jpegManifest -OutputPath $jpegPackage | Out-Null
        $jpegExtractPath = Join-Path $TestDrive "jpeg-package"
        [System.IO.Compression.ZipFile]::ExtractToDirectory($jpegPackage, $jpegExtractPath)
        $jpegPackageManifest = Get-Content -LiteralPath (Join-Path $jpegExtractPath "manifest.json") -Raw | ConvertFrom-Json
        @($jpegPackageManifest.media | Where-Object { $_.source -notlike "*.jpg" }).Count | Should Be 0
        foreach ($media in $jpegPackageManifest.media) {
            $bytes = [System.IO.File]::ReadAllBytes((Join-Path $jpegExtractPath ($media.source -replace '/', [System.IO.Path]::DirectorySeparatorChar)))
            $bytes[0] | Should Be 255
            $bytes[1] | Should Be 216
        }
    }
}
