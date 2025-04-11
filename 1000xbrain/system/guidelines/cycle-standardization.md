# Cycle Standardization Guidelines

## Overview

This document establishes the system-wide standards for cycle implementation across all domains. All cycles must adhere to these guidelines to ensure consistency, maintainability, and interoperability throughout the 1000x system.

## Core Requirements

Every cycle must:

1. **Follow Standard Structure**: Implement the 7-step sequential command structure as defined in `1000xbrain/system/cycle-manager/knowledge/cycle-structure.md`.
2. **Support Unified Model**: Implement the unified model for both autonomous and user-directed operation as defined in `1000xbrain/system/cycle-manager/knowledge/unified-model.md`.
3. **Adhere to Naming Conventions**: Follow the naming conventions defined in `1000xbrain/system/cycle-manager/knowledge/naming-conventions.md`.
4. **Use Dynamic Execution**: Implement proper dynamic execution patterns that reference process files.
5. **Maintain Operational Feedback**: Create and update operational feedback files consistent with the standard structure.
6. **Document Enhancements**: Document potential enhancements to enable autonomous operation.
7. **Implement Error Handling**: Include proper error handling in all process steps.

## Command Implementation Standards

### Every Command File Must:

1. **Follow Standard Header**: Include title with part number and dynamic execution marker
2. **Reference Process File**: Point to the corresponding process in 1000xbrain
3. **Include Placeholders**: Have placeholder comments for clarity when processed
4. **Note Next Steps**: Indicate the next command in the sequence
5. **Avoid Inline Tool Calls**: Rely on dynamic execution rather than explicit tool calls

### Example Command Structure:

```markdown
# [Command Name] | Part [Number]

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/[domain]/[cycle-name]/processes/[process-name].md
# --- END DYNAMIC EXECUTION ---

# This command [brief description of purpose]

# Placeholder: [brief description of operations]
# (Tool calls to be added within the dynamic process)

# Next Step: Invoke `run command:[domain]/[cycle-name]/[next-number]`
# (Actual invocation requires external orchestration - will be handled by Tyler)
```

## Process Implementation Standards

### Every Process File Must:

1. **Clearly Define Goal**: Include a clear statement of the process's goal
2. **List Steps Sequentially**: List steps in a clear, sequential order
3. **Include Error Handling**: Define error handling for each major step
4. **Maintain File Context**: Follow proper file reading practices
5. **Document Progress**: Update operational feedback files appropriately
6. **Signal Completion**: Indicate when the process is complete
7. **Reference Next Steps**: Note the next command in the sequence

### Example Process Structure:

```markdown
# Process: [Process Name]

# Defines the steps for [process description].

## Goal: [Clear statement of the process goal].

## Steps:

1.  **[Step Name]**:
    *   [Detailed explanation of step]
    *   [Tool calls and logic]
    *   **(Error Handling)**: [Error handling approach]

2.  **[Next Step]**:
    *   [Details...]
    
[Additional steps...]

[Final step with completion signal and next steps]
```

## Operational Feedback Standards

### Required Operational Feedback Files:

1. **current_cycle.md**: Tracks cycle status, request, and current phase
2. **change_request.md**: Documents user requirements (when in user-directed mode)
3. **implementation_plan.md**: Detailed plan for implementation
4. **implementation_log.md**: Record of implemented changes
5. **verification_report.md**: Results of verification
6. **potential_enhancements.md**: Documented potential enhancements for future autonomous operation

### Example current_cycle.md Structure:

```markdown
# Current [Cycle Name] Cycle

**Cycle ID**: [YYYYMMDD-NN]
**Status**: [Initialization/Analysis/Planning/Implementation/Verification/Refinement/Completion]
**Date Started**: [YYYY-MM-DD]
**Mode**: [Autonomous/User-Directed]

## [User Request or Enhancement]

[Details of what is being processed]

## Current Phase

[Description of current status and next steps]

## [Additional Sections as Needed]

[Phase-specific information]
```

## Unified Model Implementation

### USER REQUEST SECTION Implementation:

1. **Creation**: Must be created in command 1 (Initialization)
2. **Standard Format**: Must follow the format defined in `1000xbrain/system/cycle-manager/knowledge/unified-model.md`
3. **Mode Detection**: Must be checked in command 2 (Requirement Analysis)
4. **Processing Logic**: Must implement the correct mode-specific processing

### Enhancement Documentation:

1. **Format**: Must follow the standardized enhancement format
2. **Creation**: Must be documented during command 7 (Completion)
3. **Selection**: Must follow the priority criteria for autonomous operation
4. **Update**: Must be updated after processing to reflect completion status

## Migration and Compliance

### Existing Cycle Migration:

1. All existing cycles must be updated to follow these standards
2. The cycle-manager cycle is responsible for facilitating this migration
3. Priority should be given to frequently used cycles

### Compliance Verification:

1. The cycle-manager can verify compliance with these standards
2. Non-compliant cycles should be flagged for updates
3. New cycles must be created using the cycle-manager to ensure compliance

## References

* Cycle Structure: `1000xbrain/system/cycle-manager/knowledge/cycle-structure.md`
* Unified Model: `1000xbrain/system/cycle-manager/knowledge/unified-model.md`
* Naming Conventions: `1000xbrain/system/cycle-manager/knowledge/naming-conventions.md`
* Implementation Guidelines: `1000xbrain/system/guidelines/implementation-best-practices.md`

## Domain-Specific Considerations

### System Domain

Cycles in the system domain:
- Focus on system-wide functionality
- May modify core system components
- Often manage other cycles or system processes
- Typically have higher security and stability requirements

### Front-End Domain

Cycles in the front-end domain:
- Focus on user interface components
- May include visual design considerations
- Often involve React or other front-end frameworks
- May require specific testing approaches

### Back-End Domain

Cycles in the back-end domain:
- Focus on server-side functionality
- May include database or API operations
- Often involve security considerations
- May require specialized testing approaches

## Compliance and Maintenance

### Compliance Checking

The cycle-manager provides tools to check cycle compliance with these standards:

```
run command:system/cycle-manager/verify [domain]/[cycle-name]
```

### Updating Standards

When these standards change:

1. This guideline document will be updated
2. The cycle-manager will be updated to apply new standards
3. Existing cycles can be updated using:
   ```
   run command:system/cycle-manager/update [domain]/[cycle-name]
   ```

## Relationship with cycle-manager

The cycle-manager is responsible for:
1. Creating new cycles that comply with these standards
2. Enhancing existing cycles while maintaining compliance
3. Optimizing cycles across domains
4. Updating cycles when these standards change

## Exceptions and Special Cases

While these standards should be followed in most cases, there may be legitimate reasons for exceptions:

1. **Legacy Cycles**: Some legacy cycles may be granted temporary exceptions during migration
2. **Specialized Cycles**: Specialized cycles may require adaptations to the standard structure
3. **Experimental Cycles**: Experimental cycles may have temporary exceptions for innovation

All exceptions must be:
1. Well-documented
2. Approved by system administrators
3. Temporary when possible
4. Minimized in scope 