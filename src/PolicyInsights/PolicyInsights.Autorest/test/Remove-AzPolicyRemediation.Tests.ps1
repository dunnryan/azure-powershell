if(($null -eq $TestName) -or ($TestName -contains 'Remove-AzPolicyRemediation'))
{
  $loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
  if (-Not (Test-Path -Path $loadEnvPath)) {
      $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
  }
  . ($loadEnvPath)
  $TestRecordingFile = Join-Path $PSScriptRoot 'Remove-AzPolicyRemediation.Recording.json'
  $currentPath = $PSScriptRoot
  while(-not $mockingPath) {
      $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
      $currentPath = Split-Path -Path $currentPath -Parent
  }
  . ($mockingPath | Select-Object -First 1).FullName
}

Describe 'Remove-AzPolicyRemediation' {
    It 'DeleteBySubscriptionId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'DeleteByResourceGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'DeleteByResourceId' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'DeleteByScope' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'DeleteByManagementGroup' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }

    It 'DeleteViaIdentity' -skip {
        { throw [System.NotImplementedException] } | Should -Not -Throw
    }
}
