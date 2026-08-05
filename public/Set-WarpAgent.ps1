function Set-WarpAgent {
    <#
    .SYNOPSIS
    Updates an existing reusable Warp agent.

    .DESCRIPTION
    This function invokes the Warp CLI to update a reusable agent definition.

    .PARAMETER Id
    Required. The UID of the agent to update.

    .PARAMETER Name
    Optional. New name for the agent.

    .PARAMETER Description
    Optional. Replacement description for the agent.

    .PARAMETER RemoveDescription
    Remove the agent description.

    .PARAMETER Prompt
    Optional. Replacement base prompt for runs executed by this agent.

    .PARAMETER RemovePrompt
    Remove the base prompt from this agent.

    .PARAMETER AddSecret
    Optional. One or more secret names to add.

    .PARAMETER RemoveSecret
    Optional. One or more secret names to remove.

    .PARAMETER RemoveAllSecrets
    Remove all attached secrets.

    .PARAMETER AddSkill
    Optional. One or more skills to add.

    .PARAMETER RemoveSkill
    Optional. One or more skills to remove.

    .PARAMETER RemoveAllSkills
    Remove all attached skills.

    .PARAMETER BaseModel
    Optional. Replacement base model.

    .PARAMETER RemoveBaseModel
    Remove the base model.

    .PARAMETER Environment
    Optional. Replacement default cloud environment.

    .PARAMETER RemoveEnvironment
    Remove the default environment.

    .EXAMPLE
    Set-WarpAgent -Id "ag_abc123" -AddSkill "myorg/backend:code-review"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('Uid')]
        [string]$Id,

        [string]$Name,
        [string]$Description,
        [switch]$RemoveDescription,
        [string]$Prompt,
        [switch]$RemovePrompt,
        [string[]]$AddSecret,
        [string[]]$RemoveSecret,
        [switch]$RemoveAllSecrets,
        [string[]]$AddSkill,
        [string[]]$RemoveSkill,
        [switch]$RemoveAllSkills,
        [string]$BaseModel,
        [switch]$RemoveBaseModel,
        [string]$Environment,
        [switch]$RemoveEnvironment
    )

    process {
        $a = [System.Collections.Generic.List[string]]@('agent', 'update', $Id)

        if ($Name) { $a.Add('-n'); $a.Add($Name) }
        if ($Description) { $a.Add('--description'); $a.Add($Description) }
        if ($RemoveDescription.IsPresent) { $a.Add('--remove-description') }
        if ($Prompt) { $a.Add('--prompt'); $a.Add($Prompt) }
        if ($RemovePrompt.IsPresent) { $a.Add('--remove-prompt') }

        foreach ($s in $AddSecret)    { $a.Add('--add-secret'); $a.Add($s) }
        foreach ($s in $RemoveSecret) { $a.Add('--remove-secret'); $a.Add($s) }
        if ($RemoveAllSecrets.IsPresent) { $a.Add('--remove-all-secrets') }

        foreach ($k in $AddSkill)    { $a.Add('--add-skill'); $a.Add($k) }
        foreach ($k in $RemoveSkill) { $a.Add('--remove-skill'); $a.Add($k) }
        if ($RemoveAllSkills.IsPresent) { $a.Add('--remove-all-skills') }

        if ($BaseModel) { $a.Add('--base-model'); $a.Add($BaseModel) }
        if ($RemoveBaseModel.IsPresent) { $a.Add('--remove-base-model') }

        if ($Environment) { $a.Add('-e'); $a.Add($Environment) }
        if ($RemoveEnvironment.IsPresent) { $a.Add('--remove-environment') }

        Invoke-WarpCli -Arguments $a
    }
}
