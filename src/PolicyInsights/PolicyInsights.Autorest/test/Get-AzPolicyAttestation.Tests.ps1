if(($null -eq $TestName) -or ($TestName -contains 'Get-AzPolicyAttestation'))
{
  $loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
  if (-Not (Test-Path -Path $loadEnvPath)) {
      $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
  }
  . ($loadEnvPath)
  $TestRecordingFile = Join-Path $PSScriptRoot 'Get-AzPolicyAttestation.Recording.json'
  $currentPath = $PSScriptRoot
  while(-not $mockingPath) {
      $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
      $currentPath = Split-Path -Path $currentPath -Parent
  }
  . ($mockingPath | Select-Object -First 1).FullName
}

Describe 'Get-AzPolicyAttestation' {
    It 'ListBySubscriptionId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'ListByResourceGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'GetBySubscriptionId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'GetByResourceGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'GetByResourceId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'GetByScope' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'ScopeList' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'ListByResourceId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'GetViaIdentity' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }
}
