[CmdletBinding()]
param(
    [string] $Manifest,
    [string] $OutputPath,
    [switch] $Force
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

if ([string]::IsNullOrWhiteSpace($Manifest)) {
    $Manifest = Join-Path $PSScriptRoot "../publishing/cms-collection.json"
}

$script:Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$script:ImagePattern = [regex]::new('!\[(?<alt>[^\]\r\n]*)\]\(\s*<?(?<url>[^\s)>]+)>?(?:\s+(?:"[^"\r\n]*"|''[^''\r\n]*''))?\s*\)', [System.Text.RegularExpressions.RegexOptions]::CultureInvariant)
$script:StandaloneImagePattern = [regex]::new('(?m)^[ \t]*!\[(?<alt>[^\]\r\n]*)\]\(\s*<?(?<url>[^\s)>]+)>?(?:\s+(?:"[^"\r\n]*"|''[^''\r\n]*''))?\s*\)[ \t]*(?:\r?\n)?', [System.Text.RegularExpressions.RegexOptions]::CultureInvariant)
$script:ReferenceStyleImagePattern = [regex]::new('!\[[^\]\r\n]*\]\[[^\]\r\n]*\]|!\[[^\]\r\n]+\](?!\s*[\(\[])', [System.Text.RegularExpressions.RegexOptions]::CultureInvariant)
$script:RawImageElementPattern = [regex]::new('<\s*(?:img|picture|source)\b', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor [System.Text.RegularExpressions.RegexOptions]::CultureInvariant)
$script:TableOfContentsPattern = [regex]::new('^[ \t]{0,3}##[ \t]+Table[ \t]+of[ \t]+Contents[ \t]*(?:\r?\n|$).*?(?=^[ \t]{0,3}#{1,2}(?:[ \t]+|$)|\z)', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor [System.Text.RegularExpressions.RegexOptions]::Multiline -bor [System.Text.RegularExpressions.RegexOptions]::Singleline -bor [System.Text.RegularExpressions.RegexOptions]::CultureInvariant)
$script:AllowedImageExtensions = @(".png", ".jpg", ".jpeg", ".webp")

function Resolve-FullPath {
    param([Parameter(Mandatory = $true)][string] $Path, [Parameter(Mandatory = $true)][string] $BasePath)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return [System.IO.Path]::GetFullPath($Path)
    }

    return [System.IO.Path]::GetFullPath((Join-Path $BasePath $Path))
}

