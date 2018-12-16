Function Add-NavLocation {
    <#
    .SYNOPSIS
    Adds a Powershell bookmark to the Nav database.

    .DESCRIPTION
    Adds a Powershell bookmark to the Nav database with the name of the location
    and the path to the location.

    .PARAMETER Id
    The name of the location you want to store. This name will be used when invoking
    the path to the Powershell console. Length can be from 1 to 15 characters.

    .PARAMETER Location
    The path of the location to store.  Can be a local path or a UNC path.

    .EXAMPLE
    PS C:\> Add-NavLocation -Id c -Location C:\

    This example will add a NavLocation to the database named C that points to C:\

    .EXAMPLE
    PS C:\> Add-NavLocation c C:\

    This example will add a NavLocation to the database named C that points to C:\

    .EXAMPLE
    PS C:\> Add-NavLocation -Id c

    This example will add a NavLocation to the database named c.  Since the location
    parameter was not given, the cmdlet will insert the current location of the console
    as the path. This will have the same affect as examples 1 and 2.

    .NOTES
    Written by: Thomas Barratt
    #>
    [CmdletBinding(SupportsShouldProcess=$True)]
    Param(
        [Parameter(Position=0,Mandatory=$True)]
        [ValidateLength(1,15)]
        [string]$Id,

        [Parameter(Position=1)]
        [string]$Location = ''
    )

    $DateTimeStamp = (Get-Date).ToString()
    $DataSaveFile = "$HOME\AppData\Local\THBIV\Powershell\Navigation\data.xml"
    If (!(Test-Path $DataSaveFile)) {
        Initialize-XMLDataFile -Path $DataSaveFile
    }

    Write-Verbose '[AddNavLocation] Importing data file'
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
    Write-Verbose '[AddNavLocation] Adding members to temp object'
    If ($Location -eq '') {
        Write-Verbose '[AddNavLocation] Using the consoles current location'
        $NewLocation = (Get-Location).Path
    } Else {
        Write-Verbose "[AddNavLocation] Using $Location"
        $NewLocation = $Location
    }
    Write-Verbose "[AddNavLocation] Check if $Id is a duplicate"
    ForEach ($Item in $Locations) {
        If ($Item.Id -eq $New.Id) {
            Throw "Duplicate ID: $Id"
        }
    }
    $Props = @{
        'Id'=$Id;
        'Location'=$NewLocation;
        'DateCreated'=$DateTimeStamp;
        'Invoked'=[int]0;
    }
    $Obj = New-Object -TypeName PSObject -Property $Props

    $Locations += $Obj
    Write-Verbose '[AddNavLocation] Updating the data file'
    If ($pscmdlet.ShouldProcess("Adding '$Id' to Location Database")) {
        $Props = @{
            'DataFileCreatedDate'=$DataFileCreatedDate;
            'Locations'=$Locations;
            'RemovedLocations'=$RemovedLocations;
        }
        $NavObject = New-Object -TypeName PSObject -Property $Props
        ExportXMLData -InputObject $NavObject -Path $DataSaveFile
    }
}