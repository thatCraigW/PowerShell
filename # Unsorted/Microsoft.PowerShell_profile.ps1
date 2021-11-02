# Current Version
  $profileVersion = "v2021.11"

# Set default directory
  Set-Location C:\

## Find out if the current user identity is elevated (has admin rights)
  $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
  $principal = New-Object Security.Principal.WindowsPrincipal $identity
  $isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

## Get all ipAddresses on this PC
  $ipAddresses = (Get-NetIPAddress | Where {$_.PrefixOrigin -eq 'Manual' -or $_.PrefixOrigin -eq 'DHCP'} | Select IPAddress).IPAddress
## Format the list to be separated by a comma and trailing space
  $ipAddresses = $ipAddresses -join ", "
## Public IP
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  $ipAddressPublic = (Invoke-WebRequest -uri "http://ifconfig.me/ip" -UseBasicParsing).Content

## Get today's date on reverse chron order (year, month, date) for sorting files
  $todaysDate = Get-Date -UFormat "%Y-%m-%d"

# Functions Below


## Replaces the existing windows powershell profile with latest one from github
function update {

  $profileType  = "Microsoft.PowerShell_profile.ps1"
  $profileURL   = "https://raw.githubusercontent.com/thatCraigW/PowerShell/master/%23%20Unsorted/"
  $latestURL    = "$profileURL$profileType"

  # Is it already set up, if so just update it
    if ( Test-Path "$env:OneDriveCommercial\Documents\WindowsPowerShell" ) { 
      Remove-Item -Path "$env:OneDriveCommercial\Documents\WindowsPowerShell\$profileType" -force -ErrorAction SilentlyContinue
      [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
      Invoke-WebRequest -Uri "$latestURL" -OutFile "$env:OneDriveCommercial\Documents\WindowsPowerShell\$profileType"
      Write-Host "Re-Loading Profile..."
      Start-Sleep (2)
        .$profile

    # else is it just set up elsewhere?  
      } elseif ( Test-Path "$env:USERPROFILE\Documents\WindowsPowerShell" ) { 
        Remove-Item -Path "$env:USERPROFILE\Documents\WindowsPowerShell\$profileType" -force -ErrorAction SilentlyContinue
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri "$latestURL" -OutFile "$env:USERPROFILE\Documents\WindowsPowerShell\$profileType"
        Write-Host "Re-Loading Profile..."
        Start-Sleep (2)
          .$profile

    # ok, couldn't find it, are they known-folder redirected? Download and run it there
      } elseif ( Test-Path "$env:OneDriveCommercial\Documents" ) { 
        Write-Host '  [' -NoNewline
        Write-Host '01 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Update routine starting"
        Write-Host '  [' -NoNewline
        Write-Host '02 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Creating folder to house file(s)"
          New-Item -Path "$env:OneDriveCommercial\Documents\WindowsPowerShell\" -ItemType Directory -Force | Out-Null
        Write-Host '  [' -NoNewline
        Write-Host '03 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Acquiring latest version from github"
          Remove-Item -Path "$env:OneDriveCommercial\Documents\WindowsPowerShell\$profileType" -force -ErrorAction SilentlyContinue
          [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
          Invoke-WebRequest -Uri "$latestURL" -OutFile "$env:OneDriveCommercial\Documents\WindowsPowerShell\$profileType"
        Write-Host '  [' -NoNewline
        Write-Host '04 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Re-Loading Profile..."
        Start-Sleep (2)
          .$profile

    # ok, couldn't find it, can't see that they're known-folder redirected? Downloading and running it in local docs
      } else {
        Write-Host '  [' -NoNewline
        Write-Host '01 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Update routine starting"
        Write-Host '  [' -NoNewline
        Write-Host '02 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Creating folder to house file(s)"
          New-Item -Path "$env:USERPROFILE\Documents\WindowsPowerShell\" -ItemType Directory -Force | Out-Null
        Write-Host '  [' -NoNewline
        Write-Host '03 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Acquiring latest version from github"
          Remove-Item -Path "$env:USERPROFILE\Documents\WindowsPowerShell\$profileType" -force -ErrorAction SilentlyContinue
          [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
          Invoke-WebRequest -Uri "$latestURL" -OutFile "$env:USERPROFILE\Documents\WindowsPowerShell\$profileType"
        Write-Host '  [' -NoNewline
        Write-Host '04 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Re-Loading Profile..."
        Start-Sleep (2)
          .$profile
      }
}

## Notepad++ vs Notepad
function np {

  if ( Test-Path 'C:\Program Files\Notepad++' ) { 
    & "C:\Program Files\Notepad++\notepad++.exe"
  } elseif ( Test-Path 'C:\Program Files (x86)\Notepad++' ) { 
    & "C:\Program Files (x86)\Notepad++\notepad++.exe"
  } else { 
    & "C:\Windows\System32\notepad.exe"
  }

}

## Help Display
function pshelp {
  Write-Host "Current Commands:"
  Write-Host "+ " -NoNewLine
  Write-Host "pshelp" -NoNewLine -ForegroundColor Yellow
  Write-Host "        = Displays this menu"
  Write-Host "+ " -NoNewLine
  Write-Host "update" -NoNewLine -ForegroundColor Yellow
  Write-Host "      = Updates this profile with the latest version from CraigW's github"
  Write-Host "+ " -NoNewLine
  Write-Host "aads" -NoNewLine -ForegroundColor Yellow
  Write-Host "        = Performs AzureAD Connect Delta Sync"
  Write-Host "+ " -NoNewLine
  Write-Host "np" -NoNewLine -ForegroundColor Yellow
  Write-Host "          = Opens Notepad++ if available, Notepad if not"
  Write-Host "+ " -NoNewLine
  Write-Host "pw" -NoNewLine -ForegroundColor Yellow
  Write-Host "          = Generates a basic user password (Easy to read)"
  Write-Host "+ " -NoNewLine
  Write-Host "spw" -NoNewLine -ForegroundColor Yellow
  Write-Host "         = Generates a secure user password (More Secure, but not complex)"
  Write-Host "+ " -NoNewLine
  Write-Host "cpw" -NoNewLine -ForegroundColor Yellow
  Write-Host "         = Generates a complex user password (12 characters, complex)"
  Write-Host "+ " -NoNewLine
  Write-Host "sudo" -NoNewLine -ForegroundColor Yellow
  Write-Host "        = Opens an elevated (admin) PowerShell window"
  Write-Host "+ " -NoNewLine
  Write-Host "speedtest" -NoNewLine -ForegroundColor Yellow
  Write-Host "   = Runs a command-line speed test"
  Write-Host "+ " -NoNewLine
  Write-Host "wol" -NoNewLine -ForegroundColor Yellow
  Write-Host "         = Prompts for MAC to Wake On LAN"
  Write-Host "+ " -NoNewLine
  Write-Host "immutable" -NoNewLine -ForegroundColor Yellow
  Write-Host "   = Prompts for UPN to set immutable ID to null"
  Write-Host " "
}



## AD Sync
function aads {
  Start-ADSyncSyncCycle -PolicyType delta
}

##  Generate user passwords quickly
function New-RandomPassword {
  
  # These passwords aren't for long-term use, just temporary handover passwords

  # Inputs
    Param(
      [Parameter(Mandatory=$False)]
      $type
    )

  # Colours
    $randomColours = 'Violet','White','Red','Green','Blue','Yellow','Orange','Purple','Pink','Brown'
    $randomColour = Get-Random -Minimum 0 -Maximum 9

  # Animals
    $randomAnimals = 'Dog','Cat','Frog','Horse','Sheep','Sparrow','Shark','Lion','Tiger','Bird'
    $randomAnimal = Get-Random -Minimum 0 -Maximum 9

  # Random Number
    $randomNumber = Get-Random -Minimum 10 -Maximum 99

  # Add together
    $randomPassword = $randomColours[$randomColour] + $randomAnimals[$randomAnimal] + $randomNumber

  # Start Secure password as matching initial random
    $securePassword = $randomPassword

  # Make Secure Password slightly more secure by replacing some characters
    $ReplaceChar = new-object System.Collections.Hashtable
    $ReplaceChar['i'] = "1"
    $ReplaceChar['I'] = "!"
    $ReplaceChar['e'] = "3"
    $ReplaceChar['E'] = "#"
    $ReplaceChar['s'] = "5"
    $ReplaceChar['S'] = "%"
    $ReplaceChar['o'] = "0"
    $ReplaceChar['O'] = ")"
    $ReplaceChar['a'] = "2"
    $ReplaceChar['A'] = "@"
    $ReplaceChar[' '] = ""

    $ReplaceChar.GetEnumerator() | ForEach-Object {
      $securePassword = $securePassword -creplace($_.key, $_.value)
    }

  # Create a complex password from 12 random ascii characters
    $complexPassword = -join (33..126 | ForEach-Object {[char]$_} | Get-Random -Count 12)
  
  # If no param set;
    $result = $randomPassword

  switch ( $type )
  {      
    "basic"   { $result = $randomPassword }
    "secure"  { $result = $securePassword }
    "complex" { $result = $complexPassword }
  }

  Write-Host " "
  Write-Host $result -ForegroundColor Red
  Write-Host " "

}

function pw {
  New-RandomPassword basic
}

function spw {
  New-RandomPassword secure
}

function cpw {
  New-RandomPassword complex
}

## Wake a device via MAC address on LAN
function wol {

  # Inputs
    Param(
      [Parameter(Mandatory=$True)]
      $mac
    )
  #$mac = "50:65:f3:3c:62:de"
  # do the stufffffff
    $MacByteArray = "$mac" -split "[:-]" | ForEach-Object { [Byte] "0x$_"}
    [Byte[]] $MagicPacket = (,0xFF * 6) + ($MacByteArray  * 16)
    $UdpClient = New-Object System.Net.Sockets.UdpClient
    $UdpClient.Connect(([System.Net.IPAddress]::Broadcast),7)
    $UdpClient.Send($MagicPacket,$MagicPacket.Length)
    $UdpClient.Close()

    Write-Host "Wake On LAN attempted for: " -NoNewline -ForegroundColor Yellow
    Write-Host $mac -ForegroundColor Red
    Write-Host " "

}

## Run Powershell, elevated this time
function sudo {
    if ($args.Count -gt 0)
    {   
       $argList = "& '" + $args + "'"
       Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $argList
    }
    else
    {
       Start-Process "$psHome\powershell.exe" -Verb runAs
    }
}

## Set a users' immutable ID to null
function immutable {

  # Inputs
    Param(
      [Parameter(Mandatory=$True)]
      $user
    )

  # Set the user immutable
    Set-MSOLUser -UserPrincipalName $user -ImmutableID "$null"

}

## Perform no-ads command-line speed test
function speedtest {

  $URLspeedtestEXE = "https://github.com/thatCraigW/WindowsDrivers/raw/master/ookla-speedtest-1.0.0-win64/speedtest.exe"
  $URLspeedtestMD  = "https://github.com/thatCraigW/WindowsDrivers/raw/master/ookla-speedtest-1.0.0-win64/speedtest.md"

  # Is it already set up, if so just run it
    if ( Test-Path "$env:OneDriveCommercial\Documents\WindowsPowerShell\ookla-speedtest-1.0.0-win64" ) { 
      & "$env:OneDriveCommercial\Documents\WindowsPowerShell\ookla-speedtest-1.0.0-win64\speedtest.exe"  --accept-license --accept-gdpr

    # else is it just set up elsewhere?  
      } elseif ( Test-Path "$env:USERPROFILE\Documents\WindowsPowerShell\ookla-speedtest-1.0.0-win64" ) { 
        & "$env:USERPROFILE\Documents\WindowsPowerShell\ookla-speedtest-1.0.0-win64\speedtest.exe"  --accept-license --accept-gdpr

    # ok, couldn't find it, are they known-folder redirected? Install and run it there
      } elseif ( Test-Path "$env:OneDriveCommercial\Documents" ) { 
        Write-Host '  [' -NoNewline
        Write-Host '01 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Speedtest command-line files cannot be found"
        Write-Host '  [' -NoNewline
        Write-Host '02 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Creating folder to house files"
          New-Item -Path "$env:OneDriveCommercial\Documents\WindowsPowerShell\ookla-speedtest-1.0.0-win64" -ItemType Directory -Force | Out-Null
        Write-Host '  [' -NoNewline
        Write-Host '03 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Acquiring Speedtest command-line files as they don't exist"
          [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
          wget "$URLSpeedtestEXE" -outfile "$env:OneDriveCommercial\Documents\WindowsPowerShell\ookla-speedtest-1.0.0-win64\speedtest.exe"
          wget "$URLSpeedtestMD" -outfile "$env:OneDriveCommercial\Documents\WindowsPowerShell\ookla-speedtest-1.0.0-win64\speedtest.MD"
        Write-Host '  [' -NoNewline
        Write-Host '04 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Running Speedtest"
          & "$env:OneDriveCommercial\Documents\WindowsPowerShell\ookla-speedtest-1.0.0-win64\speedtest.exe"  --accept-license --accept-gdpr

    # ok, couldn't find it, can't see that they're known-folder redirected? Installing and running it in local docs
      } else {
        Write-Host '  [' -NoNewline
        Write-Host '01 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Speedtest command-line files cannot be found"
        Write-Host '  [' -NoNewline
        Write-Host '02 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Creating folder to house files"
          New-Item -Path "$env:USERPROFILE\Documents\WindowsPowerShell\ookla-speedtest-1.0.0-win64\" -ItemType Directory -Force | Out-Null
        Write-Host '  [' -NoNewline
        Write-Host '03 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Acquiring Speedtest command-line files as they don't exist"...""
          [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
          wget "$URLSpeedtestEXE" -outfile "$env:USERPROFILE\Documents\WindowsPowerShell\ookla-speedtest-1.0.0-win64\speedtest.exe"
          wget "$URLSpeedtestMD" -outfile "$env:USERPROFILE\Documents\WindowsPowerShell\ookla-speedtest-1.0.0-win64\speedtest.MD"
        Write-Host '  [' -NoNewline
        Write-Host '04 of 04' -ForegroundColor White -NoNewline
        Write-Host ']: ' -NoNewline
        Write-Host "Running Speedtest"
          & "$env:USERPROFILE\Documents\WindowsPowerShell\ookla-speedtest-1.0.0-win64\speedtest.exe"  --accept-license --accept-gdpr
      }
}

# Set up the logging of our files, sorted per day
  #Start-Transcript -Path "$env:OneDriveCommercial\Documents\WindowsPowerShell\$todaysDate Transcript-Windows.txt" -Append
  ## Maybe don't do this, it doesn't seem to print out nicely; there must be a better way !

# Auto-Update profile if more than 30 days old 
  ## I've put in the hours and minutes here if you really want to tweak more specifically, but they're not required. 
  ## You can just end it at AddDays(-30) if you like ¯\_(ツ)_/¯
  
  <# Commented out 2021-11
  
  if (Test-Path $profile -OlderThan (Get-Date).AddDays(-30).AddHours(-1).AddMinutes(-1)) {
        # older
        Write-Host "yep dis old"
        update
    } else {
        # newer
        Write-Host "nah this not too old"
    }
  
  #>

# Hide the on-screen output of those commands for neatness
  Clear-Host

# Initial Greeting / logon tips
  Write-Host `n"You're running PowerShell version: " -NoNewLine
  Write-Host $host.Version.Major -ForegroundColor DarkCyan
  Write-Host "Your computer name is: " -NoNewLine
  Write-Host (Get-ChildItem Env:\COMPUTERNAME).Value -ForegroundColor DarkCyan
  Write-Host "Your profile version is: " -NoNewLine
  Write-Host $profileVersion -ForegroundColor DarkCyan
  Write-Host "Your IP(s): " -NoNewLine
  Write-Host $ipAddresses -ForegroundColor DarkCyan
  Write-Host "Public IP: " -NoNewLine
  Write-Host $ipAddressPublic -ForegroundColor DarkCyan
  Write-Host `n"Current Aliases:"
  Write-Host "+ Type  " -NoNewLine
  Write-Host "pshelp" -NoNewLine -ForegroundColor Yellow
  Write-Host "  to view built-in commands & helpers +"
  Write-Host " "
  

# Formatting the window & line prompt with date / style
function Prompt {

  # Format window title to have date and username in it
    if($isAdmin){
      $Host.UI.RawUI.WindowTitle = (Get-Date -UFormat '%Y/%m/%d %R').Tostring() + " - " + (Get-ChildItem Env:\USERNAME).Value + " [Running as Admin]"
    } else {
      $Host.UI.RawUI.WindowTitle = (Get-Date -UFormat '%Y/%m/%d %R').Tostring() + " - " + (Get-ChildItem Env:\USERNAME).Value + " [Running as User]"
    }

  # Stylizing the prompt to have [00:00:00]: PS C:\> in it
    Write-Host '[' -NoNewline
    Write-Host (Get-Date -UFormat '%T') -ForegroundColor Gray -NoNewline
    Write-Host ']: PS ' -NoNewline
    Write-Host (Split-Path (Get-Location) -Leaf) -NoNewline
    return "> "
}


# Preferences to set up terminal to begin with;

## CraigW's preferred colour pattern to match VSCode colours
# Terminal Text Colors  - R:147 G:153 B:184
# Terminal Background   - R:41 G:45 B:62
# Terminal Font         - Size:14 Family:Consolas

## Confirm path to profile isn't broken / alias is working
# Test-Path $profile

## Creates blank ps profile file ready to go
## Should be stored in $env:USERPROFILE\Documents\WindowsPowerShell\
## or stored in $env:OneDriveCommercial\Documents\WindowsPowerShell\ if Known Folder Redirection is live
# New-Item -ItemType File -Path $profile -Force 
