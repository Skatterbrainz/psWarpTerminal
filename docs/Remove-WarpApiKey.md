---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 06/08/2026
PlatyPS schema version: 2024-05-01
title: Remove-WarpApiKey
---

# Remove-WarpApiKey

## SYNOPSIS

Expires an Oz API key immediately.

## SYNTAX

### __AllParameterSets

```
Remove-WarpApiKey [-Id] <string> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to immediately expire an API key.

## EXAMPLES

### EXAMPLE 1

Remove-WarpApiKey -Id "ci-key" -Force

## PARAMETERS

### -Id

Required. Name or UID of the API key to expire.

### -Force

Expire without interactive confirmation in the CLI.
