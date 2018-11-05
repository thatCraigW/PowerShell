#Connect to Office 365

$cred = Get-Credential
$session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $cred -Authentication Basic -AllowRedirection
Import-PSSession $session

#Prompt user for location and filename to save output

$file = Read-Host "Enter location and file name to save results, e.g. C:\temp\results.csv: "

#Script to load all mailboxes, get current time zone and output to a CSV file

$Users = Get-Mailbox -ResultSize unlimited -Filter {(RecipientTypeDetails -eq 'UserMailbox, RoomMailbox, SharedMailbox')} $Users | Get-MailboxRegionalConfiguration | select Identity,TimeZone, TimeFormat, DateFormat, Language | Export-CSV $file