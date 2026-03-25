---
external help file:
Module Name: Az.PolicyInsights
online version: https://learn.microsoft.com/powershell/module/az.policyinsights/get-azpolicystate
schema: 2.0.0
---

# Get-AzPolicyState

## SYNOPSIS
Gets policy compliance states for resources.

## SYNTAX

### ListBySubscriptionId (Default)
```
Get-AzPolicyState [-All] [-SubscriptionId <String[]>] [-Apply <String>] [-Filter <String>] [-From <DateTime>]
 [-OrderBy <String>] [-Select <String>] [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>]
 [-Confirm] [-WhatIf] [<CommonParameters>]
```

### ListByManagementGroup
```
Get-AzPolicyState -ManagementGroupName <String> [-All] [-Apply <String>] [-Filter <String>] [-From <DateTime>]
 [-OrderBy <String>] [-Select <String>] [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>]
 [-Confirm] [-WhatIf] [<CommonParameters>]
```

### ListByPolicyAssignment
```
Get-AzPolicyState -PolicyAssignmentName <String> [-All] [-SubscriptionId <String[]>] [-Apply <String>]
 [-Filter <String>] [-From <DateTime>] [-OrderBy <String>] [-Select <String>] [-To <DateTime>] [-Top <Int32>]
 [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### ListByPolicyAssignmentAndResourceGroup
```
Get-AzPolicyState -PolicyAssignmentName <String> -ResourceGroupName <String> [-All]
 [-SubscriptionId <String[]>] [-Apply <String>] [-Filter <String>] [-From <DateTime>] [-OrderBy <String>]
 [-Select <String>] [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### ListByPolicyDefinition
```
Get-AzPolicyState -PolicyDefinitionName <String> [-All] [-SubscriptionId <String[]>] [-Apply <String>]
 [-Filter <String>] [-From <DateTime>] [-OrderBy <String>] [-Select <String>] [-To <DateTime>] [-Top <Int32>]
 [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### ListByPolicySetDefinition
```
Get-AzPolicyState -PolicySetDefinitionName <String> [-All] [-SubscriptionId <String[]>] [-Apply <String>]
 [-Filter <String>] [-From <DateTime>] [-OrderBy <String>] [-Select <String>] [-To <DateTime>] [-Top <Int32>]
 [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### ListByResourceGroup
```
Get-AzPolicyState -ResourceGroupName <String> [-All] [-SubscriptionId <String[]>] [-Apply <String>]
 [-Filter <String>] [-From <DateTime>] [-OrderBy <String>] [-Select <String>] [-To <DateTime>] [-Top <Int32>]
 [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### ListByResourceId
```
Get-AzPolicyState -ResourceId <String> [-All] [-Apply <String>] [-Expand <String>] [-Filter <String>]
 [-From <DateTime>] [-OrderBy <String>] [-Select <String>] [-To <DateTime>] [-Top <Int32>]
 [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

## DESCRIPTION
The **Get-AzPolicyState** cmdlet gets policy compliance states for resources.

Policy state records can be queried at various scopes and time intervals specified, with a default to the last day.

Either latest policy states or all policy state transitions can be queried, with a default to only return the latest states for resources.

Results can be filtered, grouped, and group aggregations can be computed.

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

### -All
Within the specified time interval, get all policy states for the resources in scope instead of the latest only for those resources.

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

### -Apply
Apply expression for aggregations using OData notation.

```yaml
Type: System.String
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

### -Expand
Expand expression using OData notation.
For example, to expand components use $expand=components

```yaml
Type: System.String
Parameter Sets: ListByResourceId
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
Filter expression using OData notation.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -From
ISO 8601 formatted timestamp specifying the start time of the interval to query.
When not specified, the service uses ($to - 1-day).

```yaml
Type: System.DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ManagementGroupName
Management group name.

```yaml
Type: System.String
Parameter Sets: ListByManagementGroup
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OrderBy
Ordering expression using OData notation.
One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g.
"$orderby=PolicyAssignmentId, ResourceId asc".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PolicyAssignmentName
The name of a policy assignment.
This policy assignment must have exactly the same scope as the parameter set.
It cannot be a management group scope policy assignment.
For example: if `-SubscriptionId` and `-ResourceGroupName` are specified, the policy assignment must be assigned to that resource group.
If only `-SubscriptionId` is specified, then the policy assignment must be assigned to that subscription.

```yaml
Type: System.String
Parameter Sets: ListByPolicyAssignment, ListByPolicyAssignmentAndResourceGroup
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PolicyDefinitionName
The name of a policy definition.
This policy definition must exist in the subscription being queried.
It cannot be a management group scope policy definition.

```yaml
Type: System.String
Parameter Sets: ListByPolicyDefinition
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PolicySetDefinitionName
The name of a policy set definition.
This policy set definition must exist in the subscription being queried.
It cannot be a management group scope policy set definition.

```yaml
Type: System.String
Parameter Sets: ListByPolicySetDefinition
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
Resource group name.

```yaml
Type: System.String
Parameter Sets: ListByPolicyAssignmentAndResourceGroup, ListByResourceGroup
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
Resource ID.

```yaml
Type: System.String
Parameter Sets: ListByResourceId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Select
Select expression using OData notation.
Limits the columns on each record to just those requested, e.g.
"$select=PolicyAssignmentId, ResourceId".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubscriptionId
The ID of the target subscription.
Uses current subscription if one isn't provided.

```yaml
Type: System.String[]
Parameter Sets: ListByPolicyAssignment, ListByPolicyAssignmentAndResourceGroup, ListByPolicyDefinition, ListByPolicySetDefinition, ListByResourceGroup, ListBySubscriptionId
Aliases:

Required: False
Position: Named
Default value: (Get-AzContext).Subscription.Id
Accept pipeline input: False
Accept wildcard characters: False
```

### -To
ISO 8601 formatted timestamp specifying the end time of the interval to query.
When not specified, the service uses request time.

```yaml
Type: System.DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top
Maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IPolicyState

## NOTES

## RELATED LINKS

