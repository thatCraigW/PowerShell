$Mailboxes = Get-Mailbox

$Results = foreach( $Mailbox in $Mailboxes ){
    $Folders = $MailBox |
        Get-MailboxFolderStatistics |
        Measure-Object |
        Select-Object -ExpandProperty Count

    New-Object -TypeName PSCustomObject -Property @{
        Username    = $Mailbox.Alias
        FolderCount = $Folders
        }
    }

$Results |
    Select-Object -Property Username, FolderCount