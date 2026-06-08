function Get-WarpFederatedToken {
    <#
    .SYNOPSIS
    Issues a federated identity token for an Oz run.

    .DESCRIPTION
    This function invokes the Warp CLI to issue an OIDC federated identity token.

    .PARAMETER RunId
    Required. The Oz run ID requesting the token.

    .PARAMETER Audience
    Required. The token audience claim.

    .PARAMETER Duration
    Optional. Token lifetime (e.g. "15m", "1h").

    .PARAMETER SubjectTemplate
    Optional. One or more subject template components.

    .EXAMPLE
    Get-WarpFederatedToken -RunId $env:OZ_RUN_ID -Audience "sts.amazonaws.com"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$RunId,

        [Parameter(Mandatory)]
        [string]$Audience,

        [string]$Duration,
        [string[]]$SubjectTemplate
    )

    $a = [System.Collections.Generic.List[string]]@('federate', 'issue-token', '--run-id', $RunId, '--audience', $Audience)

    if ($Duration) { $a.Add('--duration'); $a.Add($Duration) }
    if ($SubjectTemplate) {
        $a.Add('--subject-template')
        foreach ($component in $SubjectTemplate) { $a.Add($component) }
    }

    Invoke-WarpCli -Arguments $a
}
