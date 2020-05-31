if (!$setupProfileHasLoaded){
    . C:\Dev-Github\powershellscripts\src\Config\powershell\SetupProfile.ps1
}

if (!(Test-Path -Path Function:\\Lint-Project)){
    . C:\Dev-Github\powershellscripts\src\DevelopmentModules\Client-Specific\Angular-Methods-Module\Lint-Project.ps1
}