if(($null -eq $TestName) -or ($TestName -contains 'New-AzPolicyAttestation'))
{
  $loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
  if (-Not (Test-Path -Path $loadEnvPath)) {
      $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
  }
  . ($loadEnvPath)
  $TestRecordingFile = Join-Path $PSScriptRoot 'New-AzPolicyAttestation.Recording.json'
  $currentPath = $PSScriptRoot
  while(-not $mockingPath) {
      $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
      $currentPath = Split-Path -Path $currentPath -Parent
  }
  . ($mockingPath | Select-Object -First 1).FullName
}

Describe 'New-AzPolicyAttestation' {
    It 'CreateBySubscriptionId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'CreateByResourceGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'CreateByResourceId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'CreateByScope' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'CreateViaIdentity' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }
}
