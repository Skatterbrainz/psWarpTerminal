function New-WarpSchedule {
    <#
    .SYNOPSIS
    Creates a new Warp scheduled agent.

    .DESCRIPTION
    This function invokes the Warp CLI to create a scheduled agent that runs periodically according to a cron expression.

    .PARAMETER Name
    Required. Name of the scheduled agent.

    .PARAMETER Cron
    Required. Cron schedule expression (e.g. "0 9 * * 1" for 9 AM every Monday).

    .PARAMETER Prompt
    Required. Prompt for what the scheduled agent should do.

    .PARAMETER Skill
    Optional. Skill spec to use (e.g. "repo:skill_name").

    .PARAMETER Model
    Optional. Override the base model.

    .PARAMETER Environment
    Optional. Cloud environment ID to run in.

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

	.NOTES
	Use the ```Test-CronTabSchedule``` function in module PSDates to validate your cron expression before creating a schedule.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Cron,

        [Parameter(Mandatory)]
        [string]$Prompt,

        [string]$Skill,
        [string]$Model,
        [string]$Environment,
        [string[]]$Mcp,
        [string]$ConfigFile,
        [string]$WorkerID,
        [switch]$Team,
        [switch]$Personal
    )

    $a = [System.Collections.Generic.List[string]]@('schedule', 'create',
        '--name', $Name, '--cron', $Cron, '--prompt', $Prompt)

    if ($Skill)       { $a.Add('--skill');   $a.Add($Skill) }
    if ($Model)       { $a.Add('--model');   $a.Add($Model) }
    if ($Environment) { $a.Add('-e');        $a.Add($Environment) }
    if ($ConfigFile)  { $a.Add('-f');        $a.Add($ConfigFile) }
    if ($WorkerID)    { $a.Add('--host');    $a.Add($WorkerID) }
    if ($Team)        { $a.Add('--team') }
    if ($Personal)    { $a.Add('--personal') }
    foreach ($m in $Mcp) { $a.Add('--mcp'); $a.Add($m) }

    Invoke-WarpCli -Arguments $a
}
