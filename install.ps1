#Requires -Version 5.1
# KIRA install script — Windows (PowerShell)
# Run from the root of the kira-agent-customization repository:
#   .\install.ps1
$ErrorActionPreference = 'Stop'

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

Write-Host 'Installing KIRA agents...'
Get-ChildItem -Path 'copilot\agents' -Filter '*.agent.md' |
    Copy-Item -Destination $AgentsDst

Write-Host 'Installing KIRA skills...'
Get-ChildItem -Path 'copilot\skills' -Directory |
    Where-Object { $_.Name -like 'kira-*' } |
    ForEach-Object {
        $dest = Join-Path $SkillsDst $_.Name
        New-Item -ItemType Directory -Force -Path $dest | Out-Null
        Copy-Item -Path (Join-Path $_.FullName 'SKILL.md') -Destination $dest
    }

Write-Host 'Installing KIRA prompts...'
Get-ChildItem -Path 'copilot\prompts' -Filter '*.prompt.md' |
    Copy-Item -Destination $PromptsDst

$agentCount  = (Get-ChildItem -Path $AgentsDst -File | Where-Object { $_.Name -like 'kira*.agent.md' }).Count
$skillCount  = (Get-ChildItem -Path $SkillsDst -Directory | Where-Object { $_.Name -like 'kira-*' }).Count
$promptCount = (Get-ChildItem -Path $PromptsDst -File -Filter 'kira-*.prompt.md').Count

Write-Host ''
Write-Host "KIRA installed to $KiraHome"
Write-Host "  Agents  : $agentCount files"
Write-Host "  Skills  : $skillCount folders"
Write-Host "  Prompts : $promptCount files"
