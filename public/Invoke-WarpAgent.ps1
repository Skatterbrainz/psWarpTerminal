function Invoke-WarpAgent {
    <#
    .SYNOPSIS
    Runs a Warp Oz agent locally or in the cloud.

    .DESCRIPTION
    This function invokes the Warp CLI to run an agent. By default the agent runs locally. Use the -Cloud switch to dispatch a remote cloud agent.

    .PARAMETER Prompt
    Required. The prompt for the agent to carry out.

    .PARAMETER Cloud
    Switch to dispatch the agent remotely instead of running locally.

    .PARAMETER Name
    Optional. A name for this agent task.

    .PARAMETER Model
    Optional. Override the base model. Use Get-WarpModel to see available models.

    .PARAMETER Environment
    Optional. Cloud environment ID to use.

    .PARAMETER Skill
    Optional. Skill spec to use as the base prompt (e.g. "repo:skill_name"). When combined with -Prompt, the skill provides the base context and the prompt is the task.

    .PARAMETER SavedPrompt
    Optional. Name of a saved prompt from Warp Drive to use instead of an inline prompt.

    .PARAMETER TaskId
    Local only. Continue or resume an existing agent task by its ID.

    .PARAMETER Conversation
    Optional. Continue an existing conversation by ID.

    .PARAMETER Mcp
    Optional. One or more MCP server specs (path or inline JSON).

    .PARAMETER ConfigFile
    Optional. Path to a YAML or JSON configuration file.

    .PARAMETER Cwd
    Local only. Working directory for the agent.

    .PARAMETER Share
    Local only. Share the session (e.g. "team:view").

    .PARAMETER Profile
    Local only. Agent profile ID to configure the session.

    .PARAMETER Open
    Cloud only. Open the session in Warp once available.

    .PARAMETER Team
    Cloud only. Make the task visible to all team members.

    .PARAMETER Personal
    Cloud only. Create the task as private to your account.

    .PARAMETER NoEnvironment
    Cloud only. Do not run in an environment.

    .PARAMETER WorkerID
    Cloud only. Where the job should be hosted. Use "warp" for Warp infrastructure, or a self-hosted worker name.

    .PARAMETER Agent
    Cloud only. Execute this run as an existing reusable agent UID.

    .PARAMETER Attach
    Cloud only. One or more image file paths to attach (max 5).

    .PARAMETER ComputerUse
    Cloud only. Enable computer use capabilities.

    .PARAMETER NoComputerUse
    Cloud only. Disable computer use capabilities.

    .PARAMETER NoSnapshot
    Disable the end-of-run workspace snapshot upload.

    .PARAMETER SnapshotUploadTimeout
    Maximum time to wait for the end-of-run snapshot upload (e.g. "5m", "300s").

    .PARAMETER SnapshotScriptTimeout
    Maximum time to wait for the declarations script before uploading the snapshot (e.g. "2m").

    .PARAMETER OneShot
    Run without updating conversation context. Does not stash results in LastAgentResult or LastConversationId, and skips auto-continue.

    .PARAMETER Fast
    Low-latency mode. Skips automatic conversation continuation, requests plain text output, bypasses event normalization/post-processing,
    and disables snapshot upload unless explicitly overridden.

    .PARAMETER FastOutputFormat
    Output format used in fast mode streaming. Defaults to `ndjson` so agent events are visible as they arrive.

    .PARAMETER MeasureTiming
    Include execution timing diagnostics in the output. Reports argument-build time, CLI startup time, first output token time, and total duration.

    .EXAMPLE
    Invoke-WarpAgent -Prompt "Build a REST API"

    .EXAMPLE
    Invoke-WarpAgent -Cloud -Prompt "Review open PRs" -Environment "env-id" -Open

    .EXAMPLE
    Invoke-WarpAgent -Skill "myorg/backend:code-review" -Prompt "focus on PR #42 on main branch"

    .EXAMPLE
    Invoke-WarpAgent -SavedPrompt "pr-security-review"

    .EXAMPLE
    Invoke-WarpAgent -Cloud -Conversation "conv_abc123" -Prompt "now add tests"
    #>
    [CmdletBinding(DefaultParameterSetName = 'Local')]
    param(
        [Parameter(Position = 0)]
        [string]$Prompt,

        [Parameter(ParameterSetName = 'Cloud', Mandatory)]
        [switch]$Cloud,

        [string]$Name,
        [string]$Model,
        [string]$Environment,
        [string]$Skill,
        [string]$SavedPrompt,
        [Parameter(ParameterSetName = 'Local')]
        [string]$TaskId,
        [string]$Conversation,
        [string[]]$Mcp,
        [string]$ConfigFile,

        # Local-only
        [Parameter(ParameterSetName = 'Local')]
        [string]$Cwd,
        [Parameter(ParameterSetName = 'Local')]
        [string]$Share,
        [Parameter(ParameterSetName = 'Local')]
        [string]$Profile,

        # Cloud-only
        [Parameter(ParameterSetName = 'Cloud')]
        [switch]$Open,
        [Parameter(ParameterSetName = 'Cloud')]
        [switch]$Team,
        [Parameter(ParameterSetName = 'Cloud')]
        [switch]$Personal,
        [Parameter(ParameterSetName = 'Cloud')]
        [switch]$NoEnvironment,
        [Parameter(ParameterSetName = 'Cloud')]
        [string]$WorkerID,
        [Parameter(ParameterSetName = 'Cloud')]
        [string]$Runner,
        [Parameter(ParameterSetName = 'Cloud')]
        [string]$Agent,
        [Parameter(ParameterSetName = 'Cloud')]
        [string[]]$Attach,
        [Parameter(ParameterSetName = 'Cloud')]
        [switch]$ComputerUse,
        [Parameter(ParameterSetName = 'Cloud')]
        [switch]$NoComputerUse,
        [Parameter(ParameterSetName = 'Cloud')]
        [ValidateSet('oz', 'claude', 'codex')]
        [string]$Harness,
        [Parameter(ParameterSetName = 'Cloud')]
        [string]$ClaudeAuthSecret,
        [Parameter(ParameterSetName = 'Cloud')]
        [string]$CodexAuthSecret,

        # Local-only MCP startup behavior
        [Parameter(ParameterSetName = 'Local')]
        [switch]$StrictMcpStartup,
        [Parameter(ParameterSetName = 'Local')]
        [string]$McpStartupTimeout,

        [switch]$NoSnapshot,
        [string]$SnapshotUploadTimeout,
        [string]$SnapshotScriptTimeout,

        [switch]$OneShot,
        [switch]$Fast,
        [switch]$MeasureTiming,
        [ValidateSet('ndjson', 'pretty', 'text', 'json')]
        [string]$FastOutputFormat = 'ndjson'
    )

    $totalWatch = [System.Diagnostics.Stopwatch]::StartNew()
    $buildWatch = [System.Diagnostics.Stopwatch]::StartNew()

    # Validate required input by mode.
    if ($Cloud.IsPresent) {
        if (-not $Prompt -and -not $SavedPrompt -and -not $Skill) {
            throw 'Cloud runs require one of: -Prompt, -SavedPrompt, or -Skill.'
        }
    } elseif (-not $Prompt -and -not $SavedPrompt -and -not $TaskId -and -not $Skill) {
        throw 'Local runs require one of: -Prompt, -SavedPrompt, -TaskId, or -Skill.'
    }

    # Auto-continue: if no explicit Conversation, try the stashed conversation ID
    $effectiveOneShot = $OneShot.IsPresent -or $Fast.IsPresent

    if (-not $effectiveOneShot -and -not $Conversation -and $script:LastConversationId) {
        Write-Verbose "Auto-continuing conversation: $script:LastConversationId"
        $Conversation = $script:LastConversationId
    }

    $sub = if ($Cloud.IsPresent) { 'run-cloud' } else { 'run' }
    $a = [System.Collections.Generic.List[string]]@('agent', $sub)
    if ($Prompt)      { $a.Add('--prompt'); $a.Add($Prompt) }
    if ($SavedPrompt) { $a.Add('--saved-prompt'); $a.Add($SavedPrompt) }
    if ($TaskId)      { $a.Add('--task-id'); $a.Add($TaskId) }

    if ($Name)         { $a.Add('-n');            $a.Add($Name) }
    if ($Model)        { $a.Add('--model');       $a.Add($Model) }
    if ($Environment)  { $a.Add('-e');            $a.Add($Environment) }
    if ($Skill)        { $a.Add('--skill');       $a.Add($Skill) }
    if ($Conversation) { $a.Add('--conversation');$a.Add($Conversation) }
    if ($ConfigFile)   { $a.Add('-f');            $a.Add($ConfigFile) }
    foreach ($m in $Mcp) { $a.Add('--mcp'); $a.Add($m) }

    # Local params
    if ($Cwd)     { $a.Add('-C');        $a.Add($Cwd) }
    if ($Share)   { $a.Add('--share');   $a.Add($Share) }
    if ($Profile) { $a.Add('--profile'); $a.Add($Profile) }
    if ($StrictMcpStartup.IsPresent) { $a.Add('--strict-mcp-startup') }
    if ($McpStartupTimeout) { $a.Add('--mcp-startup-timeout'); $a.Add($McpStartupTimeout) }

    # Cloud params
    if ($Open.IsPresent)           { $a.Add('--open') }
    if ($Team.IsPresent)           { $a.Add('--team') }
    if ($Personal.IsPresent)       { $a.Add('--personal') }
    if ($NoEnvironment.IsPresent)  { $a.Add('--no-environment') }
    if ($Agent)          { $a.Add('--agent'); $a.Add($Agent) }
    if ($WorkerID)       { $a.Add('--host'); $a.Add($WorkerID) }
    if ($Runner)         { $a.Add('--runner'); $a.Add($Runner) }
    if ($ComputerUse.IsPresent)    { $a.Add('--computer-use') }
    if ($NoComputerUse.IsPresent)  { $a.Add('--no-computer-use') }
    if ($Harness)        { $a.Add('--harness'); $a.Add($Harness) }
    if ($ClaudeAuthSecret) { $a.Add('--claude-auth-secret'); $a.Add($ClaudeAuthSecret) }
    if ($CodexAuthSecret)  { $a.Add('--codex-auth-secret');  $a.Add($CodexAuthSecret) }
    foreach ($att in $Attach) { $a.Add('--attach'); $a.Add($att) }

    # Snapshot params (local + cloud)
    if ($NoSnapshot.IsPresent -or $Fast.IsPresent)       { $a.Add('--no-snapshot') }
    if ($SnapshotUploadTimeout)      { $a.Add('--snapshot-upload-timeout'); $a.Add($SnapshotUploadTimeout) }
    if ($SnapshotScriptTimeout)      { $a.Add('--snapshot-script-timeout'); $a.Add($SnapshotScriptTimeout) }

    $buildWatch.Stop()
    $buildMs = [int][Math]::Round($buildWatch.Elapsed.TotalMilliseconds)

    if ($Fast.IsPresent) {
        if ($MeasureTiming.IsPresent) {
            $timed = Invoke-WarpCli -Arguments $a -RawOutput -OutputFormat $FastOutputFormat -StreamOutput -MeasureTiming
            if (-not $timed) { return }
            $totalWatch.Stop()
            return [PSCustomObject]@{
                Text   = $timed.Output
                Timing = [PSCustomObject]@{
                    ArgumentBuildMs = $buildMs
                    CliStartupMs    = $timed.Timing.CliStartupMs
                    FirstOutputMs   = $timed.Timing.FirstOutputMs
                    CliTotalMs      = $timed.Timing.CliTotalMs
                    TotalMs         = [int][Math]::Round($totalWatch.Elapsed.TotalMilliseconds)
                }
            }
        }

        return Invoke-WarpCli -Arguments $a -RawOutput -OutputFormat $FastOutputFormat -StreamOutput
    }

    $timedResult = $null
    if ($MeasureTiming.IsPresent) {
        $timedResult = Invoke-WarpCli -Arguments $a -MeasureTiming
        if (-not $timedResult) { return }
        $result = $timedResult.Output
    } else {
        $result = Invoke-WarpCli -Arguments $a
    }
    if (-not $result) { return }

    $normalizeWatch = [System.Diagnostics.Stopwatch]::StartNew()

    # Handle both JSON and NDJSON output shapes from agent commands.
    $events = ConvertTo-WarpAgentEvents -InputObject $result

    $convId = $events |
        ForEach-Object {
            if ($_.PSObject.Properties['conversation_id']) { $_.conversation_id }
            elseif ($_.PSObject.Properties['conversationId']) { $_.conversationId }
            elseif ($_.PSObject.Properties['conversation'] -and $_.conversation.id) { $_.conversation.id }
        } |
        Where-Object { $_ } |
        Select-Object -First 1

    if (-not $effectiveOneShot) {
        $script:LastAgentResult = $result
        if ($convId) { $script:LastConversationId = $convId }
    }

    $agentText = @(
        $events | ForEach-Object {
            $type = if ($_.PSObject.Properties['type']) { $_.type } else { $null }
            $eventType = if ($_.PSObject.Properties['event_type']) { $_.event_type } else { $null }
            if ($type -in @('agent', 'assistant') -or $eventType -in @('agent', 'assistant', 'message')) {
                if ($_.PSObject.Properties['text']) { $_.text }
                elseif ($_.PSObject.Properties['content']) {
                    if ($_.content -is [string]) { $_.content }
                    else { $_.content | Out-String }
                }
                elseif ($_.PSObject.Properties['message']) { $_.message }
            }
        }
    ) -join "`n"

    $files = [System.Collections.Generic.List[string]]::new()
    foreach ($ev in $events) {
        if ($ev.PSObject.Properties['file_paths'] -and $ev.file_paths) {
            foreach ($p in @($ev.file_paths)) {
                if ($p) { [void]$files.Add([string]$p) }
            }
        }
        if ($ev.PSObject.Properties['files'] -and $ev.files) {
            foreach ($f in @($ev.files)) {
                if ($f -is [string]) {
                    [void]$files.Add($f)
                } elseif ($f.PSObject.Properties['path'] -and $f.path) {
                    [void]$files.Add([string]$f.path)
                }
            }
        }
    }

    $normalizeWatch.Stop()
    $totalWatch.Stop()

    $output = [PSCustomObject]@{
        ConversationId = $convId
        Text           = $agentText
        Files          = @($files | Select-Object -Unique)
        Events         = $events
    }

    if ($MeasureTiming.IsPresent) {
        $output | Add-Member -NotePropertyName Timing -NotePropertyValue ([PSCustomObject]@{
            ArgumentBuildMs = $buildMs
            CliStartupMs    = $timedResult.Timing.CliStartupMs
            FirstOutputMs   = $timedResult.Timing.FirstOutputMs
            CliTotalMs      = $timedResult.Timing.CliTotalMs
            NormalizeMs     = [int][Math]::Round($normalizeWatch.Elapsed.TotalMilliseconds)
            TotalMs         = [int][Math]::Round($totalWatch.Elapsed.TotalMilliseconds)
        })
    }

    $output
}
