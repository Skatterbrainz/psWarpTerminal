---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 06/08/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpFederatedToken
---

# Get-WarpFederatedToken

## SYNOPSIS

Issues a federated identity token for an Oz run.

## SYNTAX

### Default

```
Get-WarpFederatedToken -RunId <string> -Audience <string> [-Duration <string>] [-SubjectTemplate <string[]>] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to issue an OIDC federated identity token.

## EXAMPLES

### EXAMPLE 1

Get-WarpFederatedToken -RunId $env:OZ_RUN_ID -Audience "sts.amazonaws.com"

## PARAMETERS

### -RunId

Required. The Oz run ID requesting the token.

### -Audience

Required. The token audience claim.

### -Duration

Optional. Token lifetime (e.g. "15m", "1h").

### -SubjectTemplate

Optional. One or more subject template components.
