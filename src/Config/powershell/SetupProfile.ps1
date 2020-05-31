$setupProfileHasLoaded = $true;
#if (!(Test-Path -Path $Profile.AllUsersAllHosts)){
#    New-Item -ItemType File -Path $Porfile -Force;
#}
if (!(Test-Path -Path PersonalProfile:\\)){
    New-PsDrive -Name PersonalProfile -PSProvider FileSystem -Root '\\stinefs01\fr$\makern\' | Out-Null;
}
if (!(Test-Path -Path PersonalDevGitHub:\\)){
    New-PsDrive -Name PersonalDevGitHub -PSProvider FileSystem -Root 'C:\Dev-Github\' | Out-Null;
}
$AllUserAllHostProfile = "PersonalDevGitHub:\\powershellscripts\Profiles\Work\SSF-SC008\WindowsPowershell\profile.ps1";
if (!(Test-Path -Path $Profile.AllUsersAllHosts)){
    if (!(Test-Path $AllUserAllHostProfile)){
        if (!(Test-Path $env:SCOOP_GLOBAL){
            $ScoopGit = (scoop which git);

        }
    }
    if ((Test-Path $AllUserAllHostProfile)){
        New-Item -ItemType SymbolicLink -Path $Profile.AllUsersAllHosts -Target $AllUserAllHostProfile;
    }
}
