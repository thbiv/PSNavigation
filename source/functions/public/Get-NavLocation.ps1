Function Get-NavLocation {
    <#
    .SYNOPSIS
    Returns objects containing entries in the Nav Database.

    .DESCRIPTION
    Returns objects containing entries in the Nav Database.

    .EXAMPLE
    PS C:\> Get-NavLocation

    This example will retrieve all the entries in the Nav database and display them to the host.

    .OUTPUTS
    PSNavigationLocation

    .NOTES
    Written by: Thomas Barratt
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