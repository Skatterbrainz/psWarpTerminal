---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 06/08/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpSkill
---

# Get-WarpSkill

## SYNOPSIS

Lists available Warp agent skills.

## SYNTAX

### __AllParameterSets

```
Get-WarpSkill [[-Repo] <string>] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to list available skills discovered from
your environments, or from a specific GitHub repository.

## EXAMPLES

### EXAMPLE 1

Get-WarpSkill

### EXAMPLE 2

Get-WarpSkill -Repo "myorg/backend"

## PARAMETERS

### -Repo

Optional. List skills from a specific GitHub repository.
Format: "owner/repo" or "https://github.com/owner/repo".

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
