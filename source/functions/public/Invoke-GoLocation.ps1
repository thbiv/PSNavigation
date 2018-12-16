Function Invoke-GoLocation {
    <#
    .SYNOPSIS
    Sets the location of the console to the path associated to the id given.

    .DESCRIPTION
    Sets the location of the console to the path associated to the id given.

    .PARAMETER Id
    Name of the Nav location to invoke.

    .EXAMPLE
    PS C:\> Invoke-GoLocation scripts

    This example will change the location of the console to the path assiciated
    with the scripts id. In this example, if the scripts id points to a path
    of C:\Scripts, the result displayed is:

    PS C:\Scripts>

    .EXAMPLE
    PS C:\> Go scripts

    This example if the same as example 1 but using the Go alias for
    Invoke-GoLocation

    .NOTES
    Written by: Thomas Barratt
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param(
        [Parameter(Position=0,Mandatory=$True)]
        [string]$Id
    )

    $DataSaveFile = "$HOME\AppData\Local\THBIV\Powershell\Navigation\data.xml"
    If (!(Test-Path $DataSaveFile)) {
        Write-Warning "[InvokeGoLocation] No data file exists. Cannot Invoke a location."
    } Else {
        Write-Verbose '[InvokeGoLocation] Importing data file'
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
        Write-Verbose '[InvokeGoLocation] Get object to invoke'
        $Invoked = $Locations | Where-Object {$_.Id -eq $Id}
        Write-Verbose '[InvokeGoLocation] Setting console location'
        If ($Invoked) {
            If ($pscmdlet.ShouldProcess("Invoking the Go Location '$Id'")) {
                Set-Location $Invoked.Location
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
Set-Alias -Name Go -Value Invoke-GoLocation