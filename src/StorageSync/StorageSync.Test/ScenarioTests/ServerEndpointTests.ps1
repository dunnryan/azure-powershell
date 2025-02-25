﻿# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.SYNOPSIS
Test ServerEndpoint
.DESCRIPTION
SmokeTest
#>
function Test-ServerEndpoint2 {
    # Setup
    $resourceGroupName = Get-ResourceGroupName
    Write-Verbose "RecordMode : $(Get-StorageTestMode)"
    try {
        # Test
        $storageSyncServiceName = Get-ResourceName("sss")
        $syncGroupName = Get-ResourceName("sg")
        $serverEndpointName = Get-ResourceName("sep")
        $cloudEndpointName = Get-ResourceName("cep")
        $resourceGroupLocation = Get-ResourceGroupLocation
        $resourceLocation = Get-StorageSyncLocation("Microsoft.StorageSync/storageSyncServices")

        $azureFileShareName = "testfs" #Get-ResourceName("fs")
        $storageAccountName = Get-ResourceName("sa")
        $storageAccountTenantId = Get-TenantId
        # NOTE: Check the local server drives where we are performing registration.
        $serverLocalPath = "D:\" + $serverEndpointName
        $tierFilesOlderThanDays = 10
        $volumeFreeSpacePercent = 60
        $volumeFreeSpacePercent2 = 80
        $initialUploadPolicy = "ServerAuthoritative"
        Write-Verbose "RGName: $resourceGroupName | Loc: $resourceGroupLocation | Type : ResourceGroup"
        New-AzResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation

        Write-Verbose "Resource: $storageSyncServiceName | Loc: $resourceLocation | Type : StorageSyncService"
        $storageSyncService = New-AzStorageSyncService -ResourceGroupName $resourceGroupName -Location $resourceLocation -StorageSyncServiceName $storageSyncServiceName

        Write-Verbose "Resource: $syncGroupName | Loc: $resourceLocation | Type : SyncGroup"
        $syncGroup = New-AzStorageSyncGroup -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -Name $syncGroupName

        Write-Verbose "Resource: $StorageAccountName | Loc: $resourceLocation | Type : StorageAccount"
        $storageAccount = New-AzStorageAccount -StorageAccountName $StorageAccountName -Location $resourceLocation -ResourceGroupName $resourceGroupName -Type Standard_LRS
        $key = Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $StorageAccountName
        $context = Create-StorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $key[0].Value
        Write-Verbose "Resource: $AzureFileShareName | Loc: $resourceLocation | Type : AzureStorageShare"

        $azureFileShareName = Create-StorageShare -Name $AzureFileShareName -Context $context
        $storageAccountResourceId = $storageAccount.Id

        Write-Verbose "Resource: $cloudEndpointName | Loc: $resourceLocation | Type : CloudEndpoint"
        $job = New-AzStorageSyncCloudEndpoint -ParentObject $syncGroup -Name $cloudEndpointName -StorageAccountResourceId $storageAccountResourceId -AzureFileShareName $azureFileShareName -StorageAccountTenantId $StorageAccountTenantId -AsJob
        $job | Wait-Job
        $cloudEndpoint = get-job -Id $job.Id | receive-job -Keep

        Write-Verbose "Resource: <auto-generated> | Loc: $resourceLocation | Type : RegisteredServer"
        $job = Register-AzStorageSyncServer -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -AsJob
        $job | Wait-Job
        $registeredServer = get-job -Id $job.Id | receive-job -Keep

        Write-Verbose "Resource: $serverEndpointName | Loc: $resourceLocation"
        $job = New-AzStorageSyncServerEndpoint -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -Name $serverEndpointName -ServerResourceId $registeredServer.ResourceId -ServerLocalPath $serverLocalPath -CloudTiering -VolumeFreeSpacePercent $volumeFreeSpacePercent -TierFilesOlderThanDays $tierFilesOlderThanDays -InitialUploadPolicy $initialUploadPolicy -Verbose -AsJob

        $job | Wait-Job
        $serverEndpoint = get-job -Id $job.Id | receive-job -Keep

        Write-Verbose "Validating ServerEndpoint Properties"
        Assert-AreEqual $serverEndpointName $serverEndpoint.ServerEndpointName
        Assert-AreEqual $serverLocalPath $serverEndpoint.ServerLocalPath
        Assert-AreEqual $volumeFreeSpacePercent $serverEndpoint.VolumeFreeSpacePercent

        Write-Verbose "Get ServerEndpoint by Name"
        $serverEndpoint = Get-AzStorageSyncServerEndpoint -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -ServerEndpointName $serverEndpointName

        Write-Verbose "Validating ServerEndpoint Properties"
        Assert-AreEqual $serverEndpointName $serverEndpoint.ServerEndpointName
        Assert-AreEqual $serverLocalPath $serverEndpoint.ServerLocalPath
        Assert-AreEqual $volumeFreeSpacePercent $serverEndpoint.VolumeFreeSpacePercent
        Assert-AreEqual $initialUploadPolicy $serverEndpoint.InitialUploadPolicy

        Write-Verbose "Get ServerEndpoint by ParentObject"
        $serverEndpoint = Get-AzStorageSyncServerEndpoint -ParentObject $syncGroup -Name $serverEndpointName -Verbose
        Write-Verbose "Validating ServerEndpoint Properties"
        Assert-AreEqual $serverEndpointName $serverEndpoint.ServerEndpointName
        Assert-AreEqual $serverLocalPath $serverEndpoint.ServerLocalPath
        Assert-AreEqual $volumeFreeSpacePercent $serverEndpoint.VolumeFreeSpacePercent
        Assert-AreEqual $initialUploadPolicy $serverEndpoint.InitialUploadPolicy

        Write-Verbose "Get ServerEndpoint by ParentResourceId"
        $serverEndpoint = Get-AzStorageSyncServerEndpoint -ParentResourceId $syncGroup.ResourceId -Name $serverEndpointName -Verbose
        Write-Verbose "Validating ServerEndpoint Properties"
        Assert-AreEqual $serverEndpointName $serverEndpoint.ServerEndpointName
        Assert-AreEqual $serverLocalPath $serverEndpoint.ServerLocalPath
        Assert-AreEqual $volumeFreeSpacePercent $serverEndpoint.VolumeFreeSpacePercent
        Assert-AreEqual $initialUploadPolicy $serverEndpoint.InitialUploadPolicy

        Write-Verbose "Patch ServerEndpoint by Name"
        $job = Set-AzStorageSyncServerEndpoint -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -Name $serverEndpointName -VolumeFreeSpacePercent $volumeFreeSpacePercent2 -Verbose -AsJob
        $job | Wait-Job
        $serverEndpoint2 = get-job -Id $job.Id | receive-job -Keep
        Write-Verbose "Validating ServerEndpoint Properties"
        Assert-AreEqual $serverEndpointName $serverEndpoint2.ServerEndpointName
        Assert-AreEqual $serverLocalPath $serverEndpoint2.ServerLocalPath
        Assert-AreEqual $volumeFreeSpacePercent2 $serverEndpoint2.VolumeFreeSpacePercent

        Write-Verbose "Patch ServerEndpoint by InputObject"
        $job = Set-AzStorageSyncServerEndpoint -InputObject $serverEndpoint -VolumeFreeSpacePercent $volumeFreeSpacePercent2 -Verbose -AsJob
        $job | Wait-Job
        $serverEndpoint2 = get-job -Id $job.Id | receive-job -Keep
        Write-Verbose "Validating ServerEndpoint Properties"
        Assert-AreEqual $serverEndpointName $serverEndpoint2.ServerEndpointName
        Assert-AreEqual $serverLocalPath $serverEndpoint2.ServerLocalPath
        Assert-AreEqual $volumeFreeSpacePercent2 $serverEndpoint2.VolumeFreeSpacePercent

        Write-Verbose "Patch ServerEndpoint by ResourceId"
        $job = Set-AzStorageSyncServerEndpoint -ResourceId $serverEndpoint.ResourceId -VolumeFreeSpacePercent $volumeFreeSpacePercent2 -Verbose -AsJob
        $job | Wait-Job
        $serverEndpoint2 = get-job -Id $job.Id | receive-job -Keep
        Write-Verbose "Validating ServerEndpoint Properties"
        Assert-AreEqual $serverEndpointName $serverEndpoint2.ServerEndpointName
        Assert-AreEqual $serverLocalPath $serverEndpoint2.ServerLocalPath
        Assert-AreEqual $volumeFreeSpacePercent2 $serverEndpoint2.VolumeFreeSpacePercent

        Write-Verbose "Removing ServerEndpoint: $serverEndpointName"
        Remove-AzStorageSyncServerEndpoint -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -Name $serverEndpointName -AsJob | Wait-Job

        Write-Verbose "Executing Piping Scenarios"
        New-AzStorageSyncServerEndpoint -ParentObject $syncGroup -Name $serverEndpointName -ServerResourceId $registeredServer.ResourceId -ServerLocalPath $serverLocalPath -CloudTiering -VolumeFreeSpacePercent $volumeFreeSpacePercent -TierFilesOlderThanDays $tierFilesOlderThanDays | Get-AzStorageSyncServerEndpoint  | Remove-AzStorageSyncServerEndpoint -Force -AsJob | Wait-Job

        New-AzStorageSyncServerEndpoint -ParentResourceId $syncGroup.ResourceId -Name $serverEndpointName -ServerResourceId $registeredServer.ResourceId -ServerLocalPath $serverLocalPath -CloudTiering -VolumeFreeSpacePercent $volumeFreeSpacePercent -TierFilesOlderThanDays $tierFilesOlderThanDays | Remove-AzStorageSyncServerEndpoint -Force -AsJob | Wait-Job

        Write-Verbose "Unregister Server: $($registeredServer.ServerId)"
        Unregister-AzStorageSyncServer -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -ServerId $registeredServer.ServerId -AsJob | Wait-Job

        Write-Verbose "Removing CloudEndpoint: $cloudEndpointName"
        Remove-AzStorageSyncCloudEndpoint -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -Name $cloudEndpointName -AsJob | Wait-Job

        Write-Verbose "Removing SyncGroup: $syncGroupName"
        Remove-AzStorageSyncGroup -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -Name $syncGroupName -AsJob | Wait-Job

        Write-Verbose "Removing StorageSyncService: $storageSyncServiceName"
        Remove-AzStorageSyncService -Force -ResourceGroupName $resourceGroupName -Name $storageSyncServiceName -AsJob | Wait-Job

        if (IsLive) {
            Write-Verbose "Removing: $AzureFileShareName | Loc: $resourceLocation | Type : AzureStorageShare"
            Remove-StorageShare -Name $AzureFileShareName -Context $context | Out-Null
        }

        Write-Verbose "Removing $StorageAccountName | Loc: $resourceLocation | Type : StorageAccount"
        Remove-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $StorageAccountName
    }
    finally {
        # Cleanup
        Write-Verbose "Removing ResourceGroup : $resourceGroupName"
        Clean-ResourceGroup $resourceGroupName
    }
}

