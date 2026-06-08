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

    .EXAMPLE
    Invoke-WarpAgent -Prompt "Build a REST API"

    .EXAMPLE
    Invoke-WarpAgent -Cloud -Prompt "Review open PRs" -Environment "env-id" -Open

    .EXAMPLE
    Invoke-WarpAgent -Skill "myorg/backend:code-review" -Prompt "focus on PR #42 on main branch"

    .EXAMPLE
    Invoke-WarpAgent -SavedPrompt "pr-security-review"

    .EXAMPLE
    Invoke-WarpAgent -Cloud -TaskId "task-abc123" -Prompt "now add tests"
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
        [string]$Agent,
        [Parameter(ParameterSetName = 'Cloud')]
        [string[]]$Attach,
        [Parameter(ParameterSetName = 'Cloud')]
        [switch]$ComputerUse,
        [Parameter(ParameterSetName = 'Cloud')]
        [switch]$NoComputerUse,

        [switch]$NoSnapshot,
        [string]$SnapshotUploadTimeout,
        [string]$SnapshotScriptTimeout,

        [switch]$OneShot
    )

    # Validate required input by mode.
    if ($Cloud.IsPresent) {
        if (-not $Prompt -and -not $SavedPrompt -and -not $Skill) {
            throw 'Cloud runs require one of: -Prompt, -SavedPrompt, or -Skill.'
        }
    } elseif (-not $Prompt -and -not $SavedPrompt -and -not $TaskId -and -not $Skill) {
        throw 'Local runs require one of: -Prompt, -SavedPrompt, -TaskId, or -Skill.'
    }

    # Auto-continue: if no explicit Conversation, try the stashed conversation ID
    if (-not $OneShot -and -not $Conversation -and $script:LastConversationId) {
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

    # Cloud params
    if ($Open.IsPresent)           { $a.Add('--open') }
    if ($Team.IsPresent)           { $a.Add('--team') }
    if ($Personal.IsPresent)       { $a.Add('--personal') }
    if ($NoEnvironment.IsPresent)  { $a.Add('--no-environment') }
    if ($Agent)          { $a.Add('--agent'); $a.Add($Agent) }
    if ($WorkerID)       { $a.Add('--host'); $a.Add($WorkerID) }
    if ($ComputerUse.IsPresent)    { $a.Add('--computer-use') }
    if ($NoComputerUse.IsPresent)  { $a.Add('--no-computer-use') }
    foreach ($att in $Attach) { $a.Add('--attach'); $a.Add($att) }

    # Snapshot params (local + cloud)
    if ($NoSnapshot.IsPresent)       { $a.Add('--no-snapshot') }
    if ($SnapshotUploadTimeout)      { $a.Add('--snapshot-upload-timeout'); $a.Add($SnapshotUploadTimeout) }
    if ($SnapshotScriptTimeout)      { $a.Add('--snapshot-script-timeout'); $a.Add($SnapshotScriptTimeout) }

    $result = Invoke-WarpCli -Arguments $a
    if ($result) {
        # Parse NDJSON events and extract key fields
        $events = $result -split "`n" | Where-Object { $_.Trim() -ne '' } | ForEach-Object {
            try { $_ | ConvertFrom-Json } catch {}
        }

        $convId = ($events | Where-Object type -eq 'system' | Select-Object -First 1).conversation_id

        if (-not $OneShot.IsPresent) {
            $script:LastAgentResult = $result
            if ($convId) { $script:LastConversationId = $convId }
        }

        $agentText = ($events | Where-Object type -eq 'agent').text -join "`n"
        $files = @($events | Where-Object type -eq 'tool_call' |
            ForEach-Object { $_.file_paths } | Where-Object { $_ })

        [PSCustomObject]@{
            ConversationId = $convId
            Text           = $agentText
            Files          = $files
            Events         = $events
        }
    }
}