function Resolve-RepositoryPath {
    param([Parameter(Mandatory = $true)][string] $RelativePath, [Parameter(Mandatory = $true)][string] $RepositoryRoot)

    if ([System.IO.Path]::IsPathRooted($RelativePath)) {
        throw "Repository source paths must be relative: $RelativePath"
    }

    $fullPath = [System.IO.Path]::GetFullPath((Join-Path $RepositoryRoot ($RelativePath -replace '/', [System.IO.Path]::DirectorySeparatorChar)))
    $rootPrefix = $RepositoryRoot.TrimEnd([System.IO.Path]::DirectorySeparatorChar) + [System.IO.Path]::DirectorySeparatorChar
    if (-not $fullPath.StartsWith($rootPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Repository source path escapes the repository: $RelativePath"
    }

    return $fullPath
}

function Read-FrontMatterDocument {
    param([Parameter(Mandatory = $true)][string] $Path)

    $text = [System.IO.File]::ReadAllText($Path, [System.Text.Encoding]::UTF8)
    $match = [regex]::Match($text, '\A---\r?\n(?<frontMatter>[\s\S]*?)\r?\n---\r?\n(?<body>[\s\S]*)\z')
    if (-not $match.Success) {
        throw "Markdown file has invalid or missing front matter: $Path"
    }

    $metadata = @{}
    foreach ($line in ($match.Groups["frontMatter"].Value -split '\r?\n')) {
        if ([string]::IsNullOrWhiteSpace($line)) { continue }
        $field = [regex]::Match($line, '^(?<key>[A-Za-z][A-Za-z0-9_-]*):\s*(?<value>.*)$')
        if (-not $field.Success) {
            throw "Unsupported front matter line in ${Path}: $line"
        }

        $value = $field.Groups["value"].Value.Trim()
        if ($value.Length -ge 2 -and $value[0] -eq '"' -and $value[$value.Length - 1] -eq '"') {
            $value = $value | ConvertFrom-Json
        }
        elseif ($value.Length -ge 2 -and $value[0] -eq "'" -and $value[$value.Length - 1] -eq "'") {
            $value = $value.Substring(1, $value.Length - 2).Replace("''", "'")
        }

        if ($metadata.ContainsKey($field.Groups["key"].Value)) {
            throw "Duplicate front matter field in ${Path}: $($field.Groups['key'].Value)"
        }
        $metadata[$field.Groups["key"].Value] = $value
    }

    return [pscustomobject]@{ Metadata = $metadata; Body = $match.Groups["body"].Value }
}

function Expand-Template {
    param([Parameter(Mandatory = $true)][string] $Template, [Parameter(Mandatory = $true)][int] $Chapter, [Parameter(Mandatory = $true)][string] $Title)

    return $Template.Replace("{chapter:000}", $Chapter.ToString("000")).Replace("{chapter}", $Chapter.ToString()).Replace("{title}", $Title)
}

function Test-DisallowedImageReference {
    param([Parameter(Mandatory = $true)][string] $Reference)
    $candidate = $Reference.Trim('<', '>').Trim()
    return $candidate.StartsWith("#") -or
        $candidate.StartsWith("//") -or
        $candidate.StartsWith("\\") -or
        $candidate -match '^(?i:[a-z][a-z0-9+.-]*):'
}

function Get-PackageMediaPath {
    param(
        [Parameter(Mandatory = $true)][string] $Reference,
        [Parameter(Mandatory = $true)][string] $MarkdownPath,
        [Parameter(Mandatory = $true)][string] $RepositoryRoot
    )

    $decodedReference = [System.Uri]::UnescapeDataString($Reference.Trim('<', '>'))
    $sourcePath = [System.IO.Path]::GetFullPath((Join-Path (Split-Path $MarkdownPath -Parent) ($decodedReference -replace '/', [System.IO.Path]::DirectorySeparatorChar)))
    $imagesRoot = [System.IO.Path]::GetFullPath((Join-Path $RepositoryRoot "manuscript/images"))
    $imagesPrefix = $imagesRoot.TrimEnd([System.IO.Path]::DirectorySeparatorChar) + [System.IO.Path]::DirectorySeparatorChar
    if (-not $sourcePath.StartsWith($imagesPrefix, [System.StringComparison]::OrdinalIgnoreCase) -or -not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
        throw "Markdown image does not resolve to a publishable manuscript image: $Reference in $MarkdownPath"
    }

    $extension = [System.IO.Path]::GetExtension($sourcePath).ToLowerInvariant()
    if ($script:AllowedImageExtensions -notcontains $extension) {
        throw "Unsupported CMS image extension: $sourcePath"
    }

    $relativeMediaPath = $sourcePath.Substring($imagesPrefix.Length).Replace([System.IO.Path]::DirectorySeparatorChar, '/')
    if ($script:MediaOutputFormat -ne "original") {
        $outputExtension = if ($script:MediaOutputFormat -eq "webp") { ".webp" } else { ".jpg" }
        $relativeMediaPath = [System.IO.Path]::ChangeExtension($relativeMediaPath, $outputExtension).Replace('\', '/')
    }
    return [pscustomobject]@{ SourcePath = $sourcePath; PackagePath = "media/$relativeMediaPath" }
}

function Write-PackageMedia {
    param(
        [Parameter(Mandatory = $true)][string] $SourcePath,
        [Parameter(Mandatory = $true)][string] $TargetPath
    )

    if ($script:MediaOutputFormat -eq "original") {
        Copy-Item -LiteralPath $SourcePath -Destination $TargetPath
        return
    }

    $arguments = @($SourcePath, "-strip", "-quality", $script:MediaQuality.ToString())
    if ($script:MediaOutputFormat -eq "webp") {
        $arguments += @("-define", "webp:method=6", $TargetPath)
    }
    else {
        $arguments += @("-background", "white", "-alpha", "remove", "-alpha", "off", $TargetPath)
    }

    & $script:ImageMagick.Source @arguments
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath $TargetPath -PathType Leaf)) {
        throw "ImageMagick failed to convert CMS package media: $SourcePath"
    }
}

