
$cred = Get-Credential
$o365 = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $cred -Authentication Basic -AllowRedirection
Import-PSSession $o365 -DisableNameChecking