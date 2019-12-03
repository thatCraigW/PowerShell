<#

.SYNOPSIS
    This script is designed to deploy printers to Windows 10 workstations directly without GPO.
    It's 90% the same as the InTune script, just getting from a known-safe (controlled) Internet location.

.DESCRIPTION
    Written by Craig Warren
    Version 0.1

    #########################
    #      Change Log       #
    #########################
    
    #  2018-11-15 v0.1 - Initial Release
    #  Features
    # - Download from safe-known / self-managed internet path (github?)
    # - Unzip Printer Driver package
    # - Install a driver to the local driver store using pnputil
    # - Install Local Printer with custom port
    # - Set defaults on the printer (B&W, Double Sided etc)
    
#>

# Setup: General
    #Current Script Location
    $PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
    #Current Time and Date
    $TimeDate = Get-Date -Format "yyyy-MM-dd-HH:mm:ss"

# Setup: Printer

    # Variables below surrounded in quotes are expected to be passed from another script. You can hardcode them if need be. e.g. $PrinterName = "Steve's Printer"

    #Printer Name (Seen by End User)
    $PrinterName = "$printerName"
    #Printer Driver Name (Collect from inside INF file)
    $PrinterDriver = "$driverName"
    $PrinterDriverZipName = $PrinterDriver -replace " ","-"
    #Driver INF to install
    $PrinterDriverInf = "$infName"
    #Path to Inf file for printer driver installation
    $InstallDriverPath = "C:\Temp\$PrinterDriverZipName\$infName"
    #Printer IP Address
    $PrinterIPAddress = "$printerIP"
    #Printer Port Name
    $PrinterPortName = "TCPIP:$PrinterIPAddress"


# Setup: Printer Defaults
    $PrinterDuplexMode = "$printerDuplexMode"
    $PrinterColourMode = "$printerColourMode"
    $PrinterPaperSize = "$printerPaperSize"

# Setup: Download Driver
    # Download zip - replace $driverURL with "https://safe-known-websitethatishostingyour/zipfile.zip"
    wget "$driverURL" -outfile "C:\Temp\$PrinterDriverZipName.zip"

    # Create Folder
    if(!(Test-Path "C:\Temp")){
        New-Item -Path "C:\Temp" -ItemType Directory -Force
    }

    # Extract to location
    Expand-Archive -LiteralPath "C:\Temp\$printerDriverZipName.zip" -DestinationPath "C:\Temp"


# Code Execution
try {
    # Create Driver, Port and Printer
    $PNPUtil = $env:windir + "\system32\" + 'pnputil.exe'
    & $PNPUtil /add-driver $InstallDriverPath
    Add-PrinterDriver -Name $PrinterDriver
    Add-PrinterPort -Name $PrinterPortName -PrinterHostAddress $PrinterIPAddress
    Add-Printer -Name $PrinterName -PortName $PrinterPortName -DriverName $PrinterDriver

    # Set defaults on the printer
    Set-PrintConfiguration -PrinterName $PrinterName -DuplexingMode $PrinterDuplexMode -Color $PrinterColourMode -PaperSize $PrinterPaperSize
}
catch [system.exception]
{
	$err = $_.Exception.Message
	#LogWrite "Unable to deploy printer, `r`nError: $err" -type e
    #End of Script
    #LogWrite "$eventlogSource script completed unsuccessfully- $TimeDate" -type end
	Write-Host "Unable to deploy printer, `r`nError: $err"
    #End of Script
    Write-Host "$eventlogSource script completed unsuccessfully- $TimeDate"
} 