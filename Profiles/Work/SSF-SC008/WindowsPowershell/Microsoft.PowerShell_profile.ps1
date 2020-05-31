$WorkPowershellProfileSetup = C:\Dev-Github\powershellscripts\src\Config\powershell\SetupProfile.ps1;

if (Test-Path -Path $WorkPowershellProfileSetup){
. $WorkPowershellProfileSetup;
}

