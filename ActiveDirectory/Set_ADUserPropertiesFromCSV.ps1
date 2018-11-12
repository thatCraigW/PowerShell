Import-Module ActiveDirectory

$USERS = Import-CSV c:\temp\users.csv

$USERS | Foreach
{
    # Get what they are before we start, then output

    # OfficePhone/Telephone/Landline
    $P = Get-ADUser -Identity $_.AccountName -Properties OfficePhone | Select OfficePhone;
    Write-Host "$_.AccountName Office Number was $P, setting to $_.TelephoneNumber" -ForegroundColor Green;
    
    # MobilePhone/Mobile/Cell
    $M = Get-ADUser -Identity $_.AccountName -Properties OfficePhone | Select OfficePhone;
    Write-Host "$_.AccountName Mobile was $M, setting to $_.mobile" -ForegroundColor Green;
    
    # Set the two new settings from the CSV
    Set-ADUSer -Identity $_.AccountName -TelephoneNumber $_.TelephoneNumber -mobile $_.mobile;
    
    # Check what they are now set to, compare to prior numbers, then output

    # OfficePhone/Telephone/Landline
    $P2 = Set-ADUser -Identity $_.AccountName -Properties OfficePhone | Select OfficePhone;
    Write-Host "$_.AccountName Office Number was $P, Confirming set to $P2" -ForegroundColor Green;

    # MobilePhone/Mobile/Cell
    $M2 = Set-ADUser -Identity $_.AccountName -Properties OfficePhone | Select OfficePhone;
    Write-Host "$_.AccountName Mobile Number was $M, Confirming set to $M2" -ForegroundColor Green;
}