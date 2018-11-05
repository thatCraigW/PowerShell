# this will check the OU and any children OUs for adusers that meet the criteria
get-aduser -filter * -searchbase “OU=Users,OU=MyBusiness,DC=OrgName,DC=local” -properties Telephonenumber|select givenname, surname, telephonenumber|export-csv phones.csv
