<#
This script is designed to receive variables from LabTech to check path and then create the key
First variable declarations generally should be replaced with @variableName@ in LabTech
NOTE: LabTech only allows 5 parameter input, this is the maximum.
#>

$registryPath = "@registryPath@"                        # Set in LT e.g. "HKLM:\SOFTWARE\Microsoft\Office\16.0\Common"
$registryKey = "@registryFolder@"                       # Set in LT e.g. "Identity"
$registryFullPath = "@registryPath@\@registryFolder@"   
$keyONE = "@keyONE@"                                    # Set in LT e.g. "DisableADALatopWAMOverride"
$keyTypeONE = "@keyTypeONE@"                            # Set in LT e.g. "DWORD"
$valueONE = "@keyValueONE@"                             # Set in LT e.g. "00000001"

$subfolderTest = Test-Path "$registryFullPath"

if (-NOT ($subfolderTest -eq "True")) 
{
    New-Item -Path @registryPath@ -Name @registryFolder@
}


New-ItemProperty -Path $registryFullPath -Name $keyONE -Value $valueONE -PropertyType $keyTypeONE -Force | Out-Null


# Raw Windows hard code
## This particular example disables Office 365 ProPlus' Azure AD Authentication Library (ADAL), 
## because from Win10 v1703 b15063.138 onwards we use Office's Web Account Manager (WAM) to Authenticate

<#

    $registryPath = "HKLM:\SOFTWARE\Microsoft\Office\16.0\Common\Identity"
    $Name = "DisableADALatopWAMOverride"
    $value = "00000001"

    $subfolderTest = Test-Path "$registryPath"

    if (-NOT ($subfolderTest -eq "True")) 
    {
        New-Item -Path HKLM:\Software\Microsoft\Office\16.0\Common -Name Identity
    }


    New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null

#>