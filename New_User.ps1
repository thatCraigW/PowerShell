Import-Csv .\userImport.csv | foreach-object {
New-ADUser -Name $_.DisplayName -UserPrincipalName $_.UserPrincipalName -SamAccountName $_.Username -GivenName $_.GivenName -DisplayName $_.DisplayName -Initials $_.MiddleInitial -SurName $_.Surname -Description $_.Description -Department $_.Department -StreetAddress $_.StreetAddress -City $_.City -State $_.State -PostalCode $_.ZipCode -HomePhone $_.TelephoneNumber -Title $_.Occupation -Office $_.Office -Path $_.Path -AccountPassword (ConvertTo-SecureString $_.Password -AsPlainText -force) -Enabled $True -PasswordNeverExpires $True -PassThru }