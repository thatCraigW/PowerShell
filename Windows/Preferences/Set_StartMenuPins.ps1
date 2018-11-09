function Pin-App { 
    param(
        [string]$appname,
        [switch]$unpin
    )
    try{
        if ($unpin.IsPresent){
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'From "Start" UnPin|Unpin from Start'} | %{$_.DoIt()}
            return "App '$appname' unpinned from Start"
        }else{
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'To "Start" Pin|Pin to Start'} | %{$_.DoIt()}
            return "App '$appname' pinned to Start"
        }
    }catch{
        Write-Error "Error Pinning/Unpinning App! (App-Name correct?)"
    }
}

# Start pinning stuff
Pin-App "Outlook"
Pin-App "Outlook 2016"          # Sometimes even on ProPlus these say 2016 for a while before changing to proper name
Pin-App "Word"
Pin-App "Word 2016"             # Sometimes even on ProPlus these say 2016 for a while before changing to proper name
Pin-App "Internet Explorer"
Pin-App "Excel"
Pin-App "Excel 2016"            # Sometimes even on ProPlus these say 2016 for a while before changing to proper name
Pin-App "PowerPoint"
Pin-App "PowerPoint 2016"       # Sometimes even on ProPlus these say 2016 for a while before changing to proper name
Pin-App "Google Chrome"
Pin-App "This PC"