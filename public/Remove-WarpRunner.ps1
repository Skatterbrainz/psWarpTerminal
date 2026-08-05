function Remove-WarpRunner {
    <#
    .SYNOPSIS
    Deletes a cloud runner.

    .DESCRIPTION
    This function invokes the Warp CLI to delete a runner.

    .PARAMETER Id
    Required. UID of the runner to delete.

    .PARAMETER Force
    Delete without CLI confirmation.

    .EXAMPLE
    Remove-WarpRunner -Id "runner_abc123" -Force
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('Uid')]
        [string]$Id,

        [switch]$Force
    )

    process {
        if ($PSCmdlet.ShouldProcess($Id, 'Delete runner')) {
            $a = [System.Collections.Generic.List[string]]@('runner', 'delete', $Id)
            if ($Force.IsPresent) { $a.Add('--force') }
            Invoke-WarpCli -Arguments $a
        }
    }
}
