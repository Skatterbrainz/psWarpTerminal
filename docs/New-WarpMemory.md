---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: New-WarpMemory
---

# New-WarpMemory

## SYNOPSIS

Creates a manual memory in a memory store.

## SYNTAX

```powershell
New-WarpMemory -StoreId <string> -Content <string> -Reason <string> [-Version <string>] [<CommonParameters>]
```

## DESCRIPTION

Wraps `memory create`.

## EXAMPLES

### EXAMPLE 1

```powershell
New-WarpMemory -StoreId "store_abc123" -Content "Use feature flag" -Reason "Postmortem action"
```
