function Lint-Project {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter()]
        [String]
        $ProjectName
    )
    
    begin {
        $currentDirectory = $PWD;    
    }
    
    process {        
        #record current dir    
        Set-Location -Path 'C:\Dev\Projects\SalesPortal\WebUI\'
        ng lint $ProjectName;    
    }
    
    end {
        Set-Location -Path $currentDirectory;    
    }
}
