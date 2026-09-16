[CmdletBinding()]
param(
    [string]$ManuscriptPath = (Join-Path $PSScriptRoot '..\manuscript'),
    [string]$OutputPath = (Join-Path $PSScriptRoot '..\dist\ava-sporelight-manuscript.md')
)

$ErrorActionPreference = 'Stop'

$manuscriptRoot = (Resolve-Path -LiteralPath $ManuscriptPath).Path
$outputFullPath = [IO.Path]::GetFullPath($OutputPath)
$chapterPattern = '^([0-9]{3})-.+\.md$'

$frontMatter = Join-Path $manuscriptRoot '000-front-matter.md'
$backCover = Join-Path $manuscriptRoot 'back-cover.md'
if (-not (Test-Path -LiteralPath $frontMatter -PathType Leaf)) {
    throw "Missing manuscript front matter: $frontMatter"
}
if (-not (Test-Path -LiteralPath $backCover -PathType Leaf)) {
    throw "Missing manuscript back cover: $backCover"
}

$chapters = @(Get-ChildItem -LiteralPath $manuscriptRoot -File -Filter '*.md' |
    Where-Object { $_.Name -match $chapterPattern -and $_.Name -ne '000-front-matter.md' } |
    Sort-Object { [int]$Matches[1] }, Name)

$expectedNumbers = 1..35
$actualNumbers = @($chapters | ForEach-Object {
    if ($_.Name -match $chapterPattern) { [int]$Matches[1] }
})
if (($actualNumbers -join ',') -cne ($expectedNumbers -join ',')) {
    throw "Expected manuscript chapters 001 through 035, found: $($actualNumbers -join ', ')"
}

$sourceFiles = @($frontMatter) + @($chapters.FullName) + @($backCover)
$sections = foreach ($sourceFile in $sourceFiles) {
    [IO.File]::ReadAllText($sourceFile).TrimEnd()
}
$merged = ($sections -join "`r`n`r`n---`r`n`r`n") + "`r`n"

$outputDirectory = Split-Path -Parent $outputFullPath
[IO.Directory]::CreateDirectory($outputDirectory) | Out-Null
$utf8NoBom = [Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllText($outputFullPath, $merged, $utf8NoBom)

Write-Output "Merged $($sourceFiles.Count) manuscript files into $outputFullPath"
