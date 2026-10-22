# DocReader: a Host. It composes its Features and its Foundation into a
# terminal tour of this repository, for a newcomer who wants to know what
# binds here, where things belong, and where they came from.
#
#   pwsh Hosts/DocReader/reader.ps1                 a tour of this Host
#   pwsh Hosts/DocReader/reader.ps1 canon           what binds, and what awaits the human
#   pwsh Hosts/DocReader/reader.ps1 explain <path>  whose meaning a path carries
#   pwsh Hosts/DocReader/reader.ps1 trail <path>    where a document came from
param(
    [Parameter(Position = 0)][string]$Command = 'tour',
    [Parameter(Position = 1)][string]$Target
)
$ErrorActionPreference = 'Stop'
$hostDir = $PSScriptRoot
$root = (Resolve-Path (Join-Path $hostDir '..' '..')).Path

# Composition. The Foundation is loaded first; each Feature receives the
# mechanism it needs as an argument, so no Feature reaches into another pillar.
. (Join-Path $hostDir 'Foundations' 'Markdown' 'Markdown.ps1')
. (Join-Path $hostDir 'Features' 'Canon' 'Canon.ps1')
. (Join-Path $hostDir 'Features' 'Lineage' 'Lineage.ps1')
. (Join-Path $hostDir 'Features' 'Placement' 'Placement.ps1')

