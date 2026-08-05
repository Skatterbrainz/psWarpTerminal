function New-WarpAgent {
    <#
    .SYNOPSIS
    Creates a new reusable Warp agent.

    .DESCRIPTION
    This function invokes the Warp CLI to create a reusable agent definition.

    .PARAMETER Name
    Required. Name of the agent.

    .PARAMETER Description
    Optional. Description of the agent.

    .PARAMETER Prompt
    Optional. Base prompt for runs of this agent.

    .PARAMETER Secret
    Optional. One or more secret names to attach.

    .PARAMETER Skill
    Optional. One or more skills to attach.

    .PARAMETER BaseModel
    Optional. Base model for runs executed by this agent.

    .PARAMETER Environment
    Optional. Default cloud environment ID for runs executed by this agent.

    .EXAMPLE
    New-WarpAgent -Name "Nightly Triage" -Skill "myorg/backend:issue-triage"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Name,

        [string]$Description,
        [string]$Prompt,
        [string[]]$Secret,
        [string[]]$Skill,
        [string]$BaseModel,
        [string]$Environment
    )

    $a = [System.Collections.Generic.List[string]]@('agent', 'create', '--name', $Name)

    if ($Description)  { $a.Add('--description'); $a.Add($Description) }
    if ($Prompt)       { $a.Add('--prompt'); $a.Add($Prompt) }
    foreach ($s in $Secret) { $a.Add('--secret'); $a.Add($s) }
    foreach ($k in $Skill)  { $a.Add('--skill'); $a.Add($k) }
    if ($BaseModel)   { $a.Add('--base-model'); $a.Add($BaseModel) }
    if ($Environment) { $a.Add('-e'); $a.Add($Environment) }

    Invoke-WarpCli -Arguments $a
}
