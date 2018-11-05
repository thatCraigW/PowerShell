$cred = Get-Credential
$CSSession = New-CsOnlineSession -Credential $cred
Import-PSSession $CSSession -AllowClobber