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
    Optional. Skill spec to use as the base prompt (e.g. "repo:skill_name").

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

    .PARAMETER NoEnvironment
    Cloud only. Do not run in an environment.

    .PARAMETER WorkerID
    Cloud only. Where the job should be hosted. Use "warp" for Warp infrastructure, or a self-hosted worker name.

    .PARAMETER Attach
    Cloud only. One or more image file paths to attach (max 5).

    .PARAMETER ComputerUse
    Cloud only. Enable computer use capabilities.

    .PARAMETER NoComputerUse
    Cloud only. Disable computer use capabilities.

    .PARAMETER OneShot
    Run without updating conversation context. Does not stash results in LastAgentResult or LastConversationId, and skips auto-continue.

    .EXAMPLE
    Invoke-WarpAgent -Prompt "Build a REST API"

    .EXAMPLE
    Invoke-WarpAgent -Cloud -Prompt "Review open PRs" -Environment "env-id" -Open
    #>
    [CmdletBinding(DefaultParameterSetName = 'Local')]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Prompt,

        [Parameter(ParameterSetName = 'Cloud', Mandatory)]
        [switch]$Cloud,

        [string]$Name,
        [string]$Model,
        [string]$Environment,
        [string]$Skill,
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
        [switch]$NoEnvironment,
        [Parameter(ParameterSetName = 'Cloud')]
        [string]$WorkerID,
        [Parameter(ParameterSetName = 'Cloud')]
        [string[]]$Attach,
        [Parameter(ParameterSetName = 'Cloud')]
        [switch]$ComputerUse,
        [Parameter(ParameterSetName = 'Cloud')]
        [switch]$NoComputerUse,

        [switch]$OneShot
    )

    # Auto-continue: if no explicit Conversation, try the stashed conversation ID
    if (-not $OneShot -and -not $Conversation -and $script:LastConversationId) {
        Write-Verbose "Auto-continuing conversation: $script:LastConversationId"
        $Conversation = $script:LastConversationId
    }

    $sub = if ($Cloud.IsPresent) { 'run-cloud' } else { 'run' }
    $a = [System.Collections.Generic.List[string]]@('agent', $sub, '--prompt', $Prompt)

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
    if ($Team.IsPresent) { $a.Add('--team') }
    if ($NoEnvironment.IsPresent)  { $a.Add('--no-environment') }
    if ($WorkerID)       { $a.Add('--host'); $a.Add($WorkerID) }
    if ($ComputerUse.IsPresent)    { $a.Add('--computer-use') }
    if ($NoComputerUse.IsPresent)  { $a.Add('--no-computer-use') }
    foreach ($att in $Attach) { $a.Add('--attach'); $a.Add($att) }

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
