---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 05/05/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpSettings
---

# Get-WarpSettings

## SYNOPSIS

Returns Warp Terminal settings as a PowerShell object.

## SYNTAX

### Default

```
Get-WarpSettings [[-Path] <string>] [<CommonParameters>]
```

## DESCRIPTION

Reads and parses the Warp Terminal settings.toml file, returning it as a PSCustomObject.
Automatically detects the settings file location based on the operating system.

## EXAMPLES

### EXAMPLE 1

Get-WarpSettings

### EXAMPLE 2

Get-WarpSettings -Path ~/.config/warp-terminal/settings.toml

### EXAMPLE 3

(Get-WarpSettings).appearance.themes.theme

## PARAMETERS

### -Path

Optional. Path to the settings.toml file. If not specified, the default platform-specific location is used.

