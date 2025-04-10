# Test Cheatsheet: Scripts Workflow Enhancement

## Documentation Tests

### README Verification
```powershell
# Check README existence
Test-Path 1000xscripts/README.md
Test-Path 1000xscripts/rules-scripts/README.md
Test-Path 1000xscripts/utility-scripts/README.md
Test-Path 1000xscripts/maintenance-scripts/README.md
Test-Path 1000xscripts/sync-reports/README.md

# Verify README content
Get-Content 1000xscripts/README.md | Select-String "Usage Examples"
Get-Content 1000xscripts/README.md | Select-String "Troubleshooting"
```

### Script Documentation
```powershell
# Check script headers
Get-ChildItem -Path 1000xscripts -Filter *.ps1 -Recurse | 
    ForEach-Object { Get-Content $_.FullName -First 20 | Select-String "<#" }

# Verify parameter documentation
Get-ChildItem -Path 1000xscripts -Filter *.ps1 -Recurse |
    ForEach-Object { Get-Content $_.FullName | Select-String ".PARAMETER" }
```

## Organization Tests

### Directory Structure
```powershell
# Verify directory structure
Test-Path 1000xscripts/rules-scripts
Test-Path 1000xscripts/utility-scripts
Test-Path 1000xscripts/maintenance-scripts
Test-Path 1000xscripts/sync-reports
Test-Path 1000xscripts/tests

# Check script locations
Get-ChildItem -Path 1000xscripts -Filter *.ps1 -Recurse |
    Select-Object Directory, Name
```

### Naming Convention
```powershell
# Verify script naming
Get-ChildItem -Path 1000xscripts -Filter *.ps1 -Recurse |
    Where-Object { $_.Name -notmatch '^[A-Z][a-z]+(-[A-Z][a-z]+)*\.ps1$' }

# Check test file naming
Get-ChildItem -Path 1000xscripts -Filter *.Tests.ps1 -Recurse |
    Where-Object { $_.Name -notmatch '\.Tests\.ps1$' }
```

## Testing Framework

### Pester Tests
```powershell
# Run all tests
Invoke-Pester -Path 1000xscripts/tests
Invoke-Pester -Path 1000xscripts/rules-scripts/tests
Invoke-Pester -Path 1000xscripts/utility-scripts/tests
Invoke-Pester -Path 1000xscripts/maintenance-scripts/tests

# Check test coverage
Invoke-Pester -Path 1000xscripts/tests -CodeCoverage
```

### Test Structure
```powershell
# Verify test file existence
Get-ChildItem -Path 1000xscripts -Filter *.ps1 -Recurse |
    ForEach-Object {
        $testPath = $_.FullName -replace '\.ps1$', '.Tests.ps1'
        Test-Path $testPath
    }
```

## Synchronization Tests

### Frontmatter Tests
```powershell
# Test frontmatter preservation
$source = "1000xbrain/test-file.md"
$target = ".cursor/rules/test-file.mdc"
.\1000xscripts\Sync-CursorRules.ps1 -Source $source -Target $target
Compare-Object (Get-Content $source) (Get-Content $target)
```

### Error Handling
```powershell
# Test invalid file handling
.\1000xscripts\Sync-CursorRules.ps1 -Source "nonexistent.md"

# Test invalid frontmatter
.\1000xscripts\Sync-CursorRules.ps1 -Source "invalid-frontmatter.md"
```

## Parameter System Tests

### Validation Tests
```powershell
# Test parameter validation
.\1000xscripts\rules-scripts\Test-Parameter.ps1 -InvalidParameter
.\1000xscripts\rules-scripts\Test-Parameter.ps1 -EmptyParameter ""
```

### Integration Tests
```powershell
# Test message-command integration
.\1000xscripts\rules-scripts\Test-MessageCommand.ps1 -Command "plan-mode: rules-workflow"
.\1000xscripts\rules-scripts\Test-MessageCommand.ps1 -Command "invalid-command"
```

## Common Test Scenarios

### Documentation Scenarios
1. Check all README files exist and contain required sections
2. Verify script headers contain documentation
3. Validate parameter documentation completeness
4. Check for usage examples in documentation

### Organization Scenarios
1. Verify scripts are in correct directories
2. Check naming convention compliance
3. Validate dependency documentation
4. Test directory structure integrity

### Testing Scenarios
1. Run all unit tests
2. Execute integration tests
3. Check test coverage
4. Verify error handling tests

### Synchronization Scenarios
1. Test frontmatter preservation
2. Verify file type handling
3. Check error recovery
4. Validate sync process

### Parameter Scenarios
1. Test parameter validation
2. Check message-command integration
3. Verify error handling
4. Validate documentation accuracy

## Test Recovery Procedures

### Documentation Recovery
1. Regenerate missing README files
2. Update incomplete documentation
3. Add missing usage examples
4. Create troubleshooting guides

### Organization Recovery
1. Move misplaced scripts
2. Fix naming convention violations
3. Update dependency documentation
4. Restore directory structure

### Testing Recovery
1. Fix failing tests
2. Update test coverage
3. Correct validation errors
4. Update test documentation

### Synchronization Recovery
1. Fix frontmatter issues
2. Update file type handling
3. Implement error recovery
4. Document recovery steps

### Parameter Recovery
1. Fix validation issues
2. Update message-command handling
3. Improve error messages
4. Update documentation 