Function Remove-NavLocation {
    <#
    .EXTERNALHELP PSNavigation-help.xml
    #>
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param(
        [Parameter(Position=0,Mandatory=$True,ParameterSetName='Id')]
        [string]$Id,

        [Parameter(Mandatory=$True,ParameterSetName='All')]
        [switch]$All
    )

	$DateTimeStamp = (Get-Date).ToString()
    $DataSaveFile = "$HOME\AppData\Local\THBIV\Powershell\Navigation\data.xml"
    If (!(Test-Path $DataSaveFile)) {
        Write-Verbose "[GetNavLocation] No data file exists. Nothing to remove."
    } Else {
        Write-Verbose 'Importing data file'
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
        $Locations | Add-Member -MemberType NoteProperty -Name tag -Value 0
        If ($All) {
            Write-Verbose 'Deleting All Go data'
            Write-Verbose 'Updating data file. Omitting objects with tag equal to 0.'
            $DelItems = $Locations
            $DelItems | Add-Member -MemberType NoteProperty -Name DateDeleted -Value $DateTimeStamp
            $DelItems | ForEach-Object {$RemovedLocations += $_} | Select-Object Id,Location,DateCreated,Invoked,DateDeleted
            $Locations = $Locations | Where-Object {$_.tag -ne 0} | Select-Object Id,Location,DateCreated,Invoked
        }
        Else {
            Write-Verbose 'Selecting object to remove and setting its tag to 1'
            $DelItem = $Locations | Where-Object {$_.Id -eq $Id}
            ForEach ($Item in $DelItem) {
                $Item.tag = 1
            }
            $DelItem | Add-Member -MemberType NoteProperty -Name DateDeleted -Value $DateTimeStamp
            ForEach ($Item in $DelItem) {
                $Obj = $Item | Select-Object Id,Location,DateCreated,Invoked,DateDeleted
                $RemovedLocations += $Obj
            }
            Write-Verbose 'Updating data file. Omitting the object with tag equal to 1.'
        }
        If ($pscmdlet.ShouldProcess($Id)) {
            $Locations = $Locations | Where-Object {$_.tag -ne 1} | Select-Object Id,Location,DateCreated,Invoked
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