# ----------------------------------------------------------------------------------
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

# setup the Pester environment
. (Join-Path $PSScriptRoot 'Common.ps1') 'Remediation-CRUD'



# currently: running the below tests manually to get a feel for them! :)
# next: refactor according to current behavior

# add tests for:
# - remediation resource ID filter 

# looking through tests! will note anything that'll need to change
# honestly, I think it might be good to try running some of these manually tomorrow 
#   get a feel for how they operate under my changes 
# oof, gonna have to change a loooot of Deployment variable refs here 

# right now... I'm of the mind that I might revert some changes I've made if they give issues 
#     if it's little stuff, that's one thing, but my changes are already so breaking 

# okay, start with above idea tomorrow! ^^^ try running some manually! :)

Describe 'Remediation-CRUD' {

    BeforeAll {
        $managementGroupName = $env.managementGroup

        $remediationSubAssignmentId = $env.remediationSubPolicyAssignmentId
        $remediationMgAssignmentId = $env.remediationMgPolicyAssignmentId
        $remediationSubModifyAssignmentId = $env.remediationSubModifyPolicyAssignmentId

    }

    It 'SubscriptionScope-Crud' {
        $assignmentId = $remediationSubAssignmentId
        $remediationName = "Remediation-SubscriptionScope-Crud"

        # Create a new remediation
        $job = Start-AzPolicyRemediation -PolicyAssignmentId $assignmentId -Name $remediationName -LocationFilter "westus2", "northcentralus" -FailureThreshold 0.9 -ResourceCount 3 -ParallelDeploymentCount 20 -AsJob
        $job | Wait-Job
        Assert-AreEqual "Completed" $job.State
        $remediation = $job | Receive-Job

        Validate-Remediation $remediation
        Assert-AreEqual "ExistingNonCompliant" $remediation.ResourceDiscoveryMode
        Assert-AreEqual $remediationName $remediation.Name
        Assert-AreEqual "Succeeded" $remediation.ProvisioningState
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-AreEqual 2 $remediation.Filters.Locations.Count
        Assert-AreEqualArray $remediation.Filters.Locations @("westus2", "northcentralus")
        Assert-AreEqual 3 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 0 $remediation.DeploymentSummary.FailedDeployments
        Assert-AreEqual 0.9 $remediation.FailureThreshold
        Assert-AreEqual 3 $remediation.ResourceCount
        Assert-AreEqual 20 $remediation.ParallelDeployments

        # Get the deployments for the remediation
        $remediation = Get-AzPolicyRemediation -Name $remediationName -IncludeDetail
        Assert-AreEqual 3 $remediation.Deployments.Count
        $remediation.Deployments | ForEach-Object {
           Validate-RemediationDeployment $_
        }

        # Get the deployments for the remediation with a Top filter
        $remediation = Get-AzPolicyRemediation -Name $remediationName -IncludeDetail -Top 2
        Assert-AreEqual 2 $remediation.Deployments.Count

        # Get all remediations in the subscription
        $remediations = Get-AzPolicyRemediation
        Assert-True { $remediations.Count -gt 100 }
        Validate-Remediation $remediations[10]

        # Get a limited number of remediations
        $remediations = Get-AzPolicyRemediation -Top 5
        Assert-AreEqual 5 $remediations.Count
        Validate-Remediation $remediations[0]

        # Get a limited number of remediations
        $remediations = Get-AzPolicyRemediation -Top 101
        Assert-AreEqual 101 $remediations.Count

        # Get all remediations for a specific assignment
        $remediations = Get-AzPolicyRemediation -Filter "PolicyAssignmentId eq '$assignmentId'"
        Assert-True { $remediations.Count -gt 1 }
        $remediations | ForEach-Object {
           Validate-Remediation $_
           Assert-AreEqual $assignmentId $_.PolicyAssignmentId
        }

        # Delete the remediation that was created initially
        $result = ($remediation | Remove-AzPolicyRemediation -PassThru)
        Assert-AreEqual $true $result

        # Create a new remediation
        $remediation = Start-AzPolicyRemediation -PolicyAssignmentId $assignmentId -Name $remediationName -LocationFilter "westus2", "northcentralus" -FailureThreshold 0.9 -ResourceCount 3 -ParallelDeploymentCount 20
        Validate-Remediation $remediation
        Assert-AreEqual "ExistingNonCompliant" $remediation.ResourceDiscoveryMode
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-Null $remediation.PolicyDefinitionReferenceId
        Assert-AreEqual "Accepted" $remediation.ProvisioningState
        Assert-AreEqual 2 $remediation.Filters.Locations.Count
        Assert-AreEqualArray $remediation.Filters.Locations @("westus2", "northcentralus")
        Assert-AreEqual 0 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 0.9 $remediation.FailureThreshold
        Assert-AreEqual 3 $remediation.ResourceCount
        Assert-AreEqual 20 $remediation.ParallelDeployments

        # Cancel the remediation as a job so that we wait for cancellation to complete
        $job = ($remediation | Stop-AzPolicyRemediation -AsJob)
        $job | Wait-Job

        # Get the remediation that was just canceled
        $remediation = Get-AzPolicyRemediation -Name $remediationName
        Validate-Remediation $remediation
        Assert-AreEqual "ExistingNonCompliant" $remediation.ResourceDiscoveryMode
        Assert-AreEqual $remediationName $remediation.Name
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-AreEqual "Canceled" $remediation.ProvisioningState
        Assert-AreEqual 2 $remediation.Filters.Locations.Count
        Assert-AreEqualArray $remediation.Filters.Locations @("westus2", "northcentralus")
        Assert-AreEqual 0 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 0 $remediation.DeploymentSummary.FailedDeployments
        Assert-AreEqual 0.9 $remediation.FailureThreshold
        Assert-AreEqual 3 $remediation.ResourceCount
        Assert-AreEqual 20 $remediation.ParallelDeployments
    }

    It 'ResourceGroupScope-Crud' {
        $assignmentId = $remediationSubAssignmentId
        $remediationName = "Remediation-ResourceGroupScope-Crud"
        $resourceGroupName = $env.firstRgName

        # Create a new remediation
        $job = Start-AzPolicyRemediation -ResourceGroupName $resourceGroupName -PolicyAssignmentId $assignmentId -Name $remediationName -FailureThreshold 0.9 -ResourceCount 3 -ParallelDeploymentCount 20 -AsJob
        $job | Wait-Job
        Assert-AreEqual "Completed" $job.State
        $remediation = $job | Receive-Job

        Validate-Remediation $remediation
        Assert-AreEqual $remediationName $remediation.Name
        Assert-AreEqual $remediation.ProvisioningState "Succeeded"
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-Null $remediation.Filters
        Assert-AreEqual 3 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 0 $remediation.DeploymentSummary.FailedDeployments
        Assert-AreEqual 0.9 $remediation.FailureThreshold
        Assert-AreEqual 3 $remediation.ResourceCount
        Assert-AreEqual 20 $remediation.ParallelDeployments

        # Get the deployments for the remediation
        $remediation = Get-AzPolicyRemediation -ResourceGroupName $resourceGroupName -Name $remediationName -IncludeDetail
        Assert-AreEqual 3 $remediation.Deployments.Count
        $remediation.Deployments | ForEach-Object {
           Validate-RemediationDeployment $_
        }

        # Get the deployments for the remediation (+ top filter)
        $remediation = Get-AzPolicyRemediation -ResourceGroupName $resourceGroupName -Name $remediationName -IncludeDetail -Top 2
        Assert-AreEqual 2 $remediation.Deployments.Count
        $remediation.Deployments | ForEach-Object {
           Validate-RemediationDeployment $_
        }

        # Get all remediations in the resource group
        $remediations = Get-AzPolicyRemediation -ResourceGroupName $resourceGroupName
        Assert-True { $remediations.Count -gt 1 }
        Validate-Remediation $remediations[1]

        # Get a limited number of remediations
        $remediations = Get-AzPolicyRemediation -ResourceGroupName $resourceGroupName -Top 1
        Assert-AreEqual 1 $remediations.Count
        Validate-Remediation $remediations[0]

        # Get all remediations for a specific assignment
        $remediations = Get-AzPolicyRemediation -ResourceGroupName $resourceGroupName -Filter "PolicyAssignmentId eq '$assignmentId'"
        Assert-True { $remediations.Count -ge 1 }
        $remediations | ForEach-Object {
           Validate-Remediation $_
           Assert-AreEqual $assignmentId $_.PolicyAssignmentId
        }

        # Delete the remediation that was created initially
        $result = (Remove-AzPolicyRemediation -ResourceGroupName $resourceGroupName -Name $remediationName -PassThru)
        Assert-AreEqual $true $result

        # Create a new remediation
        $remediation = Start-AzPolicyRemediation -ResourceGroupName $resourceGroupName -PolicyAssignmentId $assignmentId -Name $remediationName -FailureThreshold 0.9 -ResourceCount 3 -ParallelDeploymentCount 20
        Validate-Remediation $remediation
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-Null $remediation.PolicyDefinitionReferenceId
        Assert-AreEqual "Accepted" $remediation.ProvisioningState
        Assert-Null $remediation.Filters
        Assert-AreEqual 0 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 0.9 $remediation.FailureThreshold
        Assert-AreEqual 3 $remediation.ResourceCount
        Assert-AreEqual 20 $remediation.ParallelDeployments

        # Cancel the remediation
        Stop-AzPolicyRemediation -ResourceId $remediation.Id

        # Get the remediation that was just canceled
        $remediation = Get-AzPolicyRemediation -ResourceGroupName $resourceGroupName -Name $remediationName
        Validate-Remediation $remediation
        Assert-AreEqual $remediationName $remediation.Name
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-AreEqual "Canceled" $remediation.ProvisioningState
        Assert-Null $remediation.Filters
        Assert-AreEqual 0 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 0 $remediation.DeploymentSummary.FailedDeployments
        Assert-AreEqual 0.9 $remediation.FailureThreshold
        Assert-AreEqual 3 $remediation.ResourceCount
        Assert-AreEqual 20 $remediation.ParallelDeployments
    }

    It 'ResourceScope-Crud' {
        $assignmentId = $remediationSubAssignmentId
        $remediationName = "Remediation-ResourceScope-Crud"
        $scope = $env.testResourceId

        # Create a new remediation
        $job = Start-AzPolicyRemediation -Scope $scope -PolicyAssignmentId $assignmentId -Name $remediationName -FailureThreshold 0.9 -ResourceCount 3 -ParallelDeploymentCount 20 -AsJob
        $job | Wait-Job
        Assert-AreEqual "Completed" $job.State
        $remediation = $job | Receive-Job

        Validate-Remediation $remediation
        Assert-AreEqual $remediationName $remediation.Name
        Assert-AreEqual $remediation.ProvisioningState "Succeeded"
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-Null $remediation.Filters
        Assert-AreEqual 1 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 0 $remediation.DeploymentSummary.FailedDeployments
        Assert-AreEqual 0.9 $remediation.FailureThreshold
        Assert-AreEqual 3 $remediation.ResourceCount
        Assert-AreEqual 20 $remediation.ParallelDeployments

        # Get the deployments for the remediation
        $remediation = Get-AzPolicyRemediation -Scope $scope -Name $remediationName -IncludeDetail
        Assert-AreEqual 1 $remediation.Deployments.Count
        $remediation.Deployments | ForEach-Object {
           Validate-RemediationDeployment $_
        }

        # Get the deployments for the remediation (+ top filter)
        $remediation = Get-AzPolicyRemediation -Scope $scope -Name $remediationName -IncludeDetail -Top 2
        Assert-AreEqual 1 $remediation.Deployments.Count
        $remediation.Deployments | ForEach-Object {
           Validate-RemediationDeployment $_
        }

        # Get all remediations underneath the resource
        $remediations = Get-AzPolicyRemediation -Scope $scope
        Assert-True { $remediations.Count -gt 0 }
        Validate-Remediation $remediations[0]

        # Get all remediations for a specific assignment
        $remediations = Get-AzPolicyRemediation -Scope $scope -Filter "PolicyAssignmentId eq '$assignmentId'"
        Assert-True { $remediations.Count -gt 0 }
        $remediations | ForEach-Object {
           Validate-Remediation $_
           Assert-AreEqual $assignmentId $_.PolicyAssignmentId
        }

        # Delete the remediation that was created initially
        $result = (Remove-AzPolicyRemediation -Scope $scope -Name $remediationName -PassThru)
        Assert-AreEqual $true $result

        # Create a new remediation
        $remediation = Start-AzPolicyRemediation -Scope $scope -PolicyAssignmentId $assignmentId -Name $remediationName -FailureThreshold 0.9 -ResourceCount 3 -ParallelDeploymentCount 20
        Validate-Remediation $remediation
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-Null $remediation.PolicyDefinitionReferenceId
        Assert-AreEqual "Accepted" $remediation.ProvisioningState
        Assert-Null $remediation.Filters
        Assert-AreEqual 0 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 0.9 $remediation.FailureThreshold
        Assert-AreEqual 3 $remediation.ResourceCount
        Assert-AreEqual 20 $remediation.ParallelDeployments

        # Cancel the remediation as a job so that we wait for cancellation to complete
        $job = Stop-AzPolicyRemediation -Scope $scope -Name $remediationName -AsJob
        $job | Wait-Job

        # Get the remediation that was just canceled
        $remediation = Get-AzPolicyRemediation -Scope $scope -Name $remediationName
        Validate-Remediation $remediation
        Assert-AreEqual $remediationName $remediation.Name
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-AreEqual "Canceled" $remediation.ProvisioningState
        Assert-Null $remediation.Filters
        Assert-AreEqual 0 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 0 $remediation.DeploymentSummary.FailedDeployments
        Assert-AreEqual 0.9 $remediation.FailureThreshold
        Assert-AreEqual 3 $remediation.ResourceCount
        Assert-AreEqual 20 $remediation.ParallelDeployments
    }

    It 'ManagementGroupScope-Crud' {
        $assignmentId = $remediationMgAssignmentId
        $remediationName = "Remediation-ManagementGroupScope-Crud"

        # Create a new remediation
        $job = Start-AzPolicyRemediation -ManagementGroupName $managementGroupName -PolicyAssignmentId $assignmentId -Name $remediationName -LocationFilter "westus2", "northcentralus"  -FailureThreshold 0.9 -ResourceCount 3 -ParallelDeploymentCount 20 -AsJob
        $job | Wait-Job
        Assert-AreEqual "Completed" $job.State
        $remediation = $job | Receive-Job

        Validate-Remediation $remediation
        Assert-AreEqual $remediationName $remediation.Name
        Assert-AreEqual "Succeeded" $remediation.ProvisioningState
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-AreEqualArray $remediation.Filters.Locations @("westus2", "northcentralus")
        Assert-AreEqual 3 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 0 $remediation.DeploymentSummary.FailedDeployments
        Assert-AreEqual 0.9 $remediation.FailureThreshold
        Assert-AreEqual 3 $remediation.ResourceCount
        Assert-AreEqual 20 $remediation.ParallelDeployments

        # Get the deployments for the remediation
        $remediation = Get-AzPolicyRemediation -ManagementGroupName $managementGroupName -Name $remediationName -IncludeDetail
        Assert-True { $remediation.Deployments.Count -gt 2 }
        $remediation.Deployments | ForEach-Object {
           Validate-RemediationDeployment $_
        }

        # Get the deployments for the remediation (+ top filter)
        $remediation = Get-AzPolicyRemediation -ManagementGroupName $managementGroupName -Name $remediationName -IncludeDetail -Top 1
        Assert-AreEqual 1 $remediation.Deployments.Count
        $remediation.Deployments | ForEach-Object {
           Validate-RemediationDeployment $_
        }

        # Get all remediations in the management group
        $remediations = Get-AzPolicyRemediation -ManagementGroupName $managementGroupName
        Assert-True { $remediations.Count -gt 0 }
        Validate-Remediation $remediations[0]

        # Get a limited number of remediations
        $remediations = Get-AzPolicyRemediation -Top 1
        Assert-AreEqual 1 $remediations.Count
        Validate-Remediation $remediations[0]
  
        # Get all remediations for a specific assignment
        $remediations = Get-AzPolicyRemediation -ManagementGroupName $managementGroupName -Filter "PolicyAssignmentId eq '$assignmentId'"
        Assert-True { $remediations.Count -gt 0 }
        $remediations | ForEach-Object {
           Validate-Remediation $_
           Assert-AreEqual $assignmentId $_.PolicyAssignmentId
        }

        # Delete the remediation that was created initially
        $result = (Remove-AzPolicyRemediation -ResourceId $remediation.Id -PassThru)
        Assert-AreEqual $true $result

        # Create a new remediation
        $remediation = Start-AzPolicyRemediation -ManagementGroupName $managementGroupName -PolicyAssignmentId $assignmentId -Name $remediationName -LocationFilter "westus2", "northcentralus"  -FailureThreshold 0.9 -ResourceCount 3 -ParallelDeploymentCount 20
        Validate-Remediation $remediation
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-Null $remediation.PolicyDefinitionReferenceId
        Assert-AreEqual "Accepted" $remediation.ProvisioningState
        Assert-AreEqualArray $remediation.Filters.Locations @("westus2", "northcentralus")
        Assert-AreEqual 0 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 0.9 $remediation.FailureThreshold
        Assert-AreEqual 3 $remediation.ResourceCount
        Assert-AreEqual 20 $remediation.ParallelDeployments

        # Cancel the remediation
        Stop-AzPolicyRemediation -ManagementGroupName $managementGroupName -Name $remediationName

        # Get the remediation that was just canceled
        $remediation = Get-AzPolicyRemediation -ManagementGroupName $managementGroupName -Name $remediationName
        Validate-Remediation $remediation
        Assert-AreEqual $remediationName $remediation.Name
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-AreEqual "Canceled" $remediation.ProvisioningState
        Assert-AreEqualArray $remediation.Filters.Locations @("westus2", "northcentralus")
        Assert-AreEqual 0 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 0 $remediation.DeploymentSummary.FailedDeployments
        Assert-AreEqual 0.9 $remediation.FailureThreshold
        Assert-AreEqual 3 $remediation.ResourceCount
        Assert-AreEqual 20 $remediation.ParallelDeployments
    }

    It 'BackgroundJobs' {
        $assignmentId = $remediationSubAssignmentId
        $remediationName = "Remediation-BackgroundJobs"

        # Create a new remediation as a job which will wait for it to complete
        $job = Start-AzPolicyRemediation -PolicyAssignmentId $assignmentId -Name $remediationName -LocationFilter "westus2" -ResourceCount 1 -AsJob
        $job | Wait-Job
        Assert-AreEqual "Completed" $job.State
        $remediation = $job | Receive-Job

        Validate-Remediation $remediation
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-Null $remediation.PolicyDefinitionReferenceId
        Assert-AreEqual "Succeeded" $remediation.ProvisioningState
        Assert-AreEqual 1 $remediation.Filters.Locations.Count
        Assert-AreEqualArray $remediation.Filters.Locations @("westus2")
        Assert-AreEqual 1 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 1 $remediation.DeploymentSummary.SuccessfulDeployments
        Assert-AreEqual 0 $remediation.DeploymentSummary.FailedDeployments

        # Create the remediation again so we can remove/stop it in a job
        $remediation = Start-AzPolicyRemediation -PolicyAssignmentId $assignmentId -Name $remediationName -LocationFilter "northcentralus"

        # Remove and stop the remediation in one action as a background job
        $job = ($remediation | Remove-AzPolicyRemediation -AllowStop -PassThru -AsJob)
        $job | Wait-Job
        Assert-AreEqual "Completed" $job.State
        $result = $job | Receive-Job
        Assert-AreEqual $true $result
    }

    It 'ReEvaluateCompliance' {
        $assignmentId = $remediationSubAssignmentId
        $remediationName = "Remediation-ReEvaluateCompliance"
        $resourceGroupName = $env.emptyRgName

        # Create a new remediation
        $remediation = Start-AzPolicyRemediation -ResourceGroupName $resourceGroupName -PolicyAssignmentId $assignmentId -Name $remediationName -ResourceDiscoveryMode ReEvaluateCompliance
        Validate-Remediation $remediation
        Assert-AreEqual "ReEvaluateCompliance" $remediation.ResourceDiscoveryMode
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-Null $remediation.PolicyDefinitionReferenceId
        Assert-AreEqual "Accepted" $remediation.ProvisioningState
        Assert-Null $remediation.Filters
        Assert-AreEqual 0 $remediation.DeploymentSummary.TotalDeployments

        # Cancel the remediation
        Stop-AzPolicyRemediation -ResourceId $remediation.Id

        # Get the remediation that was just cancelled
        $remediation = Get-AzPolicyRemediation -ResourceGroupName $resourceGroupName -Name $remediationName
        Validate-Remediation $remediation
        Assert-AreEqual "ReEvaluateCompliance" $remediation.ResourceDiscoveryMode
        Assert-AreEqual $remediationName $remediation.Name
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-AreEqual "Canceled" $remediation.ProvisioningState
        Assert-Null $remediation.Filters
        Assert-AreEqual 0 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 0 $remediation.DeploymentSummary.FailedDeployments

        # Delete the remediation that was created initially
        $result = (Remove-AzPolicyRemediation -ResourceGroupName $resourceGroupName -Name $remediationName -PassThru)
        Assert-AreEqual $true $result
    }

    It 'LargeRemediation' {
        $assignmentId = $remediationSubModifyAssignmentId
        $remediationName = "Remediation-LargeRemediation"

        $job = Start-AzPolicyRemediation -PolicyAssignmentId $assignmentId -Name $remediationName -ParallelDeploymentCount 30 -ResourceCount 1010 -AsJob
        $job | Wait-Job
        Assert-AreEqual "Completed" $job.State
        $remediation = $job | Receive-Job

        Validate-Remediation $remediation
        Assert-AreEqual $assignmentId $remediation.PolicyAssignmentId
        Assert-Null $remediation.PolicyDefinitionReferenceId
        Assert-AreEqual "Succeeded" $remediation.ProvisioningState
        Assert-AreEqual 1010 $remediation.DeploymentSummary.TotalDeployments
        Assert-AreEqual 1010 $remediation.DeploymentSummary.SuccessfulDeployments
        Assert-AreEqual 0 $remediation.DeploymentSummary.FailedDeployments
        Assert-AreEqual 30 $remediation.ParallelDeployments
        Assert-AreEqual 1010 $remediation.ResourceCount

        # Get the remediation, get different numbers of remediation deployments
        $remediation = Get-AzPolicyRemediation -Name $remediationName -IncludeDetail -Top 10
        Assert-AreEqual 10 $remediation.Deployments.Count

        $remediation = Get-AzPolicyRemediation -Name $remediationName -IncludeDetail -Top 1001
        Assert-AreEqual 1001 $remediation.Deployments.Count

        $remediation = Get-AzPolicyRemediation -Name $remediationName -IncludeDetail
        Assert-AreEqual 1010 $remediation.Deployments.Count
    }

    It 'ErrorHandling' {
        $assignmentId = $remediationMgAssignmentId
        $remediationName = "Remediation-ErrorHandling"

        # Attempt to request compliance re-evaluation at MG scope, should fail
        Assert-ThrowsContains `
        { Start-AzPolicyRemediation -ManagementGroupName $managementGroupName -PolicyAssignmentId $assignmentId -Name $remediationName -ResourceDiscoveryMode ReEvaluateCompliance } `
           "InvalidCreateRemediationRequest: The request to create remediation '$remediationName' is invalid. Evaluating compliance before remediation is only supported for remediations at subscription scope and below."
        }
    }