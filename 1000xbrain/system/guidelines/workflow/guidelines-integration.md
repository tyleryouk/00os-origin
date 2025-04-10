# Guidelines Integration for Workflow Commands

## Overview

This document defines the standard approach for integrating system guidelines into workflow commands. By explicitly referencing and incorporating guidelines during workflow execution, we ensure consistent implementation that follows established best practices.

## Core Integration Pattern

### 1. Guidelines Reference in Dynamic Execution

All workflow commands should include relevant guidelines in their dynamic execution section:

```markdown
# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/system/[workflow]/processes/[process-name].md
# Knowledge: 1000xbrain/system/[workflow]/knowledge/[knowledge-name].md
# Guidelines: 1000xbrain/system/guidelines/[category]/[guideline-name].md
# --- END DYNAMIC EXECUTION ---
```

### 2. Process Integration

Process files should include explicit steps for reading and applying guidelines:

```markdown
## Steps:

1. **Read Guidelines**:
   * Use `read_file` to read `1000xbrain/system/guidelines/[category]/[guideline-name].md`
   * Parse key principles and requirements
   * **(Error Handling)**: If file doesn't exist, log warning and proceed with defaults

2. **Apply Guidelines to Implementation**:
   * Reference specific guideline principles in the implementation steps
   * Ensure actions conform to guideline requirements
   * Document any guideline-specific considerations
```

### 3. Verification Integration

Verification phases must validate guideline compliance:

```markdown
## Verification Steps:

1. **Guideline Compliance Check**:
   * Read relevant guidelines
   * Compare implementation against guideline requirements
   * Document compliance status
   * Flag any deviations for refinement
```

## Guidelines Reference Registry

Each workflow should maintain a guidelines registry that maps workflow phases to relevant guidelines:

### Example Registry Structure (in workflow knowledge file)

```markdown
## Guidelines Registry

| Workflow Phase | Relevant Guidelines |
|----------------|---------------------|
| Initiation     | `1000xbrain/system/guidelines/implementation/context-management.md` |
| Research       | `1000xbrain/system/guidelines/tool-usage/file-reading-patterns.md` |
| Planning       | `1000xbrain/system/guidelines/implementation/planning-standards.md` |
| Implementation | `1000xbrain/system/guidelines/implementation/core-implementation.md` |
| Verification   | `1000xbrain/system/guidelines/error-handling/verification-standards.md` |
| Refinement     | `1000xbrain/system/guidelines/error-handling/recovery-patterns.md` |
| Completion     | `1000xbrain/system/guidelines/communication/completion-reporting.md` |
```

## Implementation Requirements

### 1. Command Files

All workflow command files must:
* Include at least one relevant guideline in their dynamic execution section
* Use the standardized Guidelines tag format
* Reference the correct guideline path

### 2. Process Files

All workflow process files must:
* Include an explicit step for reading relevant guidelines
* Reference guideline principles in implementation steps
* Incorporate guideline requirements in decision logic

### 3. Verification Processes

All verification-related processes must:
* Include explicit guideline compliance checks
* Document compliance status clearly
* Flag deviations for refinement

## Guidelines Selection Criteria

When selecting guidelines to integrate:

1. **Relevance**: Guidelines must be directly relevant to the workflow phase
2. **Specificity**: Choose the most specific guidelines applicable
3. **Coverage**: Ensure all critical aspects have guideline coverage
4. **Consistency**: Maintain consistent guideline selection across similar workflow phases

## Example Implementation

### Command File Example:

```markdown
# Implement Autonomous Enhancements | Part 4

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/system/autonomous/processes/implementation-process.md
# Guidelines: 1000xbrain/system/guidelines/implementation/core-implementation.md
# Guidelines: 1000xbrain/system/guidelines/tool-usage/file-editing-patterns.md
# --- END DYNAMIC EXECUTION ---
```

### Process File Example:

```markdown
# Process: Autonomous Implementation

## Steps:

1. **Read Implementation Guidelines**:
   * Use `read_file` to read `1000xbrain/system/guidelines/implementation/core-implementation.md`
   * Parse key implementation principles
   * Set implementation parameters based on guidelines

2. **Read Tool Usage Guidelines**:
   * Use `read_file` to read `1000xbrain/system/guidelines/tool-usage/file-editing-patterns.md`
   * Identify appropriate file editing patterns for this implementation

3. **Execute Implementation Steps**:
   * Following the "incremental verification" principle from the guidelines
   * Apply the "safe edit pattern" from tool usage guidelines
   * Document compliance with each guideline requirement
```

## Verification of Guidelines Integration

During system verification, check that:

1. All workflow commands include relevant guidelines
2. Process files actively incorporate guideline requirements
3. Verification processes check guideline compliance
4. Implementation actually follows the referenced guidelines

## Integration Timeline

All workflows should be updated to incorporate guidelines integration:

1. **Initial Setup**: Create or update the Guidelines Registry for each workflow
2. **Command Updates**: Modify command files to include Guidelines tags
3. **Process Enhancement**: Update process files to read and apply guidelines
4. **Verification Enhancement**: Ensure verification processes check guideline compliance

## Related References

* Directory Structure: `1000xrules/core/identity/directory-structure.md`
* Core Implementation: `1000xbrain/system/guidelines/implementation/core-implementation.md`
* Workflow Design: `1000xbrain/system/guidelines/implementation/workflow-design.md` 