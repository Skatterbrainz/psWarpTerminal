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

### __AllParameterSets

```
Get-WarpSettings [[-Path] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

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

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSCustomObject

A nested PSCustomObject representing the parsed TOML settings.

## NOTES

Default settings file locations by platform:
- Linux: ~/.config/warp-terminal/settings.toml
- macOS: ~/Library/Preferences/dev.warp.Warp-Stable/settings.toml or ~/.warp/settings.toml
- Windows: $env:LOCALAPPDATA\warp-terminal\settings.toml

## RELATED LINKS

{{ Fill in the related links here }}
