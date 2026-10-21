# Proof for the Greeting promise. Run directly, or through
# Scripts/Test-Repository.ps1. Exits non-zero on the first broken promise.
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '..' 'Greeting.ps1')

$failures = 0
function Assert-Promise([string]$Claim, [scriptblock]$Check) {
    try {
        if (& $Check) { Write-Host "  ok   $Claim" }
        else { Write-Host "  FAIL $Claim"; $script:failures++ }
    } catch { Write-Host "  FAIL $Claim ($($_.Exception.Message))"; $script:failures++ }
}

Assert-Promise 'greets a person by name' { (Get-Greeting -Name 'Alice') -eq 'Hello, Alice!' }
Assert-Promise 'ignores surrounding spaces' { (Get-Greeting -Name '  Alice ') -eq 'Hello, Alice!' }
Assert-Promise 'refuses a blank name' {
    try { Get-Greeting -Name '   ' | Out-Null; $false } catch [System.ArgumentException] { $true }
}

if ($failures -gt 0) { exit 1 }
