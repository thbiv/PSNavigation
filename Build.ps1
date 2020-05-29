[CmdletBinding()]
Param (
    [Parameter(Mandatory=$False,Position=0)]
    [ValidateSet('.','Testing')]
    [string]$BuildTask = '.',

    [switch]$BumpMajorVersion,

    [switch]$BumpMinorVersion
)

Write-Host "Bootstrap Environment"
Write-Host "Nuget PackageProvider"
If (-not(Get-PackageProvider -Name Nuget)) {
    Write-Host "  - Installing..." -NoNewline
    Install-PackageProvider -Name Nuget -Force -Scope CurrentUser
    Write-Host "Done" -ForegroundColor Green
} Else {Write-Host "  - Already installed" -ForegroundColor Green}

Write-Host "Module Dependencies"
[xml]$ModuleConfig = Get-Content Module.Config.xml
$RequiredModules = $ModuleConfig.config.requiredmodules.module
ForEach ($Module in $RequiredModules) {
    Write-Host "  $($Module.name)"
    If (-not(Get-Module -Name $($Module.name) -ListAvailable)) {
        Write-Host "    - Installing..." -NoNewline
        $Params = @{
            Name = $($Module.name)
            Scope = 'CurrentUser'
            Force = $True
        }
        If ($Null -ne $Module.requiredversion) {$Params += @{RequiredVersion = $($Module.requireduversion)}}
        If ($Null -ne $Module.repository) {$Params += @{Repository = $($Module.repository)}}
        Install-Module @Params
        Write-Host "Done" -ForegroundColor Green
    } Else {Write-Host "    - Already Installed" -ForegroundColor Green}
    If (-not(Get-Module -Name $($Module.name))) {
        Write-Host "    - Importing..." -NoNewline
        Import-Module -Name $($Module.name)
        Write-Host "Done" -ForegroundColor Green
    } Else {Write-Host "    - Already Imported" -ForegroundColor Green}
}

$Params = @{
    Task = $BuildTask
    File = 'PSNavigation.build.ps1'
}
If ($BumpMajorVersion) {
    $Params.Add('BumpMajorVersion',$True)
}
If ($BumpMinorVersion) {
    $Params.Add('BumpMinorVersion',$True)
}
Invoke-Build @Params