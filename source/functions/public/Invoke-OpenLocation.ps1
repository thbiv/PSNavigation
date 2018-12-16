Function Invoke-OpenLocation {
    <#
    .SYNOPSIS
    Opens a Windows Explorer window to the path associated to the Id given.

    .DESCRIPTION
    Opens a Windows Explorer window to the path associated to the Id given.

    .PARAMETER Id
    Name of the Open location to invoke.

    .PARAMETER Path
    Lets you type in a path manually if you do not need to add the location
    to the database.

    .EXAMPLE
    PS C:\> Invoke-OpenLocation scripts

    This example will open a Windows Explorer window to the path assiciated
    with the scripts id.

    .EXAMPLE
    PS C:\> Open scripts

    This example is the same as example 1 but using the Open alias for
    Invoke-OpenLocation

    .EXAMPLE
    PS C:\> Open

    This example will open the current location of the console. In this case
    C:\ will open in a window.

    .EXAMPLE
    PS C:\> Open -Path 'C:\Users'

    This example will open an explorer window to C:\Users without having to
    add the location to the database.

    .NOTES
    Written by: Thomas Barratt
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Position=0)]
        [string]$Id = '',

        [Alias('p')]
        [string]$Path
    )

    $DataSaveFile = "$HOME\AppData\Local\THBIV\Powershell\Navigation\data.xml"
    If (!(Test-Path $DataSaveFile)) {
        Write-Warning "[InvokeOpenLocation] No data file exists. Cannot Invoke a location."
    } Else {
        Write-Verbose '[InvokeOpenLocation] Importing data file'
        Try {
			$NavData = ImportXMLData -Path $DataSaveFile
        }
		Catch {
			$ErrorMessage = $_.Exception.Message
            Throw $ErrorMessage
		}
		$DataFileCreatedDate = $NavData.DataFileCreatedDate
		$Locations = $NavData.Locations
		$RemovedLocations = $NavData.RemovedLocations
        Write-Verbose '[InvokeOpenLocation] Get object to invoke'
        If ($Path) {
            If (Test-Path -Path $Path) {
                explorer.exe $Path
            } Else {
                Throw "$Path does not exist"
            }
        } Else {
            If ($Id -eq '') {
                $OpenItem = (Get-Location).Path
            } Else {
                $OpenItem = $Locations | Where-Object {$_.Id -eq $Id}
                If (!($OpenItem)) {

                    Throw "$Id does not exist in the database"
                }
            }
            If ($OpenItem) {
                Write-Verbose '[InvokeOpenLocation] Opening explorer window'
		        Push-Location $OpenItem.Location
                explorer.exe .
                Pop-Location
				If ($Id) {
					$Locations | Where-Object {$_.Id -eq $Id} | ForEach-Object {$_.Invoked ++}
					$Props = @{
						'DataFileCreatedDate'=$DataFileCreatedDate;
						'Locations'=$Locations;
						'RemovedLocations'=$RemovedLocations;
					}
					$NavObject = New-Object -TypeName PSObject -Property $Props
					ExportXMLData -InputObject $NavObject -Path $DataSaveFile
				}
            }
        }
    }
}
Set-Alias -Name Open -Value Invoke-OpenLocation