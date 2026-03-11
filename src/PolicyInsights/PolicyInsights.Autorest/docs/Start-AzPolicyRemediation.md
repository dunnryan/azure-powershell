---
external help file:
Module Name: Az.PolicyInsights
online version: https://learn.microsoft.com/powershell/module/az.policyinsights/start-azpolicyremediation
schema: 2.0.0
---

# Start-AzPolicyRemediation

## SYNOPSIS
Create a remediation at management group scope.

## SYNTAX

### CreateExpanded1 (Default)
```
Start-AzPolicyRemediation -Name <String> [-SubscriptionId <String>] [-FailureThresholdPercentage <Single>]
 [-FilterLocation <String[]>] [-FilterResourceId <String[]>] [-ParallelDeployment <Int32>]
 [-PolicyAssignmentId <String>] [-PolicyDefinitionReferenceId <String>] [-ResourceCount <Int32>]
 [-ResourceDiscoveryMode <String>] [-DefaultProfile <PSObject>] [-AsJob] [-NoWait] [<CommonParameters>]
```

### CreateExpanded
```
Start-AzPolicyRemediation -ManagementGroupId <String> -Name <String> [-FailureThresholdPercentage <Single>]
 [-FilterLocation <String[]>] [-FilterResourceId <String[]>] [-ParallelDeployment <Int32>]
 [-PolicyAssignmentId <String>] [-PolicyDefinitionReferenceId <String>] [-ResourceCount <Int32>]
 [-ResourceDiscoveryMode <String>] [-DefaultProfile <PSObject>] [-AsJob] [-NoWait] [<CommonParameters>]
```

### CreateExpanded2
```
Start-AzPolicyRemediation -Name <String> -ResourceGroupName <String> [-SubscriptionId <String>]
 [-FailureThresholdPercentage <Single>] [-FilterLocation <String[]>] [-FilterResourceId <String[]>]
 [-ParallelDeployment <Int32>] [-PolicyAssignmentId <String>] [-PolicyDefinitionReferenceId <String>]
 [-ResourceCount <Int32>] [-ResourceDiscoveryMode <String>] [-DefaultProfile <PSObject>] [-AsJob] [-NoWait]
 [<CommonParameters>]
```

### CreateExpanded3
```
Start-AzPolicyRemediation -Name <String> -ResourceId <String> [-FailureThresholdPercentage <Single>]
 [-FilterLocation <String[]>] [-FilterResourceId <String[]>] [-ParallelDeployment <Int32>]
 [-PolicyAssignmentId <String>] [-PolicyDefinitionReferenceId <String>] [-ResourceCount <Int32>]
 [-ResourceDiscoveryMode <String>] [-DefaultProfile <PSObject>] [-AsJob] [-NoWait] [<CommonParameters>]
```

### CreateExpandedScope
```
Start-AzPolicyRemediation -Name <String> -PolicyAssignmentId <String> -Scope <String>
 [-ManagementGroupId <String>] [-ResourceGroupName <String>] [-FailureThresholdPercentage <Single>]
 [-FilterLocation <String[]>] [-FilterResourceId <String[]>] [-ParallelDeployment <Int32>]
 [-PolicyDefinitionReferenceId <String>] [-ResourceCount <Int32>] [-ResourceDiscoveryMode <String>]
 [-DefaultProfile <PSObject>] [-AsJob] [-NoWait] [<CommonParameters>]
```

### CreateViaIdentityExpanded1
```
Start-AzPolicyRemediation -InputObject <IPolicyInsightsIdentity> [-FailureThresholdPercentage <Single>]
 [-FilterLocation <String[]>] [-FilterResourceId <String[]>] [-ParallelDeployment <Int32>]
 [-PolicyAssignmentId <String>] [-PolicyDefinitionReferenceId <String>] [-ResourceCount <Int32>]
 [-ResourceDiscoveryMode <String>] [-DefaultProfile <PSObject>] [-AsJob] [-NoWait] [<CommonParameters>]
```

### CreateViaIdentityExpanded2
```
Start-AzPolicyRemediation [-FailureThresholdPercentage <Single>] [-FilterLocation <String[]>]
 [-FilterResourceId <String[]>] [-ParallelDeployment <Int32>] [-PolicyAssignmentId <String>]
 [-PolicyDefinitionReferenceId <String>] [-ResourceCount <Int32>] [-ResourceDiscoveryMode <String>]
 [-DefaultProfile <PSObject>] [-AsJob] [-NoWait] [<CommonParameters>]
```

