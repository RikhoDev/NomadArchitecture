# Proof for the Canon Feature, with a fake header reader: the Feature needs
# only what its contract names.
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '..' 'Canon.ps1')
. (Join-Path $PSScriptRoot '..' '..' '..' '..' '..' 'Scripts' 'Proof.ps1')

$root = Join-Path ([IO.Path]::GetTempPath()) ([Guid]::NewGuid())
New-Item -ItemType Directory (Join-Path $root '.nomad-method') | Out-Null
"# canon`nRules.md`nGuide.md`nGone.md" | Set-Content (Join-Path $root '.nomad-method/canon')
'x' | Set-Content (Join-Path $root 'Rules.md')
'x' | Set-Content (Join-Path $root 'Guide.md')
$headers = @{
    'Rules.md' = @{ status = 'canon'; awaiting_reading = 'feature-readme, folder-grammar' }
    'Guide.md' = @{ status = 'proposed' }
}
$read = { param($p) $headers[(Split-Path $p -Leaf)] }

$canon = @(Get-Canon -Root $root -ReadHeader $read)
Assert-Promise 'lists every entry of the canon list, comments skipped' { $canon.Count -eq 3 -and $canon[0].Path -eq 'Rules.md' }
Assert-Promise 'reports each status as the file declares it' { $canon[0].Status -eq 'canon' -and $canon[1].Status -eq 'proposed' }
Assert-Promise 'names the sections still awaiting the human' {
    ($canon[0].AwaitingReading -join '|') -eq 'feature-readme|folder-grammar' -and $canon[1].AwaitingReading.Count -eq 0
}
Assert-Promise 'says when a listed file is missing' { -not $canon[2].Exists }
Assert-Promise 'a repository without a canon list has no canon' {
    $empty = Join-Path ([IO.Path]::GetTempPath()) ([Guid]::NewGuid()); New-Item -ItemType Directory $empty | Out-Null
    $none = @(Get-Canon -Root $empty -ReadHeader $read); Remove-Item -Recurse -Force $empty; $none.Count -eq 0
}

Remove-Item -Recurse -Force $root
Complete-Proof
