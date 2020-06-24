[CmdletBinding()]
Param (
    [Parameter(Mandatory=$False,Position=0)]
    [ValidateSet('.','Testing')]
    [string]$BuildTask = '.',
    [switch]$BumpMajorVersion,
    [switch]$BumpMinorVersion
)

Write-Host "Bootstrap Environment"
Write-Host "Loading Config File"
[xml]$ModuleConfig = Get-Content Module.Config.xml
Write-Host "Nuget PackageProvider"
If (-not(Get-PackageProvider -Name Nuget)) {
    Write-Host "  - Installing..." -NoNewline
    Install-PackageProvider -Name Nuget -Force -Scope CurrentUser
    Write-Host "Done" -ForegroundColor Green
} Else {Write-Host "  - Already installed" -ForegroundColor Green}

Write-Host "Repositories"
If (((Get-PSRepository -Name PSGallery).InstallationPolicy) -ne 'Trusted') {
    Write-Host "  - Setting PSGallery to Trusted..." -NoNewline
    Set-PSRepository -Name PSGallery -InstallationPolicy 'Trusted'
    Write-Host "Done" -ForegroundColor Green
} Else { Write-Host "  - PSGallery is Trusted"}
$Repos = $ModuleConfig.config.psrepos.psrepo
ForEach ($Repo in $Repos) {
    Write-Host "$($Repo.name)"
    If (-not(Get-PSRepository -Name $($Repo.name))) {
        Write-Host "  - Registering PSRepository..." -NoNewline
        $Params = @{
            Name = $($Repo.name)
            SourceLocation = $($Repo.sourcelocation)
            InstallationPolicy = $($Repo.installationpolicy)
        }
        Register-PSRepository @Params
        Write-Host "Done" -ForegroundColor Green
    } Else {Write-Host "  - Already Registered" -ForegroundColor Green}
}
Write-Host "Module Dependencies"
$RequiredModules = $ModuleConfig.config.requiredmodules.module
ForEach ($Module in $RequiredModules) {
    Write-Host "  $($Module.name)"
    If (-not(Get-Module -Name $($Module.name) -ListAvailable)) {
        Write-Host "  - Installing..." -NoNewline
        $Params = @{
            Name = $($Module.name)
            Scope = 'CurrentUser'
            Force = $True
        }
        If ($Null -ne $Module.requiredversion) {$Params += @{RequiredVersion = $($Module.requiredversion)}}
        If ($Null -ne $Module.repository) {$Params += @{Repository = $($Module.repository)}}
        Install-Module @Params
        Write-Host "Done" -ForegroundColor Green
    } Else {Write-Host "  - Already Installed" -ForegroundColor Green}
    If (-not(Get-Module -Name $($Module.name))) {
        Write-Host "  - Importing..." -NoNewline
        Import-Module -Name $($Module.name)
        Write-Host "Done" -ForegroundColor Green
    } Else {Write-Host "  - Already Imported" -ForegroundColor Green}
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