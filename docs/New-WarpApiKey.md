---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 06/08/2026
PlatyPS schema version: 2024-05-01
title: New-WarpApiKey
---

# New-WarpApiKey

## SYNOPSIS

Creates a new Oz API key.

## SYNTAX

### ExpiresIn

```
New-WarpApiKey [-Name] <string> [-Agent <string>] -ExpiresIn <string> [<CommonParameters>]
```

### ExpiresAt

```
New-WarpApiKey [-Name] <string> [-Agent <string>] -ExpiresAt <string> [<CommonParameters>]
```

### NoExpiration

```
New-WarpApiKey [-Name] <string> [-Agent <string>] -NoExpiration [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to create a new API key.

## EXAMPLES

### EXAMPLE 1

New-WarpApiKey -Name "ci-key" -ExpiresIn "30d"

### EXAMPLE 2

New-WarpApiKey -Name "nightly-agent" -Agent "ag_abc123" -NoExpiration

## PARAMETERS

### -Name

Required. Name of the API key.

### -Agent

Optional. Agent UID to authenticate as.

### -ExpiresIn

Optional. Expire after a duration such as "30d", "12h", or "90m".

### -ExpiresAt

Optional. Expire at a specific RFC3339 timestamp.

### -NoExpiration

Optional. Create a key with no expiration.
