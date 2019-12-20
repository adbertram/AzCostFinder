Set-StrictMode -Version Latest

## These script vars are used to create a service principal and role custom-built to only require needed privileges
$script:AzCustomRoleName = 'AzCostFinder PowerShell Module Cost Viewer'
$script:projectName = 'AzCostFinder'

# Get public and private function definition files.
$Public = @(Get-ChildItem -Path $PSScriptRoot\public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $PSScriptRoot\private\*.ps1 -ErrorAction SilentlyContinue)

# Dot source the files.
foreach ($import in @($Public + $Private)) {
    try {
        Write-Verbose "Importing $($import.FullName)"
        . $import.FullName
    } catch {
        Write-Error "Failed to import function $($import.FullName): $_"
    }
}

foreach ($file in $Public) {
    Export-ModuleMember -Function $file.BaseName
}