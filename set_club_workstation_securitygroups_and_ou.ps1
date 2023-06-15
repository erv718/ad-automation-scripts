#Get All Computers for Clubs OU and place in file
Get-ADComputer -Filter * -SearchBase "CN=Computers,DC=ad,DC=corp.example,DC=com" | Select-Object Name | Export-CSV 'F:\Scripts\set_club_workstation_securitygroups_and_ou\defaultComputers.csv' -NoTypeInformation -Encoding UTF8
Get-ADComputer -Filter * -SearchBase "OU=Clubs,OU=Locations,OU=[Company],DC=ad,DC=corp.example,DC=com" | Select-Object Name | Export-CSV 'F:\Scripts\set_club_workstation_securitygroups_and_ou\clubComputers.csv' -NoTypeInformation -Encoding UTF8



$defaultComputers_csv = 'F:\Scripts\set_club_workstation_securitygroups_and_ou\defaultComputers.csv'
$clubComputers_csv = 'F:\Scripts\set_club_workstation_securitygroups_and_ou\clubComputers.csv'
$club_ous_csv = 'F:\Scripts\set_club_workstation_securitygroups_and_ou\club_computer_ous.csv'

function set_club_workstation_securitygroups_and_ou{
	param($COMPUTERSLIST)
	
	$computers = Import-Csv -Path $COMPUTERSLIST
	$ous = Import-Csv -Path $club_ous_csv
	$regex = [regex]::new("\d+")

	#Remove and re-add Security Groups
	foreach( $computer in $computers ){
		$SelectedComputer = ($computer.Name)
		#Write-Host $SelectedComputer
		if ( $SelectedComputer -match "([0-9]{3})" -And !($SelectedComputer.StartsWith('6999-')) ){
			#Write-Host $SelectedComputer #Store each PC that is changed table to add to email body/attachment
			$computermatch = $regex.Match($SelectedComputer)
			[string]$ComputerClubID = [int]$computermatch.Value
			#Write-Host $ComputerClubID
			$FRD = $ComputerClubID + '-FRD'
			$FRD1 = $ComputerClubID + '-FRD1'
			$FRD2 = $ComputerClubID + '-FRD2'
			$FRD3 = $ComputerClubID + '-FRD3'
			$FRD4 = $ComputerClubID + '-FRD4'
			$FRD5 = $ComputerClubID + '-FRD5'
			$FD = $ComputerClubID + '-FD'
			$FD1 = $ComputerClubID + '-FD1'
			$FD2 = $ComputerClubID + '-FD2'
			$FD3 = $ComputerClubID + '-FD3'
			$FD4 = $ComputerClubID + '-FD4'
			$FD5 = $ComputerClubID + '-FD5'
			$606MF = '606-KIOSK'
			$MF = $ComputerClubID + '-KIOSK'
			$MF1 = $ComputerClubID + '-KIOSK1'
			$MF2 = $ComputerClubID + '-KIOSK2'
			$MF3 = $ComputerClubID + '-KIOSK3'
			$MF4 = $ComputerClubID + '-KIOSK4'
			$MF5 = $ComputerClubID + '-KIOSK5'
			$ACM = $ComputerClubID + '-ACM'
			$ACM1 = $ComputerClubID + '-ACM1'
			$ACM2 = $ComputerClubID + '-ACM2'
			$ACM3 = $ComputerClubID + '-ACM3'
			$ACM4 = $ComputerClubID + '-ACM4'
			$ACM5 = $ComputerClubID + '-ACM5'
			$CM = $ComputerClubID + '-CM'
			$CM1 = $ComputerClubID + '-CM1'
			$CM2 = $ComputerClubID + '-CM2'
			$CM3 = $ComputerClubID + '-CM3'
			$CM4 = $ComputerClubID + '-CM4'
			$CM5 = $ComputerClubID + '-CM5'
			$LEFT_KIOSK = 'CORP-' + $ComputerClubID + '-L'
			$LEFT_KIOSK1 = 'CORP-' + $ComputerClubID + '-L1'
			$LEFT_KIOSK2 = 'CORP-' + $ComputerClubID + '-L2'
			$LEFT_KIOSK3 = 'CORP-' + $ComputerClubID + '-L3'
			$LEFT_KIOSK4 = 'CORP-' + $ComputerClubID + '-L4'
			$LEFT_KIOSK5 = 'CORP-' + $ComputerClubID + '-L5'
			$RIGHT_KIOSK = 'CORP-' + $ComputerClubID + '-R'
			$RIGHT_KIOSK1 = 'CORP-' + $ComputerClubID + '-R1'
			$RIGHT_KIOSK2 = 'CORP-' + $ComputerClubID + '-R2'
			$RIGHT_KIOSK3 = 'CORP-' + $ComputerClubID + '-R3'
			$RIGHT_KIOSK4 = 'CORP-' + $ComputerClubID + '-R4'
			$RIGHT_KIOSK5 = 'CORP-' + $ComputerClubID + '-R5'
			$AD_GROUPS = Get-ADPrincipalGroupMembership -Identity ($SelectedComputer + '$')| where {$_.Name -ne "Domain Computers"}
			if ( $SelectedComputer -in ($FRD, $FRD1, $FRD2, $FRD3, $FRD4, $FRD5, $FD, $FD1, $FD2, $FD3, $FD4, $FD5, $606MF) ){
				$WorkstationType = 'FD'
				#Write-Host $WorkstationType
				if ($AD_GROUPS -ne $null){
					Remove-ADPrincipalGroupMembership -Identity ($SelectedComputer + '$') -MemberOf $AD_GROUPS -Confirm:$false
				}
				Add-ADGroupMember -Identity 'All Club Computers' -Members ($SelectedComputer + "$")
				Add-ADGroupMember -Identity 'FD Club Computers' -Members ($SelectedComputer + "$")
				Add-ADGroupMember -Identity 'Club FD&MF Web Filter' -Members ($SelectedComputer + "$")
			}
			if ( $SelectedComputer -in ($MF, $MF1, $MF2, $MF3, $MF4, $MF5) ){
				$WorkstationType = 'MF'
				#Write-Host $WorkstationType
				if ($AD_GROUPS -ne $null){
					Remove-ADPrincipalGroupMembership -Identity ($SelectedComputer + '$') -MemberOf $AD_GROUPS -Confirm:$false
				}
				Add-ADGroupMember -Identity 'All Club Computers' -Members ($SelectedComputer + "$")
				Add-ADGroupMember -Identity 'MF Club Computers' -Members ($SelectedComputer + "$")
				Add-ADGroupMember -Identity 'Club FD&MF Web Filter' -Members ($SelectedComputer + "$")
			}
			if ( $SelectedComputer -in ($ACM, $ACM1, $ACM2, $ACM3, $ACM4, $ACM5, $CM, $CM1, $CM2, $CM3, $CM4, $CM5) ){
				$WorkstationType = 'BO'
				#Write-Host $WorkstationType
				if ($AD_GROUPS -ne $null){
					Remove-ADPrincipalGroupMembership -Identity ($SelectedComputer + '$') -MemberOf $AD_GROUPS -Confirm:$false
				}
				Add-ADGroupMember -Identity 'All Club Computers' -Members ($SelectedComputer + "$")
				Add-ADGroupMember -Identity 'BO Club Computers' -Members ($SelectedComputer + "$")
			}
			if ( $SelectedComputer -in ($LEFT_KIOSK, $LEFT_KIOSK1, $LEFT_KIOSK2, $LEFT_KIOSK3, $LEFT_KIOSK4, $LEFT_KIOSK5, $RIGHT_KIOSK, $RIGHT_KIOSK1, $RIGHT_KIOSK2, $RIGHT_KIOSK3, $RIGHT_KIOSK4, $RIGHT_KIOSK5) ){
				$WorkstationType = 'Kiosk'
				#Write-Host $WorkstationType
				if ($AD_GROUPS -ne $null){
					Remove-ADPrincipalGroupMembership -Identity ($SelectedComputer + '$') -MemberOf $AD_GROUPS -Confirm:$false
				}
				Add-ADGroupMember -Identity 'All Club Computers' -Members ($SelectedComputer + "$")
				Add-ADGroupMember -Identity 'Kiosk Club Computers' -Members ($SelectedComputer + "$")
			}
			
			#Move Computer to Correct OU
			foreach ( $ou in $ous ){
				$SelectedOU = ($ou.path)
				$oumatch = $regex.Match($SelectedOU)
				$OUClubID = [int]$oumatch.Value
				if ($OUClubID -eq $ComputerClubID) {
					#Write-Host $OUClubID
					#Write-Host $ComputerClubID
					#Write-Host $SelectedOU
					Get-ADComputer $SelectedComputer |Move-ADObject -TargetPath $SelectedOU -Verbose
				}
				else {
					""
				}
			}
		}
		else {
			""
		}
	}
}

#Computers from Default Computers OU
set_club_workstation_securitygroups_and_ou($defaultComputers_csv)

#Computers from Clubs OU
set_club_workstation_securitygroups_and_ou($clubComputers_csv)

#Windows 11
Import-Module ActiveDirectory

# Define the security group distinguished name
$groupDN = "CN=Windows 11 Devices,OU=Tech Ops,OU=Security Groups,OU=Corporate,OU=Locations,OU=[Company],DC=ad,DC=corp.example,DC=com"

# Search for all computers running Windows 11 in Active Directory
$win11Computers = Get-ADComputer -Filter 'OperatingSystem -like "Windows 11*"' | Select-Object

foreach ($computer in $win11Computers) {
    # Add computer to the security group
    Add-ADGroupMember -Identity $groupDN -Members ($computer)
    Write-Output "Added $computer to the Windows 11 security group."
}
