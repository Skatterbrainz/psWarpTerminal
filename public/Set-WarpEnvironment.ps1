function Set-WarpEnvironment {
    <#
    .SYNOPSIS
    Updates an existing Warp cloud environment.

    .DESCRIPTION
    This function invokes the Warp CLI to update a cloud environment. Additional arguments are passed through to the CLI.

    .PARAMETER Id
    Required. The ID of the environment to update. May be piped from another command.

    .PARAMETER PassThru
    Optional. Additional arguments forwarded to the Warp CLI update command.

    .EXAMPLE
    Set-WarpEnvironment -Id "env-abc123" --name "new-name"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string]$Id,

        [Parameter(ValueFromRemainingArguments)]
        [string[]]$PassThru
    )

    process {
        $a = [System.Collections.Generic.List[string]]@('environment', 'update', $Id)
        if ($PassThru) { $a.AddRange([string[]]$PassThru) }
        Invoke-WarpCli -Arguments $a
    }
}
