---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 02/20/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpSchedule
---

# Get-WarpSchedule

## SYNOPSIS

Retrieves a list of Warp scheduled agents.

## SYNTAX

### List (Default)

```
Get-WarpSchedule [<CommonParameters>]
```

### ById

```
Get-WarpSchedule [-Id] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function invokes the Warp CLI to list all scheduled agents or get a specific schedule by ID.

## EXAMPLES

### EXAMPLE 1

Get-WarpSchedule

### EXAMPLE 2

Get-WarpSchedule -Id "sched-abc123"

## PARAMETERS

### -Id

Optional.
The ID of a specific schedule to retrieve.
If not provided, all schedules will be listed.
May be piped from another command that outputs an object with an 'Id' property.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: ById
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
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

### System.String

{{ Fill in the Description }}

## OUTPUTS

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