### CreateViaIdentityExpanded3
```
Start-AzPolicyRemediation [-FailureThresholdPercentage <Single>] [-FilterLocation <String[]>]
 [-FilterResourceId <String[]>] [-ParallelDeployment <Int32>] [-PolicyAssignmentId <String>]
 [-PolicyDefinitionReferenceId <String>] [-ResourceCount <Int32>] [-ResourceDiscoveryMode <String>]
 [-DefaultProfile <PSObject>] [-AsJob] [-NoWait] [<CommonParameters>]
```

### CreateViaIdentityManagementGroupExpanded
```
Start-AzPolicyRemediation -Name <String> [-FailureThresholdPercentage <Single>] [-FilterLocation <String[]>]
 [-FilterResourceId <String[]>] [-ParallelDeployment <Int32>] [-PolicyAssignmentId <String>]
 [-PolicyDefinitionReferenceId <String>] [-ResourceCount <Int32>] [-ResourceDiscoveryMode <String>]
 [-DefaultProfile <PSObject>] [-AsJob] [-NoWait] [<CommonParameters>]
```

## DESCRIPTION
Create a remediation at management group scope.

## EXAMPLES

### Example 1: {{ Add title here }}
```powershell
{{ Add code here }}
```

```output
{{ Add output here (remove the output block if the example doesn't have an output) }}
```

{{ Add description here }}

### Example 2: {{ Add title here }}
```powershell
{{ Add code here }}
```

```output
{{ Add output here (remove the output block if the example doesn't have an output) }}
```

{{ Add description here }}

## PARAMETERS

### -AsJob
Run cmdlet in the background.
Runs until terminal state of Remediation is reached.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultProfile
The DefaultProfile parameter is not functional.
Use the SubscriptionId parameter when available if executing the cmdlet against a different subscription.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases: AzureRMContext, AzureCredential

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FailureThresholdPercentage
A number between 0.0 to 1.0 representing the percentage failure threshold.
The remediation will fail if the percentage of failed remediation operations (i.e.
failed deployments) exceeds this threshold.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases: FailureThreshold

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FilterLocation
The resource locations that will be remediated.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: LocationFilter

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FilterResourceId
The IDs of the resources that will be remediated.
Can specify at most 100 IDs.
This filter cannot be used when ReEvaluateCompliance is set to ReEvaluateCompliance, and cannot be empty if provided.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InputObject
Identity Parameter

```yaml
Type: Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IPolicyInsightsIdentity
Parameter Sets: CreateViaIdentityExpanded1
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ManagementGroupId
Management group ID.

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateExpandedScope
Aliases: ManagementGroupName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
The name of the remediation.

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateExpanded1, CreateExpanded2, CreateExpanded3, CreateExpandedScope, CreateViaIdentityManagementGroupExpanded
Aliases: RemediationName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NoWait
Run the command asynchronously

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParallelDeployment
Determines how many resources to remediate at any given time.
Can be used to increase or reduce the pace of the remediation.
If not provided, the default parallel deployments value is used.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: ParallelDeploymentCount

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PolicyAssignmentId
The resource ID of the policy assignment that should be remediated.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PolicyDefinitionReferenceId
The policy definition reference ID of the individual definition that should be remediated.
Required when the policy assignment being remediated assigns a policy set definition.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ResourceCount
Determines the max number of resources that can be remediated by the remediation job.
If not provided, the default resource count is used.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ResourceDiscoveryMode
The way resources to remediate are discovered.
Defaults to ExistingNonCompliant if not specified.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ResourceGroupName
Resource group name.

```yaml
Type: System.String
Parameter Sets: CreateExpanded2, CreateExpandedScope
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ResourceId
Resource ID.

```yaml
Type: System.String
Parameter Sets: CreateExpanded3
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Scope
Scope of the resource.
E.g.
'/subscriptions/{subscriptionId}/resourceGroups/{rgName}'.

```yaml
Type: System.String
Parameter Sets: CreateExpandedScope
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SubscriptionId
The ID of the target subscription.

```yaml
Type: System.String
Parameter Sets: CreateExpanded1, CreateExpanded2
Aliases:

Required: False
Position: Named
Default value: (Get-AzContext).Subscription.Id
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IPolicyInsightsIdentity

### System.Int32

### System.Single

### System.String

### System.String[]

## OUTPUTS

### Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IRemediation

## NOTES

## RELATED LINKS