function Convert-MarkdownForPackage {
    param(
        [Parameter(Mandatory = $true)][string] $Body,
        [Parameter(Mandatory = $true)][string] $MarkdownPath,
        [Parameter(Mandatory = $true)][string] $RepositoryRoot,
        [Parameter(Mandatory = $true)][hashtable] $MediaByPackagePath
    )

    if ($script:ReferenceStyleImagePattern.IsMatch($Body) -or $script:RawImageElementPattern.IsMatch($Body)) {
        throw "CMS packages require inline Markdown image syntax with local manuscript image files: $MarkdownPath"
    }

    $references = New-Object System.Collections.Generic.List[object]
    foreach ($match in $script:ImagePattern.Matches($Body)) {
        $url = $match.Groups["url"].Value
        if (Test-DisallowedImageReference $url) {
            throw "External, embedded, and fragment image sources are not allowed in CMS packages: $url in $MarkdownPath"
        }
        $resolved = Get-PackageMediaPath -Reference $url -MarkdownPath $MarkdownPath -RepositoryRoot $RepositoryRoot
        $fileName = [System.IO.Path]::GetFileName($resolved.SourcePath)
        $orderMatch = [regex]::Match($fileName, '^(?<order>[0-9]{2})-.+')
        if (-not $orderMatch.Success) {
            throw "Manuscript image filename must start with a two-digit order prefix such as '01-': $fileName in $MarkdownPath"
        }

        $expectedOrder = $references.Count + 1
        $actualOrder = [int]$orderMatch.Groups["order"].Value
        if ($actualOrder -ne $expectedOrder) {
            throw "Manuscript images must be referenced in contiguous filename order. Expected $($expectedOrder.ToString('00'))- but found $fileName in $MarkdownPath"
        }

        $reference = [pscustomobject]@{ OriginalUrl = $url; AltText = $match.Groups["alt"].Value; SourcePath = $resolved.SourcePath; PackagePath = $resolved.PackagePath; Order = $actualOrder }
        $references.Add($reference)
        if (-not $MediaByPackagePath.ContainsKey($resolved.PackagePath)) {
            $MediaByPackagePath[$resolved.PackagePath] = [pscustomobject]@{
                source = $resolved.PackagePath
                title = if ([string]::IsNullOrWhiteSpace($reference.AltText)) { [System.IO.Path]::GetFileNameWithoutExtension($reference.SourcePath) } else { $reference.AltText }
                altText = if ([string]::IsNullOrWhiteSpace($reference.AltText)) { $null } else { $reference.AltText }
                sourcePath = $reference.SourcePath
            }
        }
    }

    $cover = $null
    if ($references.Count -gt 0) {
        $cover = $references[0]
        $coverRemoved = $false
        foreach ($standaloneMatch in $script:StandaloneImagePattern.Matches($Body)) {
            if ($cover.OriginalUrl -eq $standaloneMatch.Groups["url"].Value) {
                $Body = $Body.Remove($standaloneMatch.Index, $standaloneMatch.Length)
                $coverRemoved = $true
                break
            }
        }
        if (-not $coverRemoved) {
            throw "The first manuscript image must be a standalone Markdown image so it can be promoted to the cover: $($cover.OriginalUrl) in $MarkdownPath"
        }
    }

    $rewritten = $script:ImagePattern.Replace($Body, [System.Text.RegularExpressions.MatchEvaluator]{
        param($match)
        $url = $match.Groups["url"].Value
        $resolved = Get-PackageMediaPath -Reference $url -MarkdownPath $MarkdownPath -RepositoryRoot $RepositoryRoot
        return $match.Value.Replace($url, "../$($resolved.PackagePath)")
    })

    return [pscustomobject]@{
        Body = $rewritten.Trim()
        CoverMedia = if ($null -eq $cover) { $null } else { $cover.PackagePath }
        CoverAlt = if ($null -eq $cover -or [string]::IsNullOrWhiteSpace($cover.AltText)) { $null } else { $cover.AltText }
        RelatedMedia = @($references | Where-Object { $null -eq $cover -or $_.PackagePath -ne $cover.PackagePath } | ForEach-Object { $_.PackagePath })
    }
}

