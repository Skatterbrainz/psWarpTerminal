---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Watch-WarpRunMessage
---

# Watch-WarpRunMessage

## SYNOPSIS

Watches for new messages delivered to a run inbox.

## SYNTAX

```powershell
Watch-WarpRunMessage -RunId <string> [-SinceSequence <long>] [<CommonParameters>]
```

## DESCRIPTION

Wraps `run message watch`.

## EXAMPLES

### EXAMPLE 1

```powershell
Watch-WarpRunMessage -RunId "run_abc123"
```
