---
external help file:
Module Name: Az.PolicyInsights
online version: https://learn.microsoft.com/powershell/module/az.policyinsights/new-azpolicyattestation
schema: 2.0.0
---

# New-AzPolicyAttestation

## SYNOPSIS
Create an attestation at subscription scope.

## SYNTAX

### CreateExpanded (Default)
```
New-AzPolicyAttestation -Name <String> -PolicyAssignmentId <String> [-SubscriptionId <String>]
 [-AssessmentDate <DateTime>] [-Comment <String>] [-ComplianceState <String>]
 [-Evidence <IAttestationEvidence[]>] [-ExpiresOn <DateTime>] [-Metadata <String>] [-Owner <String>]
 [-PolicyDefinitionReferenceId <String>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### CreateExpanded1
```
New-AzPolicyAttestation -Name <String> -ResourceGroupName <String> -PolicyAssignmentId <String>
 [-SubscriptionId <String>] [-AssessmentDate <DateTime>] [-Comment <String>] [-ComplianceState <String>]
 [-Evidence <IAttestationEvidence[]>] [-ExpiresOn <DateTime>] [-Metadata <String>] [-Owner <String>]
 [-PolicyDefinitionReferenceId <String>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### CreateExpanded2
```
New-AzPolicyAttestation -Name <String> -ResourceId <String> -PolicyAssignmentId <String>
 [-AssessmentDate <DateTime>] [-Comment <String>] [-ComplianceState <String>]
 [-Evidence <IAttestationEvidence[]>] [-ExpiresOn <DateTime>] [-Metadata <String>] [-Owner <String>]
 [-PolicyDefinitionReferenceId <String>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### CreateScope
```
New-AzPolicyAttestation -Name <String> -Scope <String> -PolicyAssignmentId <String>
 [-AssessmentDate <DateTime>] [-Comment <String>] [-ComplianceState <String>]
 [-Evidence <IAttestationEvidence[]>] [-ExpiresOn <DateTime>] [-Metadata <String>] [-Owner <String>]
 [-PolicyDefinitionReferenceId <String>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### CreateViaIdentityExpanded1
```
New-AzPolicyAttestation -InputObject <IPolicyInsightsIdentity> -PolicyAssignmentId <String>
 [-AssessmentDate <DateTime>] [-Comment <String>] [-ComplianceState <String>]
 [-Evidence <IAttestationEvidence[]>] [-ExpiresOn <DateTime>] [-Metadata <String>] [-Owner <String>]
 [-PolicyDefinitionReferenceId <String>] [-DefaultProfile <PSObject>] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

## DESCRIPTION
Create an attestation at subscription scope.

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

### -AssessmentDate
The time the evidence was assessed

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

### -Comment
Comments describing why this attestation was created.

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

### -ComplianceState
The compliance state that should be set on the resource.

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

### -Evidence
The evidence supporting the compliance state set in this attestation.

```yaml
Type: Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IAttestationEvidence[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpiresOn
The time the compliance state should expire.

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

### -Metadata
Additional metadata for this attestation

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

### -Name
The name of the attestation.

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateExpanded1, CreateExpanded2, CreateScope
Aliases: AttestationName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Owner
The person responsible for setting the state of the resource.
This value is typically an Azure Active Directory object ID.

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

### -PolicyAssignmentId
The resource ID of the policy assignment that the attestation is setting the state for.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PolicyDefinitionReferenceId
The policy definition reference ID from a policy set definition that the attestation is setting the state for.
If the policy assignment assigns a policy set definition the attestation can choose a definition within the set definition with this property or omit this and set the state for the entire set definition.

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

### -ResourceGroupName
The name of the resource group.
The name is case insensitive.

```yaml
Type: System.String
Parameter Sets: CreateExpanded1
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
Parameter Sets: CreateExpanded2
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope
Scope of the resource.
E.g.
'/subscriptions/{subscriptionId}/resourceGroups/{rgName}'.

```yaml
Type: System.String
Parameter Sets: CreateScope
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubscriptionId
The ID of the target subscription.

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateExpanded1
Aliases:

Required: False
Position: Named
Default value: (Get-AzContext).Subscription.Id
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

## OUTPUTS

### Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IAttestation

## NOTES

## RELATED LINKS

