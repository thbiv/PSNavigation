Function Get-NavLocation {
    <#
    .EXTERNALHELP PSNavigation-help.xml
    #>
    [CmdletBinding(SupportsPaging)]
    [OutputType([PSNavigationLocation])]
    Param()

    $DataSaveFile = "$HOME\AppData\Local\THBIV\Powershell\Navigation\data.xml"
    If (!(Test-Path $DataSaveFile)) {
        Write-Verbose "[GetNavLocation] No data file exists. Nothing to output."
    } Else {
        Try {
            Write-Verbose "[GetNavLocation] Data file exists. Importing data."
            $NavData = ImportXMLData -Path $DataSaveFile
        }
        Catch {
            $ErrorMessage = $_.Exception.Message
            Throw $ErrorMessage
        }
        Write-Verbose "[GetNavLocation] Output PSNavigationLocation Objects"
        ForEach ($Location in $NavData.Locations) {
            $Obj = New-Object -TypeName PSNavigationLocation -ArgumentList $($Location.Id),
                                                                           $($Location.Location),
                                                                           $($Location.DateCreated),
                                                                           $($Location.Invoked)
            Write-Output $Obj
        }
    }
}