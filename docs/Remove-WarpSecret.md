---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Remove-WarpSecret
---

# Remove-WarpSecret

## SYNOPSIS

Deletes a Warp secret.

## SYNTAX

```powershell
Remove-WarpSecret -Id <string> [-Force] [-Team] [-Personal] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Deletes a secret by name or UID.

## EXAMPLES

### EXAMPLE 1

```powershell
Remove-WarpSecret -Id "MY_SECRET" -Force
```
