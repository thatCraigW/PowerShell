#Create a PST file

New-MailboxExportRequest -Mailbox <user> -FilePath \\<server FQDN>\<shared folder name>\<PST name>.pst

#Check on export Progress

Get-MailboxExportRequestStatistics -Identity username\MailboxExport
