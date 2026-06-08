function New-WarpApiKey {
    <#
    .SYNOPSIS
    Creates a new Oz API key.

    .DESCRIPTION
    This function invokes the Warp CLI to create a new API key.

    .PARAMETER Name
    Required. Name of the API key.

    .PARAMETER Agent
    Optional. Agent UID to authenticate as.

    .PARAMETER ExpiresIn
    Optional. Expire after a duration such as "30d", "12h", or "90m".

    .PARAMETER ExpiresAt
    Optional. Expire at a specific RFC3339 timestamp.

    .PARAMETER NoExpiration
    Optional. Create a key with no expiration.

    .EXAMPLE
    New-WarpApiKey -Name "ci-key" -ExpiresIn "30d"

    .EXAMPLE
    New-WarpApiKey -Name "nightly-agent" -Agent "ag_abc123" -NoExpiration
    #>
    [CmdletBinding(DefaultParameterSetName = 'ExpiresIn')]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Name,

        [string]$Agent,

        [Parameter(Mandatory, ParameterSetName = 'ExpiresIn')]
        [string]$ExpiresIn,

        [Parameter(Mandatory, ParameterSetName = 'ExpiresAt')]
        [string]$ExpiresAt,

        [Parameter(Mandatory, ParameterSetName = 'NoExpiration')]
        [switch]$NoExpiration
    )

    $a = [System.Collections.Generic.List[string]]@('api-key', 'create')

    if ($Agent) { $a.Add('--agent'); $a.Add($Agent) }

    if ($PSCmdlet.ParameterSetName -eq 'ExpiresIn') {
        $a.Add('--expires-in'); $a.Add($ExpiresIn)
    } elseif ($PSCmdlet.ParameterSetName -eq 'ExpiresAt') {
        $a.Add('--expires-at'); $a.Add($ExpiresAt)
    } else {
        $a.Add('--no-expiration')
    }

    $a.Add($Name)

    Invoke-WarpCli -Arguments $a
}
