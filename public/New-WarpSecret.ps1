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

    .PARAMETER Team
    Create at the team level.

    .PARAMETER Personal
    Create as private to your account.

    .EXAMPLE
    New-WarpSecret -Name "API_KEY" -ValueFile "./secret.txt" -Description "Production API key"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Name,

        [string]$ValueFile,
        [string]$Description,
        [switch]$Team,
        [switch]$Personal
    )

    $a = [System.Collections.Generic.List[string]]@('secret', 'create')

    if ($Description) { $a.Add('-d');  $a.Add($Description) }
    if ($ValueFile)   { $a.Add('-f');  $a.Add($ValueFile) }
    if ($Team)        { $a.Add('--team') }
    if ($Personal)    { $a.Add('--personal') }
    $a.Add($Name)

    Invoke-WarpCli -Arguments $a
}
