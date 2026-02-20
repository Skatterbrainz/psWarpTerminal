function Get-WarpEnvironment {
    <#
    .SYNOPSIS
    Retrieves a list of Warp environments.
    
    .PARAMETER Id
    Optional. The ID of a specific environment to retrieve. If not provided, all environments will
    be listed. May be piped from another command that outputs an object with an 'Id' property.

    .DESCRIPTION
    This function invokes the Warp CLI to list all available environments or get a specific environment by ID.

    .EXAMPLE
    Get-WarpEnvironment
    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(ParameterSetName = 'ById', Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string]$Id
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ById') {
            Invoke-WarpCli -Arguments @('environment', 'get', $Id)
        } else {
            Invoke-WarpCli -Arguments @('environment', 'list')
        }
    }
}