function Remove-TableOfContents {
    param([Parameter(Mandatory = $true)][string] $Body)

    return $script:TableOfContentsPattern.Replace($Body, "").Trim()
}

function Add-OptionalProperty {
    param([Parameter(Mandatory = $true)] $Object, [Parameter(Mandatory = $true)][string] $Name, $Value)
    if ($null -ne $Value -and -not [string]::IsNullOrWhiteSpace([string]$Value)) {
        if ($Object -is [System.Collections.IDictionary]) {
            $Object[$Name] = $Value
        }
        else {
            $Object | Add-Member -NotePropertyName $Name -NotePropertyValue $Value
        }
    }
}

function Read-CmsPageMetadata {
    param(
        [Parameter(Mandatory = $true)][string] $ManuscriptPath,
        [Parameter(Mandatory = $true)][string] $ExpectedId,
        [Parameter(Mandatory = $true)][string] $MetadataDirectory,
        [Parameter(Mandatory = $true)] $Limits,
        [Parameter(Mandatory = $true)][bool] $HasCoverImage,
        [Parameter(Mandatory = $true)][hashtable] $UsedMetadataFiles
    )

    $metadataPath = Join-Path $MetadataDirectory ([System.IO.Path]::GetFileNameWithoutExtension($ManuscriptPath) + ".json")
    if (-not (Test-Path -LiteralPath $metadataPath -PathType Leaf)) {
        throw "CMS page metadata is missing for ${ExpectedId}: $metadataPath"
    }

    $metadata = [System.IO.File]::ReadAllText($metadataPath, [System.Text.Encoding]::UTF8) | ConvertFrom-Json
    $allowedProperties = @("schemaVersion", "id", "summary", "seoTitle", "metaDescription", "coverImageAlt")
    foreach ($property in $metadata.psobject.Properties) {
        if ($allowedProperties -notcontains $property.Name) {
            throw "Unsupported CMS page metadata property '$($property.Name)' in $metadataPath"
        }
    }
    if ($metadata.schemaVersion -ne 1 -or $metadata.id -ne $ExpectedId) {
        throw "CMS page metadata has an invalid schema version or stable id: $metadataPath"
    }

    foreach ($field in @("summary", "seoTitle", "metaDescription")) {
        $property = $metadata.psobject.Properties[$field]
        if ($null -eq $property -or [string]::IsNullOrWhiteSpace([string]$property.Value)) {
            throw "CMS page metadata field '$field' is required: $metadataPath"
        }
        $maximum = [int]$Limits.$field
        if ([string]$property.Value -ne ([string]$property.Value).Trim() -or ([string]$property.Value).Length -gt $maximum) {
            throw "CMS page metadata field '$field' exceeds its $maximum character limit or has surrounding whitespace: $metadataPath"
        }
    }

    $coverAltProperty = $metadata.psobject.Properties["coverImageAlt"]
    if ($HasCoverImage) {
        if ($null -eq $coverAltProperty -or [string]::IsNullOrWhiteSpace([string]$coverAltProperty.Value)) {
            throw "coverImageAlt is required for a page with a cover image: $metadataPath"
        }
        $coverAltMaximum = [int]$Limits.coverImageAlt
        if ([string]$coverAltProperty.Value -ne ([string]$coverAltProperty.Value).Trim() -or ([string]$coverAltProperty.Value).Length -gt $coverAltMaximum) {
            throw "coverImageAlt exceeds its $coverAltMaximum character limit or has surrounding whitespace: $metadataPath"
        }
    }
    elseif ($null -ne $coverAltProperty -and -not [string]::IsNullOrWhiteSpace([string]$coverAltProperty.Value)) {
        throw "coverImageAlt is only allowed when the manuscript page has a promoted cover image: $metadataPath"
    }

    $UsedMetadataFiles[[System.IO.Path]::GetFullPath($metadataPath)] = $true
    return $metadata
}

