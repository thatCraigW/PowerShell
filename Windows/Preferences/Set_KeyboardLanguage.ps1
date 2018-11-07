# Add secondary en-US keyboard
Function AddENKeyboard {
	Write-Output "Adding secondary en-US keyboard..."
	$langs = Get-WinUserLanguageList
	$langs.Add("en-US")
	Set-WinUserLanguageList $langs -Force
}

# Remove secondary en-US keyboard
Function RemoveENKeyboard {
	Write-Output "Removing secondary en-US keyboard..."
	$langs = Get-WinUserLanguageList
	Set-WinUserLanguageList ($langs | Where-Object {$_.LanguageTag -ne "en-US"}) -Force
}

# Remove en-INTL keyboard, leave US only
Function ForceUSONLYKeyboard {
	Write-Output "Hard Forcing single en-US language with no special keyboards..."
	Set-WinUserLanguageList -LanguageList en-US -Force
}

# Remove en-INTL keyboard, leave AU as secondary option
Function ForceUSandAUKeyboard {
	Write-Output "Hard Forcing single en-US language with no special keyboards..."
	Set-WinUserLanguageList -LanguageList en-US, en-AU -Force
}
#AddENKeyboard
#RemoveENKeyboard
ForceUSONLYKeyboard
#ForceUSandAUKeyboard