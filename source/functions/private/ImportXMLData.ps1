Function ImportXMLData {
	Param(
		[Parameter(Mandatory=$True)][string]$Path
	)
	$XML = New-Object -TypeName XML
    $XML.Load($Path)
	$DataFileCreatedDate = $XML.navigation.datecreated
	$Locations = @()
	ForEach ($Item in $($XML.navigation.locations.location)) {
		$Props = @{
			'Id'=$($Item.id);
			'Location'=$($Item.location);
			'DateCreated'=$($Item.datecreated);
			'Invoked'=[int]$($Item.invoked);
		}
		$Obj = New-Object -TypeName PSObject -Property $Props
		$Locations += $Obj
	}
	$RemovedLocations = @()
	ForEach ($Item in $($XML.navigation.removedlocations.location)) {
		$Props = @{
			'Id'=$($Item.id);
			'Location'=$($Item.location);
			'DateCreated'=$($Item.datecreated);
			'Invoked'=[int]$($Item.invoked);
			'datedeleted'=$($Item.datedeleted);
		}
		$Obj = New-Object -TypeName PSObject -Property $Props
		$RemovedLocations += $Obj
	}
	$Props = @{
		'DataFileCreatedDate'=$DataFileCreatedDate;
		'Locations'=$Locations;
		'RemovedLocations'=$RemovedLocations;
	}
	$Output = New-Object -TypeName PSObject -Property $Props
	Write-Output $Output
}