# Test Cheatsheet: Rules-Workflow Subsystem Enhancement

## Front-End Enhancement Test Cases

### Test Case 1: Front-End File Access
**Objective**: Verify that the new project-rule-parameter can read front-end files
**Steps**:
1. Apply the project-rule-parameter: `plan-mode: rules-workflow @parameters/rules/plan-mode-front-end-enhancement.mdc`
2. Check if it can read front-end component files: `front-end/src/components/`
3. Verify it can analyze front-end structure

**Expected Result**: Successfully reads and analyzes front-end files without errors

### Test Case 2: Modification Boundary Enforcement
**Objective**: Verify that the project-rule-parameter only modifies 1000xbrain files
**Steps**:
1. Apply the project-rule-parameter: `plan-mode: rules-workflow @parameters/rules/plan-mode-front-end-enhancement.mdc`
2. Attempt to modify both 1000xbrain files and front-end files
3. Verify which modifications are allowed

**Expected Result**: Only allows modifications to 1000xbrain files, prevents modifications to front-end files

### Test Case 3: Cross-Workflow Navigation
**Objective**: Verify that the tool call sequences effectively navigate both domains
**Steps**:
1. Apply the project-rule-parameter: `plan-mode: rules-workflow @parameters/rules/plan-mode-front-end-enhancement.mdc`
2. Test tool call sequences for navigating between rules-workflow and front-end files
3. Verify navigation effectiveness

**Expected Result**: Tool call sequences work smoothly for cross-domain navigation

## Helper Command Classification Tests

### Test Case 4: Command Category Documentation
**Objective**: Verify that helper commands are clearly categorized
**Steps**:
1. Check the README.md in parameters/rules directory
2. Verify that all helper commands are categorized into one of the six categories
3. Ensure each category has a clear description

**Expected Result**: All helper commands are clearly categorized with descriptions

### Test Case 5: Usage Timing Documentation
**Objective**: Verify that usage timing is documented for each command category
**Steps**:
1. Check the README.md in parameters/rules directory
2. Verify that each category has usage timing information
3. Ensure the information is clear and actionable

**Expected Result**: Clear usage timing information for all command categories

### Test Case 6: Workflow Phase Alignment
**Objective**: Verify that helper commands are aligned with workflow phases
**Steps**:
1. Check the README.md in parameters/rules directory
2. Verify that each command indicates which workflow phase(s) it applies to
3. Ensure the alignments are logical and clear

**Expected Result**: Clear workflow phase alignments for all commands

## Directory Structure Tests

### Test Case 7: Subdirectory Creation
**Objective**: Verify that all required subdirectories are created
**Steps**:
1. Check the parameters/rules directory
2. Verify that all planned subdirectories exist
3. Ensure the structure matches the design

**Expected Result**: All subdirectories exist and match the planned structure

### Test Case 8: README.md Presence
**Objective**: Verify that README.md files are present where needed
**Steps**:
1. Check for README.md in parameters/rules directory
2. Check for README.md in each subdirectory
3. Verify content relevance

**Expected Result**: README.md files present and relevant in all required locations

## Workflow and Pathway Header Tests

### Test Case 9: README Header Format
**Objective**: Verify that the README.md has the correct header format
**Steps**:
1. Check the README.md in workflows/rules-workflow directory
2. Verify that it includes workflow and pathway headers
3. Ensure the format is clear and standardized

**Expected Result**: Clear, standardized header format in README.md

### Test Case 10: Project-Rule-Parameter References
**Objective**: Verify that project-rule-parameter references are included
**Steps**:
1. Check the README.md in workflows/rules-workflow directory
2. Verify that it includes project-rule-parameter references
3. Ensure they are correctly formatted

**Expected Result**: Correctly formatted project-rule-parameter references

## No-Planning-Folder Mode Tests

### Test Case 11: Mode Documentation
**Objective**: Verify that the no-planning-folder mode is documented
**Steps**:
1. Check the README.md in parameters/rules directory
2. Verify that it includes documentation for the no-planning-folder mode
3. Ensure the documentation is complete

**Expected Result**: Complete documentation for no-planning-folder mode

### Test Case 12: Syntax and Usage Documentation
**Objective**: Verify that syntax and usage are documented
**Steps**:
1. Check the no-planning-folder mode documentation
2. Verify that it includes syntax and usage information
3. Ensure the information is clear and actionable

**Expected Result**: Clear syntax and usage information

### Test Case 13: Research-Implementation Pattern
**Objective**: Verify that the research-implementation pattern is documented
**Steps**:
1. Check the no-planning-folder mode documentation
2. Verify that it includes information on the research-implementation pattern
3. Ensure the information is clear and actionable

**Expected Result**: Clear documentation of the research-implementation pattern

## Comprehensive Verification Tests

### Test Case 14: Front-End Enhancement Project-Rule-Parameter Content
**Objective**: Verify that the front-end enhancement project-rule-parameter includes all required content
**Steps**:
1. Check the plan-mode-front-end-enhancement.md file
2. Verify that it includes all required content
3. Ensure the content is accurate and complete

**Expected Result**: Complete and accurate content in the project-rule-parameter

### Test Case 15: Helper Command Documentation Completeness
**Objective**: Verify that all helper commands are documented
**Steps**:
1. Check the README.md in parameters/rules directory
2. Verify that all helper commands listed in requirements are documented
3. Ensure the documentation is complete

**Expected Result**: Complete documentation for all helper commands

### Test Case 16: No-Planning-Folder Directory Structure
**Objective**: Verify that the directory structure for no-planning-folder mode is created
**Steps**:
1. Check the parameters/rules directory
2. Verify that the no-planning-folder directory exists
3. Ensure it is ready for future project-rule-parameters

**Expected Result**: Directory structure ready for no-planning-folder mode

## Usage Testing

### Test Case 17: Front-End Enhancement Usage
**Objective**: Verify that the front-end enhancement project-rule-parameter works as expected
**Steps**:
1. Apply the project-rule-parameter: `plan-mode: rules-workflow @parameters/rules/plan-mode-front-end-enhancement.mdc`
2. Follow a complete workflow to enhance front-end functionality
3. Verify the enhancement process

**Expected Result**: Smooth enhancement process with expected behavior

### Test Case 18: Helper Command Usage
**Objective**: Verify that helper commands work as expected based on documentation
**Steps**:
1. Select a helper command from each category
2. Apply each command according to documentation
3. Verify behavior matches documentation

**Expected Result**: Helper commands behave as documented

### Test Case 19: No-Planning-Folder Usage Documentation
**Objective**: Verify that no-planning-folder usage is clearly documented
**Steps**:
1. Check the no-planning-folder mode documentation
2. Verify that it includes clear usage examples
3. Ensure the examples cover all needed scenarios

**Expected Result**: Clear and comprehensive usage examples

## Regression Testing

### Test Case 20: Existing Functionality Preservation
**Objective**: Verify that all existing functionality is preserved
**Steps**:
1. Test all existing workflows and commands
2. Verify that they still work as expected
3. Ensure no regressions

**Expected Result**: All existing functionality works as expected 