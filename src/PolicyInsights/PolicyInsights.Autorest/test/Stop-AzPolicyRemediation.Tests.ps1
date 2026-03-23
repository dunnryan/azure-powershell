if(($null -eq $TestName) -or ($TestName -contains 'Stop-AzPolicyRemediation'))
{
  $loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
  if (-Not (Test-Path -Path $loadEnvPath)) {
      $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
  }
  . ($loadEnvPath)
  $TestRecordingFile = Join-Path $PSScriptRoot 'Stop-AzPolicyRemediation.Recording.json'
  $currentPath = $PSScriptRoot
  while(-not $mockingPath) {
      $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
      $currentPath = Split-Path -Path $currentPath -Parent
  }
  . ($mockingPath | Select-Object -First 1).FullName
}

Describe 'Stop-AzPolicyRemediation' {
    It 'CancelBySubscriptionId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'CancelByResourceGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'CancelByResourceId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'CancelByScope' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'CancelByManagementGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'CancelViaIdentity' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }
}
