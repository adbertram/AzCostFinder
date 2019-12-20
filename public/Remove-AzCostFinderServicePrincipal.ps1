function Remove-AzCostFinderServicePrincipal {
    [OutputType('null')]
    [CmdletBinding()]
    param
    ()

    $ErrorActionPreference = 'Stop'
    
    if ($app = Get-AzADApplication -DisplayName $script:projectName) {
        Write-Verbose -Message "Removing Azure AD application $script:projectName..."
        $app | Remove-AzADApplication
    }

    if ($sp = Get-AzADServicePrincipal -DisplayName $script:projectName) {
        Write-Verbose -Message 'Removing AzCostFinder service principal...'
        $sp | Remove-AzADServicePrincipal
    }

    # if ($roleAss = Get-AzRoleAssignment -RoleDefinitionName $script:AzCustomRoleName) {
    #     Write-Verbose -Message 'Removing role assignment....'
    #     $roleAss | Remove-AzRoleAssignment
    # }

    if ($roleDef = Get-AzRoleDefinition -Name $script:AzCustomRoleName) {
        Write-Verbose -Message 'Removing AzCostFinder Azure role definition....'
        $roleDef | Remove-AzRoleDefinition
    }
}