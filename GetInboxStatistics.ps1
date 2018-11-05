$Mailboxes = Get-Mailbox

$Results = foreach( $Mailbox in $Mailboxes ){
    $inboxstats = Get-MailboxFolderStatistics $mailbox -FolderScope Inbox | Where-Object {$_.FolderPath -eq "/Inbox"}
 
    $mbObj = New-Object PSObject
    $mbObj | Add-Member -MemberType NoteProperty -Name "Display Name" -Value $mailbox.DisplayName
    $mbObj | Add-Member -MemberType NoteProperty -Name "Inbox Size (Mb)" -Value $inboxstats.FolderandSubFolderSize.ToMB()
    $mbObj | Add-Member -MemberType NoteProperty -Name "Inbox Items" -Value $inboxstats.ItemsinFolderandSubfolders
    $report += $mbObj
	}

$Results | Format-List


<#

$Mailboxes = Get-Mailbox

$Results = foreach( $Mailbox in $Mailboxes ){
    $Folders = $MailBox |
        Get-MailboxFolderStatistics -FolderScope Inbox | Where-Object {$_.FolderPath -eq "/Inbox"}|
        Measure-Object |
        Select-Object -ExpandProperty Count

    New-Object -TypeName PSCustomObject -Property @{
        Username    = $Mailbox.DisplayName
        FolderCount = $Folders
        }
    }

$Results |
    Select-Object -Property Username, FolderCount

#>

#IsMailboxEnabled