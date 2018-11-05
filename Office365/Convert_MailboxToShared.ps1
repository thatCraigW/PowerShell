$user = Read-Host "Email Address to Convert to Shared Mailbox"
Get-Mailbox -Identity $user | Format-List RecipientTypeDetails
Set-Mailbox -Identity $user -Type Shared
Set-Mailbox -Identity $user -HiddenFromAddressListsEnabled $true
Get-Mailbox -Identity $user | Format-List RecipientTypeDetails