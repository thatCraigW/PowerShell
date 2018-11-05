$cred = Get-Credential
Import-Module SkypeOnlineConnector
$cssession = New-CsOnlineSession $cred
Import-PSSession $cssession -AllowClobber
Get-CsTenant | fl DisplayName