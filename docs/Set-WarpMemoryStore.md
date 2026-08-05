---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Set-WarpMemoryStore
---

# Set-WarpMemoryStore

## SYNOPSIS

Updates a memory store description.

## SYNTAX

```powershell
Set-WarpMemoryStore -StoreId <string> -Description <string> [<CommonParameters>]
```

## DESCRIPTION

Wraps `memory-store update`.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-WarpMemoryStore -StoreId "store_abc123" -Description "Shared coding guidance"
```