function Test-ServerEndpoint {
    # Setup
    $resourceGroupName = Get-ResourceGroupName
    Write-Verbose "RecordMode : $(Get-StorageTestMode)"
    try {
        # Test
        $storageSyncServiceName = Get-ResourceName("sss")
        $syncGroupName = Get-ResourceName("sg")
        $serverEndpointName = Get-ResourceName("sep")
        $cloudEndpointName = Get-ResourceName("cep")
        $resourceGroupLocation = Get-ResourceGroupLocation
        $resourceLocation = Get-StorageSyncLocation("Microsoft.StorageSync/storageSyncServices")

        $azureFileShareName = "testfs" #Get-ResourceName("fs")
        $storageAccountName = Get-ResourceName("sa")
        $storageAccountTenantId = Get-TenantId
        # NOTE: Check the local server drives where we are performing registration.
        $serverLocalPath = "D:\" + $serverEndpointName
        $tierFilesOlderThanDays = 10
        $volumeFreeSpacePercent = 60
        $volumeFreeSpacePercent2 = 80
        $initialUploadPolicy = "Merge"

        Write-Verbose "RGName: $resourceGroupName | Loc: $resourceGroupLocation | Type : ResourceGroup"
        New-AzResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation

        Write-Verbose "Resource: $storageSyncServiceName | Loc: $resourceLocation | Type : StorageSyncService"
        $storageSyncService = New-AzStorageSyncService -ResourceGroupName $resourceGroupName -Location $resourceLocation -StorageSyncServiceName $storageSyncServiceName

        Write-Verbose "Resource: $syncGroupName | Loc: $resourceLocation | Type : SyncGroup"
        $syncGroup = New-AzStorageSyncGroup -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -Name $syncGroupName

        Write-Verbose "Resource: $StorageAccountName | Loc: $resourceLocation | Type : StorageAccount"
        New-AzStorageAccount -StorageAccountName $StorageAccountName -Location $resourceLocation -ResourceGroupName $resourceGroupName -Type Standard_LRS
        $storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $StorageAccountName

        $key = Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $StorageAccountName
        $context = Create-StorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $key[0].Value
        Write-Verbose "Resource: $AzureFileShareName | Loc: $resourceLocation | Type : AzureStorageShare"

        $azureFileShareName = Create-StorageShare -Name $AzureFileShareName -Context $context
        $storageAccountResourceId = $storageAccount.Id

        Write-Verbose "Resource: $cloudEndpointName | Loc: $resourceLocation | Type : CloudEndpoint"
        $job = New-AzStorageSyncCloudEndpoint -ParentObject $syncGroup -Name $cloudEndpointName -StorageAccountResourceId $storageAccountResourceId -AzureFileShareName $azureFileShareName -StorageAccountTenantId $StorageAccountTenantId -AsJob
        $job | Wait-Job
        $cloudEndpoint = get-job -Id $job.Id | receive-job -Keep

        Write-Verbose "Resource: <auto-generated> | Loc: $resourceLocation | Type : RegisteredServer"
        $job = Register-AzStorageSyncServer -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -AsJob
        $job | Wait-Job
        $registeredServer = get-job -Id $job.Id | receive-job -Keep

        Write-Verbose "Resource: $serverEndpointName | Loc: $resourceLocation"
        $job = New-AzStorageSyncServerEndpoint -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -Name $serverEndpointName -ServerResourceId $registeredServer.ResourceId -ServerLocalPath $serverLocalPath -CloudTiering -VolumeFreeSpacePercent $volumeFreeSpacePercent -TierFilesOlderThanDays $tierFilesOlderThanDays -InitialUploadPolicy $initialUploadPolicy -Verbose -AsJob
        $job | Wait-Job
        $serverEndpoint = get-job -Id $job.Id | receive-job -Keep

        Write-Verbose "Removing ServerEndpoint: $serverEndpointName"
        Remove-AzStorageSyncServerEndpoint -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -Name $serverEndpointName -AsJob | Wait-Job

        Write-Verbose "Unregister Server: $($registeredServer.ServerId)"
        Unregister-AzStorageSyncServer -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -ServerId $registeredServer.ServerId -AsJob | Wait-Job

        Write-Verbose "Removing CloudEndpoint: $cloudEndpointName"
        Remove-AzStorageSyncCloudEndpoint -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -Name $cloudEndpointName -AsJob | Wait-Job

        Write-Verbose "Removing SyncGroup: $syncGroupName"
        Remove-AzStorageSyncGroup -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -Name $syncGroupName -AsJob | Wait-Job

        Write-Verbose "Removing StorageSyncService: $storageSyncServiceName"
        Remove-AzStorageSyncService -Force -ResourceGroupName $resourceGroupName -Name $storageSyncServiceName -AsJob | Wait-Job

        if (IsLive) {
            Write-Verbose "Removing: $AzureFileShareName | Loc: $resourceLocation | Type : AzureStorageShare"
            Remove-StorageShare -Name $AzureFileShareName -Context $context | Out-Null
        }

        Write-Verbose "Removing $StorageAccountName | Loc: $resourceLocation | Type : StorageAccount"
        Remove-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $StorageAccountName
    }
    finally {
        # Cleanup
        Write-Verbose "Removing ResourceGroup : $resourceGroupName"
        Clean-ResourceGroup $resourceGroupName
    }
}

