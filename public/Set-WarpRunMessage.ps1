function Set-WarpRunMessage {
    <#
    .SYNOPSIS
    Marks a run message as delivered.

    .DESCRIPTION
    This function invokes the Warp CLI to mark an inbox message as delivered.

    .PARAMETER MessageId
    Required. The message ID to mark as delivered.

    .EXAMPLE
    Set-WarpRunMessage -MessageId "msg_abc123"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [string]$MessageId
    )

    process {
        Invoke-WarpCli -Arguments @('run', 'message', 'mark-delivered', $MessageId)
    }
}
