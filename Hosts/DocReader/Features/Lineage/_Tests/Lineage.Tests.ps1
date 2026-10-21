# Proof for the Lineage Feature, with fake documents and headers.
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '..' 'Lineage.ps1')
. (Join-Path $PSScriptRoot '..' '..' '..' '..' '..' 'Scripts' 'Proof.ps1')

$root = [IO.Path]::GetTempPath()
$docs = @('docs/Old.md', 'docs/Middle.md', 'docs/New.md', 'docs/New.Trail.20261021.md', 'docs/New.Trail.20250101.md', 'docs/Other.md', 'Loop.md')
$headers = @{
    'docs/Old.md'    = @{ superseded_by = 'Middle.md' }
    'docs/Middle.md' = @{ superseded_by = 'New.md#section' }
    'docs/New.md'    = @{ status = 'canon' }
    'Loop.md'        = @{ superseded_by = 'Loop.md' }
}
$read = { param($p) $headers[[IO.Path]::GetRelativePath($root, $p).Replace('\', '/')] }
$list = { $docs }

$old = Get-Lineage -Root $root -Path 'docs/Old.md' -ReadHeader $read -ListDocuments $list
Assert-Promise 'follows superseded_by to the current document, anchors ignored' { ($old.ReplacedBy -join ' > ') -eq 'docs/Middle.md > docs/New.md' }
$new = Get-Lineage -Root $root -Path 'docs/New.md' -ReadHeader $read -ListDocuments $list
Assert-Promise 'names what a document replaced' { ($new.Replaces -join '|') -eq 'docs/Middle.md' }
Assert-Promise 'finds its Trails beside it, oldest first' { ($new.Trails -join '|') -eq 'docs/New.Trail.20250101.md|docs/New.Trail.20261021.md' }
$trail = Get-Lineage -Root $root -Path 'docs/New.Trail.20261021.md' -ReadHeader $read -ListDocuments $list
Assert-Promise 'a Trail knows its document' { $trail.TrailOf -eq 'docs/New.md' }
Assert-Promise 'a superseded_by loop ends instead of hanging' {
    (Get-Lineage -Root $root -Path 'Loop.md' -ReadHeader $read -ListDocuments $list).ReplacedBy.Count -eq 0
}

Complete-Proof
