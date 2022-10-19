
# DO NOT RUN IN PRODUCTION ###################################################################################################################################
# WARNING: This block of code is extremely destructive and will delete all resource(s) forcefully excluding only the storage account configured for cloudshell
Get-AzResource | ForEach-Object -Parallel {
    # Set variables
    $resource = $_
    $resourceName = $resource.Name
    $resourceId = $resource.ResourceId
    $cloudShellStorage = (Get-CloudDrive).StorageAccountName

    # If/Else Logic to avoid deleting cloudsh
    if ($resourceName -eq $cloudShellStorage) {
        "Skipping... $resourceName"
    }
    else {
        try {
            "Deleting... $resourceName"
            Remove-AzResource -Id $resourceId -Force | Out-Null
        }
        catch {
            "Failed to Delete... $resourceName"
        }
    }
}
