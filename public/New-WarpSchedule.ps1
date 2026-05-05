function New-WarpSchedule {
    <#
    .SYNOPSIS
    Creates a new Warp scheduled agent.

    .DESCRIPTION
    This function invokes the Warp CLI to create a scheduled agent that runs periodically according to a cron expression.
    Either -Prompt or -Skill (or both) must be provided.

    .PARAMETER Name
    Required. Name of the scheduled agent.

    .PARAMETER Cron
    Required. Cron schedule expression (e.g. "0 9 * * 1" for 9 AM every Monday).

    .PARAMETER Prompt
    Prompt for what the scheduled agent should do. Required unless -Skill is specified.
    When used with -Skill, the skill provides the base context and the prompt is the task.

    .PARAMETER Skill
    Skill spec to automate on a schedule (e.g. "repo:skill_name" or "org/repo:skill_name").
    Required unless -Prompt is specified.

    .PARAMETER Model
    Optional. Override the base model.

    .PARAMETER Environment
    Optional. Cloud environment ID to run in.

    .PARAMETER NoEnvironment
    Do not run the agent in an environment.

    .PARAMETER Mcp
    Optional. One or more MCP server specs.

    .PARAMETER ConfigFile
    Optional. Path to a YAML or JSON configuration file.

    .PARAMETER WorkerID
    Optional. Where the job should be hosted. Use "warp" for Warp infrastructure, or a self-hosted worker name.

    .PARAMETER Team
    Create at the team level.

    .PARAMETER Personal
    Create as private to your account.

    .EXAMPLE
    New-WarpSchedule -Name "daily-review" -Cron "0 9 * * *" -Prompt "Review open PRs" -Environment "env-id"

    .EXAMPLE
    New-WarpSchedule -Name "nightly-deps" -Cron "0 2 * * *" -Skill "myorg/infra:dep-update"

    .EXAMPLE
    New-WarpSchedule -Name "weekly-audit" -Cron "0 9 * * 1" -Skill "myorg/backend:security-review" -Prompt "Focus on auth modules"

	.NOTES
	Use the ```Test-CronTabSchedule``` function in module PSDates to validate your cron expression before creating a schedule.
    #>
    [CmdletBinding(DefaultParameterSetName = 'ByPrompt')]
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Cron,

        [Parameter(Mandatory, ParameterSetName = 'ByPrompt')]
        [Parameter(ParameterSetName = 'BySkill')]
        [string]$Prompt,

        [Parameter(Mandatory, ParameterSetName = 'BySkill')]
        [Parameter(ParameterSetName = 'ByPrompt')]
        [string]$Skill,

        [string]$Model,
        [string]$Environment,
        [switch]$NoEnvironment,
        [string[]]$Mcp,
        [string]$ConfigFile,
        [string]$WorkerID,
        [switch]$Team,
        [switch]$Personal
    )

    $a = [System.Collections.Generic.List[string]]@('schedule', 'create',
        '--name', $Name, '--cron', $Cron)

    if ($Prompt)       { $a.Add('--prompt'); $a.Add($Prompt) }
    if ($Skill)        { $a.Add('--skill');  $a.Add($Skill) }
    if ($Model)        { $a.Add('--model');  $a.Add($Model) }
    if ($Environment)  { $a.Add('-e');       $a.Add($Environment) }
    if ($NoEnvironment.IsPresent) { $a.Add('--no-environment') }
    if ($ConfigFile)   { $a.Add('-f');       $a.Add($ConfigFile) }
    if ($WorkerID)     { $a.Add('--host');   $a.Add($WorkerID) }
    if ($Team)         { $a.Add('--team') }
    if ($Personal)     { $a.Add('--personal') }
    foreach ($m in $Mcp) { $a.Add('--mcp'); $a.Add($m) }

    Invoke-WarpCli -Arguments $a
}
