#Requires -Version 5.1
# KIRA install script — Windows (PowerShell)
# Run from the root of the kira-agent-customization repository:
#   .\install.ps1
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$AgentsSrc = Join-Path $ScriptRoot 'copilot\agents'
$SkillsSrc = Join-Path $ScriptRoot 'copilot\skills'
$PromptsSrc = Join-Path $ScriptRoot 'copilot\prompts'

$KiraHome  = Join-Path $env:USERPROFILE '.copilot'
$AgentsDst = Join-Path $KiraHome 'agents'
$SkillsDst = Join-Path $KiraHome 'skills'
$PromptsDst = Join-Path $KiraHome 'prompts'

# Ensure destination directories exist
@($AgentsDst, $SkillsDst, $PromptsDst) | ForEach-Object {
    New-Item -ItemType Directory -Force -Path $_ | Out-Null
}

Write-Host 'Removing existing KIRA files...'

# Agents — KIRA-managed agents and any stale prior conversation agent names
Get-ChildItem -Path $AgentsDst -File |
    Where-Object {
        $_.Name -eq 'kira.agent.md' -or
        $_.Name -like 'kira-*.agent.md' -or
        $_.Name -eq 'kira-aura.agent.md' -or
        $_.Name -eq 'kira-companion.agent.md' -or
        $_.Name -eq 'mila.agent.md'
    } |
    Remove-Item -Force

# Skills — any folder named kira-*
Get-ChildItem -Path $SkillsDst -Directory |
    Where-Object { $_.Name -like 'kira-*' } |
    Remove-Item -Recurse -Force

# Prompts — kira-*.prompt.md
Get-ChildItem -Path $PromptsDst -File -Filter 'kira-*.prompt.md' |
    Remove-Item -Force

$agentCount = 0
$skillCount = 0
$promptCount = 0

Write-Host 'Installing KIRA agents...'
if (Test-Path -LiteralPath $AgentsSrc -PathType Container) {
    Get-ChildItem -LiteralPath $AgentsSrc -File -Filter '*.agent.md' |
        ForEach-Object {
            Copy-Item -LiteralPath $_.FullName -Destination $AgentsDst
            $agentCount++
        }
}

Write-Host 'Installing KIRA skills...'
if (Test-Path -LiteralPath $SkillsSrc -PathType Container) {
    Get-ChildItem -LiteralPath $SkillsSrc -Directory |
        ForEach-Object {
            $skillFile = Join-Path $_.FullName 'SKILL.md'
            if (Test-Path -LiteralPath $skillFile -PathType Leaf) {
                $dest = Join-Path $SkillsDst $_.Name
                New-Item -ItemType Directory -Force -Path $dest | Out-Null
                Copy-Item -LiteralPath $skillFile -Destination $dest
                $skillCount++
            }
        }
}

Write-Host 'Installing KIRA prompts...'
if (Test-Path -LiteralPath $PromptsSrc -PathType Container) {
    Get-ChildItem -LiteralPath $PromptsSrc -File -Filter '*.prompt.md' |
        ForEach-Object {
            Copy-Item -LiteralPath $_.FullName -Destination $PromptsDst
            $promptCount++
        }
}

Write-Host ''
Write-Host "KIRA installed to $KiraHome"
Write-Host "  Agents  : $agentCount files"
Write-Host "  Skills  : $skillCount folders"
Write-Host "  Prompts : $promptCount files"
