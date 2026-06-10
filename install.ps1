#Requires -Version 5.1
# KIRA install script — Windows (PowerShell)
# Run from the root of the kira-agent-customization repository:
#   .\install.ps1
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$AgentsSrc = Join-Path $ScriptRoot 'copilot\agents'
$SkillsSrc = Join-Path $ScriptRoot 'copilot\skills'
$PromptsSrc = Join-Path $ScriptRoot 'copilot\prompts'
$InstructionsSrc = Join-Path $ScriptRoot 'copilot\instructions'

# Note: no hard-coded legacy prompt names here. The installer will copy current
# prompt files from the repository into the platform prompts directory and use
# Copy-Item -Force to overwrite existing files. This avoids brittle name-based
# cleanup logic.

$KiraHome = if ($env:KIRA_HOME) { $env:KIRA_HOME } else { Join-Path $env:USERPROFILE '.copilot' }
$AgentsDst = Join-Path $KiraHome 'agents'
$SkillsDst = Join-Path $KiraHome 'skills'
$InstructionsDst = Join-Path $KiraHome 'instructions'

# VS Code reads .prompt.md files from the platform User prompts directory
$PromptsDst = if ($env:VSCODE_PROMPTS_DIR) { $env:VSCODE_PROMPTS_DIR } else { Join-Path $env:APPDATA 'Code\User\prompts' }

# We don't perform aggressive name-based deletions here. Copy operations below
# use -Force to overwrite any existing files that match the repo sources.

$agentCount = 0
$skillCount = 0
$promptCount = 0
$instructionCount = 0

Write-Host 'Installing KIRA agents...'
if (Test-Path -LiteralPath $AgentsSrc -PathType Container) {
    New-Item -ItemType Directory -Force -Path $AgentsDst | Out-Null
    Get-ChildItem -LiteralPath $AgentsSrc -File -Filter '*.agent.md' |
        ForEach-Object {
            Copy-Item -LiteralPath $_.FullName -Destination $AgentsDst -Force
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
                Copy-Item -LiteralPath $skillFile -Destination $dest -Force
                $skillCount++
            }
        }
}

Write-Host 'Installing KIRA prompts...'
if (Test-Path -LiteralPath $PromptsSrc -PathType Container) {
    Get-ChildItem -LiteralPath $PromptsSrc -File -Filter '*.prompt.md' |
        ForEach-Object {
            New-Item -ItemType Directory -Force -Path $PromptsDst | Out-Null
            Copy-Item -LiteralPath $_.FullName -Destination $PromptsDst -Force
            $promptCount++
        }
}

Write-Host 'Installing KIRA instructions...'
if (Test-Path -LiteralPath $InstructionsSrc -PathType Container) {
    Get-ChildItem -LiteralPath $InstructionsSrc -File -Filter '*.instructions.md' |
        ForEach-Object {
            New-Item -ItemType Directory -Force -Path $InstructionsDst | Out-Null
            Copy-Item -LiteralPath $_.FullName -Destination $InstructionsDst -Force
            $instructionCount++
        }
}

Write-Host ''
Write-Host "KIRA installed to $KiraHome"
Write-Host "  Agents  : $agentCount files"
Write-Host "  Skills  : $skillCount folders"
Write-Host "  Prompts : $promptCount files -> $PromptsDst"
Write-Host "  Instructions : $instructionCount files"
