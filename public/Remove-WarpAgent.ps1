function Remove-WarpAgent {
    <#
    .SYNOPSIS
    Deletes a reusable Warp agent.

    .DESCRIPTION
    This function invokes the Warp CLI to delete a reusable agent.

    .PARAMETER Id
    Required. The UID of the agent to delete.

    .EXAMPLE
    Remove-WarpAgent -Id "ag_abc123"
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('Uid')]
        [string]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess($Id, 'Delete reusable agent')) {
            Invoke-WarpCli -Arguments @('agent', 'delete', $Id)
        }
    }
}
