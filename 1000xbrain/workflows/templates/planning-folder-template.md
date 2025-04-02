# Planning Folder Template

This file provides the standard template for planning folder README.md files in all workflows. It ensures consistency and completeness of planning documentation.

## README.md Format

Every planning folder README.md file MUST begin with the workflow type and pathway as the first line in this format:

```
# workflow-type | pathway-type
```

Where:
- **workflow-type**: The workflow performing the implementation (rules-workflow, front-end-workflow, etc.)
- **pathway-type**: The focus or target of the enhancement (component-creation, api-integration, etc.)

### ⚠️ CRITICAL RULE: Workflow Type Selection ⚠️

The workflow-type MUST be the workflow that is PERFORMING the implementation, NOT the workflow being enhanced or affected.

✅ **CORRECT EXAMPLES**:
- When enhancing front-end-workflow using rules-workflow: `# rules-workflow | front-end-workflow-enhancement`
- When creating components using front-end-workflow: `# front-end-workflow | component-creation`
- When enhancing back-end-workflow using rules-workflow: `# rules-workflow | back-end-workflow-enhancement`

❌ **INCORRECT EXAMPLES**:
- ❌ `# front-end-workflow | front-end-workflow-enhancement` (when rules-workflow is doing the implementation)
- ❌ `# back-end-workflow | back-end-workflow-enhancement` (when rules-workflow is doing the implementation)

The workflow-type must match:
1. The workflow you initialized with your plan-mode message-command
2. The workflow that will implement the changes
3. The workflow containing the parameters being used

## Complete README.md Structure

```markdown
# workflow-type | pathway-type

## Project Overview

Brief description of the enhancement or feature being implemented.

## Implementation Status

**🔄 PLANNING PHASE**: Current status of the implementation.

## Problem Statement

- What problem is being solved?
- Why is this enhancement needed?
- What are the current limitations?

## Solution Overview

1. Key approach point 1
2. Key approach point 2
3. Key approach point 3

## Planning Documents

- [Requirements](requirements.md) - Core requirements and objectives
- [Context: Feature Name](context-feature.md) - Analysis of current system
- [Implementation: Feature Name](implementation-feature.md) - Detailed implementation approach
- [Implementation Progress](implementation-progress.md) - Summary of implementation status

## Project-Rule-Parameters Used

This planning folder uses the following project-rule-parameters:

| Project-Rule-Parameter | Purpose |
|------------------------|---------|
| `@parameters/rules/plan-mode/plan-mode-template.mdc` | Planning template |
| `@parameters/rules/dev-mode/dev-mode-template.mdc` | Implementation template |

## Implementation Approach

1. Approach step 1
2. Approach step 2
3. Approach step 3

## Key Features

1. **Feature 1**:
   - Benefit A
   - Benefit B

2. **Feature 2**:
   - Benefit A
   - Benefit B

## Implementation Benefits

1. **Benefit Category 1**:
   - Specific improvement A
   - Specific improvement B

2. **Benefit Category 2**:
   - Specific improvement A
   - Specific improvement B

## Implementation Strategy

Briefly describe the implementation strategy.

## Conclusion

Summary of the enhancement and its expected impact.
```

## Template Customization

This template should be customized for each planning folder:

1. Replace `workflow-type` with the correct workflow performing the implementation
2. Replace `pathway-type` with a clear description of the implementation focus
3. Fill in all sections with relevant details
4. Include all necessary planning documents
5. List all project-rule-parameters being used
6. Customize the implementation approach for the specific enhancement

## Workflow-Specific Considerations

### rules-workflow Planning:
- Focus on documentation clarity and completeness
- Include comprehensive architecture analysis
- Document implementation boundaries

### front-end-workflow Planning:
- Focus on component architecture
- Include UI/UX considerations
- Document state management approach

### back-end-workflow Planning:
- Focus on API design and data flow
- Include security considerations
- Document performance expectations

## Template Verification

Before considering the README.md complete, verify:

1. The workflow-type is correct (matches the implementing workflow)
2. All required sections are included
3. All planning documents are referenced
4. Implementation status is clearly indicated
5. Project-rule-parameters are correctly listed
6. Problem statement clearly defines the issue
7. Solution overview provides a clear approach 