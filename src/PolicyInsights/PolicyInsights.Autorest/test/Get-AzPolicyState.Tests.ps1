if(($null -eq $TestName) -or ($TestName -contains 'Get-AzPolicyState'))
{
  $loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
  if (-Not (Test-Path -Path $loadEnvPath)) {
      $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
  }
  . ($loadEnvPath)
  $TestRecordingFile = Join-Path $PSScriptRoot 'Get-AzPolicyState.Recording.json'
  $currentPath = $PSScriptRoot
  while(-not $mockingPath) {
      $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
      $currentPath = Split-Path -Path $currentPath -Parent
  }
  . ($mockingPath | Select-Object -First 1).FullName
}

Describe 'Get-AzPolicyState' {
    It 'ListBySubscriptionId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'ListByResourceGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'ListByPolicySetDefinition' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'ListByPolicyDefinition' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'ListByPolicyAssignment' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'ListByPolicyAssignmentAndResourceGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'ListByManagementGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'ListByResourceId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }
}
