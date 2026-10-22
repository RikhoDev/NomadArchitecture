# Proof for Scripts/Test-CanonAuthority.ps1, in a throwaway git repository.
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '..' 'Proof.ps1')
$checkScript = Join-Path $PSScriptRoot '..' 'Test-CanonAuthority.ps1'
$pwsh = (Get-Process -Id $PID).Path

$repo = Join-Path ([IO.Path]::GetTempPath()) ([Guid]::NewGuid())
New-Item -ItemType Directory (Join-Path $repo '.nomad-method') | Out-Null
function Invoke-RepoGit { git -C $repo @args 2>&1 | Out-Null }
Invoke-RepoGit init -q -b main
Invoke-RepoGit config user.email t@example.com
Invoke-RepoGit config user.name t
"Rules.md" | Set-Content (Join-Path $repo '.nomad-method/canon')
"---`nstatus: canon`ndecided_by_assistant: one, two`n---`n`n# Rules`n`n## One`n`n## Two" | Set-Content (Join-Path $repo 'Rules.md')
'x' | Set-Content (Join-Path $repo 'notes.md')
Invoke-RepoGit add -A
Invoke-RepoGit commit -qm 'base'
$base = (git -C $repo rev-parse HEAD)

function Commit([string]$file, [string]$text, [string]$message) {
    $text | Add-Content (Join-Path $repo $file)
    Invoke-RepoGit add -A
    Invoke-RepoGit commit -q -m $message
}
function Check {
    $out = & $pwsh -NoProfile -File $checkScript -Repository $repo -Range "$base..HEAD" 2>&1 | Out-String
    [pscustomobject]@{ Code = $LASTEXITCODE; Text = $out }
    Invoke-RepoGit reset -q --hard $base
}

Commit 'notes.md' 'more' 'A note'
Assert-Promise 'a commit that touches no canon needs no declaration' { (Check).Code -eq 0 }

Commit 'Rules.md' 'More rule.' 'Amend a rule'
Assert-Promise 'a canon commit without Canon-Authority is refused' {
    $r = Check; $r.Code -eq 1 -and $r.Text -match 'declares no Canon-Authority'
}

Commit 'Rules.md' 'More rule.' "Amend a rule`n`nCanon-Authority: review"
Assert-Promise 'a canon commit declared for review passes' { (Check).Code -eq 0 }

Commit 'Rules.md' 'More rule.' "Amend a rule`n`nCanon-Authority: delegated"
Assert-Promise 'a delegated canon commit must quote its delegation' {
    $r = Check; $r.Code -eq 1 -and $r.Text -match 'quotes no Delegation'
}

Commit 'Rules.md' 'More rule.' "Amend a rule`n`nCanon-Authority: delegated`nDelegation: ""do your best"""
Assert-Promise 'a delegated canon commit with its delegation passes' { (Check).Code -eq 0 }

Commit 'Rules.md' 'x' "Amend`n`nCanon-Authority: whoever"
Assert-Promise 'an unknown authority is refused' { (Check).Code -eq 1 }

(Get-Content (Join-Path $repo 'Rules.md')) -replace 'decided_by_assistant: one, two', 'decided_by_assistant: two' | Set-Content (Join-Path $repo 'Rules.md')
Invoke-RepoGit add -A
Invoke-RepoGit commit -q -m "Read section one`n`nCanon-Authority: delegated`nDelegation: ""proceed"""
Assert-Promise 'only a human may clear a section the assistant decided' {
    $r = Check; $r.Code -eq 1 -and $r.Text -match 'clears #one'
}

(Get-Content (Join-Path $repo 'Rules.md')) -replace 'decided_by_assistant: one, two', 'decided_by_assistant: two' | Set-Content (Join-Path $repo 'Rules.md')
Invoke-RepoGit add -A
Invoke-RepoGit commit -q -m "Read section one`n`nCanon-Authority: human"
Assert-Promise 'a human may clear it' { (Check).Code -eq 0 }

Remove-Item -Recurse -Force $repo
Complete-Proof