$readHeader = { param($path) if (Test-Path -LiteralPath $path -PathType Leaf) { Read-StatusHeader $path } }
$readLead = { param($path) Get-MarkdownLead $path }
$listDocuments = {
    Get-ChildItem -Path $root -Recurse -File -Filter *.md |
        ForEach-Object { [IO.Path]::GetRelativePath($root, $_.FullName).Replace('\', '/') } |
        Where-Object { $_ -notmatch '^\.git/' }
}

function Write-Wrapped([string]$Text, [string]$Indent = '  ') {
    $line = $Indent
    foreach ($word in ($Text -split '\s+' | Where-Object { $_ })) {
        if ($line.Length + $word.Length -gt 78 -and $line.Trim()) { Write-Output $line.TrimEnd(); $line = $Indent }
        $line += "$word "
    }
    if ($line.Trim()) { Write-Output $line.TrimEnd() }
}

function ConvertTo-RepoPath([string]$Path) {
    # A path is read from where the reader was called, if that lands inside
    # this repository; otherwise from the repository root.
    $fromHere = [IO.Path]::GetFullPath($Path, (Get-Location).Path)
    $inside = $fromHere.StartsWith($root.TrimEnd([IO.Path]::DirectorySeparatorChar) + [IO.Path]::DirectorySeparatorChar)
    $full = if ($inside -and (Test-Path -LiteralPath $fromHere)) { $fromHere } else { [IO.Path]::GetFullPath((Join-Path $root $Path)) }
    [IO.Path]::GetRelativePath($root, $full).Replace('\', '/')
}

function Show-Tour {
    $readme = Join-Path $hostDir 'README.md'
    Write-Output 'DocReader, a Host (WHY)'
    Write-Wrapped (Get-MarkdownLead $readme)
    Write-Output ''
    foreach ($pillar in 'Features', 'Foundations', 'Core') {
        $folder = Join-Path $hostDir $pillar
        if (-not (Test-Path $folder)) { continue }
        Write-Output "$pillar ($($script:PillarRoles[$pillar])):"
        foreach ($resident in Get-ChildItem $folder -Directory | Sort-Object Name) {
            Write-Output "  $($resident.Name)"
            Write-Wrapped (Get-MarkdownLead (Join-Path $resident.FullName 'README.md')) '    '
        }
        Write-Output ''
    }
    Write-Output 'Absent on purpose:'
    Write-Wrapped (Get-MarkdownSection $readme 'Absent on purpose')
    Write-Output ''
    Write-Output 'Next: canon, explain <path>, trail <path>.'
}

function Show-Canon {
    $canon = @(Get-Canon -Root $root -ReadHeader $readHeader)
    if (-not $canon) { Write-Output 'No canon list (.nomad-method/canon) in this repository.'; return }
    Write-Output 'What binds here:'
    foreach ($file in $canon) {
        $status = if (-not $file.Exists) { 'MISSING' } else { $file.Status }
        Write-Output ("  {0,-38} {1}" -f $file.Path, $status)
        foreach ($section in $file.DecidedByAssistant) {
            Write-Output "      #$section   decided by the assistant under delegation"
        }
    }
    Write-Output ''
    Write-Wrapped ('Sections the assistant decided bind under the human''s delegation; the human''s reading can overturn any of them. ' +
        'Why: __Docs/README.md#canon.') ''
}

function Show-Explain([string]$Path) {
    $place = Get-Placement -Root $root -Path $Path -ReadLead $readLead
    if (-not $place.Exists) { [Console]::Error.WriteLine("reader: $Path is not in this repository"); exit 1 }
    Write-Output $place.Path
    if ($place.Nesting.Count) {
        $innermostFirst = @($place.Nesting)[($place.Nesting.Count - 1)..0]
        Write-Output ('  is:      ' + (($innermostFirst | ForEach-Object { "$($_.Pillar.TrimEnd('s')) $($_.Name) ($($_.Role))" }) -join ', inside '))
    }
    Write-Output "  world:   $($place.World)"
    $header = & $readHeader (Join-Path $root $place.Path)
    if ($header) { Write-Output "  status:  $($header['status']) $($header['kind'])$(if ($header['origin']) { ", origin $($header['origin'])" })" }
    if ($place.Owner) {
        Write-Output "  owner:   $($place.Owner)"
        Write-Wrapped $place.OwnerLead '           '
    }
    if ($place.Path -like '*.md') {
        $lineage = Get-Lineage -Root $root -Path $place.Path -ReadHeader $readHeader -ListDocuments $listDocuments
        if ($lineage.ReplacedBy.Count) { Write-Output "  replaced by: $($lineage.ReplacedBy[-1])" }
        if ($lineage.Trails.Count) { Write-Output "  trails:  $($lineage.Trails.Count) (see: trail $($place.Path))" }
    }
}

function Show-Trail([string]$Path) {
    if (-not (Test-Path -LiteralPath (Join-Path $root $Path) -PathType Leaf)) { [Console]::Error.WriteLine("reader: $Path is not a document in this repository"); exit 1 }
    $lineage = Get-Lineage -Root $root -Path $Path -ReadHeader $readHeader -ListDocuments $listDocuments
    Write-Output $lineage.Path
    if ($lineage.TrailOf) { Write-Output "  is a Trail of: $($lineage.TrailOf)" }
    if ($lineage.Replaces.Count) { $lineage.Replaces | ForEach-Object { Write-Output "  replaced:      $_" } }
    if ($lineage.ReplacedBy.Count) { Write-Output "  replaced by:   $($lineage.ReplacedBy -join ' > ')" }
    if ($lineage.Trails.Count) { $lineage.Trails | ForEach-Object { Write-Output "  trail:         $_" } }
    if (-not ($lineage.TrailOf -or $lineage.Replaces.Count -or $lineage.ReplacedBy.Count -or $lineage.Trails.Count)) {
        Write-Output '  no recorded lineage: it replaced nothing, nothing replaced it, and it has no Trail.'
    }
}

switch ($Command) {
    'tour' { Show-Tour }
    'canon' { Show-Canon }
    { $_ -in 'explain', 'trail' } {
        if (-not $Target) { [Console]::Error.WriteLine("reader: $Command needs a path"); exit 2 }
        $path = ConvertTo-RepoPath $Target
        if ($Command -eq 'explain') { Show-Explain $path } else { Show-Trail $path }
    }
    default {
        [Console]::Error.WriteLine("reader: unknown command '$Command'. Commands: tour, canon, explain <path>, trail <path>.")
        exit 2
    }
}
