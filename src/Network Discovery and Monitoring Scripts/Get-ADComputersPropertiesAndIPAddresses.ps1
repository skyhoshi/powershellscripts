function Get-ADComputersPropertiesAndIPAddresses {
<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
    [CmdletBinding(DefaultParameterSetName = 'Identification', 
        SupportsShouldProcess = $true, 
        PositionalBinding = $false,
        HelpUri = 'https://www.github.com/skyhoshi/powershell',
        ConfirmImpact = 'Medium')]
    [Alias()]
    [OutputType([String])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory = $true, 
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true, 
            ValueFromRemainingArguments = $false, 
            Position = 0,
            ParameterSetName = 'Identification')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        # [ValidateCount(0, 5)]
        # [ValidateSet("sun", "moon", "earth")]
        [Alias("AD Server Name or IP Address")]        
        $HostName

        # # Param2 help description
        # [Parameter(ParameterSetName = 'Parameter Set 1')]
        # [AllowNull()]
        # [AllowEmptyCollection()]
        # [AllowEmptyString()]
        # [ValidateScript( { $true })]
        # [ValidateRange(0, 5)]
        # [int]
        # $Param2,

        # # Param3 help description
        # [Parameter(ParameterSetName = 'Another Parameter Set')]
        # [ValidatePattern("[a-z]*")]
        # [ValidateLength(0, 15)]
        # [String]
        # $Param3
    )

    Begin {
        if ([System.io.File]::Exists("$env:USERPROFILE\desktop\ComputerActiveDirectoryReport-Prelim.csv")) {
            Remove-Item "$env:USERPROFILE\desktop\ComputerActiveDirectoryReport-Prelim.csv" -Force
        }
    }
    Process {
        if ($pscmdlet.ShouldProcess("Target", "Operation")) {
            ########################################################################################

            ########################################################################################
            $AdHostSearch = [adsisearcher]("WinNt://$hostname")
            $AdHostSearch.Filter = "objectclass=computer";
            $searchResults = $null
            $searchResults = $AdHostSearch.FindAll() 
            ########################################################################################
            $HostNameList = New-Object -TypeName System.Collections.ArrayList;
            #$AdComputerPropertiesList = New-Object -TypeName System.Collections.ArrayList;
            foreach ($result in $searchResults) {
                #Write-Host $result.Properties
                foreach ($unTypedProperty in $result.Properties) {
                    #Write-Host "UnTyped Properties" -ForegroundColor yellow;
                    foreach ($prop in $unTypedProperty) {
                        $AdComputerName = $prop["cn"];
                        #Write-Host -ForegroundColor Green "Properties for computer $AdComputerName";
                        $HostNameList.Add($AdComputerName);
                    }
                }
            }
            #$AdComputerPropertiesList | Select-Object * | Export-Csv "$env:USERPROFILE\desktop\ComputerActiveDirectoryReport-Prelim.csv" -NoTypeInformation -Force

            ForEach ($hostn in $hostNameList) {
                #Write-Host $hostname
                try {
                    $hostEntry = [System.Net.Dns]::GetHostByName($hostn)
                    $hostEntry;
                }
                catch {
                    Write-Host "$hostn :: $_" -ForegroundColor Yellow 
                }
            }
        }
    }
    End {
    }
}

Get-ADComputersPropertiesAndIPAddresses -HostName "sorafamily.com"
