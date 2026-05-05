function Set-WarpSchedule {
    <#
    .SYNOPSIS
    Updates an existing Warp scheduled agent.

    .DESCRIPTION
    This function invokes the Warp CLI to update a scheduled agent's configuration.

    .PARAMETER Id
    Required. The ID of the schedule to update. May be piped from another command.

    .PARAMETER Name
    Optional. Update the scheduled agent name.

    .PARAMETER Cron
    Optional. Update the cron schedule expression.

    .PARAMETER Prompt
    Optional. Update the prompt.

    .PARAMETER Skill
    Optional. Update the skill spec (e.g. "repo:skill_name").

    .PARAMETER RemoveSkill
    Remove the skill from this scheduled agent.

    .PARAMETER Model
    Optional. Override the base model.

    .PARAMETER Environment
    Optional. Cloud environment ID.

    .PARAMETER RemoveEnvironment
    Remove the environment from this schedule.

    .PARAMETER Mcp
    Optional. One or more MCP server specs to add.

    .PARAMETER RemoveMcp
    Optional. One or more MCP server names to remove.

    .PARAMETER ConfigFile
    Optional. Path to a YAML or JSON configuration file.

    .PARAMETER WorkerID
    Optional. Where the job should be hosted.

    .EXAMPLE
    Set-WarpSchedule -Id "sched-abc123" -Cron "0 10 * * *"

    .EXAMPLE
    Set-WarpSchedule -Id "sched-abc123" -Skill "myorg/repo:new-skill" -Prompt "Focus on tests"

    .EXAMPLE
    Get-WarpSchedule -Id "sched-abc123" | Set-WarpSchedule -RemoveSkill
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string]$Id,

        [string]$Name,
        [string]$Cron,
        [string]$Prompt,
        [string]$Skill,
        [switch]$RemoveSkill,
        [string]$Model,
        [string]$Environment,
        [switch]$RemoveEnvironment,
        [string[]]$Mcp,
        [string[]]$RemoveMcp,
        [string]$ConfigFile,
        [string]$WorkerID
    )

    process {
        $a = [System.Collections.Generic.List[string]]@('schedule', 'update', $Id)

        if ($Name)        { $a.Add('--name');   $a.Add($Name) }
        if ($Cron)        { $a.Add('--cron');   $a.Add($Cron) }
        if ($Prompt)      { $a.Add('--prompt'); $a.Add($Prompt) }
        if ($Skill)       { $a.Add('--skill');  $a.Add($Skill) }
        if ($RemoveSkill.IsPresent)       { $a.Add('--remove-skill') }
        if ($Model)       { $a.Add('--model');  $a.Add($Model) }
        if ($Environment) { $a.Add('-e');       $a.Add($Environment) }
        if ($RemoveEnvironment.IsPresent) { $a.Add('--remove-environment') }
        if ($ConfigFile)  { $a.Add('-f');       $a.Add($ConfigFile) }
        if ($WorkerID)    { $a.Add('--host');   $a.Add($WorkerID) }
        foreach ($m in $Mcp)       { $a.Add('--mcp');        $a.Add($m) }
        foreach ($r in $RemoveMcp) { $a.Add('--remove-mcp'); $a.Add($r) }

        Invoke-WarpCli -Arguments $a
    }
}
