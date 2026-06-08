function Remove-WarpApiKey {
    <#
    .SYNOPSIS
    Expires an Oz API key immediately.

    .DESCRIPTION
    This function invokes the Warp CLI to immediately expire an API key.

    .PARAMETER Id
    Required. Name or UID of the API key to expire.

    .PARAMETER Force
    Expire without interactive confirmation in the CLI.

    .EXAMPLE
    Remove-WarpApiKey -Id "ci-key" -Force
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('Name', 'Uid')]
        [string]$Id,

        [switch]$Force
    )

    process {
        if ($PSCmdlet.ShouldProcess($Id, 'Expire API key')) {
            $a = [System.Collections.Generic.List[string]]@('api-key', 'expire', $Id)
            if ($Force.IsPresent) { $a.Add('--force') }
            Invoke-WarpCli -Arguments $a
        }
    }
}
