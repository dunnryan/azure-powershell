---
external help file:
Module Name: Az.PolicyInsights
online version: https://learn.microsoft.com/powershell/module/az.policyinsights/get-azpolicyattestation
schema: 2.0.0
---

# Get-AzPolicyAttestation

## SYNOPSIS
Gets policy attestations.

## SYNTAX

### ListBySubscriptionId (Default)
```
Get-AzPolicyAttestation [-SubscriptionId <String[]>] [-Filter <String>] [-Top <Int32>]
 [-DefaultProfile <PSObject>] [<CommonParameters>]
```

### GetByResourceGroup
```
Get-AzPolicyAttestation -Name <String> -ResourceGroupName <String> [-SubscriptionId <String[]>]
 [-DefaultProfile <PSObject>] [<CommonParameters>]
```

### GetByResourceId
```
Get-AzPolicyAttestation -ResourceId <String> [-Name <String>] [-DefaultProfile <PSObject>]
 [<CommonParameters>]
```

### GetByScope
```
Get-AzPolicyAttestation -Name <String> -Scope <String> [-DefaultProfile <PSObject>] [<CommonParameters>]
```

### GetBySubscriptionId
```
Get-AzPolicyAttestation -Name <String> [-SubscriptionId <String[]>] [-DefaultProfile <PSObject>]
 [<CommonParameters>]
```

### GetViaIdentity
```
Get-AzPolicyAttestation -InputObject <IPolicyInsightsIdentity> [-DefaultProfile <PSObject>]
 [<CommonParameters>]
```

### ListByResourceGroup
```
Get-AzPolicyAttestation -ResourceGroupName <String> [-SubscriptionId <String[]>] [-Filter <String>]
 [-Top <Int32>] [-DefaultProfile <PSObject>] [<CommonParameters>]
```

### ListByResourceId
```
Get-AzPolicyAttestation -ResourceId <String> [-Filter <String>] [-Top <Int32>] [-DefaultProfile <PSObject>]
 [<CommonParameters>]
```

### ScopeList
```
Get-AzPolicyAttestation -Scope <String> [-Filter <String>] [-Top <Int32>] [-DefaultProfile <PSObject>]
 [<CommonParameters>]
```

## DESCRIPTION
The **Get-AzPolicyAttestation** cmdlet gets all policy attestations in a scope or a particular attestation.

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
Filter expression using OData notation.

```yaml
Type: System.String
Parameter Sets: ListByResourceGroup, ListByResourceId, ListBySubscriptionId, ScopeList
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Identity Parameter

```yaml
Type: Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IPolicyInsightsIdentity
Parameter Sets: GetViaIdentity
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
The name of the attestation.

```yaml
Type: System.String
Parameter Sets: GetByResourceGroup, GetByResourceId, GetByScope, GetBySubscriptionId
Aliases: AttestationName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
The name of the resource group.
The name is case insensitive.

```yaml
Type: System.String
Parameter Sets: GetByResourceGroup, ListByResourceGroup
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId
ID of the resource that an attestation or attestations were made against.

```yaml
Type: System.String
Parameter Sets: GetByResourceId, ListByResourceId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope
Scope of the resource.
E.g.
'subscriptions/\{subscriptionId}/resourceGroups/\{rgName}'.

```yaml
Type: System.String
Parameter Sets: GetByScope, ScopeList
Aliases:

Required: True
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
Parameter Sets: GetByResourceGroup, GetBySubscriptionId, ListByResourceGroup, ListBySubscriptionId
Aliases:

Required: False
Position: Named
Default value: (Get-AzContext).Subscription.Id
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top
Maximum number of records to return.
If not provided, the maximum number of records returned is determined by the Azure Policy service (currently 1000).

```yaml
Type: System.Int32
Parameter Sets: ListByResourceGroup, ListByResourceId, ListBySubscriptionId, ScopeList
Aliases:

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

## OUTPUTS

### Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IAttestation

## NOTES

## RELATED LINKS

