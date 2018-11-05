$registryPath = "HKLM:\SOFTWARE\Microsoft\Office\16.0\Common\Identity"
$Name = "DisableADALatopWAMOverride"
$nameTWO = "EnableADAL"
$value = "00000001"
$valueTWO = "00000000"

$subfolderTest = Test-Path "$registryPath"

if (-NOT ($subfolderTest -eq "True")) 
{
    New-Item -Path HKLM:\Software\Microsoft\Office\16.0\Common -Name Identity
}


New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null

New-ItemProperty -Path $registryPath -Name $nameTWO -Value $valueTWO -PropertyType DWORD -Force | Out-Null
