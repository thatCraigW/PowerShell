# Get list of all volumes on computer that meet criteria
# ------Has a drive letter
# ------Is of Fixed volume Drive type.
# ------has over 30gb capacity.
# ------Is not a USB.

$blvols = Get-BitLockerVolume # List of all volumes that can be bitlockered.
$res = ""
$blList = ""

# Loop through and collect each of the drive letters associated with USB logical disks.
$driveLetters = Get-CimInstance -Class Win32_DiskDrive -Filter 'InterfaceType != "USB"' -KeyOnly | 
    Get-CimAssociatedInstance -ResultClassName Win32_DiskPartition -KeyOnly |
    Get-CimAssociatedInstance -ResultClassName Win32_LogicalDisk | Where-Object {$_.Size -gt 30000000000}

foreach($blv in $blvols)
{    
    $letter = "$($blv.MountPoint)" -replace '[\W]'
    $vol = Get-Volume -DriveLetter $letter 
    if($driveLetters.DeviceID.Contains($blv.MountPoint))
    {
        if($blv.ProtectionStatus -eq 'Off')
        {
           # Write-Output "Bitlockering $($vol.DriveLetter)"
            $res += "Checking out $($blv.MountPoint)`n -----------------`n+     Drive met the required criteria`n+     Volume Mount Type : $($vol.DriveType)`n+     Volume Drive Size(>30 GB) : $($vol.Size/1GB) GB`n+     Volume Bitlocker Status: $($blv.ProtectionStatus)`r`n"
        }
        else{
             #Write-Output "Bitlocker already enabled on $($vol.DriveLetter)"
            $res += "Checking out $($blv.MountPoint)`n -----------------`n+     Drive met the required criteria, already bitlockered`n+     Volume Mount Type : $($vol.DriveType)`n+     Volume Drive Size(>30 GB) : $($vol.Size/1GB) GB`n+     Volume Bitlocker Status: $($blv.ProtectionStatus)`n+     Volume Encryption Status : $($blv.EncryptionPercentage)`r`n"
        }
    }
    else{
        #Write-Output "$($vol.DriveLetter) did not meet the required criteria"
        $res += "Checking out $($blv.MountPoint)`n -----------------`n+     Drive did not meet the required criteria`n+     Volume Mount Type : $($vol.DriveType)`n+     Volume Drive Size(>30 GB) : $($vol.Size/1GB) GB`n+     Volume Bitlocker Status: $($blv.ProtectionStatus)`r`n"
    }
}

Write-Output $res