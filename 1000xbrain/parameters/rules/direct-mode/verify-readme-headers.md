# Workflow: rules-workflow | Pathway: validation

# Verify README Headers

## File Purpose and Relationship

This file defines the operation of the `verify-readme-headers: planning-folder-path` message-command, which verifies that README.md files in planning folders have the correct workflow header format. It should be consulted to understand:

- How to verify README.md headers in planning folders
- How to detect and fix common workflow-type confusion issues
- The correct format for README.md headers
- The relationship between workflow-type and implementing workflow

This file complements:
- **workflows/rules-workflow/validation-script.md**: Core validation mechanisms
- **workflows/rules-workflow/rules-workflow.md**: Core README.md requirements
- **parameters/rules/plan-mode/README.md**: Planning-specific README.md requirements

## Usage as Project-Rule-Parameter

This file contains verification procedures for README.md headers in planning folders. It should be referenced as a project-rule-parameter when verifying README.md headers:

```
verify-readme-headers: planning/folder-path @parameters/rules/dev-mode/validation-verify-readme-headers.mdc
```

For more comprehensive verification, see `@parameters/rules/dev-mode/validation-verify-planning.mdc`.

## 1. Verification Process

The `verify-readme-headers` message-command performs the following checks:

1. **Header Existence**: Verifies that the README.md begins with a header line
2. **Header Format**: Verifies the header follows the `# workflow-type | pathway-type` format
3. **Workflow Type Match**: Verifies the workflow-type matches the implementing workflow
4. **Common Confusion Detection**: Checks for common workflow-type confusion patterns

### Tool Call Sequence

```typescript
// 1. Check for README.md existence
file_search("README.md", "Checking for README.md file in specified planning folder")

// 2. Read the README.md file
read_file("planning/folder-path/README.md", offset=1, limit=1)

// 3. Parse the header and check format
// Internal parsing of the header to extract workflow-type and pathway-type

// 4. Verify workflow type is correct
// Internal verification against expected workflow type
```

### Common Confusion Patterns

The verification tool specifically checks for these common confusion patterns:

1. **Front-End Enhancement Confusion**:
   - Incorrect: `# front-end-workflow | front-end-workflow-enhancement`
   - Correct: `# rules-workflow | front-end-workflow-enhancement`
   - When: Rules-workflow is enhancing front-end-workflow documentation

2. **Back-End Enhancement Confusion**:
   - Incorrect: `# back-end-workflow | back-end-workflow-enhancement`
   - Correct: `# rules-workflow | back-end-workflow-enhancement`
   - When: Rules-workflow is enhancing back-end-workflow documentation

3. **Documentation Enhancement Confusion**:
   - Incorrect: `# documentation-workflow | documentation-workflow-enhancement`
   - Correct: `# rules-workflow | documentation-workflow-enhancement`
   - When: Rules-workflow is enhancing documentation-workflow

## 2. Header Correction Process

If the verification detects an incorrect header, it offers to fix it:

1. **Issue Detection**: Reports the exact issue with the current header
2. **Correction Recommendation**: Provides the correct header format
3. **Automatic Correction**: Offers to automatically update the header

### Automatic Correction

```typescript
// If header correction is approved:
edit_file("planning/folder-path/README.md",
          "Fix README.md header to use correct workflow type",
          "# correct-workflow | pathway-type\n\n// ... existing content ...")
```

## 3. Verification Results

The verification tool provides detailed results:

1. **Success Message**: When the header is correct
2. **Warning Message**: When minor format issues are detected
3. **Error Message**: When critical workflow-type mistakes are found
4. **Correction Instructions**: How to fix detected issues

### Success Response Format

```
✅ README.md header verified: # rules-workflow | front-end-workflow-enhancement
   - Workflow type: rules-workflow (correct)
   - Pathway type: front-end-workflow-enhancement
```

### Error Response Format

```
❌ README.md header verification failed: # front-end-workflow | front-end-workflow-enhancement
   - Expected workflow type: rules-workflow
   - Found workflow type: front-end-workflow
   - ERROR: This is a common confusion pattern. The workflow-type must be the workflow PERFORMING 
     the implementation (rules-workflow), not the target being affected (front-end-workflow).
   - CORRECTION: Change header to "# rules-workflow | front-end-workflow-enhancement"
```

## 4. Usage Examples

### Basic Verification

```
verify-readme-headers: planning/80-front-end-workflow-enhancement @parameters/rules/dev-mode/validation-verify-readme-headers.mdc
```

Response:
```
Verified README.md in planning/80-front-end-workflow-enhancement
```

### Verification with Correction

```
verify-readme-headers: planning/80-front-end-workflow-enhancement @parameters/rules/dev-mode/validation-verify-readme-headers.mdc
```

Response:
```
❌ README.md header verification failed: # front-end-workflow | front-end-workflow-enhancement
   - Expected workflow type: rules-workflow
   - Found workflow type: front-end-workflow
   - ERROR: This is a common confusion pattern. The workflow-type must be the workflow PERFORMING 
     the implementation (rules-workflow), not the target being affected (front-end-workflow).
   - CORRECTION: Change header to "# rules-workflow | front-end-workflow-enhancement"
   
Would you like to automatically fix this header? (Respond with "yes" to update)
```

## 5. Verification Principles

1. **Implementation Workflow Priority**: The workflow-type must match the workflow performing the implementation
2. **Message-Command Alignment**: The workflow-type should align with the message-command used
3. **Parameter Source Alignment**: The workflow-type should match the source of project-rule-parameters
4. **Clear Communication**: The header must clearly communicate which workflow is responsible for implementation
5. **Consistent Context**: The header must provide consistent context for anyone viewing the planning folder

## 6. Relationship with Other Verification Tools

This tool is part of a verification suite:

1. **validation-verify-readme-headers**: Focused on README.md header format verification
2. **validation-verify-planning**: Comprehensive planning folder verification
3. **validation-verify-context-files**: Context file verification
4. **validation-verify-implementation**: Implementation plan verification

These tools work together to ensure complete verification coverage.

## 7. Implementation Notes

This verification tool helps maintain proper workflow boundaries by ensuring README.md headers correctly represent the implementing workflow. It helps prevent the common confusion between:

1. The workflow that is PERFORMING the implementation (which should be the workflow-type)
2. The target of the enhancement (which should be reflected in the pathway-type)

By enforcing this distinction, the tool helps prevent hallucinations about which workflow is responsible for implementation and ensures the correct tools and parameters are used. 