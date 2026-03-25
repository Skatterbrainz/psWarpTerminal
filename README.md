# psWarpTerminal

PowerShell wrapper for the Warp Terminal (warp-terminal or Oz) CLI

![PowerShell](https://img.shields.io/badge/PowerShell-7.0%2B-blue)
![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Platform](https://img.shields.io/badge/platform-MacOS-green)
![Platform](https://img.shields.io/badge/platform-Linux-orange)
![License](https://img.shields.io/badge/license-MIT-green)

Idiomatic PowerShell functions that wrap the `warp-terminal` or `oz` CLI, giving you structured objects, pipeline support, and tab-completion instead of raw text output.

## 🎯 Overview

This module exposes 28 public functions covering the full surface of the `warp-terminal` or `oz` CLI. Every function returns parsed `PSCustomObject` output (via `--output-format json` under the hood), so results plug directly into `Format-Table`, `Where-Object`, `Export-Csv`, and the rest of the PowerShell ecosystem.

## Important Note

Both ```warp-terminal``` and ```oz``` CLI are still being developed, so features are not aligned with the Warp Terminal GUI. For example, it's not (yet) possible to create agents, agent profiles, skills, rules, interface with Warp Drive or check billing and usage status. I will try to keep this module updated as often as features change, but feel free to submit PR's for anything you feel would enhance or repair this module. Thank you!

## ✨ Features

- 🤖 **Agent Operations** - Launch local or cloud agents, list available agents and profiles, with automatic conversation continuation
- 📋 **Run Management** - List and inspect ambient agent task runs
- 🌐 **Environment Management** - Create, update, delete, and inspect cloud environments and base images
- 🔐 **Secret Management** - Create, update, delete, and list secrets in Warp's secure storage
- ⏰ **Schedule Management** - Create, update, pause, resume, and delete scheduled (cron) agents
- 🔌 **Integrations** - List, create, and update integrations
- 🧩 **Utility** - List available models, MCP servers, and manage authentication

## Requirements

- PowerShell 7.0 or higher (tested with 7.5 and 7.6)
- `warp-terminal` CLI installed and in your `PATH`
- A Warp account (authenticate via `Connect-Warp`)

## Installation

### From PowerShell Gallery

```powershell
Install-PsResource psWarpTerminal
```

### From GitHub

1. **Clone the repository**
   ```bash
   git clone https://github.com/ds0934/psWarpTerminal.git
   cd psWarpTerminal
   ```

2. **Import the module**
   ```powershell
   Import-Module ./psWarpTerminal.psd1
   ```

## Usage

Import the module and explore available cmdlets:

```powershell
# Import the module
Import-Module psWarpTerminal

# Get all available cmdlets
Get-Command -Module psWarpTerminal

# Authenticate
Connect-Warp

# Launch a cloud agent
Invoke-WarpAgent -Cloud -Prompt "Build a REST API" -Environment "my-env-id" -Open

# List recent runs
Get-WarpRun -Limit 5

# Inspect a specific run
Get-WarpRun -TaskId "abc123"

# List environments, pipe to delete
Get-WarpEnvironment | Where-Object name -eq "old-env" | Remove-WarpEnvironment

# Create a scheduled agent
New-WarpSchedule -Name "daily-review" -Cron "0 9 * * *" -Prompt "Review open PRs" -Environment "my-env-id"

# Pause / resume a schedule
Suspend-WarpSchedule -Id "sched-id"
Resume-WarpSchedule -Id "sched-id"
```

### 🔄 Conversation Continuation

`Invoke-WarpAgent` automatically tracks conversation context across calls. After the first invocation, follow-on prompts continue the same conversation without needing to pass a conversation ID manually.

```powershell
# Start a new agent conversation
Invoke-WarpAgent -Prompt "Build a REST API"

# Follow-on prompt automatically continues the same conversation
Invoke-WarpAgent -Prompt "Now add unit tests"

# Inspect the stored context
Get-WarpAgentContext

# Start fresh by clearing the context
Clear-WarpAgentContext
Invoke-WarpAgent -Prompt "Something completely different"
```

Use `-Verbose` to see when auto-continuation is applied. You can always override by passing `-Conversation` explicitly.

## 📖 Function Reference

Refer to the [docs](./docs/) folder for current function references. Complete list of exported cmdlets (including conversation context helpers):

### Agent

| Function | Description |
|---|---|
| `Invoke-WarpAgent` | Run an agent locally (default) or in the cloud (`-Cloud`). Auto-continues conversations |
| `Get-WarpAgent` | List available agents |
| `Get-WarpAgentProfile` | List agent profiles |
| `Get-WarpAgentContext` | Inspect the stored conversation context from the last agent run |
| `Clear-WarpAgentContext` | Reset the conversation context to start a fresh session |

### Runs

| Function | Description |
|---|---|
| `Get-WarpRun` | List runs or get a specific run by `-TaskId` |

### Environment

| Function | Description |
|---|---|
| `Get-WarpEnvironment` | List environments or get one by `-Id` |
| `New-WarpEnvironment` | Create a cloud environment |
| `Set-WarpEnvironment` | Update an existing environment |
| `Remove-WarpEnvironment` | Delete an environment (supports `-WhatIf`) |
| `Get-WarpEnvironmentImage` | List available base images |

### Secret

| Function | Description |
|---|---|
| `Get-WarpSecret` | List secrets |
| `New-WarpSecret` | Create a secret |
| `Set-WarpSecret` | Update a secret |
| `Remove-WarpSecret` | Delete a secret (supports `-WhatIf`) |

### Schedule

| Function | Description |
|---|---|
| `New-WarpSchedule` | Create a scheduled agent with a cron expression |
| `Get-WarpSchedule` | List schedules or get one by `-Id` |
| `Set-WarpSchedule` | Update a schedule |
| `Remove-WarpSchedule` | Delete a schedule (supports `-WhatIf`) |
| `Suspend-WarpSchedule` | Pause a scheduled agent |
| `Resume-WarpSchedule` | Unpause a scheduled agent |

### Integration

| Function | Description |
|---|---|
| `Get-WarpIntegration` | List integrations |
| `New-WarpIntegration` | Create an integration |
| `Set-WarpIntegration` | Update an integration |

### Authentication

| Function | Description |
|---|---|
| `Connect-Warp` | Log in to Warp |
| `Disconnect-Warp` | Log out (supports `-WhatIf`) |
| `Get-WarpModel` | List available models |
| `Get-WarpMcp` | List MCP servers |

## Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features or cmdlets
- Improve documentation
- Submit pull requests

Please open an [issue](https://github.com/ds0934/psWarpTerminal/issues) or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Version History

- 1.2.0 - 2026-03-25
  - Added detection for either warp-terminal or oz and process requests accordingly
  - Added -SkillsArguments and -SavedPrompt parameters to Invoke-WarpAgent
    - -Prompt is no longer mandatory if -SavedPrompt is provided
    - -SkillArguments accepts a string array
- 1.1.0 - 2026-02-26
  - Added model tab-completion
  - Fixed handling of JSON response data
  - Fixed issues with context caching for conversation tracking
  - Added functions for conversation history
  - Added New-WarpSchedule
  - Renamed Host_ to WorkerID to match warp-terminal references
  - Added -OneShot parameter to Invoke-WarpAgent to submit prompts without conversation baggage
- 1.0.0 - 2026-02-20
  - Initial release