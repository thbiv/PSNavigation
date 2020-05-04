Function Invoke-GoLocation {
    <#
    .EXTERNALHELP PSNavigation-help.xml
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