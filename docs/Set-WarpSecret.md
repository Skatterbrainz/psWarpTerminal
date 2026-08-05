---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Set-WarpSecret
---

# Set-WarpSecret

## SYNOPSIS

Updates an existing Warp secret.

## SYNTAX

```powershell
Set-WarpSecret -Id <string> [[-PassThru] <string[]>] [<CommonParameters>]
```

## DESCRIPTION

Updates a secret by name or UID and forwards additional CLI arguments to `secret update`.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-WarpSecret -Id "MY_SECRET" --value
```

### EXAMPLE 2

```powershell
Set-WarpSecret -Id "MY_SECRET" -f ./new-value.txt -d "rotated key"
```
