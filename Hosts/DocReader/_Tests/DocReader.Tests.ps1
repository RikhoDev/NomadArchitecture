# Proof for the DocReader Host: run its real commands against this repository
# and check what a newcomer would see.
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '..' '..' '..' 'Scripts' 'Proof.ps1')
$reader = Join-Path $PSScriptRoot '..' 'reader.ps1'
$pwsh = (Get-Process -Id $PID).Path

function Invoke-Reader {
    $out = & $pwsh -NoProfile -File $reader @args 2>&1 | Out-String
    [pscustomobject]@{ Text = $out; Code = $LASTEXITCODE }
}

$tour = Invoke-Reader
Assert-Promise 'the tour names every pillar the Host holds, from its READMEs' {
    $tour.Code -eq 0 -and $tour.Text -match 'Features \(WHAT\)' -and $tour.Text -match 'Foundations \(HOW\)' -and
    $tour.Text -match 'Canon' -and $tour.Text -match 'Lineage' -and $tour.Text -match 'Placement' -and $tour.Text -match 'Markdown'
}
Assert-Promise 'the tour explains what is absent on purpose' { $tour.Text -match 'There is no `Core/`' }

$canon = Invoke-Reader canon
Assert-Promise 'canon lists the canon files with their status' {
    $canon.Code -eq 0 -and $canon.Text -match 'Worldview\.md\s+canon' -and $canon.Text -match '__Docs__/Architecture\.md\s+canon'
}
Assert-Promise 'canon shows what still awaits the human' { $canon.Text -match "#feature-readme\s+decided by the assistant; awaiting the human's reading" }

$explain = Invoke-Reader explain 'Hosts/DocReader/Features/Canon/Canon.ps1'
Assert-Promise 'explain reads a path from the inside out' {
    $explain.Code -eq 0 -and $explain.Text -match 'Feature Canon \(WHAT\), inside Host DocReader \(WHY\)'
}
Assert-Promise 'explain names the owner README and its promise' {
    $explain.Text -match 'owner:\s+Hosts/DocReader/Features/Canon/README\.md' -and $explain.Text -match 'Say what binds'
}
$superseded = Invoke-Reader explain '__Docs__/Concepts/PortsAndConnectors.md'
Assert-Promise 'explain points from a superseded document to its replacement' { $superseded.Text -match 'replaced by: __Docs__/Architecture\.md' }

$trail = Invoke-Reader trail 'Worldview.md'
Assert-Promise 'trail lists a document''s Trails' { $trail.Code -eq 0 -and $trail.Text -match 'Worldview\.Trail\.20261021\.md' }

Assert-Promise 'a path is read from the repository root when called from outside it' {
    Push-Location ([IO.Path]::GetTempPath())
    try { (Invoke-Reader explain 'Worldview.md').Text -match '^Worldview\.md' } finally { Pop-Location }
}
Assert-Promise 'an unknown command is refused with code 2' { (Invoke-Reader nonsense).Code -eq 2 }
Assert-Promise 'a missing path is refused with code 1' { (Invoke-Reader explain 'Nowhere/at/all.md').Code -eq 1 }

Complete-Proof
