# Module-scoped state for agent conversation tracking
$script:LastAgentResult = $null
$script:LastConversationId = $null

# Cache for model tab-completion (5-minute TTL)
$script:ModelCache = $null
$script:ModelCacheExpiry = [datetime]::MinValue

# Cache for MCP tab-completion (5-minute TTL)
$script:McpCache = $null
$script:McpCacheExpiry = [datetime]::MinValue

('private', 'public') | ForEach-Object {
	Get-ChildItem -Path $(Join-Path -Path $PSScriptRoot -ChildPath $_) -Filter "*.ps1" | Foreach-Object {
        Write-Verbose "Importing $($_.FullName)"
		. $_.FullName
	}
}

# Register tab-completion for -Model parameter
$script:ModelCompleter = {
	param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
	if (-not $script:ModelCache -or (Get-Date) -gt $script:ModelCacheExpiry) {
		$script:ModelCache = @(Get-WarpModel | ForEach-Object { $_.id })
		$script:ModelCacheExpiry = (Get-Date).AddMinutes(5)
	}
	$script:ModelCache | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
		$val = if ($_ -match '\s') { "'$_'" } else { $_ }
		[System.Management.Automation.CompletionResult]::new($val, $_, 'ParameterValue', $_)
	}
}
Register-ArgumentCompleter -CommandName Invoke-WarpAgent -ParameterName Model -ScriptBlock $script:ModelCompleter
Register-ArgumentCompleter -CommandName New-WarpSchedule -ParameterName Model -ScriptBlock $script:ModelCompleter

# Register tab-completion for -Mcp parameter
$script:McpCompleter = {
	param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
	if (-not $script:McpCache -or (Get-Date) -gt $script:McpCacheExpiry) {
		$script:McpCache = @(Get-WarpMcp | ForEach-Object { $_.name })
		$script:McpCacheExpiry = (Get-Date).AddMinutes(5)
	}
	$script:McpCache | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
		$val = if ($_ -match '\s') { "'$_'" } else { $_ }
		[System.Management.Automation.CompletionResult]::new($val, $_, 'ParameterValue', $_)
	}
}
Register-ArgumentCompleter -CommandName Invoke-WarpAgent -ParameterName Mcp -ScriptBlock $script:McpCompleter
