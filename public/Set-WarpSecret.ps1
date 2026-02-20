function Set-WarpSecret {
    <#
    .SYNOPSIS
    Updates an existing Warp secret.

    .DESCRIPTION
    This function invokes the Warp CLI to update a secret. Additional arguments are passed through to the CLI.

    .PARAMETER Id
    Required. The ID of the secret to update. May be piped from another command.

    .PARAMETER PassThru
    Optional. Additional arguments forwarded to the Warp CLI update command.

    .EXAMPLE
    Set-WarpSecret -Id "secret-abc123" -f ./new-value.txt
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string]$Id,

        [Parameter(ValueFromRemainingArguments)]
        [string[]]$PassThru
    )

    process {
        $a = [System.Collections.Generic.List[string]]@('secret', 'update', $Id)
        if ($PassThru) { $a.AddRange([string[]]$PassThru) }
        Invoke-WarpCli -Arguments $a
    }
}
