function Get-WinADForestOptionalFeatures {
    [CmdletBinding()]
    param(
        $ComputerProperties
    )

    $LapsProperties = 'ms-Mcs-AdmPwd' #  'ms-Mcs-AdmPwdExpirationTime'


    $OptionalFeatures = $(Get-ADOptionalFeature -Filter * )
    $Optional = [ordered]@{
        'Recycle Bin Enabled'                          = 'N/A'
        'Privileged Access Management Feature Enabled' = 'N/A'
    }
    foreach ($Feature in $OptionalFeatures) {
        if ($Feature.Name -eq 'Recycle Bin Feature') {
            $Optional.'Recycle Bin Enabled' = $Feature.EnabledScopes.Count -gt 0
        }
        if ($Feature.Name -eq 'Privileged Access Management Feature') {
            $Optional.'Privileged Access Management Feature Enabled' = $Feature.EnabledScopes.Count -gt 0
        }
    }
    $Optional.'Laps Enabled' = ($ComputerProperties -contains $LapsProperties)
    return $Optional
}