# Target Cycle Handling

## Overview

This document defines the standard approach for handling target cycles within the cognitive architecture system, with special emphasis on the "All Cycles | System" target option.

## Core Target Cycle Format

The standard format for target cycles is:

```
domain/cycle-name
```

Where:
- `domain` is one of: `system`, `frontend`, `backend`
- `cycle-name` is a specific cycle within that domain (e.g., `cycle-manager`, `autonomous`, `major-changes`)

## Special Target Cycle Options

In addition to the standard format, the system supports special target cycle options:

### "All Cycles | System"

The "All Cycles | System" target option is used when changes should be applied to all cycles within the system domain.

#### Usage Guidelines

When "All Cycles | System" is specified:

1. **Directive Interpretation**: 
   - The change should be applied to all system cycles
   - System cycles include: `cycle-manager`, `autonomous`, `major-changes`
   - This is implemented as a systematic change across all relevant process files

2. **Process Flow**:
   - Requirement analysis identifies this special target
   - Planning creates a comprehensive approach that includes all system cycles
   - Implementation applies changes systematically to all affected cycles

3. **Change Types Most Applicable**:
   - Structural changes to cycle processes
   - Updates to templates and standardized formats
   - Changes to common patterns used across cycles
   - Architectural improvements that affect multiple cycles

#### Implementation Pattern

When implementing "All Cycles | System" changes:

1. **Inventory Phase**:
   - Create a complete inventory of all system cycles
   - Identify common process files used across cycles
   - Map dependencies between cycles

2. **Common-First Approach**:
   - Apply changes to common files and patterns first
   - Ensure consistency in implementation across cycles
   - Test changes with one cycle before extending to others

3. **Systematic Verification**:
   - Verify changes in each cycle independently
   - Confirm cross-cycle functionality
   - Document any cycle-specific adaptations needed

## Standard Target Cycles

The current standard target cycles in the system are:

### System Domain
- `system/cycle-manager` - For cycle management system changes
- `system/autonomous` - For autonomous enhancement system changes
- `system/major-changes` - For major architectural changes

### Frontend Domain
- `frontend/main` - Main frontend cycle (when created)

### Backend Domain
- `backend/main` - Main backend cycle (when created)

## Target Cycle Processing

When processing target cycles in requirement analysis:

1. **Validation**:
   - Check if the specified target follows the domain/cycle-name format
   - Verify the domain is valid
   - Verify the cycle exists within that domain
   - Check for special target options like "All Cycles | System"

2. **Handling Special Cases**:
   - For "All Cycles | System":
     - Set an internal flag indicating system-wide changes
     - Create a comprehensive plan for applying changes across cycles
     - Include a systematic approach in the implementation plan

3. **Propagation**:
   - Pass the validated target cycle to the planning phase
   - Include target-specific guidance in the implementation plan
   - Ensure implementation respects the target scope

## Implementation Guidelines

### For Standard Target Cycles

When implementing changes for a standard target cycle:

```markdown
# Implementation Example (Standard Target)

1. Validate the target cycle format (domain/cycle-name)
2. Read the relevant process files for that specific cycle
3. Apply changes to that cycle's specific process files
4. Update only the targeted cycle's implementation
```

### For "All Cycles | System" Target

When implementing system-wide changes:

```markdown
# Implementation Example (All Cycles | System)

1. Identify all system cycles (cycle-manager, autonomous, major-changes)
2. Create an inventory of affected files:
   - Common process files
   - Cycle-specific process files
   - Knowledge files that affect multiple cycles
3. Apply changes systematically:
   - Start with common files
   - Apply consistent patterns across cycle-specific files
   - Update relevant knowledge files
4. Verify changes in each cycle independently
```

## Special Considerations

1. **Cycle Independence**:
   - Even when changes apply to all cycles, each cycle maintains its own independent operation
   - The integrity of each cycle's specific purpose should be preserved

2. **Creation of New Cycles**:
   - When creating new cycles, ensure they follow the standards established for existing cycles
   - New cycles should be compatible with system-wide changes applied via "All Cycles | System"

3. **Domain-Specific Adaptations**:
   - System-wide changes may need domain-specific adaptations
   - Document any variations in implementation across cycles

## Related Resources

- User Request Handling: `1000xbrain/system/cycle-manager/knowledge/user-request-handling.md`
- 1000xplans Usage: `1000xbrain/system/cycle-manager/knowledge/1000xplans-usage.md`
- Process Files:
  - `1000xbrain/system/cycle-manager/processes/requirement-analysis-process.md`
  - `1000xbrain/system/cycle-manager/processes/planning-process.md`
  - `1000xbrain/system/cycle-manager/processes/implementation-process.md` 