# Proof for the Greeting promise. Run directly, or through
# Scripts/Test-Repository.ps1. Exits non-zero if any promise is broken.
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '..' 'Greeting.ps1')

. (Join-Path $PSScriptRoot '..' '..' '..' '..' '..' 'Scripts' 'Proof.ps1')

Assert-Promise 'greets a person by name' { (Get-Greeting -Name 'Alice') -eq 'Hello, Alice!' }
Assert-Promise 'ignores surrounding spaces' { (Get-Greeting -Name '  Alice ') -eq 'Hello, Alice!' }
Assert-Promise 'refuses a blank name' {
    try { Get-Greeting -Name '   ' | Out-Null; $false } catch [System.ArgumentException] { $true }
}

Complete-Proof
