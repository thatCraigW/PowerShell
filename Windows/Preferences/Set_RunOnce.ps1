#Reboots and starts next script
$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
Set-ItemProperty -Path $RunOnceKey -Name 'NextRun' -Value 'C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionpolicy Bypass -windowstyle hidden -File "C:\Windows\Resources\AIO_DeBloater.ps1" '
