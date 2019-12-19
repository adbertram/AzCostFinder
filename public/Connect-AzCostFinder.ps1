function Connect-AzCostFinder {
    [CmdletBinding()]
    param
    (
        
    )

    $ErrorActionPreference = 'Stop'

    ## Create the Azure AD app, service principal and role if it doesn't exist yet
    if (-not (Get-AzAdApplication -DisplayName $script:azureAdAppName)) {
        $app = New-AzCostFinderServicePrincipal
    }

    #region Authenticate with the service principal
    $appCred = New-Object System.Management.Automation.PSCredential ($app.ApplicationId, $app.ApplicationPassword)
    Connect-AzAccount -ServicePrincipal -SubscriptionId $azSubCtx.Subscription.Id -Tenant $azSubCtx.Tenant.Id -Credential $appCred
    #endregion
}