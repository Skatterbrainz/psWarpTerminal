---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Set-WarpMemory
---

# Set-WarpMemory

## SYNOPSIS

Updates a memory and creates a new version.

## SYNTAX

```powershell
Set-WarpMemory -MemoryId <string> -StoreId <string> -Content <string> -Reason <string> [-Version <string>] [<CommonParameters>]
```

## DESCRIPTION

Wraps `memory update`.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-WarpMemory -MemoryId "mem_abc123" -StoreId "store_abc123" -Content "New content" -Reason "Correction"
```
