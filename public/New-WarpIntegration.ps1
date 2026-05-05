function New-WarpIntegration {
    <#
    .SYNOPSIS
    Creates a new Warp integration.

    .DESCRIPTION
    This function invokes the Warp CLI to create a new integration for a supported provider.

    .PARAMETER Provider
    Required. The provider to integrate (linear or slack).

    .PARAMETER Prompt
    Optional. Custom instructions for the integration.

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
    Optional. Worker host ID for self-hosted workers.

    .EXAMPLE
    New-WarpIntegration -Provider linear -Environment "env-id"

    .EXAMPLE
    New-WarpIntegration -Provider slack -Prompt "Respond helpfully to questions in #dev"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateSet('linear', 'slack')]
        [string]$Provider,

        [string]$Prompt,
        [string]$Model,
        [string]$Environment,
        [switch]$NoEnvironment,
        [string[]]$Mcp,
        [string]$ConfigFile,
        [string]$WorkerID
    )

    $a = [System.Collections.Generic.List[string]]@('integration', 'create', $Provider)

    if ($Prompt)       { $a.Add('--prompt'); $a.Add($Prompt) }
    if ($Model)        { $a.Add('--model');  $a.Add($Model) }
    if ($Environment)  { $a.Add('-e');       $a.Add($Environment) }
    if ($NoEnvironment.IsPresent) { $a.Add('--no-environment') }
    if ($ConfigFile)   { $a.Add('-f');       $a.Add($ConfigFile) }
    if ($WorkerID)     { $a.Add('--host');   $a.Add($WorkerID) }
    foreach ($m in $Mcp) { $a.Add('--mcp'); $a.Add($m) }

    Invoke-WarpCli -Arguments $a
}
