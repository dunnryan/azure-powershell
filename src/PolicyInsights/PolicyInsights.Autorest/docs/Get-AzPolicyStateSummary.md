---
external help file:
Module Name: Az.PolicyInsights
online version: https://learn.microsoft.com/powershell/module/az.policyinsights/get-azpolicystatesummary
schema: 2.0.0
---

# Get-AzPolicyStateSummary

## SYNOPSIS
Summarizes policy states for the resources under the management group.

## SYNTAX

### Summarize1 (Default)
```
Get-AzPolicyStateSummary [-SubscriptionId <String>] [-Filter <String>] [-From <DateTime>] [-To <DateTime>]
 [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### Summarize
```
Get-AzPolicyStateSummary -ManagementGroupName <String> [-Filter <String>] [-From <DateTime>] [-To <DateTime>]
 [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### Summarize2
```
Get-AzPolicyStateSummary -ResourceGroupName <String> [-SubscriptionId <String>] [-Filter <String>]
 [-From <DateTime>] [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### Summarize3
```
Get-AzPolicyStateSummary -ResourceId <String> [-Filter <String>] [-From <DateTime>] [-To <DateTime>]
 [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### Summarize4
```
Get-AzPolicyStateSummary -PolicySetDefinitionName <String> [-SubscriptionId <String>] [-Filter <String>]
 [-From <DateTime>] [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### Summarize5
```
Get-AzPolicyStateSummary -PolicyDefinitionName <String> [-SubscriptionId <String>] [-Filter <String>]
 [-From <DateTime>] [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### Summarize6
```
Get-AzPolicyStateSummary -PolicyAssignmentName <String> [-SubscriptionId <String>] [-Filter <String>]
 [-From <DateTime>] [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### Summarize7
```
Get-AzPolicyStateSummary -PolicyAssignmentName <String> -ResourceGroupName <String> [-SubscriptionId <String>]
 [-Filter <String>] [-From <DateTime>] [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm]
 [-WhatIf] [<CommonParameters>]
```

### SummarizeViaIdentity
```
Get-AzPolicyStateSummary -InputObject <IPolicyInsightsIdentity> [-Filter <String>] [-From <DateTime>]
 [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### SummarizeViaIdentity1
```
Get-AzPolicyStateSummary -InputObject <IPolicyInsightsIdentity> [-Filter <String>] [-From <DateTime>]
 [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### SummarizeViaIdentity2
```
Get-AzPolicyStateSummary -InputObject <IPolicyInsightsIdentity> [-Filter <String>] [-From <DateTime>]
 [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### SummarizeViaIdentity3
```
Get-AzPolicyStateSummary -InputObject <IPolicyInsightsIdentity> [-Filter <String>] [-From <DateTime>]
 [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### SummarizeViaIdentity4
```
Get-AzPolicyStateSummary -InputObject <IPolicyInsightsIdentity> [-Filter <String>] [-From <DateTime>]
 [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### SummarizeViaIdentity5
```
Get-AzPolicyStateSummary -InputObject <IPolicyInsightsIdentity> [-Filter <String>] [-From <DateTime>]
 [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### SummarizeViaIdentity6
```
Get-AzPolicyStateSummary -InputObject <IPolicyInsightsIdentity> [-Filter <String>] [-From <DateTime>]
 [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### SummarizeViaIdentitySubscription
```
Get-AzPolicyStateSummary -PolicySetDefinitionName <String> -SubscriptionInputObject <IPolicyInsightsIdentity>
 [-Filter <String>] [-From <DateTime>] [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm]
 [-WhatIf] [<CommonParameters>]
```

### SummarizeViaIdentitySubscription1
```
Get-AzPolicyStateSummary -PolicyDefinitionName <String> -Subscription1InputObject <IPolicyInsightsIdentity>
 [-Filter <String>] [-From <DateTime>] [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm]
 [-WhatIf] [<CommonParameters>]
```

### SummarizeViaIdentitySubscription2
```
Get-AzPolicyStateSummary -PolicyAssignmentName <String> -Subscription2InputObject <IPolicyInsightsIdentity>
 [-Filter <String>] [-From <DateTime>] [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm]
 [-WhatIf] [<CommonParameters>]
```

### SummarizeViaIdentitySubscription3
```
Get-AzPolicyStateSummary -PolicyAssignmentName <String> -Subscription3InputObject <IPolicyInsightsIdentity>
 [-Filter <String>] [-From <DateTime>] [-To <DateTime>] [-Top <Int32>] [-DefaultProfile <PSObject>] [-Confirm]
 [-WhatIf] [<CommonParameters>]
```

## DESCRIPTION
Summarizes policy states for the resources under the management group.

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

### -Filter
OData filter expression.

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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InputObject
Identity Parameter

```yaml
Type: Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IPolicyInsightsIdentity
Parameter Sets: SummarizeViaIdentity, SummarizeViaIdentity1, SummarizeViaIdentity2, SummarizeViaIdentity3, SummarizeViaIdentity4, SummarizeViaIdentity5, SummarizeViaIdentity6
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ManagementGroupName
Management group name.

```yaml
Type: System.String
Parameter Sets: Summarize
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PolicyAssignmentName
Policy assignment name.

```yaml
Type: System.String
Parameter Sets: Summarize6, Summarize7, SummarizeViaIdentitySubscription2, SummarizeViaIdentitySubscription3
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PolicyDefinitionName
Policy definition name.

```yaml
Type: System.String
Parameter Sets: Summarize5, SummarizeViaIdentitySubscription1
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PolicySetDefinitionName
Policy set definition name.

```yaml
Type: System.String
Parameter Sets: Summarize4, SummarizeViaIdentitySubscription
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ResourceGroupName
Resource group name.

```yaml
Type: System.String
Parameter Sets: Summarize2, Summarize7
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
Parameter Sets: Summarize3
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Subscription1InputObject
Identity Parameter

```yaml
Type: Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IPolicyInsightsIdentity
Parameter Sets: SummarizeViaIdentitySubscription1
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Subscription2InputObject
Identity Parameter

```yaml
Type: Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IPolicyInsightsIdentity
Parameter Sets: SummarizeViaIdentitySubscription2
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Subscription3InputObject
Identity Parameter

```yaml
Type: Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IPolicyInsightsIdentity
Parameter Sets: SummarizeViaIdentitySubscription3
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -SubscriptionId
Microsoft Azure subscription ID.

```yaml
Type: System.String
Parameter Sets: Summarize1, Summarize2, Summarize4, Summarize5, Summarize6, Summarize7
Aliases:

Required: False
Position: Named
Default value: (Get-AzContext).Subscription.Id
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SubscriptionInputObject
Identity Parameter

```yaml
Type: Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IPolicyInsightsIdentity
Parameter Sets: SummarizeViaIdentitySubscription
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
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
Accept pipeline input: True (ByPropertyName)
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

### Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IPolicyInsightsIdentity

### System.DateTime

### System.String

## OUTPUTS

### Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.ISummary

## NOTES

## RELATED LINKS

