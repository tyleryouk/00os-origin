# Minimalist Documentation Standards

## Overview

These standards define the minimalist approach to cycle documentation, focusing on reducing cognitive load while maintaining necessary information. All templates and documentation should follow these standards.

## Core Principles

1. **Remove All Date References**
   * No dates in templates or operational feedback files
   * No date tracking in process files
   * No current-date placeholders in templates

2. **Essential Information Only**
   * Include only information necessary for cycle operation
   * Eliminate redundant or decorative elements
   * Focus on functional content over metadata

3. **Consistent Structure**
   * Use standardized headings across all documentation
   * Maintain consistent formatting
   * Use consistent terminology

## Template Standards

### Change Request Template

```markdown
# Change Request Details

**Requestor**: Tyler Youk
**Status**: [Analysis/Planning/Implementation/Verification/Refinement/Completed]
**Priority**: [High/Medium/Low]

## Request Description

[Brief description of requested change]

## Requirements

* [Requirement 1]
* [Requirement 2]
* [Additional requirements as needed]

## Scope

**In Scope:**
* [Component 1]
* [Component 2]

**Out of Scope:**
* [Excluded component 1]
* [Excluded component 2]

## Success Criteria

* [Criterion 1]
* [Criterion 2]
* [Additional criteria as needed]

## Special Considerations

* [Consideration 1]
* [Consideration 2]
```

### Implementation Plan Template

```markdown
# Implementation Plan: [Brief Title]

**Mode**: [USER_DIRECTED/AUTONOMOUS]
**Priority**: [High/Medium/Low]
**Status**: [Planning/In Progress/Completed]

## Overview

[Brief description of implementation approach]

## Goal

[Clear statement of implementation goal]

## Implementation Phases

### Phase 1: [Phase Name]

* [Key task 1]
* [Key task 2]

### Phase 2: [Phase Name]

* [Key task 1]
* [Key task 2]

## Detailed Task Breakdown

### Phase 1: [Phase Name]

1. **[Task 1]**:
   * [Subtask details]
   * [Files/components affected]

2. **[Task 2]**:
   * [Subtask details]
   * [Files/components affected]

## Dependencies

* [Dependency 1]
* [Dependency 2]

## Success Criteria

* [Criterion 1]
* [Criterion 2]

## Risk Assessment

* **Risk**: [Risk description]
  * **Mitigation**: [Mitigation approach]

## Next Steps

[Next command to execute]
```

### Implementation Log Template

```markdown
# Implementation Log

**Plan Reference**: [Implementation plan title]
**Mode**: [USER_DIRECTED/AUTONOMOUS]

## Execution Summary

[Brief summary of implementation status]

## Task Execution

### Phase 1: [Phase Name]

1. **[Task 1]**:
   * Completed: [Yes/No/Partial]
   * Files Modified: 
     * [File path 1]
     * [File path 2]
   * Notes: [Brief notes]

## Issues Encountered

* [Issue description and resolution]

## Overall Status

[Complete/In Progress/Stalled] - [Brief status description]
```

### Current Cycle Template

```markdown
# Current Cycle

**Cycle ID**: [identifier]
**Status**: [Initialized/Requirements Analyzed/Plan Created/Implementation Completed/Verified/Refined/Completed]

## Current Phase

[Description of current phase and readiness for next step]

## Operation Mode

[USER_DIRECTED/AUTONOMOUS]

## Document References

* Change Request: [path to document]
* Implementation Plan: [path to document]
* Implementation Log: [path to document]
* Verification Report: [path to document]
* Refinement Log: [path to document]
* Completion Summary: [path to document]

## Next Step

[Next command to execute]
```

## Process File Standards

1. **Minimize Error Handling Verbosity**
   * Consolidate error handling sections
   * Use brief, clear error handling notes
   * Focus on actionable recovery steps

2. **Streamline Steps**
   * Combine related steps where possible
   * Remove unnecessary detailed instructions
   * Focus on essential actions

3. **Remove Date Handling**
   * Remove all instructions for adding/updating dates
   * Remove date calculations and tracking
   * Replace date references with status transitions

## Implementation

These standards should be applied to:

1. All template files in operational_feedback folders
2. All process files in the three core cycles
3. All command files in the three core cycles

The standards focus on efficient communication and minimal documentation overhead while maintaining the core functionality of the cycles. 