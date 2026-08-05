function New-WarpSecret {
    <#
    .SYNOPSIS
    Creates a new Warp secret.

    .DESCRIPTION
    This function invokes the Warp CLI to create a new secret in Warp's secure storage. If no ValueFile is specified, the value is read from standard input.

    .PARAMETER Name
    Required. Name of the secret to create.

    .PARAMETER ValueFile
    Optional. File to read the secret value from.

    .PARAMETER Description
    Optional. Description of the secret.

    .PARAMETER Type
    Optional. Secret type for generic secret creation.

    .PARAMETER ClaudeApiKey
    Create a Claude/Anthropic auth secret (equivalent to: secret create claude api-key).

    .PARAMETER CodexApiKey
    Create a Codex/OpenAI auth secret (equivalent to: secret create codex api-key).

    .PARAMETER BaseUrl
    Optional OpenAI base URL used with -CodexApiKey.

    .PARAMETER Team
    Create at the team level.

    .PARAMETER Personal
    Create as private to your account.

    .EXAMPLE
    New-WarpSecret -Name "API_KEY" -ValueFile "./secret.txt" -Description "Production API key"
    #>
    [CmdletBinding(DefaultParameterSetName = 'Raw')]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Raw')]
        [ValidateSet('raw-value', 'anthropic-api-key')]
        [string]$Type,

        [Parameter(ParameterSetName = 'ClaudeApiKey')]
        [switch]$ClaudeApiKey,

        [Parameter(ParameterSetName = 'CodexApiKey')]
        [switch]$CodexApiKey,

        [string]$ValueFile,
        [string]$Description,
        [switch]$Team,
        [switch]$Personal,

        [Parameter(ParameterSetName = 'CodexApiKey')]
        [string]$BaseUrl
    )

    $a = [System.Collections.Generic.List[string]]::new()
    if ($PSCmdlet.ParameterSetName -eq 'ClaudeApiKey') {
        $a.AddRange([string[]]@('secret', 'create', 'claude', 'api-key'))
    } elseif ($PSCmdlet.ParameterSetName -eq 'CodexApiKey') {
        $a.AddRange([string[]]@('secret', 'create', 'codex', 'api-key'))
    } else {
        $a.AddRange([string[]]@('secret', 'create'))
    }

    if ($Description) { $a.Add('-d');  $a.Add($Description) }
    if ($ValueFile)   { $a.Add('-f');  $a.Add($ValueFile) }
    if ($Type)        { $a.Add('-t');  $a.Add($Type) }
    if ($Team)        { $a.Add('--team') }
    if ($Personal)    { $a.Add('--personal') }
    if ($BaseUrl)     { $a.Add('--base-url'); $a.Add($BaseUrl) }
    $a.Add($Name)

    Invoke-WarpCli -Arguments $a
}
