# Enable Windows 7 Photo Viewer
Function EnableWin7PhotoViewer {
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
    Write-Output "Enabling Windows 7 Photo Viewer..."
    Set-Variable -Name Folder0Path -value "HKCR:\Applications"
    Set-Variable -Name Folder1Path -value "HKCR:\Applications\photoviewer.dll"
    Set-Variable -Name Folder1Name -value "photoviewer.dll"
    Set-Variable -Name Folder2Path -value "HKCR:\Applications\photoviewer.dll\shell"
    Set-Variable -Name Folder2Name -value "shell"
    Set-Variable -Name Folder3Path -value "HKCR:\Applications\photoviewer.dll\shell\open"
    Set-Variable -Name Folder3Name -value "open"
    Set-Variable -Name Folder4Path -value "HKCR:\Applications\photoviewer.dll\shell\open\command"
    Set-Variable -Name Folder4Name -value "command"
    Set-Variable -Name Folder5Path -value "HKCR:\Applications\photoviewer.dll\shell\open\DropTarget"
    Set-Variable -Name Folder5Name -value "DropTarget"
    Set-Variable -Name Folder6Path -value "HKCR:\Applications\photoviewer.dll\shell\print"
    Set-Variable -Name Folder6Name -value "print"
    Set-Variable -Name Folder7Path -value "HKCR:\Applications\photoviewer.dll\shell\print\command"
    Set-Variable -Name Folder7Name -value "command"
    Set-Variable -Name Folder8Path -value "HKCR:\Applications\photoviewer.dll\shell\print\DropTarget"
    Set-Variable -Name Folder8Name -value "DropTarget"

    for ($i=1; $i -le 8; $i++)
    {
        $b = $i-1
        $curFolder = Get-Variable -Name "Folder$i`Path" -ValueOnly
        $curFolderName = "Folder$i`Path"
        $prevFolder = Get-Variable -Name "Folder$b`Path" -ValueOnly
        $curName = Get-Variable -Name "Folder$i`Name" -ValueOnly

        # 5 is sibling, not child of previous; so set prev folder to correct parent
        if ($curFolderName.contains("5"))
        {
            Write-Host "Current Folder was 5"
            $prevFolder = Get-Variable -Name "Folder3Path" -ValueOnly
        }

        # 6 is sibling of 3, not child of previous; so set prev folder to correct parent
        if($curFolderName.contains("6"))
        {
            Write-Host "Current Folder was 6"
            $prevFolder = Get-Variable -Name "Folder2Path" -ValueOnly
        }

        # 8 is sibling, not child of previous; so set prev folder to correct parent
        if($curFolderName.contains("8"))
        {
            Write-Host "Current Folder was 8"
            $prevFolder = Get-Variable -Name "Folder6Path" -ValueOnly
        }

        # This line was just for testing before executing to ensure we found what we needed to find
        # Write-Host " Current: $curFolder, Prev: $prevFolder, Current: $curName"

        # This is the loop that will go through each of our 8 folders and make sure their path exists and create if it doesn't
        if (-NOT ((Test-Path $curFolder) -eq "True")) 
        {
            New-Item -Path $prevFolder -Name $curName
        }

    }

    # Finally, we can set the invidual keys
    #New-ItemProperty -Path $FullPathtoKey -Name $keyName -Value $keyValue -PropertyType $keyType -Force | Out-Null
    New-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\open" -Name "MuiVerb" -Value "@photoviewer.dll,-3043" -Force | Out-Null
    New-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\open\command" -Name "(Default)" -Value "%SystemRoot%\System32\rundll32.exe `"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll`", ImageView_Fullscreen %1" -PropertyType "MultiString" -Force | Out-Null
    New-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\open\DropTarget" -Name "Clsid" -Value "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" -PropertyType "String" -Force | Out-Null
    New-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\print\command" -Name "(Default)" -Value "%SystemRoot%\System32\rundll32.exe `"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll`", ImageView_Fullscreen %1" -PropertyType "MultiString" -Force | Out-Null
    New-ItemProperty -Path "HKCR:\Applications\photoviewer.dll\shell\print\DropTarget" -Name "Clsid" -Value "{60fd46de-f830-4894-a628-6fa81bc0190d}" -PropertyType "String" -Force | Out-Null
}

EnableWin7PhotoViewer