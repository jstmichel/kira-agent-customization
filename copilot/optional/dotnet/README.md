# Optional .NET Pack

This add-on keeps the core Kira pack language-agnostic while preserving the .NET-specific workflows.

## Included When Enabled

- `skills/kira-coverage-analysis`
- `skills/kira-ef-migration-workflow`
- `instructions/kira-csharp-conventions.instructions.md`

## Install

### macOS / Linux

```bash
KIRA_INCLUDE_DOTNET=1 ./install.sh
```

### Windows PowerShell

```powershell
$env:KIRA_INCLUDE_DOTNET=1
.\install.ps1
```

Without that environment variable, these assets are not installed.
