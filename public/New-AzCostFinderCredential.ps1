function New-AzCostFinderCredential {
    [OutputType('type')]
    [CmdletBinding(SupportsShouldProcess)]
    param
    (
        
    )

    $ErrorActionPreference = 'Stop'

    #region Create the Azure AD application
    # $appPw = New-RandomPassword

    # if (-not ($app = Get-AzADApplication -DisplayName $script:projectName)) {
    #     Write-Verbose -Message "Creating Azure AD application $script:projectName..."
    #     $app = New-AzADApplication -DisplayName $script:projectName -IdentifierUris 'http://azcostfinder.io' -Password $appPw
    # }
    #endregion

    $azSubCtx = Get-AzContext

    #region Create a new role and assign the role to the service principal
    if (-not (Get-AzRoleDefinition -Name $script:AzCustomRoleName)) {
        Write-Verbose -Message 'Creating AzCostFinder Azure role definition....'
        $null = New-AzCostFinderRole -SubscriptionId ($azSubCtx.Subscription.Id)
    }

    #region Create the service principal referencing the application created
    Write-Verbose -Message 'Creating AzCostFinder service principal...'
    New-AzADServicePrincipal -DisplayName $script:projectName -Role $script:AzCustomRoleName
    #endregion

    
    # if (-not (Get-AzRoleAssignment -ServicePrincipalName $sp.ServicePrincipalNames[0] -ErrorAction Ignore)) {
    #     Write-Verbose -Message 'Assigning service principal to AzCostFinder Azure role definition....'
    #     $null = New-AzRoleAssignment -RoleDefinitionName $script:AzCustomRoleName -ServicePrincipalName $sp.ServicePrincipalNames[0]
    # }
}