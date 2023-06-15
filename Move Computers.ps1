$hostnames_csv = 'C:\users\$env:USERNAME\Desktop\hostnames.csv'
$ous_csv = 'C:\users\$env:USERNAME\Desktop\ous.csv'
$hostnames = Import-Csv -Path $hostnames_csv
$ous = Import-Csv -Path $ous_csv
$regex = [regex]::new("\d+")

foreach( $hostname in $hostnames ){
	$SelectedHostname = ($hostname.hostname)
	if ($SelectedHostname -match "([0-9]{3})"){
		$hostmatch = $regex.Match($SelectedHostname)
		$HostClubID = [int]$hostmatch.Value
		Write-Host $HostClubID
		foreach ( $ou in $ous ){
			$SelectedOU = ($ou.ou)
			$oumatch = $regex.Match($SelectedOU)
			$OUClubID = [int]$oumatch.Value
			if ($OUClubID -eq $HostClubID) {
				Write-Host $OUClubID
				#Get-ADComputer $SelectedHostname |Move-ADObject -TargetPath $SelectedOU -Verbose
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