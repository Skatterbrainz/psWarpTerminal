# Change Log

## Version History

- 1.5.0 - 2026-06-08
  - Added reusable agent management cmdlets: `New-WarpAgent`, `Set-WarpAgent`, and `Remove-WarpAgent`
  - Added API key management cmdlets: `Get-WarpApiKey`, `New-WarpApiKey`, and `Remove-WarpApiKey`
  - Added `Get-WarpSkill` for `oz agent skills` (including `-Repo` filtering)
  - Added `Get-WarpFederatedToken` wrapper for `oz federate issue-token`
  - Updated `Get-WarpAgent` to align with current Oz CLI behavior (`agent list` / `agent get`)
  - Updated `Invoke-WarpAgent`:
    - Added cloud `-Agent` parameter (`--agent`)
    - Restricted `-TaskId` to local runs
    - Added explicit cloud/local required argument validation
  - Expanded `Get-WarpRun` list filters to support current `oz run list` options
  - Updated CLI discovery to include `oz-preview` fallback in `Invoke-WarpCli`

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
