function New-AzCostFinderRole {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$SubscriptionId
    )

    $ErrorActionPreference = 'Stop'

    $role = Get-AzRoleDefinition -Name 'Reader'
    $role.Id = $null
    $role.Name = $script:AzCustomRoleName
    $role.Description = 'Can read all necessary pricing data across Azure resources.'
    $role.Actions.RemoveRange(0, $role.Actions.Count)
    $role.Actions.Add('Microsoft.Compute/virtualMachines/vmSizes/read')
    $role.Actions.Add('Microsoft.Resources/subscriptions/locations/read')
    $role.Actions.Add('Microsoft.Resources/providers/read')
    $role.Actions.Add('Microsoft.ContainerService/containerServices/read')
    $role.Actions.Add('Microsoft.Commerce/RateCard/read')
    $role.AssignableScopes.Clear()
    $role.AssignableScopes.Add("/subscriptions/$SubscriptionId")

    New-AzRoleDefinition -Role $role
}