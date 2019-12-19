function New-RandomPassword {
    [OutputType('securestring')]
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [int]$Length = 20
    )

    $ErrorActionPreference = 'Stop'

    $ReturnString = ''
    $AvailableChar = 42..57 + 65..90 + 97..122
    $AvailableChar | Get-Random -Count $Length | ForEach-Object {
        $ReturnString += [char][byte]$_
    }
    ConvertTo-SecureString -String $ReturnString -AsPlainText -Force
}