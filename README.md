# psWarpTerminal

PowerShell wrapper for the Warp Terminal (warp-terminal or Oz) CLI

![PowerShell](https://img.shields.io/badge/PowerShell-7.0%2B-blue)
![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Platform](https://img.shields.io/badge/platform-MacOS-green)
![Platform](https://img.shields.io/badge/platform-Linux-orange)
![License](https://img.shields.io/badge/license-MIT-green)

Idiomatic PowerShell functions that wrap the `warp-terminal` or `oz` CLI, giving you structured objects, pipeline support, and tab-completion instead of raw text output.

## 🎯 Overview

This module exposes 32 public functions covering the full surface of the `warp-terminal` or `oz` CLI. Every function returns parsed `PSCustomObject` output (via `--output-format json` under the hood), so results plug directly into `Format-Table`, `Where-Object`, `Export-Csv`, and the rest of the PowerShell ecosystem.

## Important Note

Both ```warp-terminal``` and ```oz``` CLI are still being developed, so features are not aligned with the Warp Terminal GUI. For example, it's not (yet) possible to create agents, agent profiles, skills, rules, interface with Warp Drive or check billing and usage status. I will try to keep this module updated as often as features change, but feel free to submit PR's for anything you feel would enhance or repair this module. Thank you!

## ✨ Features

- 🤖 **Agent Operations** - Launch local or cloud agents, list available agents and profiles, with automatic conversation continuation
- 📋 **Run Management** - List and inspect ambient agent task runs
- 📦 **Artifact Management** - Fetch metadata for and download files produced by cloud agent runs
- 🌐 **Environment Management** - Create, update, delete, and inspect cloud environments and base images
- 🔐 **Secret Management** - Create, update, delete, and list secrets in Warp's secure storage
- ⏰ **Schedule Management** - Create, update, pause, resume, and delete scheduled (cron) agents
- 🔌 **Integrations** - List, create, and update integrations (Linear, Slack) with full parameter support
- ⚙️ **Settings** - Read and parse the local Warp `settings.toml` into a PowerShell object
- 🧩 **Utility** - List available models, MCP servers, identify the current user, and manage authentication

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

# Schedule a skill instead of a prompt
New-WarpSchedule -Name "nightly-deps" -Cron "0 2 * * *" -Skill "myorg/infra:dep-update"

# Pause / resume a schedule
Suspend-WarpSchedule -Id "sched-id"
Resume-WarpSchedule -Id "sched-id"

# Read local Warp settings
(Get-WarpSettings).appearance.themes.theme
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
| `Invoke-WarpAgent` | Run an agent locally (default) or in the cloud (`-Cloud`). Auto-continues conversations. Supports snapshot control |
| `Get-WarpAgent` | List available agents, optionally filtered by `-Repo` |
| `Get-WarpAgentProfile` | List agent profiles |
| `Get-WarpAgentContext` | Inspect the stored conversation context from the last agent run |
| `Clear-WarpAgentContext` | Reset the conversation context to start a fresh session |

### Runs

| Function | Description |
|---|---|
| `Get-WarpRun` | List runs or get a specific run by `-TaskId` |

### Artifact

| Function | Description |
|---|---|
| `Get-WarpArtifact` | Get metadata for an artifact by `-Uid` |
| `Save-WarpArtifact` | Download an artifact file to disk (supports `-WhatIf`) |

### Environment

| Function | Description |
|---|---|
| `Get-WarpEnvironment` | List environments or get one by `-Id` |
| `New-WarpEnvironment` | Create a cloud environment |
| `Set-WarpEnvironment` | Update an environment's name, image, repos, setup commands, etc. |
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
| `New-WarpSchedule` | Create a scheduled agent with `-Prompt`, `-Skill`, or both |
| `Get-WarpSchedule` | List schedules or get one by `-Id` |
| `Set-WarpSchedule` | Update a schedule's name, cron, prompt, skill, environment, MCP servers, etc. |
| `Remove-WarpSchedule` | Delete a schedule (supports `-WhatIf`) |
| `Suspend-WarpSchedule` | Pause a scheduled agent |
| `Resume-WarpSchedule` | Unpause a scheduled agent |

### Integration

| Function | Description |
|---|---|
| `Get-WarpIntegration` | List integrations |
| `New-WarpIntegration` | Create an integration for a provider (`linear`, `slack`) with environment, MCP, and prompt support |
| `Set-WarpIntegration` | Update an integration's prompt, environment, MCP servers, model, or worker host |

### Settings

| Function | Description |
|---|---|
| `Get-WarpSettings` | Read and parse the local `settings.toml` into a `PSCustomObject`. Auto-detects path on Linux, macOS, and Windows |

### Authentication & Utility

| Function | Description |
|---|---|
| `Connect-Warp` | Log in to Warp |
| `Disconnect-Warp` | Log out (supports `-WhatIf`) |
| `Get-WarpWhoAmI` | Print information about the logged-in user |
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

- 1.4.0 - 2026-05-05
  - Added `Get-WarpSettings` to read and parse the local Warp `settings.toml` into a structured object (cross-platform path detection)
  - Added private `ConvertFrom-Toml` helper for TOML parsing
  - Added `-NoSnapshot`, `-SnapshotUploadTimeout`, and `-SnapshotScriptTimeout` parameters to `Invoke-WarpAgent` (local and cloud)
  - Added `-Repo` parameter to `Get-WarpAgent` to list skills from a specific GitHub repository
  - `New-WarpSchedule` now supports `-Skill` as an alternative to `-Prompt` (or both together), plus `-NoEnvironment`
  - **Upgraded `Set-WarpEnvironment`** from pass-through to explicit parameters: `-Name`, `-Description`, `-RemoveDescription`, `-DockerImage`, `-Repo`, `-RemoveRepo`, `-SetupCommand`, `-RemoveSetupCommand`, `-Force`
  - **Upgraded `Set-WarpSchedule`** from pass-through to explicit parameters: `-Name`, `-Cron`, `-Prompt`, `-Skill`, `-RemoveSkill`, `-Model`, `-Environment`, `-RemoveEnvironment`, `-Mcp`, `-RemoveMcp`, `-ConfigFile`, `-WorkerID`
  - **Upgraded `New-WarpIntegration`** from pass-through to explicit parameters: `-Provider` (linear/slack), `-Prompt`, `-Model`, `-Environment`, `-NoEnvironment`, `-Mcp`, `-ConfigFile`, `-WorkerID`
  - **Upgraded `Set-WarpIntegration`** from pass-through to explicit parameters: `-Provider`, `-Prompt`, `-Model`, `-Environment`, `-RemoveEnvironment`, `-Mcp`, `-RemoveMcp`, `-ConfigFile`, `-WorkerID`
- 1.3.0 - 2026-04-17
  - Added `Get-WarpArtifact` and `Save-WarpArtifact` wrappers for the new `oz artifact` subcommand
  - Added `Get-WarpWhoAmI` wrapper for `oz whoami`
  - Added `-TaskId` parameter to `Invoke-WarpAgent` to continue/resume an existing task
  - Added `-Personal` switch to `Invoke-WarpAgent` (cloud) for symmetry with `-Team`
  - **Breaking:** Removed `-SkillArguments` from `Invoke-WarpAgent`. The underlying `--arg` flag is no longer valid on `oz agent run`; pass skill arguments via `-Prompt` instead (per the CLI's `--skill` help)
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