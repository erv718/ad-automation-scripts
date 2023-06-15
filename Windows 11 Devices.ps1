# Import Active Directory module
Import-Module ActiveDirectory

# Define the security group distinguished name
$groupDN = "CN=Windows 11 Devices,OU=Tech Ops,OU=Security Groups,OU=Corporate,OU=Locations,OU=[Company],DC=ad,DC=corp.example,DC=com"

# Search for all computers running Windows 11 in Active Directory
$win11Computers = Get-ADComputer -Filter 'OperatingSystem -like "Windows 11*"' | Select-Object -ExpandProperty DistinguishedName

foreach ($computerDN in $win11Computers) {
    # Add computer to the security group using its Distinguished Name
    Add-ADGroupMember -Identity $groupDN -Members $computerDN
    Write-Output "Added $computerDN to the Windows 11 security group."
}
