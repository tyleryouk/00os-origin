# Test Cheatsheet: Project-Rule-Parameter System Enhancement

## Registry Verification Tests

### Test 1: Unified Registry Schema Validation
**Purpose**: Verify the unified registry schema correctly combines both existing registries
**Test Steps**:
1. Create a unified registry with the new schema
2. Verify schema structure matches design
3. Test with sample parameters from both existing systems
4. Verify all fields are correctly represented

### Test 2: Parameter Migration Verification
**Purpose**: Verify all parameters are correctly migrated to the unified registry
**Test Steps**:
1. Run migration utilities on existing registries
2. Compare parameter count before and after migration
3. Verify sample parameters have all properties correctly migrated
4. Validate JSON structure and integrity

### Test 3: Registry CRUD Operations
**Purpose**: Verify all CRUD operations work with the unified registry
**Test Steps**:
1. Create new parameters in different workflows
2. Read parameters from different workflows
3. Update parameters in different workflows
4. Delete parameters from different workflows
5. Verify all operations maintain registry integrity

### Test 4: Registry Backward Compatibility
**Purpose**: Verify existing scripts and commands work with the new registry
**Test Steps**:
1. Run existing parameter management commands
2. Verify operations are successful
3. Check for any errors or warnings
4. Confirm parameters are correctly modified

## Command Verification Tests

### Test 5: Create Rules Parameter Command
**Purpose**: Verify the create-rules-parameter command functions correctly
**Test Steps**:
```
create-rules-parameter: name="test-parameter" category="test" message-command="test-command"
```
1. Verify command creates parameter in registry
2. Check parameter file is created with correct structure
3. Verify registry entry contains all properties
4. Test with different parameter configurations

### Test 6: Remove Rules Parameter Command
**Purpose**: Verify the remove-rules-parameter command functions correctly
**Test Steps**:
```
remove-rules-parameter: name="test-parameter"
```
1. Verify command removes parameter from registry
2. Check parameter file remains (should not be deleted)
3. Verify registry no longer contains the parameter
4. Test removal of non-existent parameter (error handling)

### Test 7: Update Rules Parameter Command
**Purpose**: Verify the update-rules-parameter command functions correctly
**Test Steps**:
```
update-rules-parameter: name="test-parameter" description="Updated description"
```
1. Verify command updates parameter in registry
2. Check registry entry contains updated properties
3. Verify other properties remain unchanged
4. Test with multiple property updates

### Test 8: Error Handling
**Purpose**: Verify commands handle errors gracefully
**Test Steps**:
1. Test with invalid parameter names
2. Test with missing required properties
3. Test with invalid property values
4. Verify error messages are clear and actionable

## Reference Verification Tests

### Test 9: Alias Reference Resolution
**Purpose**: Verify alias references are correctly resolved
**Test Steps**:
1. Create test parameter with alias reference
2. Try to access parameter via alias in message-command
3. Verify parameter is correctly loaded
4. Test with different workflow types

### Test 10: Reference Update Propagation
**Purpose**: Verify parameter updates propagate to references
**Test Steps**:
1. Update parameter path in registry
2. Verify alias references still resolve correctly
3. Test with parameter category changes
4. Verify direct path references are properly converted

### Test 11: Reference Scan Utility
**Purpose**: Verify reference scan utility correctly identifies all references
**Test Steps**:
1. Run reference scan utility on codebase
2. Verify all parameter references are identified
3. Check for any missed references
4. Validate scan results match expected references

## Integration Verification Tests

### Test 12: Knowledge System Integration
**Purpose**: Verify parameter system integrates with knowledge system
**Test Steps**:
1. Create parameter with knowledge references
2. Use fetch_rules to access parameter knowledge
3. Verify knowledge components are correctly accessed
4. Test knowledge integration in parameter creation process

### Test 13: Workflow Integration
**Purpose**: Verify parameters work correctly across workflows
**Test Steps**:
1. Create parameters in different workflows
2. Access parameters from different workflows
3. Verify workflow isolation works correctly
4. Test cross-workflow parameter references

### Test 14: Planning to Implementation Process
**Purpose**: Verify complete parameter management process
**Test Steps**:
1. Plan parameter creation with documentation
2. Implement parameter with correct structure
3. Register parameter in registry
4. Verify parameter accessibility
5. Check documentation reflects new parameter

## System-Wide Tests

### Test 15: Registry Consistency
**Purpose**: Verify registry maintains consistency across operations
**Test Steps**:
1. Perform sequence of create, update, remove operations
2. Verify registry state after each operation
3. Check for any inconsistencies
4. Validate registry structure remains intact

### Test 16: Performance Tests
**Purpose**: Verify system performs efficiently with many parameters
**Test Steps**:
1. Create large number of test parameters (50+)
2. Test registry operations with large dataset
3. Measure operation times
4. Verify performance meets requirements

### Test 17: Script Integration
**Purpose**: Verify PowerShell scripts work correctly with new system
**Test Steps**:
1. Run each PowerShell script with test parameters
2. Verify script outputs match expected results
3. Check for any errors or warnings
4. Validate scripts handle edge cases

## Special Test Cases

### Test 18: Migration Edge Cases
**Purpose**: Verify migration handles special cases correctly
**Test Cases**:
1. Parameters with missing properties
2. Parameters with custom properties
3. Duplicate parameters across registries
4. Invalid parameter structures

### Test 19: Alias Conversion Edge Cases
**Purpose**: Verify alias conversion handles special cases correctly
**Test Cases**:
1. References with spaces or special characters
2. References to non-existent parameters
3. Ambiguous references
4. Nested references

### Test 20: Verification Tool Tests
**Purpose**: Verify parameter verification tools work correctly
**Test Steps**:
1. Run verification on clean registry
2. Introduce deliberate errors and run verification
3. Check verification identifies all issues
4. Verify verification reports are clear and actionable

## Test Data

### Sample Parameters for Testing
```json
{
  "test-parameter": {
    "path": "parameters/rules/test/test-parameter.md",
    "description": "Test parameter for verification",
    "category": "test",
    "messageCommand": "test-command",
    "standardParameters": ["param1", "param2"]
  },
  "another-test": {
    "path": "parameters/front-end/test/another-test.md",
    "description": "Another test parameter",
    "category": "test",
    "messageCommand": "another-test",
    "standardParameters": []
  }
}
```

### Sample Commands for Testing
```
create-rules-parameter: name="test-parameter" category="test" message-command="test-command"
remove-rules-parameter: name="test-parameter"
update-rules-parameter: name="test-parameter" description="Updated description"
```

## Verification Checklist

- [ ] Unified registry schema validated
- [ ] All parameters migrated correctly
- [ ] All CRUD operations functioning
- [ ] Backward compatibility confirmed
- [ ] All new commands functioning correctly
- [ ] Error handling works appropriately
- [ ] Alias references resolve correctly
- [ ] Reference updates propagate properly
- [ ] Knowledge system integration works
- [ ] Cross-workflow operations function correctly
- [ ] Complete process verified
- [ ] System handles edge cases properly
- [ ] Performance meets requirements
- [ ] All scripts integrated correctly
- [ ] Verification tools functioning 