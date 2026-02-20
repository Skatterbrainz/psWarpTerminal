function Set-WarpIntegration {
    <#
    .SYNOPSIS
    Updates an existing Warp integration.

    .DESCRIPTION
    This function invokes the Warp CLI to update an integration. Arguments are passed through to the CLI.

    .PARAMETER PassThru
    Optional. Arguments forwarded to the Warp CLI update command.

    .EXAMPLE
    Set-WarpIntegration
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments)]
        [string[]]$PassThru
    )

    $a = [System.Collections.Generic.List[string]]@('integration', 'update')
    if ($PassThru) { $a.AddRange([string[]]$PassThru) }
    Invoke-WarpCli -Arguments $a
}