$manifestFullPath = Resolve-FullPath -Path $Manifest -BasePath (Get-Location).Path
if (-not (Test-Path -LiteralPath $manifestFullPath -PathType Leaf)) {
    throw "Publishing manifest was not found: $manifestFullPath"
}

$repositoryRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
$configuration = [System.IO.File]::ReadAllText($manifestFullPath, [System.Text.Encoding]::UTF8) | ConvertFrom-Json
if ($configuration.schemaVersion -ne 1 -or $configuration.kind -ne "book" -or [string]::IsNullOrWhiteSpace($configuration.packageKey) -or [string]::IsNullOrWhiteSpace($configuration.culture)) {
    throw "Publishing manifest is invalid or unsupported: $manifestFullPath"
}

$metadataDirectory = Resolve-RepositoryPath -RelativePath $configuration.metadata.directory -RepositoryRoot $repositoryRoot
if (-not (Test-Path -LiteralPath $metadataDirectory -PathType Container)) {
    throw "CMS page metadata directory was not found: $metadataDirectory"
}
$metadataLimits = $configuration.metadata.limits
if ([int]$metadataLimits.summary -lt 1 -or [int]$metadataLimits.summary -gt 320 -or
    [int]$metadataLimits.seoTitle -lt 1 -or [int]$metadataLimits.seoTitle -gt 160 -or
    [int]$metadataLimits.metaDescription -lt 1 -or [int]$metadataLimits.metaDescription -gt 165 -or
    [int]$metadataLimits.coverImageAlt -lt 1 -or [int]$metadataLimits.coverImageAlt -gt 165) {
    throw "CMS page metadata limits must be positive and cannot exceed Driftya's limits."
}
$usedMetadataFiles = @{}

if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    $OutputPath = Join-Path $repositoryRoot "dist/$($configuration.packageKey).cms-package.zip"
}
$outputFullPath = Resolve-FullPath -Path $OutputPath -BasePath (Get-Location).Path
if ((Test-Path -LiteralPath $outputFullPath) -and -not $Force) {
    throw "Output package already exists. Use -Force to replace it: $outputFullPath"
}

$script:MediaOutputFormat = "original"
$script:MediaQuality = 96
if ($null -ne $configuration.media -and $null -ne $configuration.media.outputFormat) {
    $script:MediaOutputFormat = ([string]$configuration.media.outputFormat).Trim().ToLowerInvariant()
}
if ($script:MediaOutputFormat -notin @("original", "webp", "jpeg")) {
    throw "Media outputFormat must be original, webp, or jpeg."
}
if ($null -ne $configuration.media -and $null -ne $configuration.media.quality) {
    $script:MediaQuality = [int]$configuration.media.quality
}
if ($script:MediaQuality -lt 1 -or $script:MediaQuality -gt 100) {
    throw "Media quality must be between 1 and 100."
}
if ($script:MediaOutputFormat -ne "original") {
    $script:ImageMagick = Get-Command magick -CommandType Application -ErrorAction SilentlyContinue
    if ($null -eq $script:ImageMagick) {
        throw "ImageMagick is required for CMS media conversion. Install it or set media.outputFormat to original."
    }
}

$mediaByPackagePath = @{}
$collectionSourcePath = Resolve-RepositoryPath -RelativePath $configuration.collection.source -RepositoryRoot $repositoryRoot
$collectionDocument = Read-FrontMatterDocument -Path $collectionSourcePath
if ($collectionDocument.Metadata["id"] -ne "ava-sporelight-front-matter" -or $collectionDocument.Metadata["type"] -ne "front-matter") {
    throw "Collection source must be the canonical Ava: Sporelight front matter."
}
$collectionBody = Remove-TableOfContents -Body $collectionDocument.Body
$collectionContent = Convert-MarkdownForPackage -Body $collectionBody -MarkdownPath $collectionSourcePath -RepositoryRoot $repositoryRoot -MediaByPackagePath $mediaByPackagePath
$collectionMetadata = Read-CmsPageMetadata -ManuscriptPath $collectionSourcePath -ExpectedId "ava-sporelight-front-matter" -MetadataDirectory $metadataDirectory -Limits $metadataLimits -HasCoverImage ($null -ne $collectionContent.CoverMedia) -UsedMetadataFiles $usedMetadataFiles
if ($null -ne $collectionContent.CoverMedia) {
    $mediaByPackagePath[$collectionContent.CoverMedia].altText = [string]$collectionMetadata.coverImageAlt
}

