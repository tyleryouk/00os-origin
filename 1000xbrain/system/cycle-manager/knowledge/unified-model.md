# Unified Cycle Model: Autonomous and User-Directed Operation

## Overview

The Unified Cycle Model is a key innovation that eliminates the need for separate autonomous and user-directed cycle types by implementing a single model capable of operating in both modes. All cycles within the 1000x system follow this unified approach, simplifying maintenance while maximizing flexibility.

## Core Concepts

### 1. Single Model, Dual Operation

The Unified Cycle Model allows all cycles to operate in one of two modes:

1. **User-Directed Mode**: Activated when a user provides specific input through the USER REQUEST SECTION. The cycle processes this input directly, following the user's requirements.

2. **Autonomous Mode**: Activated when no user input is provided. The cycle refers to previously documented potential enhancements to determine what work to perform autonomously.

This dual-mode capability eliminates the need for separate cycle types, reducing complexity and duplication.

### 2. Mode Determination Logic

Mode determination occurs in step 2 of every cycle (Requirement Analysis) using the following logic:

```
If USER REQUEST SECTION contains valid user input:
    Process as User-Directed Mode
    - Parse user requirements
    - Document specific requirements
    - Proceed with user-directed workflow
Else:
    Process as Autonomous Mode
    - Check for documented potential enhancements
    - Select highest priority enhancement
    - Document selected enhancement as current requirement
    - Proceed with autonomous workflow
```

### 3. Enhancement Documentation

To support autonomous operation, every cycle must:

1. Document potential enhancements during the completion phase (step 7)
2. Store these enhancements in a standardized format and location
3. Include priority, scope, and implementation details for each enhancement
4. Update enhancement status after autonomous processing

## USER REQUEST SECTION Standardization

The USER REQUEST SECTION is a critical component of the unified model and must follow this standardized format:

```markdown
## USER REQUEST SECTION

[User-provided requirements will be placed here by Tyler]

/* 
IMPORTANT: This section is reserved for user input. 
If this section contains text (other than this instructional comment),
the cycle will operate in User-Directed Mode.
If this section is empty or contains only this comment, 
the cycle will operate in Autonomous Mode.
*/
```

This section is:
1. Created during cycle initialization (step 1)
2. Checked during requirement analysis (step 2)
3. Updated with analysis results after processing

## Autonomous Enhancement Selection

When operating in autonomous mode, the cycle must select an enhancement using these criteria:

1. **Priority**: Higher priority enhancements are selected first
2. **Dependencies**: Enhancements with satisfied dependencies are preferred
3. **Complexity**: In case of ties, lower complexity enhancements are preferred
4. **Age**: Older enhancements (waiting longer) get preference

## Enhancement Documentation Format

Potential enhancements follow this standardized format:

```markdown
## Potential Enhancements

1. **[Enhancement Title]**:
   * **Priority**: [High/Medium/Low]
   * **Complexity**: [High/Medium/Low]
   * **Dependencies**: [List of dependencies, if any]
   * **Description**: [Detailed description of the enhancement]
   * **Implementation Notes**: [Key implementation details]
   * **Success Criteria**: [How to verify successful implementation]
   * **Status**: [Pending/Selected/Completed/Deferred]
   * **Date Added**: [YYYY-MM-DD]

2. **[Next Enhancement]**:
   * [Details as above]
```

This structured format ensures that all cycles have sufficient information to operate autonomously when no user input is provided.

## Integration with Planning

The unified model ensures that:

1. Planning (step 3) works consistently regardless of mode
2. The same success criteria verification approach applies to both modes
3. Documentation is standardized across modes
4. Enhancement status is updated appropriately after completion

## Implementation Examples

### Command 1: Initialization (Example Structure)

```markdown
# Creates the USER REQUEST SECTION if not already present
edit_file("1000xbrain/<domain>/<cycle-name>/operational_feedback/current_cycle.md", "Create current cycle with USER REQUEST SECTION", "...")
```

### Command 2: Requirement Analysis (Example Logic)

```markdown
# Check if USER REQUEST SECTION contains user input
user_request = read_file("1000xbrain/<domain>/<cycle-name>/operational_feedback/current_cycle.md")

if user_request contains non-empty USER REQUEST SECTION:
    # Process as user-directed mode
    analyze_user_requirements(user_request)
else:
    # Process as autonomous mode
    enhancement = select_highest_priority_enhancement()
    document_selected_enhancement(enhancement)
```

## Benefits of the Unified Model

1. **Reduced Duplication**: Eliminates need for separate cycle types
2. **Consistent Structure**: All cycles follow the same pattern regardless of operation mode
3. **Flexibility**: Cycles can switch between modes without structural changes
4. **Enhanced Autonomy**: Clear path for autonomous operation when no user input exists
5. **Maintainability**: Centralized management of cycle structure and behavior
6. **Future-Proofing**: Easy to extend with additional capabilities while maintaining backward compatibility

## References

* Cycle Structure: `1000xbrain/system/cycle-manager/knowledge/cycle-structure.md`
* Cycle Standardization Guidelines: `1000xbrain/system/guidelines/cycle-standardization.md` 
* Naming Conventions: `1000xbrain/system/cycle-manager/knowledge/naming-conventions.md` 