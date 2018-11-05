$user = Read-Host "Enter user email address to be removed: "

Remove-MsolUser -UserPrincipalName $user -force
Remove-MsolUser -UserPrincipalName $user -RemoveFromRecycleBin -Force