function Test-ServerEndpointWithIdentityMigration {
    # Setup
    $resourceGroupName = Get-ResourceGroupName
    Write-Verbose "RecordMode : $(Get-StorageTestMode)"
    try {
        # Test
        $storageSyncServiceName = Get-ResourceName("sss")
        $syncGroupName = Get-ResourceName("sg")
        $serverEndpointName = Get-ResourceName("sep")
        $cloudEndpointName = Get-ResourceName("cep")
        $resourceGroupLocation = Get-ResourceGroupLocation
        $resourceLocation = Get-StorageSyncLocation("Microsoft.StorageSync/storageSyncServices")

        $azureFileShareName = "testfs" #Get-ResourceName("fs")
        $storageAccountName = Get-ResourceName("sa")
        $storageAccountTenantId = Get-TenantId
        # NOTE: Check the local server drives where we are performing registration.
        $serverLocalPath = "D:\" + $serverEndpointName
        $tierFilesOlderThanDays = 10
        $volumeFreeSpacePercent = 60
        $volumeFreeSpacePercent2 = 80
        $initialUploadPolicy = "Merge"

        Write-Verbose "RGName: $resourceGroupName | Loc: $resourceGroupLocation | Type : ResourceGroup"
        New-AzResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation

        Write-Verbose "Resource: $storageSyncServiceName | Loc: $resourceLocation | Type : StorageSyncService"
        $storageSyncService = New-AzStorageSyncService -ResourceGroupName $resourceGroupName -Location $resourceLocation -StorageSyncServiceName $storageSyncServiceName

        Write-Verbose "Resource: $syncGroupName | Loc: $resourceLocation | Type : SyncGroup"
        $syncGroup = New-AzStorageSyncGroup -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -Name $syncGroupName

        Write-Verbose "Resource: $StorageAccountName | Loc: $resourceLocation | Type : StorageAccount"
        New-AzStorageAccount -StorageAccountName $StorageAccountName -Location $resourceLocation -ResourceGroupName $resourceGroupName -Type Standard_LRS
        $storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $StorageAccountName

        $key = Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $StorageAccountName
        $context = Create-StorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $key[0].Value
        Write-Verbose "Resource: $AzureFileShareName | Loc: $resourceLocation | Type : AzureStorageShare"

        $azureFileShareName = Create-StorageShare -Name $AzureFileShareName -Context $context
        $storageAccountResourceId = $storageAccount.Id

        Write-Verbose "Resource: $cloudEndpointName | Loc: $resourceLocation | Type : CloudEndpoint"
        $job = New-AzStorageSyncCloudEndpoint -ParentObject $syncGroup -Name $cloudEndpointName -StorageAccountResourceId $storageAccountResourceId -AzureFileShareName $azureFileShareName -StorageAccountTenantId $StorageAccountTenantId -AsJob
        $job | Wait-Job
        $cloudEndpoint = get-job -Id $job.Id | receive-job -Keep

        Write-Verbose "Resource: <auto-generated> | Loc: $resourceLocation | Type : RegisteredServer"
        $job = Register-AzStorageSyncServer -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -AsJob
        $job | Wait-Job
        $registeredServer = get-job -Id $job.Id | receive-job -Keep

        Write-Verbose "Resource: $serverEndpointName | Loc: $resourceLocation"
        $job = New-AzStorageSyncServerEndpoint -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -Name $serverEndpointName -ServerResourceId $registeredServer.ResourceId -ServerLocalPath $serverLocalPath -CloudTiering -VolumeFreeSpacePercent $volumeFreeSpacePercent -TierFilesOlderThanDays $tierFilesOlderThanDays -InitialUploadPolicy $initialUploadPolicy -Verbose -AsJob
        $job | Wait-Job
        $serverEndpoint = get-job -Id $job.Id | receive-job -Keep

        Start-TestSleep -Seconds 60
        # Ensure that arc is installed onto the server /subscriptions/e29c162a-d1d4-4cc3-8295-80057c1f4bd9/resourceGroups/ankushbrg/providers/Microsoft.HybridCompute/machines/miMachine
        Write-Verbose "Migrating StorageSyncService : $storageSyncServiceName"
        Set-AzStorageSyncServiceIdentity -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -Verbose

        Write-Verbose "Removing ServerEndpoint: $serverEndpointName"
        Remove-AzStorageSyncServerEndpoint -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -Name $serverEndpointName -AsJob | Wait-Job

        Write-Verbose "Unregister Server: $($registeredServer.ServerId)"
        Unregister-AzStorageSyncServer -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -ServerId $registeredServer.ServerId -AsJob | Wait-Job

        Write-Verbose "Removing CloudEndpoint: $cloudEndpointName"
        Remove-AzStorageSyncCloudEndpoint -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -Name $cloudEndpointName -AsJob | Wait-Job

        Write-Verbose "Removing SyncGroup: $syncGroupName"
        Remove-AzStorageSyncGroup -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -Name $syncGroupName -AsJob | Wait-Job

        #Start-TestSleep -Seconds 300
        Write-Verbose "Removing StorageSyncService: $storageSyncServiceName"
        Remove-AzStorageSyncService -Force -ResourceGroupName $resourceGroupName -Name $storageSyncServiceName -AsJob | Wait-Job

        if (IsLive) {
            Write-Verbose "Removing: $AzureFileShareName | Loc: $resourceLocation | Type : AzureStorageShare"
            Remove-StorageShare -Name $AzureFileShareName -Context $context | Out-Null
        }

        Write-Verbose "Removing $StorageAccountName | Loc: $resourceLocation | Type : StorageAccount"
        Remove-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $StorageAccountName
    }
    finally {
        # Cleanup
        Write-Verbose "Removing ResourceGroup : $resourceGroupName"
        Clean-ResourceGroup $resourceGroupName
    }
}

