function New-AzCostFinderServicePrincipal {
    [OutputType('type')]
    [CmdletBinding(SupportsShouldProcess)]
    param
    (
        
    )

    $ErrorActionPreference = 'Stop'

    #region Create the Azure AD application
    $appPw = New-RandomPassword

    $myApp = New-AzADApplication -DisplayName $script:azureAdAppName -IdentifierUris 'http://azcostfinder.io' -Password $appPw
    #endregion

    #region Create the service principal referencing the application created
    $sp = New-AzADServicePrincipal -ApplicationId $myApp.ApplicationId
    #endregion

    $azSubCtx = Get-AzContext

    #region Create a new role and assign the role to the service principal
    if (-not (Get-AzRoleDefinition -Name $script:AzCustomRoleName)) {
        New-AzCostFinderRole -SubscriptionId ($azSubCtx.Subscription.Id)
        $null = New-AzRoleAssignment -RoleDefinitionName $script:AzCustomRoleName -ServicePrincipalName $sp.ServicePrincipalNames[0]
    }
    #endregion

    [pscustomobject]@{
        'ApplicationId'       = $myApp.ApplicationId
        'ApplicationPassword' = $appPw
    }
}