function Watch-WarpRunMessage {
    <#
    .SYNOPSIS
    Watches for new messages delivered to a run inbox.

    .DESCRIPTION
    This function invokes the Warp CLI to stream run inbox events.

    .PARAMETER RunId
    Required. The run ID whose inbox should be watched.

    .PARAMETER SinceSequence
    Optional. Resume after this event sequence (inclusive cursor). Defaults to 0.

    .EXAMPLE
    Watch-WarpRunMessage -RunId "run_abc123"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('TaskId')]
        [string]$RunId,

        [long]$SinceSequence = 0
    )

    $a = [System.Collections.Generic.List[string]]@('run', 'message', 'watch', $RunId)
    if ($SinceSequence -ge 0) {
        $a.Add('--since-sequence')
        $a.Add([string]$SinceSequence)
    }

    Invoke-WarpCli -Arguments $a
}