$chapterDirectory = Resolve-RepositoryPath -RelativePath $configuration.bookPages.sourceDirectory -RepositoryRoot $repositoryRoot
$chapterFiles = @(Get-ChildItem -LiteralPath $chapterDirectory -File -Filter "*.md" | Where-Object { $_.Name -match '^(?<chapter>[0-9]{3})-.+\.md$' -and $Matches["chapter"] -ne "000" } | Sort-Object Name)
$expectedCount = [int]$configuration.bookPages.expectedCount
if ($chapterFiles.Count -ne $expectedCount) {
    throw "Expected $expectedCount numbered chapters but found $($chapterFiles.Count)."
}

$pages = @()
for ($chapter = 1; $chapter -le $expectedCount; $chapter++) {
    $number = $chapter.ToString("000")
    $matches = @($chapterFiles | Where-Object { $_.Name.StartsWith("$number-", [System.StringComparison]::Ordinal) })
    if ($matches.Count -ne 1) {
        throw "Expected exactly one chapter file for chapter $number."
    }

    $document = Read-FrontMatterDocument -Path $matches[0].FullName
    $expectedId = "ava-sporelight-chapter-$number"
    if ($document.Metadata["id"] -ne $expectedId -or [int]$document.Metadata["chapter"] -ne $chapter -or [string]::IsNullOrWhiteSpace($document.Metadata["title"])) {
        throw "Chapter $number has invalid id, chapter number, or title metadata."
    }

    $title = [string]$document.Metadata["title"]
    $content = Convert-MarkdownForPackage -Body $document.Body -MarkdownPath $matches[0].FullName -RepositoryRoot $repositoryRoot -MediaByPackagePath $mediaByPackagePath
    $pageMetadata = Read-CmsPageMetadata -ManuscriptPath $matches[0].FullName -ExpectedId $expectedId -MetadataDirectory $metadataDirectory -Limits $metadataLimits -HasCoverImage ($null -ne $content.CoverMedia) -UsedMetadataFiles $usedMetadataFiles
    if ($null -ne $content.CoverMedia) {
        $mediaByPackagePath[$content.CoverMedia].altText = [string]$pageMetadata.coverImageAlt
    }
    $page = [ordered]@{
        source = "pages/$number.md"
        slug = Expand-Template -Template $configuration.bookPages.slugTemplate -Chapter $chapter -Title $title
        pageType = "bookPage"
        title = Expand-Template -Template $configuration.bookPages.titleTemplate -Chapter $chapter -Title $title
        sortOrder = $chapter
        summary = [string]$pageMetadata.summary
        seoTitle = [string]$pageMetadata.seoTitle
        metaDescription = [string]$pageMetadata.metaDescription
    }
    Add-OptionalProperty -Object $page -Name "author" -Value $configuration.bookPages.author
    Add-OptionalProperty -Object $page -Name "robotsPolicy" -Value $configuration.bookPages.robotsPolicy
    Add-OptionalProperty -Object $page -Name "coverMedia" -Value $content.CoverMedia
    $pageCoverAlt = $pageMetadata.psobject.Properties["coverImageAlt"]
    Add-OptionalProperty -Object $page -Name "coverImageAlt" -Value $(if ($null -eq $pageCoverAlt) { $null } else { $pageCoverAlt.Value })
    if ($content.RelatedMedia.Count -gt 0) { $page["relatedMedia"] = @($content.RelatedMedia) }
    $pages += [pscustomobject]$page
    $matches[0] | Add-Member -NotePropertyName PackageBody -NotePropertyValue $content.Body
}

$metadataFiles = @(Get-ChildItem -LiteralPath $metadataDirectory -File -Filter "*.json")
if ($metadataFiles.Count -ne $usedMetadataFiles.Count -or $metadataFiles.Where({ -not $usedMetadataFiles.ContainsKey($_.FullName) }).Count -gt 0) {
    throw "CMS page metadata must contain exactly one sidecar for the collection and each numbered chapter."
}

