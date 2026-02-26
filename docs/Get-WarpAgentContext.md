---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 02/26/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpAgentContext
---

# Get-WarpAgentContext

## SYNOPSIS

Returns the stored context from the last Invoke-WarpAgent call.

## SYNTAX

### __AllParameterSets

```
Get-WarpAgentContext [-AsObject] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function returns the module-scoped result object from the most recent Invoke-WarpAgent invocation.
The stored context is used for automatic conversation continuation on follow-on prompts.
By default the raw stored value is returned.
Use -AsObject to force conversion from JSON string to a PSCustomObject.

## EXAMPLES

### EXAMPLE 1

Get-WarpAgentContext

### EXAMPLE 2

Get-WarpAgentContext -AsObject

### EXAMPLE 3

(Get-WarpAgentContext -AsObject).conversation_id

## PARAMETERS

### -AsObject

Convert the stored context from a JSON string to a PSCustomObject.
Useful when the stored result is a JSON-formatted string with escaped characters.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
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

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}

