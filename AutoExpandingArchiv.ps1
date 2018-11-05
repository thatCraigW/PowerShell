

#------------------------------------------------------------------------------
# THIS CODE AND ANY ASSOCIATED INFORMATION ARE PROVIDED “AS IS” WITHOUT
# WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT
# LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
# FOR A PARTICULAR PURPOSE. THE ENTIRE RISK OF USE, INABILITY TO USE, OR 
# RESULTS FROM THE USE OF THIS CODE REMAINS WITH THE USER.
#
#------------------------------------------------------------------------------
# Author: Eyal Doron 
# Version: 1.1 
# Last Modified Date: 23/09/2017  
# Last Modified By: eyal@o365info.com
# Web site: http://o365info.com
# sn -AA0016789sssssax
#------------------------------------------------------------------------------
# Hope that you enjoy it ! 
# And, may the force of PowerShell will be with you  :-)
# ------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# PowerShell Functions
#------------------------------------------------------------------------------

function checkConnection ()
{
		$a = Get-PSSession
		if ($a.ConfigurationName -ne "Microsoft.Exchange")
		{
			
			write-host     'You are not connected to Exchange Online PowerShell ;-(         ' 
			write-host      'Please connect using the Menu option 1) Login to Office 365 + Exchange Online using Remote PowerShell        '
			#Read-Host "Press Enter to continue..."
			Add-Type -AssemblyName System.Windows.Forms
			[System.Windows.Forms.MessageBox]::Show("You are not connected to Exchange Online PowerShell ;-( `nSelect menu 1 to connect `nPress OK to continue...", "o365info.com PowerShell script", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
			Clear-Host
			break
		}
}



Function DisconnectExchangeOnline ()
{
Get-PSSession | Where-Object {$_.ConfigurationName -eq "Microsoft.Exchange"} | Remove-PSSession

}


Function Set-AlternatingRows {
       <#
       
       #>
    [CmdletBinding()]
       Param(
             [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [string]$Line,
       
           [Parameter(Mandatory=$True)]
             [string]$CSSEvenClass,
       
        [Parameter(Mandatory=$True)]
           [string]$CSSOddClass
       )
       Begin {
             $ClassName = $CSSEvenClass
       }
       Process {
             If ($Line.Contains("<tr>"))
             {      $Line = $Line.Replace("<tr>","<tr class=""$ClassName"">")
                    If ($ClassName -eq $CSSEvenClass)
                    {      $ClassName = $CSSOddClass
                    }
                    Else
                    {      $ClassName = $CSSEvenClass
                    }
             }
             Return $Line
       }
}




#------------------------------------------------------------------------------
# Genral
#------------------------------------------------------------------------------
$FormatEnumerationLimit = -1
$Date = Get-Date
$Datef = Get-Date -Format "\Da\te dd-MM-yyyy \Ti\me H-mm" 
#------------------------------------------------------------------------------
# PowerShell console window Style
#------------------------------------------------------------------------------

$pshost = get-host
$pswindow = $pshost.ui.rawui

	$newsize = $pswindow.buffersize
	
	if($newsize.height){
		$newsize.height = 3000
		$newsize.width = 150
		$pswindow.buffersize = $newsize
	}

	$newsize = $pswindow.windowsize
	if($newsize.height){
		$newsize.height = 50
		$newsize.width = 150
		$pswindow.windowsize = $newsize
	}

#------------------------------------------------------------------------------
# HTML Style start 
#------------------------------------------------------------------------------
$Header = @"
<style>
Body{font-family:segoe ui,arial;color:black; }

H1 {font-size: 26px; font-weight:bold;width: 70% text-transform: uppercase; color: #0000A0; background:#2F5496 ; color: #ffffff; padding: 10px 10px 10px 10px ; border: 3px solid #00B0F0;}
H2{ background:#F2F2F2 ; padding: 10px 10px 10px 10px ; color: #013366; margin-top:35px;margin-bottom:25px;font-size: 22px;padding:5px 15px 5px 10px; }

.TextStyle {font-size: 26px; font-weight:bold ; color:black; }

TABLE {border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}
TH {border-width: 1px;padding: 5px;border-style: solid;border-color: #d1d3d4;background-color:#0072c6 ;color:white;}
TD {border-width: 1px;padding: 3px;border-style: solid;border-color: black;}

.odd  { background-color:#ffffff; }
.even { background-color:#dddddd; }



.o365info {height: 90px;padding-top:5px;padding-bottom:5px;margin-top:20px;margin-bottom:20px;border-top: 3px dashed #002060;border-bottom: 3px dashed #002060;background: #00CCFF;font-size: 120%;font-weight:bold;background:#00CCFF url(http://o365info.com/wp-content/files/PowerShell-Images/o365info120.png) no-repeat 680px -5px;
}

</style>

"@

$EndReport = "<div class=o365info>  This report was created by using <a href= http://o365info.com target=_blank>o365info.com</a> PowerShell script </div>"
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------




#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Manage Auto Expanding Archive -Exchange Online - PowerShell - Script menu
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

$Loop = $true
While ($Loop)
{
    write-host 
    write-host +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    write-host   " Manage Auto Expanding Archive -Exchange Online - PowerShell - Script menu"
    write-host +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    write-host
	write-host -ForegroundColor white  '----------------------------------------------------------------------------------------------' 
    write-host -ForegroundColor white  -BackgroundColor DarkCyan     'Connect Exchange Online using Remote PowerShell        ' 
    write-host -ForegroundColor white  '----------------------------------------------------------------------------------------------' 
	write-host -ForegroundColor Yellow ' 1) Login to Exchange Online using Remote PowerShell ' 
    write-host
	write-host -ForegroundColor green '----------------------------------------------------------------------------------------------' 
    write-host -ForegroundColor white  -BackgroundColor Blue     'SECTION A: Enable the option of Auto Expanding Archive       ' 
    write-host -ForegroundColor green '----------------------------------------------------------------------------------------------' 
    write-host                                              ' 2)  Enable the option of - Auto Expanding Archive | Organization level '
	write-host                                              ' 3)  Enable the option of - Auto Expanding Archive | Single Mailbox   '
	write-host                                              ' 4)  Enable the option of - Auto Expanding Archive | For each mailbox with Archive (Bulk)   '
	write-host -ForegroundColor green  '----------------------------------------------------------------------------------------------' 
    write-host -ForegroundColor white  -BackgroundColor DarkGreen   'SECTION B:  Display information about Auto Expanding Archive  ' 
    write-host -ForegroundColor green  '----------------------------------------------------------------------------------------------' 
    write-host                                              ' 5)  Display information about Auto Expanding Archive | Organization level '
	write-host                                              ' 6)  Display information about Auto Expanding Archive | Single Mailbox  '
	write-host -ForegroundColor green  '----------------------------------------------------------------------------------------------' 
    write-host -ForegroundColor white  -BackgroundColor DarkGreen   'SECTION C:  Display + Export information about Exchange Online USER mailboxes with Archive   ' 
    write-host -ForegroundColor green  '----------------------------------------------------------------------------------------------' 
    write-host                                              ' 7)  Display + Export information about Exchange Online USER mailboxes with Archive '
    write-host -ForegroundColor green '----------------------------------------------------------------------------------------------' 
    write-host -ForegroundColor white  -BackgroundColor DarkCyan 'End of PowerShell - Script menu ' 
    write-host -ForegroundColor green  '----------------------------------------------------------------------------------------------' 
	write-host -ForegroundColor Yellow            "20)  Disconnect PowerShell session" 
    write-host
    write-host -ForegroundColor Yellow            "21)  Exit the PowerShell script menu (Or use the keyboard combination - CTRL + C)" 
    write-host

    $opt = Read-Host "Select an option [1-21]"
    write-host $opt
    switch ($opt) 


{


	
1
{

#####################################################################
# Connect Exchange Online using Remote PowerShell
#####################################################################

# == Section: General information ===

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		------------------------------------------------------------------------------------------                                                                
write-host  -ForegroundColor white  	'To be able to use the PowerShell menus in the script,  '
write-host  -ForegroundColor white  	'you will need to Login to Exchange Online using Remote PowerShell. '
write-host  -ForegroundColor white  	'In the credentials windows that appear,   '
write-host  -ForegroundColor white  	'provide your Office 365 Global Administrator credentials.  '
write-host  -ForegroundColor white		------------------------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Cyan    	'$UserCredential = Get-Credential '
write-host  -ForegroundColor Cyan    	'$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection '
write-host  -ForegroundColor Cyan    	'Import-PSSession $Session '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host

DisconnectExchangeOnline
# Specify your administrative user credentials on the line below 

$user = “Provide credentials”

$UserCredential = Get-Credential -Credential $user

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session


# All Exchange Online USER Mailboxes 
$global:GetMBXUser     =  Get-MailBox -Filter '(RecipientTypeDetails -eq "UserMailbox")'


# Report included fields
$global:Array1  = "DisplayName","archivedatabase", "AutoExpandingArchiveEnabled" , "archivename", "archivequota", "archivewarningquota"
$global:Array2  = "DisplayName","AutoExpandingArchiveEnabled" , "archivename"



}



	
#=========================================================================================
# SECTION A: Enable the option of Auto Expanding Archive
#=========================================================================================


2
{


#####################################################################
# Enable the option of - Auto Expanding Archive | Organization level
#####################################################################

checkConnection
# General information  

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Enable the option of - Auto Expanding Archive | Organization level '
write-host  -ForegroundColor white		--------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Cyan    	'Set-OrganizationConfig -AutoExpandingArchive '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host

# Display Information 

write-host
write-host -------------------------------------------------------------------------------------------------
write-host -ForegroundColor white  -BackgroundColor Blue   "Display information about: Auto Expanding Archive | Organization level BEFORE the update"
write-host -------------------------------------------------------------------------------------------------
Get-OrganizationConfig | Select-Object AutoExpandingArchiveEnabled | Out-String
write-host -------------------------------------------------------------------------------------------------

# PowerShell Command
Set-OrganizationConfig -AutoExpandingArchive


# Display Information 

write-host
write-host -------------------------------------------------------------------------------------------------
write-host -ForegroundColor white  -BackgroundColor Magenta  "Display information about: Auto Expanding Archive | Organization level  => AFTER the update"
write-host -------------------------------------------------------------------------------------------------
Get-OrganizationConfig | Select-Object AutoExpandingArchiveEnabled | Out-String
write-host -------------------------------------------------------------------------------------------------


# End the menu command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}




3
{


#####################################################################
# Enable the option of - Auto Expanding Archive | Single Mailbox
#####################################################################

checkConnection
# General information  

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Enable the option of - Auto Expanding Archive | Single Mailbox '
write-host  -ForegroundColor white		--------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Cyan    	'Enable-Mailbox <Mailbox> -AutoExpandingArchive '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# User input

write-host -ForegroundColor white	'User input '
write-host -ForegroundColor white	---------------------------------------------------------------------------- 
write-host -ForegroundColor Yellow	"You will need to provide 1 parameter:"  
write-host
write-host -ForegroundColor Yellow	"1.  Mailbox name  "  
write-host -ForegroundColor Yellow	"Provide the Identity (Alias or E-mail address) of the Target mailbox"    
write-host -ForegroundColor Yellow	"For example:  Bob@o365info.com"
write-host
$Alias  = Read-Host "Type the mailbox name "
write-host
write-host

# Display Information 

write-host
write-host -------------------------------------------------------------------------------------------------
write-host -ForegroundColor white  -BackgroundColor Blue   Display information about: "$Alias".ToUpper() Auto Expanding Archive => BEFORE the update
write-host -------------------------------------------------------------------------------------------------
Get-Mailbox $Alias | Select-Object AutoExpandingArchiveEnabled | Out-String
write-host -------------------------------------------------------------------------------------------------

# PowerShell Command

Enable-Mailbox $Alias -AutoExpandingArchive

# Display Information 

write-host
write-host -------------------------------------------------------------------------------------------------
write-host -ForegroundColor white  -BackgroundColor Magenta  Display information about: "$Alias".ToUpper() Auto Expanding Archive  => AFTER the update
write-host -------------------------------------------------------------------------------------------------
Get-Mailbox $Alias | Select-Object AutoExpandingArchiveEnabled | Out-String
write-host -------------------------------------------------------------------------------------------------


# Empty the content of a variable
$global:GetMBXUser    =  $null
$global:GetMBXUser     =  Get-MailBox -Filter '(RecipientTypeDetails -eq "UserMailbox")'


# End the menu command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}



		
4
{


#####################################################################
# Enable the option of - Auto Expanding Archive | For each mailbox with Archive (Bulk)
#####################################################################

checkConnection
# General information  

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'Enable the option of - Auto Expanding Archive | For each mailbox with Archive (Bulk) '
write-host  -ForegroundColor white  	'The current menu option will perform the following tasks: '
write-host  -ForegroundColor white  	'1. Find (search) for all Exchange mailboxes that answer the following conditions . '
write-host  -ForegroundColor white  	'* rch) for all Exchange USER mailboxes with Archive. '
write-host  -ForegroundColor white  	'2. Activate the option of - Auto Expanding Archive for each of these mailboxes.  '

write-host  -ForegroundColor white		--------------------------------------------------------------------  
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host

# Define the variable that will store the affected Exchange mailboxes 
$MBXandArchive = $global:GetMBXUser  | Where-Object {$_.ArchiveDatabase -ne $null  -and  $_.AutoExpandingArchiveEnabled -eq $False }

# Display Information 

write-host
write-host -------------------------------------------------------------------------------------------------
write-host -ForegroundColor white  -BackgroundColor DarkCyan   "Display information about Exchange Online USER mailboxes with Archive"
write-host -------------------------------------------------------------------------------------------------
$MBXandArchive | Where-Object {$_.ArchiveDatabase -ne $null} | Select-Object $global:Array2 | Out-String
write-host -------------------------------------------------------------------------------------------------



# PowerShell Command

ForEach ($Mailbox in $MBXandArchive)
{

Enable-Mailbox $Mailbox.WindowsLiveID  -AutoExpandingArchive

write-host 
write-host  -ForegroundColor white		---------------------------------------------------------------------------- 
write-host -ForegroundColor white	"Activate the option of Auto Expanding Archive on User Mailbox -  " -nonewline; write-host "$Mailbox".ToUpper() -ForegroundColor white -BackgroundColor DarkCyan 
write-host  -ForegroundColor white		----------------------------------------------------------------------------  
write-host 

# Empty the content of a variable
$MBXandArchive   =  $null
$MBXandArchive = $global:GetMBXUser  | Where-Object {$_.ArchiveDatabase -ne $null  -and  $_.AutoExpandingArchiveEnabled -eq $False }

write-host
write-host -------------------------------------------------------------------------------------------------
write-host -ForegroundColor white  -BackgroundColor DarkCyan   "Display information about Exchange Online USER mailboxes with Archive"
write-host -------------------------------------------------------------------------------------------------
$MBXandArchive | Where-Object {$_.ArchiveDatabase -ne $null} | Select-Object $global:Array2 | Out-String
write-host -------------------------------------------------------------------------------------------------



}


# End the Command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}




#=========================================================================================
# SECTION B:  Display information about Auto Expanding Archive
#=========================================================================================


5
{


#####################################################################
# Display information about Auto Expanding Archive | Organization level
#####################################################################

checkConnection
# General information  

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Display information about Auto Expanding Archive | Organization level. '
write-host  -ForegroundColor white		--------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Cyan    	'Get-OrganizationConfig | Select-Object AutoExpandingArchiveEnabled '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host

# Display Information 

write-host
write-host -------------------------------------------------------------------------------------------------
write-host -ForegroundColor white  -BackgroundColor DarkCyan   "Display information about: Auto Expanding Archive | Organization level" 
write-host -------------------------------------------------------------------------------------------------
Get-OrganizationConfig | Select-Object AutoExpandingArchiveEnabled | Out-String
write-host -------------------------------------------------------------------------------------------------

# End the menu command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}




6
{


#####################################################################
#  Display information about Auto Expanding Archive | Single Mailbox
#####################################################################

checkConnection
# General information  

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                         
write-host  -ForegroundColor white		Information                                                                                          
write-host  -ForegroundColor white		----------------------------------------------------------------------------                                                             
write-host  -ForegroundColor white  	'This option will: '
write-host  -ForegroundColor white  	'Display information about Auto Expanding Archive | Single Mailbox '
write-host  -ForegroundColor white		--------------------------------------------------------------------  
write-host  -ForegroundColor white  	'The PowerShell command that we use is: '
write-host  -ForegroundColor Cyan    	'Get-Mailbox <Mailbox> | FL AutoExpandingArchiveEnabled '
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host
write-host


# User input

write-host -ForegroundColor white	'User input '
write-host -ForegroundColor white	---------------------------------------------------------------------------- 
write-host -ForegroundColor Yellow	"You will need to provide 1 parameter:"  
write-host
write-host -ForegroundColor Yellow	"1.  Mailbox name  "  
write-host -ForegroundColor Yellow	"Provide the Identity (Alias or E-mail address) of the Target mailbox"    
write-host -ForegroundColor Yellow	"For example:  Bob@o365info.com"
write-host
$Alias  = Read-Host "Type the mailbox name "
write-host
write-host

# Display Information 

# Display Information 

write-host
write-host -------------------------------------------------------------------------------------------------
write-host -ForegroundColor white  -BackgroundColor DarkCyan   Display information about: "$Alias".ToUpper() Auto Expanding Archive 
write-host -------------------------------------------------------------------------------------------------
Get-Mailbox $Alias | FL AutoExpandingArchiveEnabled | Out-String
write-host -------------------------------------------------------------------------------------------------


# End the menu command
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}




		
#===============================================================================================================
# SECTION C:  Display + Export information about Exchange Online mailbox with Archive
#===============================================================================================================

7
{

##########################################################################################################
# Display + Export information about Exchange Online USER mailboxes with Archive
##########################################################################################################
checkConnection
# General information  

clear-host

write-host
write-host
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                              
write-host  -ForegroundColor white		Introduction                                                                                          
write-host  -ForegroundColor white		--------------------------------------------------------------------------------------                                                              
write-host  -ForegroundColor white  	'This option will:  '
write-host  -ForegroundColor white  	'Display + Export information about Exchange Online USER mailboxes with Archive '
write-host  -ForegroundColor white		--------------------------------------------------------------------------------------  
write-host  -ForegroundColor white  	'NOTE - The export command will:   '
write-host  -ForegroundColor white  	'1. Create a folder named INFO in drive C: '
write-host  -ForegroundColor white  	'2. Save all of the exported information to diffrent file formats: TXT,CSV and HTML '
write-host  -ForegroundColor white  	'The files will be saved in the follwoing path:' -NoNewline;Write-Host 'C:\INFO\Exchange Online mailbox with Archive' -ForegroundColor Yellow  -BackgroundColor DarkGreen							 
write-host  -ForegroundColor Magenta	oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo                                          
write-host

$MBXandArchive = $global:GetMBXUser  | Where-Object {$_.ArchiveDatabase -ne $null}

# Display Information 

write-host
write-host -------------------------------------------------------------------------------------------------
write-host -ForegroundColor white  -BackgroundColor DarkCyan   "Display information about Exchange Online USER mailboxes with Archive"
write-host -------------------------------------------------------------------------------------------------
$MBXandArchive | Where-Object {$_.ArchiveDatabase -ne $null} | Select-Object $global:Array1| Out-String
write-host -------------------------------------------------------------------------------------------------


# == Section: Export Data to Files


# Create folders Structure that contain the exported information to TXT, CSV and HTML files
# Folder and path Structure


$A20 =  "C:\INFO\Exchange Online USER mailboxes with Archive"


#---------------------------------------------------------------------------------------------------
# Create the required folders in Drive C:\INFO
#---------------------------------------------------------------------------------------------------

# 1. xxxxxx
if (!(Test-Path -path $A20))
{New-Item $A20 -type directory}


# == Section: Export data to files  ===


#---------------------------------------------------------------------------------------------------
# Export information to Files
#---------------------------------------------------------------------------------------------------

### TXT ####
$MBXandArchive  | Format-List | Out-File $A20\"Exchange Online USER mailboxes with Archive.txt" -Encoding UTF8
##########

### CSV ####
$MBXandArchive  | Export-CSV $A20\"Exchange Online USER mailboxes with Archive.CSV" –NoTypeInformation -Encoding utf8
##########

### HTML ####
$MBXandArchive | Where-Object {$_.ArchiveDatabase -ne $null} | Select-Object $global:Array1 | ConvertTo-Html  -post $EndReport -head $Header -Body  "<H1>Exchange Online USER mailboxes with Archive | $Datef </H1>"  | Set-AlternatingRows -CSSEvenClass even -CSSOddClass odd | Out-File $A20\"Exchange Online USER mailboxes with Archive.html"
##########

	
# End the menu command 
write-host
write-host
Read-Host "Press Enter to continue..."
write-host
write-host

}
			
	


	
	

	
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Section END - Disconnect PowerShell session 
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

	
20
{

##########################################
# Disconnect PowerShell session  
##########################################


write-host -ForegroundColor Yellow Choosing this option will Disconnect the current PowerShell session 

Disconnect-ExchangeOnline 

write-host
write-host

#———— Indication ———————

if ($lastexitcode -eq 0)
{
write-host -------------------------------------------------------------
write-host "The command complete successfully !" -ForegroundColor Yellow
write-host "The PowerShell session is disconnected" -ForegroundColor Yellow
write-host -------------------------------------------------------------
}
else

{
write-host "The command Failed :-(" -ForegroundColor red

}

#———— End of Indication ———————


}




21
{

##########################################
# Exit the PowerShell script menu (Or use the keyboard combination - CTRL + C)  
##########################################


$Loop = $true
Exit
}

}


}
