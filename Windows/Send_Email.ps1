$devName = Hostname
$smtpCred = (Get-Credential)                # You could hard-code something here, if the script contents are never seen. Otherwise read in a hash?
$ToAddress = 'email@domain'                     # If you do hard-code, you likely don't need this up here (only here for prompt), can be direct in $mailparam
$FromAddress = 'PowerShell@domain.com'      # Suggest making a service account/shared mailbox for these to authenticate it
$SmtpServer = 'smtp.office365.com'          # o365 server as example
$SmtpPort = '587'                           # o365 port, als -UseSsl at the end

$mailparam = @{
    To = $ToAddress
    From = $FromAddress
    Subject = "Ran <scriptname> on $devName - Fail/Success"
    Body = "We Ran <scriptname> on $devName - and this happened:</br></br>Fail/Success</br></br>verbose details here"
    SmtpServer = $SmtpServer
    Port = $SmtpPort
    Credential = $smtpCred
}

Send-MailMessage @mailparam -UseSsl         # will fail on MFA accounts, at least I think it should?