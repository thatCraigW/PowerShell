#Connect to Office 365

$cred = Get-Credential
$session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $cred -Authentication Basic -AllowRedirection
Import-PSSession $session

# Set Legal hold on all mailboxes to 7 years

Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "UserMailbox, SharedMailbox, Roommailbox"} | Set-Mailbox -LitigationHoldEnabled $true -LitigationHoldDuration 2555