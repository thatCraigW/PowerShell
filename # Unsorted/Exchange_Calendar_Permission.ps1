$boxen = get-mailbox -Resultsize Unlimited
foreach ($box in $boxen) {
    $addresses = $box.EmailAddresses
    foreach ( $address in $addresses ) {
        [string]$ID = $address.AddressString
        write-host ID1 $ID
        $ID += ":\Calendar"
        $permissions = get-mailboxfolderpermission $ID
        write-host ID: $ID
        foreach ( $perm in $permissions ) {
            $mailbox = $address
            $granteduser = $perm.User
            $access = $perm.AccessRights
            $identity = $perm.Identity
            $valid = $perm.IsValid
            if ( $identity -ne "Anonymous" ) {
                $outstring = "$mailbox,$granteduser,$identity,$access,$valid`n"
                $output += $outstring
                write-host $outstring
            }
        }
    }
}
set-content C:\temp\calendarPermissions.csv $output