function Test-ServerEndpointAfterIdentityMigration {
    # Setup
    $resourceGroupName = Get-ResourceGroupName
    Write-Verbose "RecordMode : $(Get-StorageTestMode)"
    try {
        # Test
        $storageSyncServiceName = Get-ResourceName("sss")
        $syncGroupName = Get-ResourceName("sg")
        $serverEndpointName = Get-ResourceName("sep")
        $cloudEndpointName = Get-ResourceName("cep")
        $resourceGroupLocation = Get-ResourceGroupLocation
        $resourceLocation = Get-StorageSyncLocation("Microsoft.StorageSync/storageSyncServices")

        $azureFileShareName = "testfs" #Get-ResourceName("fs")
        $storageAccountName = Get-ResourceName("sa")
        $storageAccountTenantId = Get-TenantId
        # NOTE: Check the local server drives where we are performing registration.
        $serverLocalPath = "D:\" + $serverEndpointName
        $tierFilesOlderThanDays = 10
        $volumeFreeSpacePercent = 60
        $volumeFreeSpacePercent2 = 80
        $initialUploadPolicy = "Merge"

        Write-Verbose "RGName: $resourceGroupName | Loc: $resourceGroupLocation | Type : ResourceGroup"
        New-AzResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation

        Write-Verbose "Resource: $storageSyncServiceName | Loc: $resourceLocation | Type : StorageSyncService"
        $storageSyncService = New-AzStorageSyncService -ResourceGroupName $resourceGroupName -Location $resourceLocation -StorageSyncServiceName $storageSyncServiceName

        Write-Verbose "Resource: $syncGroupName | Loc: $resourceLocation | Type : SyncGroup"
        $syncGroup = New-AzStorageSyncGroup -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -Name $syncGroupName

        Write-Verbose "Resource: $StorageAccountName | Loc: $resourceLocation | Type : StorageAccount"
        New-AzStorageAccount -StorageAccountName $StorageAccountName -Location $resourceLocation -ResourceGroupName $resourceGroupName -Type Standard_LRS
        $storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $StorageAccountName

        $key = Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $StorageAccountName
        $context = Create-StorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $key[0].Value
        Write-Verbose "Resource: $AzureFileShareName | Loc: $resourceLocation | Type : AzureStorageShare"

        $azureFileShareName = Create-StorageShare -Name $AzureFileShareName -Context $context
        $storageAccountResourceId = $storageAccount.Id

        Write-Verbose "Resource: <auto-generated> | Loc: $resourceLocation | Type : RegisteredServer"
        $job = Register-AzStorageSyncServer -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -AsJob
        $job | Wait-Job
        $registeredServer = get-job -Id $job.Id | receive-job -Keep

        # Waiting on 9530 event to show up
        Start-TestSleep -Seconds 60
        # Ensure that arc is installed onto the server /subscriptions/e29c162a-d1d4-4cc3-8295-80057c1f4bd9/resourceGroups/ankushbrg/providers/Microsoft.HybridCompute/machines/miMachine
        Write-Verbose "Migrating StorageSyncService : $storageSyncServiceName"
        Set-AzStorageSyncServiceIdentity -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -Verbose

        Write-Verbose "Resource: $cloudEndpointName | Loc: $resourceLocation | Type : CloudEndpoint"
        $job = New-AzStorageSyncCloudEndpoint -ParentObject $syncGroup -Name $cloudEndpointName -StorageAccountResourceId $storageAccountResourceId -AzureFileShareName $azureFileShareName -StorageAccountTenantId $StorageAccountTenantId -AsJob
        $job | Wait-Job
        $cloudEndpoint = get-job -Id $job.Id | receive-job -Keep
        $cloudEndpoint | Set-AzStorageSyncCloudEndpointPermission

        Write-Verbose "Resource: $serverEndpointName | Loc: $resourceLocation"
        $job = New-AzStorageSyncServerEndpoint -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -Name $serverEndpointName -ServerResourceId $registeredServer.ResourceId -ServerLocalPath $serverLocalPath -CloudTiering -VolumeFreeSpacePercent $volumeFreeSpacePercent -TierFilesOlderThanDays $tierFilesOlderThanDays -InitialUploadPolicy $initialUploadPolicy -Verbose -AsJob
        $job | Wait-Job
        $serverEndpoint = get-job -Id $job.Id | receive-job -Keep
        $serverEndpoint | Set-AzStorageSyncServerEndpointPermission

        Write-Verbose "Removing ServerEndpoint: $serverEndpointName"
        Remove-AzStorageSyncServerEndpoint -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -Name $serverEndpointName -AsJob | Wait-Job

        Write-Verbose "Unregister Server: $($registeredServer.ServerId)"
        Unregister-AzStorageSyncServer -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -ServerId $registeredServer.ServerId -AsJob | Wait-Job

        Write-Verbose "Removing CloudEndpoint: $cloudEndpointName"
        Remove-AzStorageSyncCloudEndpoint -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -SyncGroupName $syncGroupName -Name $cloudEndpointName -AsJob | Wait-Job

        Write-Verbose "Removing SyncGroup: $syncGroupName"
        Remove-AzStorageSyncGroup -Force -ResourceGroupName $resourceGroupName -StorageSyncServiceName $storageSyncServiceName -Name $syncGroupName -AsJob | Wait-Job

        #Start-TestSleep -Seconds 300
        Write-Verbose "Removing StorageSyncService: $storageSyncServiceName"
        Remove-AzStorageSyncService -Force -ResourceGroupName $resourceGroupName -Name $storageSyncServiceName -AsJob | Wait-Job

        if (IsLive) {
            Write-Verbose "Removing: $AzureFileShareName | Loc: $resourceLocation | Type : AzureStorageShare"
            Remove-StorageShare -Name $AzureFileShareName -Context $context | Out-Null
        }

        Write-Verbose "Removing $StorageAccountName | Loc: $resourceLocation | Type : StorageAccount"
        Remove-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $StorageAccountName
    }
    finally {
        # Cleanup
        Write-Verbose "Removing ResourceGroup : $resourceGroupName"
        Clean-ResourceGroup $resourceGroupName
    }
}
