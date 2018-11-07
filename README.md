# PowerShell
Powershell Scripts &amp; Snippets

## Active Directory
- [Get_UsersByOU](https://github.com/thatCraigW/PowerShell/blob/master/ActiveDirectory/Get_UsersByOU.ps1) - Search all users within a specific location and get properties, export to csv.

## Azure
- [Connect_Azure](https://github.com/thatCraigW/PowerShell/blob/master/Azure/Connect_Azure.ps1) - Does what it says on the box.
- [Get_LicensedUsers](https://github.com/thatCraigW/PowerShell/blob/master/Azure/Get_LicensedUsers.ps1) - Lists all licensed users.
- [RemoveUser](https://github.com/thatCraigW/PowerShell/blob/master/Azure/RemoveUser.ps1) - Prompts for email before executing Remove-MsolUser command (inc. recycle bin).

## Exchange
- [ExportPST](https://github.com/thatCraigW/PowerShell/blob/master/Exchange/ExportPST.ps1) - Export PSTs from mailboxes.

## Office 365
- [Connect_O365](https://github.com/thatCraigW/PowerShell/blob/master/Office365/Connect_O365.ps1) - Prompt for creds, then connect to tenant.
- [Connect_O365_SfB](https://github.com/thatCraigW/PowerShell/blob/master/Office365/Connect_O365_SfB.ps1) - As above, but for Lync/SfB tenant.
- [Convert_MailboxToShared](https://github.com/thatCraigW/PowerShell/blob/master/Office365/Convert_MailboxToShared.ps1) - Prompts for account, then converts to shared mailbox.
- [Enable_LegalHold](https://github.com/thatCraigW/PowerShell/blob/master/Office365/Enable_LegalHold.ps1) - Enables Litigation Hold on all Mailboxes.
- [Get_DistributionGroupMembers](https://github.com/thatCraigW/PowerShell/blob/master/Office365/Get_DistributionGroupMembers.ps1) - Loops through ALL DGs and lists every member of each DG.
- [Get_MailboxLimits](https://github.com/thatCraigW/PowerShell/blob/master/Office365/Get_MailboxLimits.ps1) - Retrieves full stats on a mailbox.
- [Get_MailboxStats](https://github.com/thatCraigW/PowerShell/blob/master/Office365/Get_MailboxStats.ps1) - Retrieves full stats on many (ALL) mailboxes.
- [MailboxDelegations](https://github.com/thatCraigW/PowerShell/blob/master/Office365/MailboxDelegations.ps1) - Send As, Full Access and Send on Behalf commands.
- [Wizard_AutoExpandingArchive](https://github.com/thatCraigW/PowerShell/blob/master/Office365/Wizard_AutoExpandingArchive.ps1) - Wizard to audit or set AutoExpandingArchive specific mailbox or tenant.

## Windows

- [Enable_Scripts](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Enable_Scripts.ps1) - Enables PowerShell scripts to run on the local machine.
- [Get_FileDownloadAndExecute](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Get_FileDownloadAndExecute.ps1) - Download a file from a URL, then run it (silently).
- [Get_Printers](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Get_Printers.ps1) - List the printers available on the local machine.
- [Get_RegistryTestAndSet_Registry](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Get_RegistryTestAndSet_Registry.ps1) - Checks Registry Path exists, creates if it doesnt, and creates a new key.
- [Get_VPNVerifyConnected](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Get_VPNVerifyConnected.ps1) - Confirms if you're connected to a VPN. It doesn't care which, just that one is live.
- [Misc FreshBuild](https://github.com/thatCraigW/PowerShell/blob/master/Windows/FreshBuild) - Things to consider for first-logon / automated builds.
- - [Set_AppSuggestions](https://github.com/thatCraigW/PowerShell/blob/master/Windows/FreshBuild/Set_AppSuggestions.ps1) - Toggle for "Suggested" Apps.
- - [Set_BloatApps](https://github.com/thatCraigW/PowerShell/blob/master/Windows/FreshBuild/Set_BloatApps.ps1) - Toggles for bloat apps like MineCraft UWP etc auto-installing.
- [Misc Preferences](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences) - Preference Toggles and default app/file associations.
- - [Set_AutoRunAutoPlay](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences/Set_AutoRunAutoPlay.ps1) - Toggles for Auto Run and AutoPlay, default is both off.
- - [Set_ControlPanelView](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences/Set_ControlPanelView.ps1) - Settings for Control Panel style, large, small icons or category view.
- - [Set_ExplorerThumnails](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences/Set_ExplorerThumnails.ps1) - Sets Thumbnail generation / caching.
- - [Set_ExtTypeHiddenFiles](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences/Set_ExtTypeHiddenFiles.ps1) - Choose to show/hide extentions & hidden files.
- - [Set_FileExplorerDefaultWindow](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences/Set_FileExplorerDefaultWindow.ps1) - Choose if new explorer windows open This PC or Quick Access.
- - [Set_KeyboardLanguage](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences/Set_KeyboardLanguage.ps1) - Add / Remove Keyboard Languages (try ENG INTL).
- - [Set_LibraryMusicPicVid3D](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences/Set_LibraryMusicPicVid3D.ps1) - Show / Hide Music, Pictures, Videos, 3D Objects Libraries in Explorer.
- - [Set_NetworkProfilesPubPriv](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences/Set_NetworkProfilesPubPriv.ps1) - Set Networks to Public or Private.
- - [Set_ShortcutCreationStyle](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences/Set_ShortcutCreationStyle.ps1) - Toggles the appending of "- shortcut" and the little arrow icon overlay to new shortcuts.
- - [Set_StartMenuWebSearch](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences/Set_StartMenuWebSearch.ps1) - Toggle if Start Menu searches include web results.
- - [Set_TaskBarIconSizeStyle](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences/Set_TaskBarIconSizeStyle.ps1) - Choose Large, Small, combined task bar icon styles.
- - [Set_TaskBarTaskViewButton](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences/Set_TaskBarTaskViewButton.ps1) - Toggle the Task View button on or off.
- - [Set_WifiSense](https://github.com/thatCraigW/PowerShell/blob/master/Windows/Preferences/Set_WifiSense.ps1) - Turn Wifi Sense on or off.