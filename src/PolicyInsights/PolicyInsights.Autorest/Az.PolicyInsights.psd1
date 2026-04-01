@{
  GUID = '111a457d-aca0-41e4-95bb-b4e461b374b8'
  RootModule = './Az.PolicyInsights.psm1'
  ModuleVersion = '20.1.1'
  CompatiblePSEditions = 'Core', 'Desktop'
  Author = 'Microsoft Corporation'
  CompanyName = 'Microsoft Corporation'
  Copyright = 'Microsoft Corporation. All rights reserved.'
  Description = 'Microsoft Azure PowerShell: PolicyInsights cmdlets'
  PowerShellVersion = '5.1'
  DotNetFrameworkVersion = '4.7.2'
  RequiredAssemblies = './bin/Az.PolicyInsights.private.dll'
  FormatsToProcess = './Az.PolicyInsights.format.ps1xml'
  ScriptsToProcess = @('./custom/Helpers.ps1')
  FunctionsToExport = 'Get-AzPolicyAttestation', 'Get-AzPolicyEvent', 'Get-AzPolicyMetadata', 'Get-AzPolicyRemediation', 'Get-AzPolicyState', 'Get-AzPolicyStateSummary', 'New-AzPolicyAttestation', 'Remove-AzPolicyAttestation', 'Remove-AzPolicyRemediation', 'Start-AzPolicyComplianceScan', 'Start-AzPolicyRemediation', 'Stop-AzPolicyRemediation', 'Update-AzPolicyAttestation'
  AliasesToExport = 'Set-AzPolicyAttestation'
  PrivateData = @{
    PSData = @{
      Tags = 'Azure', 'ResourceManager', 'ARM', 'PSModule', 'PolicyInsights'
      LicenseUri = 'https://aka.ms/azps-license'
      ProjectUri = 'https://github.com/Azure/azure-powershell'
      ReleaseNotes = ''
    }
  }
}
