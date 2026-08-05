---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpMemoryStore
---

# Get-WarpMemoryStore

## SYNOPSIS

Lists memory stores, gets a memory store, or lists store-attached agents.

## SYNTAX

### List (Default)

```powershell
Get-WarpMemoryStore [<CommonParameters>]
```

### Get

```powershell
Get-WarpMemoryStore -StoreId <string> [<CommonParameters>]
```

### Agents

```powershell
Get-WarpMemoryStore -StoreId <string> -StoreAgents [<CommonParameters>]
```

## DESCRIPTION

Wraps `memory-store list`, `memory-store get`, and `memory-store list-store-agents`.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-WarpMemoryStore
```
