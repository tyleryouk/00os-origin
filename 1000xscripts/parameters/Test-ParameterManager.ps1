[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$TestRegistry = "$PSScriptRoot\test-alias-registry.json"
)

# Create a test environment
function Setup-TestEnvironment {
    Write-Output "Setting up test environment..."
    
    # Create test registry
    $initialRegistry = @{
        schemaVersion = "1.0"
        lastUpdated = (Get-Date).ToString("o")
        aliases = @{}
    }
    
    $initialRegistry | ConvertTo-Json -Depth 10 | Set-Content -Path $TestRegistry
    
    # Create test directories
    $testDir = "$PSScriptRoot\..\..\1000xbrain\test"
    New-Item -Path "$testDir\parameters\rules\plan-mode" -ItemType Directory -Force | Out-Null
    New-Item -Path "$testDir\parameters\rules\dev-mode" -ItemType Directory -Force | Out-Null
    New-Item -Path "$testDir\parameters\front-end\plan-mode" -ItemType Directory -Force | Out-Null
    
    Write-Output "Test environment created."
}

# Clean up test environment
function Cleanup-TestEnvironment {
    Write-Output "Cleaning up test environment..."
    
    if (Test-Path $TestRegistry) {
        Remove-Item -Path $TestRegistry -Force
    }
    
    $testDir = "$PSScriptRoot\..\..\1000xbrain\test"
    if (Test-Path $testDir) {
        Remove-Item -Path $testDir -Recurse -Force
    }
    
    Write-Output "Test environment cleaned up."
}

# Test: Register-ParameterAlias
function Test-RegisterParameterAlias {
    Write-Output "Testing Register-ParameterAlias..."
    
    # Setup test
    $originalPath = "$PSScriptRoot\alias-registry.json"
    $backupPath = "$PSScriptRoot\alias-registry.json.bak"
    
    # Backup original registry if it exists
    if (Test-Path $originalPath) {
        Copy-Item -Path $originalPath -Destination $backupPath -Force
    }
    
    # Run test with test registry
    $testPath = "test/parameters/rules/plan-mode/test-parameter.md"
    $result = & "$PSScriptRoot\Register-ParameterAlias.ps1" `
              -Workflow "rules" `
              -Name "test-parameter" `
              -Path $testPath `
              -Description "Test parameter" `
              -Category "plan-mode" `
              -MessageCommand "plan-mode" `
              -StandardParameters @("workflow-type") `
              -RegistryPath $TestRegistry
    
    # Verify
    $registry = Get-Content -Path $TestRegistry -Raw | ConvertFrom-Json
    $success = $registry.aliases.rules.'test-parameter' -ne $null
    
    # Check if test file was created
    $fileCreated = Test-Path "$PSScriptRoot\..\..\1000xbrain\$testPath"
    
    # Report result
    if ($success -and $fileCreated) {
        Write-Output "✅ Register-ParameterAlias test passed."
    } else {
        Write-Output "❌ Register-ParameterAlias test failed."
        if (-not $success) {
            Write-Output "   Parameter not found in registry."
        }
        if (-not $fileCreated) {
            Write-Output "   Parameter file not created."
        }
    }
    
    # Restore original registry if it was backed up
    if (Test-Path $backupPath) {
        Copy-Item -Path $backupPath -Destination $originalPath -Force
        Remove-Item -Path $backupPath -Force
    }
    
    return $success -and $fileCreated
}

