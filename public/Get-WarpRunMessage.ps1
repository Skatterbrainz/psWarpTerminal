function Get-WarpRunMessage {
    <#
    .SYNOPSIS
    Lists run inbox messages or retrieves a specific message body.

    .DESCRIPTION
    This function invokes the Warp CLI to list message headers for a run inbox,
    or read a specific message by ID.

    .PARAMETER RunId
    Required in List mode. The run ID whose inbox should be listed.

    .PARAMETER MessageId
    Required in Read mode. The message ID to read.

    .PARAMETER Unread
    In List mode, only return unread messages.

    .PARAMETER Since
    In List mode, only return messages sent at or after this RFC3339 timestamp.

    .PARAMETER Limit
    In List mode, maximum number of messages to return. Defaults to 50.

    .EXAMPLE
    Get-WarpRunMessage -RunId "run_abc123" -Unread

    .EXAMPLE
    Get-WarpRunMessage -MessageId "msg_abc123"
    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(ParameterSetName = 'List', Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('TaskId')]
        [string]$RunId,

        [Parameter(ParameterSetName = 'Read', Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [string]$MessageId,

        [Parameter(ParameterSetName = 'List')]
        [switch]$Unread,

        [Parameter(ParameterSetName = 'List')]
        [string]$Since,

        [Parameter(ParameterSetName = 'List')]
        [int]$Limit = 50
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'Read') {
            Invoke-WarpCli -Arguments @('run', 'message', 'read', $MessageId)
            return
        }

        $a = [System.Collections.Generic.List[string]]@('run', 'message', 'list', $RunId)
        if ($Unread.IsPresent) { $a.Add('--unread') }
        if ($Since) { $a.Add('--since'); $a.Add($Since) }
        if ($Limit -gt 0) { $a.Add('-L'); $a.Add([string]$Limit) }

        Invoke-WarpCli -Arguments $a
    }
}
