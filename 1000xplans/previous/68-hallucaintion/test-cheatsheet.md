# Test Cheatsheet: Project-Rule-Parameters Enhancement

## Test Scenarios

### 1. Template Renaming Verification
- **Objective**: Verify successful renaming of past-chat hallucination template
- **Steps**:
  1. Check existence of `template-past-chat-hallucination.md`
  2. Verify old file `template-hallucination.md` is removed
  3. Confirm content accurately reflects past-chat focus

### 2. New Template Creation
- **Objective**: Verify creation and structure of standard hallucination template
- **Steps**:
  1. Check existence of `template-standard-hallucination.md`
  2. Verify template structure follows standards
  3. Confirm content addresses standard hallucination cases

### 3. Message-Command Integration
- **Objective**: Verify both templates work with message-commands
- **Test Cases**:
  ```
  plan-mode: rules-workflow @template-past-chat-hallucination.mdc
  plan-mode: rules-workflow @template-standard-hallucination.mdc
  ```

### 4. Mode System Compatibility
- **Objective**: Verify templates work in both modes
- **Test Cases**:
  1. Plan-mode activation with each template
  2. Dev-mode activation with each template
  3. Mode transitions with templates active

## Success Criteria

### File Structure
- [ ] Both templates exist in correct locations
- [ ] File names follow proper conventions
- [ ] Content formatting is consistent

### Integration
- [ ] Message-commands recognize both templates
- [ ] Mode system properly handles both templates
- [ ] Rules workflow integrates with both templates

### Functionality
- [ ] Past-chat hallucination template works as expected
- [ ] Standard hallucination template works as expected
- [ ] Templates maintain proper separation of concerns

## Test Data Requirements
1. Example of past-chat hallucination scenario
2. Example of standard hallucination scenario
3. Sample message-command sequences
4. Mode transition test cases 