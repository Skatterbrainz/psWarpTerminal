function Send-WarpRunMessage {
    <#
    .SYNOPSIS
    Sends a message from one run to one or more recipient runs.

    .DESCRIPTION
    This function invokes the Warp CLI to send a run-to-run message.

    .PARAMETER To
    Required. One or more recipient run IDs.

    .PARAMETER Subject
    Required. Message subject.

    .PARAMETER Body
    Required. Message body.

    .PARAMETER SenderRunId
    Required. Sender run ID.

    .EXAMPLE
    Send-WarpRunMessage -SenderRunId "run_sender" -To "run_recipient" -Subject "status" -Body "tests passed"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string[]]$To,

        [Parameter(Mandatory)]
        [string]$Subject,

        [Parameter(Mandatory)]
        [string]$Body,

        [Parameter(Mandatory)]
        [string]$SenderRunId
    )

    $a = [System.Collections.Generic.List[string]]@('run', 'message', 'send')
    foreach ($recipient in $To) {
        $a.Add('--to')
        $a.Add($recipient)
    }
    $a.Add('--subject')
    $a.Add($Subject)
    $a.Add('--body')
    $a.Add($Body)
    $a.Add('--sender-run-id')
    $a.Add($SenderRunId)

    Invoke-WarpCli -Arguments $a
}