$collection = [ordered]@{
    source = "pages/collection.md"
    slug = [string]$configuration.collection.slug
    pageType = "collection"
    title = [string]$configuration.collection.title
    sortOrder = 0
    summary = [string]$collectionMetadata.summary
    seoTitle = [string]$collectionMetadata.seoTitle
    metaDescription = [string]$collectionMetadata.metaDescription
}
foreach ($name in @("metaKeywords", "author", "robotsPolicy")) {
    Add-OptionalProperty -Object $collection -Name $name -Value $configuration.collection.$name
}
Add-OptionalProperty -Object $collection -Name "coverMedia" -Value $collectionContent.CoverMedia
$collectionCoverAlt = $collectionMetadata.psobject.Properties["coverImageAlt"]
Add-OptionalProperty -Object $collection -Name "coverImageAlt" -Value $(if ($null -eq $collectionCoverAlt) { $null } else { $collectionCoverAlt.Value })
if ($collectionContent.RelatedMedia.Count -gt 0) { $collection["relatedMedia"] = @($collectionContent.RelatedMedia) }

$packageManifest = [ordered]@{
    schemaVersion = 1
    kind = "book"
    packageKey = [string]$configuration.packageKey
    culture = [string]$configuration.culture
    collection = [pscustomobject]$collection
    pages = @($pages)
    media = @($mediaByPackagePath.Values | Sort-Object source | ForEach-Object {
        [ordered]@{ source = $_.source; title = $_.title; altText = $_.altText }
    })
}

$temporaryRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("ava-cms-package-" + [guid]::NewGuid().ToString("N"))
try {
    New-Item -ItemType Directory -Path (Join-Path $temporaryRoot "pages") -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $temporaryRoot "media") -Force | Out-Null
    [System.IO.File]::WriteAllText((Join-Path $temporaryRoot "manifest.json"), ($packageManifest | ConvertTo-Json -Depth 12), $script:Utf8NoBom)
    [System.IO.File]::WriteAllText((Join-Path $temporaryRoot "pages/collection.md"), $collectionContent.Body, $script:Utf8NoBom)
    foreach ($chapterFile in $chapterFiles) {
        $number = $chapterFile.Name.Substring(0, 3)
        [System.IO.File]::WriteAllText((Join-Path $temporaryRoot "pages/$number.md"), [string]$chapterFile.PackageBody, $script:Utf8NoBom)
    }
    foreach ($media in $mediaByPackagePath.Values) {
        $target = Join-Path $temporaryRoot ($media.source -replace '/', [System.IO.Path]::DirectorySeparatorChar)
        New-Item -ItemType Directory -Path (Split-Path $target -Parent) -Force | Out-Null
        Write-PackageMedia -SourcePath $media.sourcePath -TargetPath $target
    }

    $checksums = [ordered]@{}
    foreach ($file in (Get-ChildItem -LiteralPath $temporaryRoot -File -Recurse | Sort-Object FullName)) {
        $relativePath = $file.FullName.Substring($temporaryRoot.Length + 1).Replace([System.IO.Path]::DirectorySeparatorChar, '/')
        $checksums[$relativePath] = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
    }
    [System.IO.File]::WriteAllText((Join-Path $temporaryRoot "checksums.json"), ($checksums | ConvertTo-Json -Depth 4), $script:Utf8NoBom)

    $outputDirectory = Split-Path $outputFullPath -Parent
    if (-not (Test-Path -LiteralPath $outputDirectory)) { New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null }
    if (Test-Path -LiteralPath $outputFullPath) { Remove-Item -LiteralPath $outputFullPath -Force }
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::CreateFromDirectory($temporaryRoot, $outputFullPath, [System.IO.Compression.CompressionLevel]::Optimal, $false)
}
finally {
    if (Test-Path -LiteralPath $temporaryRoot) { Remove-Item -LiteralPath $temporaryRoot -Recurse -Force }
}

Write-Output ([pscustomobject]@{
    PackagePath = $outputFullPath
    PageCount = $pages.Count + 1
    MediaCount = $mediaByPackagePath.Count
    MediaFormat = $script:MediaOutputFormat
    MediaQuality = $script:MediaQuality
    PackageKey = $configuration.packageKey
})