# Test: Remove-ParameterAlias
function Test-RemoveParameterAlias {
    Write-Output "Testing Remove-ParameterAlias..."
    
    # Setup test with a parameter
    $testPath = "test/parameters/rules/plan-mode/test-parameter.md"
    & "$PSScriptRoot\Register-ParameterAlias.ps1" `
      -Workflow "rules" `
      -Name "test-parameter" `
      -Path $testPath `
      -Description "Test parameter" `
      -Category "plan-mode" `
      -MessageCommand "plan-mode" `
      -StandardParameters @("workflow-type") `
      -RegistryPath $TestRegistry
    
    # Test removal
    $result = & "$PSScriptRoot\Remove-ParameterAlias.ps1" `
              -Workflow "rules" `
              -Name "test-parameter" `
              -RegistryPath $TestRegistry
    
    # Verify
    $registry = Get-Content -Path $TestRegistry -Raw | ConvertFrom-Json
    $success = (-not ($registry.aliases.rules.PSObject.Properties.Name -contains "test-parameter"))
    
    # Report result
    if ($success) {
        Write-Output "✅ Remove-ParameterAlias test passed."
    } else {
        Write-Output "❌ Remove-ParameterAlias test failed. Parameter still exists in registry."
    }
    
    return $success
}

# Test: Update-ParameterAlias
function Test-UpdateParameterAlias {
    Write-Output "Testing Update-ParameterAlias..."
    
    # Setup test with a parameter
    $testPath = "test/parameters/rules/plan-mode/test-parameter.md"
    & "$PSScriptRoot\Register-ParameterAlias.ps1" `
      -Workflow "rules" `
      -Name "test-parameter" `
      -Path $testPath `
      -Description "Test parameter" `
      -Category "plan-mode" `
      -MessageCommand "plan-mode" `
      -StandardParameters @("workflow-type") `
      -RegistryPath $TestRegistry
    
    # Test update
    $result = & "$PSScriptRoot\Update-ParameterAlias.ps1" `
              -Workflow "rules" `
              -Name "test-parameter" `
              -Description "Updated description" `
              -RegistryPath $TestRegistry
    
    # Verify
    $registry = Get-Content -Path $TestRegistry -Raw | ConvertFrom-Json
    $success = $registry.aliases.rules.'test-parameter'.description -eq "Updated description"
    
    # Report result
    if ($success) {
        Write-Output "✅ Update-ParameterAlias test passed."
    } else {
        Write-Output "❌ Update-ParameterAlias test failed. Description not updated."
    }
    
    return $success
}

# Test: Resolve-AliasReference
function Test-ResolveAliasReference {
    Write-Output "Testing Resolve-AliasReference..."
    
    # Setup test with a parameter
    $testPath = "test/parameters/rules/plan-mode/test-parameter.md"
    & "$PSScriptRoot\Register-ParameterAlias.ps1" `
      -Workflow "rules" `
      -Name "test-parameter" `
      -Path $testPath `
      -Description "Test parameter" `
      -Category "plan-mode" `
      -MessageCommand "plan-mode" `
      -StandardParameters @("workflow-type") `
      -RegistryPath $TestRegistry
    
    # Test resolution
    $result = & "$PSScriptRoot\Resolve-AliasReference.ps1" `
              -AliasReference "@alias:rules:test-parameter" `
              -RegistryPath $TestRegistry
    
    # Verify
    $success = $result -eq $testPath
    
    # Report result
    if ($success) {
        Write-Output "✅ Resolve-AliasReference test passed."
    } else {
        Write-Output "❌ Resolve-AliasReference test failed. Resolved to '$result' instead of '$testPath'."
    }
    
    return $success
}

# Test workflow isolation
function Test-WorkflowIsolation {
    Write-Output "Testing workflow isolation..."
    
    # Setup test with two parameters with the same name in different workflows
    $rulesPath = "test/parameters/rules/plan-mode/common-name.md"
    $frontEndPath = "test/parameters/front-end/plan-mode/common-name.md"
    
    & "$PSScriptRoot\Register-ParameterAlias.ps1" `
      -Workflow "rules" `
      -Name "common-name" `
      -Path $rulesPath `
      -Description "Rules parameter" `
      -Category "plan-mode" `
      -MessageCommand "plan-mode" `
      -StandardParameters @("workflow-type") `
      -RegistryPath $TestRegistry
    
    & "$PSScriptRoot\Register-ParameterAlias.ps1" `
      -Workflow "front-end" `
      -Name "common-name" `
      -Path $frontEndPath `
      -Description "Front-end parameter" `
      -Category "plan-mode" `
      -MessageCommand "plan-mode" `
      -StandardParameters @("workflow-type") `
      -RegistryPath $TestRegistry
    
    # Verify both parameters exist with proper isolation
    $registry = Get-Content -Path $TestRegistry -Raw | ConvertFrom-Json
    
    $rulesExists = $registry.aliases.rules.'common-name' -ne $null
    $frontEndExists = $registry.aliases.'front-end'.'common-name' -ne $null
    $differentPaths = $registry.aliases.rules.'common-name'.path -ne $registry.aliases.'front-end'.'common-name'.path
    
    # Test resolution of each alias
    $rulesResolved = & "$PSScriptRoot\Resolve-AliasReference.ps1" -AliasReference "@alias:rules:common-name" -RegistryPath $TestRegistry
    $frontEndResolved = & "$PSScriptRoot\Resolve-AliasReference.ps1" -AliasReference "@alias:front-end:common-name" -RegistryPath $TestRegistry
    
    $correctlyResolved = ($rulesResolved -eq $rulesPath) -and ($frontEndResolved -eq $frontEndPath)
    
    $success = $rulesExists -and $frontEndExists -and $differentPaths -and $correctlyResolved
    
    # Report result
    if ($success) {
        Write-Output "✅ Workflow isolation test passed."
    } else {
        Write-Output "❌ Workflow isolation test failed."
        
        if (-not $rulesExists) {
            Write-Output "   Rules parameter does not exist."
        }
        
        if (-not $frontEndExists) {
            Write-Output "   Front-end parameter does not exist."
        }
        
        if (-not $differentPaths) {
            Write-Output "   Parameters have the same path."
        }
        
        if (-not $correctlyResolved) {
            Write-Output "   Aliases not correctly resolved."
            Write-Output "   Rules resolved to: $rulesResolved"
            Write-Output "   Front-end resolved to: $frontEndResolved"
        }
    }
    
    return $success
}

# Run all tests
function Run-AllTests {
    Write-Output "`nRunning alias-based parameter management system tests..."
    
    # Setup test environment
    Setup-TestEnvironment
    
    # Run individual tests
    $registerTest = Test-RegisterParameterAlias
    $removeTest = Test-RemoveParameterAlias
    $updateTest = Test-UpdateParameterAlias
    $resolveTest = Test-ResolveAliasReference
    $isolationTest = Test-WorkflowIsolation
    
    # Calculate overall success
    $allTestsPassed = $registerTest -and $removeTest -and $updateTest -and $resolveTest -and $isolationTest
    
    # Display summary
    Write-Output "`nTest Results Summary:"
    Write-Output "====================="
    Write-Output "Register Parameter: $(if ($registerTest) { "✅ PASSED" } else { "❌ FAILED" })"
    Write-Output "Remove Parameter: $(if ($removeTest) { "✅ PASSED" } else { "❌ FAILED" })"
    Write-Output "Update Parameter: $(if ($updateTest) { "✅ PASSED" } else { "❌ FAILED" })"
    Write-Output "Resolve Alias Reference: $(if ($resolveTest) { "✅ PASSED" } else { "❌ FAILED" })"
    Write-Output "Workflow Isolation: $(if ($isolationTest) { "✅ PASSED" } else { "❌ FAILED" })"
    Write-Output "`nOverall Status: $(if ($allTestsPassed) { "✅ ALL TESTS PASSED" } else { "❌ SOME TESTS FAILED" })"
    
    # Cleanup test environment
    Cleanup-TestEnvironment
    
    return $allTestsPassed
}

# Always print output
$VerbosePreference = "Continue"
$DebugPreference = "Continue"

# Run all tests by default
Write-Output "Starting tests, output will be displayed..."
Run-AllTests 