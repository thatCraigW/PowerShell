Function SetDeBloaterToRunOnce {
    # HAY WHAT WE DOING?
    Write-Host "Attempting to mount default registry hive"

    # Apparently we're loading a registry hive, the default user in fact!
    & REG LOAD HKLM\DEFAULT C:\Users\Default\NTUSER.DAT

    # Oh and we're checking if a path exists
    $subfolderTest = Test-Path "HKLM:\DEFAULT\Software\Microsoft\Windows\CurrentVersion\RunOnce"

    # And then creating it, if it doesn't
    if (-NOT ($subfolderTest -eq "True")) 
    {
        New-Item -Path "HKLM:\DEFAULT\Software\Microsoft\Windows\CurrentVersion" -Name "Runonce"
    }

    # Oh and then we're messing with the RunOnce key, so the first time users log on something runs... once...
    $RunOnceKey = "HKLM:\DEFAULT\Software\Microsoft\Windows\CurrentVersion\RunOnce"
    Set-ItemProperty -Path $RunOnceKey -Name 'NextRun' -Value 'C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionpolicy Bypass -windowstyle hidden -File "C:\Windows\Resources\AIO_DeBloater.ps1" '

    # Here we set vars for a while loop
    $unloaded = $false
    $attempts = 0

    # Wile loop tries to unload the hive, up to 5 times in case it lags
    while (!$unloaded -and ($attempts -le 5)) {
    [gc]::Collect() # necessary call to be able to unload registry hive
    & REG UNLOAD HKLM\DEFAULT
    $unloaded = $?
    $attempts += 1
    }

    # If its still not unloaded, spit out an error message
    if (!$unloaded) {
        Write-Warning "Unable to dismount default user registry hive at HKLM\DEFAULT - manual dismount required"
    }

    # WE DONE HERE
}

SetDeBloaterToRunOnce