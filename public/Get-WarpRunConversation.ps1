function Get-WarpRunConversation {
    <#
    .SYNOPSIS
    Retrieves a run conversation by conversation ID.

    .DESCRIPTION
    This function invokes the Warp CLI to fetch conversation content for a run conversation.

    .PARAMETER ConversationId
    Required. The conversation ID to retrieve.

    .EXAMPLE
    Get-WarpRunConversation -ConversationId "conv_abc123"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [string]$ConversationId
    )

    process {
        Invoke-WarpCli -Arguments @('run', 'conversation', 'get', $ConversationId)
    }
}
