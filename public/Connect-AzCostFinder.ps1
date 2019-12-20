function Connect-AzCostFinder {
    [CmdletBinding()]
    param
    (
        
    )

    $ErrorActionPreference = 'Stop'

    if (-not (Get-AzADServicePrincipal -DisplayName $script:projectName)) {
        $sp = New-AzCostFinderCredential
    }

    ## Decrypt the service principal credential. It's needed in plain text to send to the REST API
    $spPlainTextPw = [System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($sp.Secret))

    $loginUri = "https://login.microsoftonline.com/$((Get-AzContext).Tenant.Id)/oauth2/token?api-version=1.0"

    $body = @{
        grant_type    = "client_credentials"
        resource      = "https://management.core.windows.net/"
        client_id     = $sp.ApplicationId
        client_secret = $spPlainTextPw
    }

    $loginResponse = Invoke-RestMethod $loginUri -Method Post -Body $body
    $script:authToken = $loginResponse.token_type + ' ' + $loginResponse.access_token
}