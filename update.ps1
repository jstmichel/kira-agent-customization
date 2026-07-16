#Requires -Version 5.1
# KIRA update script — Windows (PowerShell)
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
& (Join-Path $ScriptRoot 'install.ps1') @args
exit $LASTEXITCODE
