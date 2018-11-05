################################################################################################################################################################
# Script accepts 3 parameters from the command line
#
# Office365Username - Mandatory - Administrator login ID for the tenant we are querying
# Office365Password - Mandatory - Administrator login password for the tenant we are querying
# UserIDFile - Optional - Path and File name of file full of UserPrincipalNames we want the Mailbox Folder Permissions for.  Seperated by New Line, no header.
#
#
# To run the script
#
# .\Get-AllFolderPerms.ps1 -Office365Username admin@xxxxxx.onmicrosoft.com -Office365Password Password123 -UserIDFile c:\Files\InputFile.txt
#
# NOTE: If you do not pass an input file to the script, it will return the permissions of Folders for ALL mailboxes in the tenant.  Not advisable for tenants with large
# user count (< 3,000) 
 #
 # Author: 				Alan Byrne
 # Version: 				1.0
 # Last Modified Date: 	10/08/2012
 # Last Modified By: 	Alan Byrne
 ################################################################################################################################################################
 #$ErrorActionPreference = "SilentlyContinue"
 #Accept input parameters
 Param(
 	[Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
     [string] $Office365Username,
 	[Parameter(Position=1, Mandatory=$true, ValueFromPipeline=$true)]
     [string] $Office365Password,	
 	[Parameter(Position=2, Mandatory=$false, ValueFromPipeline=$true)]
     [string] $UserIDFile
 )
 
 #Constant Variables
 $OutputFile = "C:\Temp\MailboxFolderPerms.csv"   #The CSV Output file that is created, change for your purposes
 
 
 #Main
 Function Main {
 
 	#Remove all existing Powershell sessions
 	Get-PSSession | Remove-PSSession
 	
 	#Call ConnectTo-ExchangeOnline function with correct credentials
 	ConnectTo-ExchangeOnline -Office365AdminUsername $Office365Username -Office365AdminPassword $Office365Password			
 	
 	#Prepare Output file with headers
 	Out-File -FilePath $OutputFile -InputObject "UserLoginName,FolderName,FolderPath,FolderType,UserWithAccess,AccessRights" -Encoding UTF8
 	
 	#Check if we have been passed an input file path
 	if ($userIDFile -ne "")
 	{
 		#We have an input file, read it into memory
 		$objUsers = import-csv -Header "UserPrincipalName" $UserIDFile
 	}
 	else
 	{
 		#No input file found, gather all mailboxes from Office 365
 		$objUsers = get-mailbox -ResultSize Unlimited | select UserPrincipalName
 	}
 	
 	#Iterate through all users	
 	Foreach ($objUser in $objUsers)
 	{	
 		#Connect to the users mailbox
 		$objUserMailboxFolders = Get-MailboxFolderStatistics -Identity $($objUser.UserPrincipalName)
 		
 		#Prepare UserPrincipalName variable
 		$strUserPrincipalName = $objUser.UserPrincipalName
 		
 		#Loop through each permission
 		foreach ($objFolder in $objUserMailboxFolders)
 		{			
 			#Only get permissions for these types of folders
 			if ( ($objFolder.FolderType -eq "Calendar") -or ($objFolder.FolderType -eq "Contacts") -or ($objFolder.FolderType -eq "ConversationActions") -or ($objFolder.FolderType -eq "CommunicatorHistory") -or ($objFolder.FolderType -eq "DeletedItems") -or ($objFolder.FolderType -eq "Drafts") -or ($objFolder.FolderType -eq "Inbox") -or ($objFolder.FolderType -eq "User Created") -or ($objFolder.FolderType -eq "Journal") -or ($objFolder.FolderType -eq "JunkEmail")-or ($objFolder.FolderType -eq "Notes")-or ($objFolder.FolderType -eq "Outbox")-or ($objFolder.FolderType -eq "RssSubscription")-or ($objFolder.FolderType -eq "SentItems")-or ($objFolder.FolderType -eq "Tasks"))
 			{
 				#Get the folder permissions
 				$objFolderPermissions = Get-MailboxFolderPermission -identity ($strUserPrincipalName + ":" + $($objFolder.FolderPath) -replace "/","\")
 				
 				#Loop through each user with access
 				foreach ($objFolderPermission in $objFolderPermissions)
 				{
 					#Write out the permissions
 					write-host ($strUserPrincipalName + "," + $objFolderPermission.FolderName + "," + $objFolder.FolderPath + "," + $objFolder.FolderType + "," + $objFolderPermission.User + "," + $objFolderPermission.AccessRights)  
 					Out-File -FilePath $OutputFile -InputObject ($strUserPrincipalName + "," + $objFolderPermission.FolderName + "," + $objFolder.FolderPath + "," + $objFolder.FolderType + "," + $objFolderPermission.User + "," + $objFolderPermission.AccessRights)  -Encoding UTF8 -Append
 				}
 			}
 		}
 	}
 	
 	#Clean up session
 	Get-PSSession | Remove-PSSession
 }
 
 ###############################################################################
 #
 # Function ConnectTo-ExchangeOnline
 #
 # PURPOSE
 #    Connects to Exchange Online Remote PowerShell using the tenant credentials
 #
 # INPUT
 #    Tenant Admin username and password.
 #
 # RETURN
 #    None.
 #
 ###############################################################################
 function ConnectTo-ExchangeOnline
 {   
 	Param( 
 		[Parameter(
 		Mandatory=$true,
 		Position=0)]
 		[String]$Office365AdminUsername,
 		[Parameter(
 		Mandatory=$true,
 		Position=1)]
 		[String]$Office365AdminPassword
 
     )
 		
 	#Encrypt password for transmission to Office365
 	$SecureOffice365Password = ConvertTo-SecureString -AsPlainText $Office365AdminPassword -Force    
 	
 	#Build credentials object
 	$Office365Credentials  = New-Object System.Management.Automation.PSCredential $Office365AdminUsername, $SecureOffice365Password
 	
 	#Create remote Powershell session
 	$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $Office365credentials -Authentication Basic –AllowRedirection    	
 
 	#Import the session
     Import-PSSession $Session -AllowClobber | Out-Null
 }
 
 
 # Start script
 . Main