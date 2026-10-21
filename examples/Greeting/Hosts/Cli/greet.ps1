# Cli: a Host. It composes the Greeting Feature into something a person can run,
# and decides how a refused promise is shown to that person:
#   pwsh examples/Greeting/Hosts/Cli/greet.ps1 -Name Alice
param([Parameter(Mandatory = $true)][AllowEmptyString()][string]$Name)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '..' '..' 'Features' 'Greeting' 'Greeting.ps1')
try {
    Get-Greeting -Name $Name
} catch [System.ArgumentException] {
    [Console]::Error.WriteLine("greet: " + $_.Exception.Message)
    exit 2
}
