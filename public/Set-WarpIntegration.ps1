function Set-WarpIntegration {
    <#
    .SYNOPSIS
    Updates an existing Warp integration.

    .DESCRIPTION
    This function invokes the Warp CLI to update an integration for a supported provider.

    .PARAMETER Provider
    Required. The provider to update (linear or slack).

    .PARAMETER Prompt
    Optional. Custom instructions for the integration.

    .PARAMETER Model
    Optional. Override the base model.

    .PARAMETER Environment
    Optional. Cloud environment ID to run in.

    .PARAMETER RemoveEnvironment
    Remove the environment from this integration.

    .PARAMETER Mcp
    Optional. One or more MCP server specs to add.

    .PARAMETER RemoveMcp
    Optional. One or more MCP server names to remove.

    .PARAMETER ConfigFile
    Optional. Path to a YAML or JSON configuration file.

    .PARAMETER WorkerID
    Optional. Worker host ID for self-hosted workers.

    .EXAMPLE
    Set-WarpIntegration -Provider slack -Prompt "Updated instructions"

    .EXAMPLE
    Set-WarpIntegration -Provider linear -RemoveMcp "old-server"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateSet('linear', 'slack')]
        [string]$Provider,

        [string]$Prompt,
        [string]$Model,
        [string]$Environment,
        [switch]$RemoveEnvironment,
        [string[]]$Mcp,
        [string[]]$RemoveMcp,
        [string]$ConfigFile,
        [string]$WorkerID
    )

    $a = [System.Collections.Generic.List[string]]@('integration', 'update', $Provider)

    if ($Prompt)       { $a.Add('--prompt'); $a.Add($Prompt) }
    if ($Model)        { $a.Add('--model');  $a.Add($Model) }
    if ($Environment)  { $a.Add('-e');       $a.Add($Environment) }
    if ($RemoveEnvironment.IsPresent) { $a.Add('--remove-environment') }
    if ($ConfigFile)   { $a.Add('-f');       $a.Add($ConfigFile) }
    if ($WorkerID)     { $a.Add('--host');   $a.Add($WorkerID) }
    foreach ($m in $Mcp)       { $a.Add('--mcp');        $a.Add($m) }
    foreach ($r in $RemoveMcp) { $a.Add('--remove-mcp'); $a.Add($r) }

    Invoke-WarpCli -Arguments $a
}
