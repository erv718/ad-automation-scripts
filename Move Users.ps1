$users_csv = 'C:\users\$env:USERNAME\Desktop\users.csv'
$ous_csv = 'C:\users\$env:USERNAME\Desktop\ous.csv'
$users = Import-Csv -Path $users_csv
$ous = Import-Csv -Path $ous_csv
$regex = [regex]::new("\d+")

foreach( $user in $users ){
	$SelectedUser = ($user.user)
	$SelectedUserDescription = ($user.description)
	if ( $SelectedUserDescription -match "([0-9]{3})" ){
		$usermatch = $regex.Match($SelectedUserDescription)
		$UserClubID = [int]$usermatch.Value
		Write-Host $UserClubID
		foreach ( $ou in $ous ){
			$SelectedOU = ($ou.ou)
			$oumatch = $regex.Match($SelectedOU)
			$OUClubID = [int]$oumatch.Value
			if ($OUClubID -eq $UserClubID) {
				Write-Host $OUClubID
				#Get-ADUser $SelectedUser |Move-ADObject -TargetPath $SelectedOU -Verbose
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