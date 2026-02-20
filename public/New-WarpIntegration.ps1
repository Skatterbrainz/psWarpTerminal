function New-WarpIntegration {
    <#
    .SYNOPSIS
    Creates a new Warp integration.

    .DESCRIPTION
    This function invokes the Warp CLI to create a new integration. Arguments are passed through to the CLI.

    .PARAMETER PassThru
    Optional. Arguments forwarded to the Warp CLI create command.

    .EXAMPLE
    New-WarpIntegration
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments)]
        [string[]]$PassThru
    )

    $a = [System.Collections.Generic.List[string]]@('integration', 'create')
    if ($PassThru) { $a.AddRange([string[]]$PassThru) }
    Invoke-WarpCli -Arguments $a
}
