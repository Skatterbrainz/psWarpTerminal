# Module-scoped state for agent conversation tracking
$script:LastAgentResult = $null
$script:LastConversationId = $null

('private', 'public') | ForEach-Object {
	Get-ChildItem -Path $(Join-Path -Path $PSScriptRoot -ChildPath $_) -Filter "*.ps1" | Foreach-Object {
        Write-Verbose "Importing $($_.FullName)"
		. $_.FullName
	}
}
