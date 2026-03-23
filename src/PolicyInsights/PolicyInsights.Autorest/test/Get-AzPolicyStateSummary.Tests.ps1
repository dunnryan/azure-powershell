if(($null -eq $TestName) -or ($TestName -contains 'Get-AzPolicyStateSummary'))
{
  $loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
  if (-Not (Test-Path -Path $loadEnvPath)) {
      $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
  }
  . ($loadEnvPath)
  $TestRecordingFile = Join-Path $PSScriptRoot 'Get-AzPolicyStateSummary.Recording.json'
  $currentPath = $PSScriptRoot
  while(-not $mockingPath) {
      $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
      $currentPath = Split-Path -Path $currentPath -Parent
  }
  . ($mockingPath | Select-Object -First 1).FullName
}

Describe 'Get-AzPolicyStateSummary' {
    It 'SummarizeBySubscriptionId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'SummarizeByResourceGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'SummarizeByPolicySetDefinition' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'SummarizeByPolicyDefinition' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'SummarizeByPolicyAssignment' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'SummarizeByPolicyAssignmentAndResourceGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'SummarizeByManagementGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'SummarizeByResourceId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }
}
