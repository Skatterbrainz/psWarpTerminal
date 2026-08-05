---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 05/05/2026
PlatyPS schema version: 2024-05-01
title: Set-WarpSchedule
---

# Set-WarpSchedule

## SYNOPSIS

Updates an existing Warp scheduled agent.

## SYNTAX

### Default

```
Set-WarpSchedule [-Id] <string> [-Name <string>] [-Cron <string>] [-Prompt <string>]
 [-Skill <string>] [-RemoveSkill] [-Model <string>] [-Environment <string>]
 [-RemoveEnvironment] [-Mcp <string[]>] [-RemoveMcp <string[]>] [-ConfigFile <string>]
 [-WorkerID <string>] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to update a scheduled agent's configuration.

## EXAMPLES

### EXAMPLE 1

Set-WarpSchedule -Id "sched-abc123" -Cron "0 10 * * *"

### EXAMPLE 2

Set-WarpSchedule -Id "sched-abc123" -Skill "myorg/repo:new-skill" -Prompt "Focus on tests"

### EXAMPLE 3

Get-WarpSchedule -Id "sched-abc123" | Set-WarpSchedule -RemoveSkill

## PARAMETERS

### -Id

Required. The ID of the schedule to update. May be piped from another command.


### -Name

Optional. Update the scheduled agent name.


### -Cron

Optional. Update the cron schedule expression.


### -Prompt

Optional. Update the prompt.


### -Skill

Optional. Update the skill spec (e.g. "repo:skill_name").


### -RemoveSkill

Remove the skill from this scheduled agent.


### -Model

Optional. Override the base model.


### -Environment

Optional. Cloud environment ID.


### -RemoveEnvironment

Remove the environment from this schedule.


### -Mcp

Optional. One or more MCP server specs to add.


### -RemoveMcp

Optional. One or more MCP server names to remove.


### -ConfigFile

Optional. Path to a YAML or JSON configuration file.


### -WorkerID

Optional. Where the job should be hosted.

