Get-MailboxFolderStatistics user@domain.com | Where {$_.FolderPath -eq "/Top Of Information Store"} | Select FolderAndSubfolderSize,ItemsInFolderAndSubfolders;
Get-MailboxFolderStatistics user@domain.com | Where {$_.FolderPath -eq "/Inbox"} | Select Name,FolderAndSubfolderSize,ItemsInFolderAndSubfolders;
.\GetMailboxStats.ps1