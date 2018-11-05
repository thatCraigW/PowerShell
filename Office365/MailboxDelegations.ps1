### Send-as permissions

Get-RecipientPermission username | Format-List

Add-RecipientPermission username -Trustee username2 -AccessRights SendAs -Confirm:$False

Remove-RecipientPermission username -AccessRights SendAs -Trustee username2

Get-Mailbox -resultsize Unlimited | Select-Object alias | ForEach-Object{ Remove-RecipientPermission Investigator_Room -AccessRights SendAs -Trustee $_.alias -Confirm:$false }

Get-Mailbox -resultsize Unlimited | Select-Object alias | ForEach-Object { Remove-MailboxPermission -Identity Investigator_Room -User $_.alias -AccessRights FullAccess, SendAs,ExternalAccount,DeleteItem,ReadPermission,ChangePermission,ChangeOwner -InheritanceType All -Confirm:$false }


### Full Access permissions

Get-MailboxPermission -Identity username | Format-List

Add-MailboxPermission -Identity username -User username2 -AccessRights FullAccess

Remove-MailboxPermission -Identity username -User username2 -AccessRights FullAccess -InheritanceType All


### Shared Mailbox send on behalf

Get-Mailbox SharedMailboxAddress | ft Name,grantsendonbehalfto -wrap

Set-Mailbox SharedMailboxAddress –Grantsendonbehalfto @{add="email1@domain.com,email2@domain.com"}

Set-Mailbox SharedMailboxAddress –Grantsendonbehalfto @{remove="email1@domain.com,email2@domain.com"}

Get-Mailbox -resultsize Unlimited | Select-Object alias | ForEach-Object { Set-Mailbox Investigator_Room –Grantsendonbehalfto @{remove=$_.alias} }
