# Process: Cycle Creation

# Defines the steps for creating a new standardized cycle in any domain.

## Goal: Create a fully-functional, standards-compliant cycle with all required components.

## Steps:

1.  **Validate Inputs**:
    *   Validate that the target domain is valid (system, front-end, back-end)
    *   Validate that the cycle name follows naming conventions (kebab-case)
    *   Validate that the cycle doesn't already exist
    *   **(Error Handling)**: If validation fails, provide clear error message and stop

2.  **Create Directory Structure**:
    *   Create commands directory structure:
        ```
        mkdir -p 1000xcommands/[domain]/[cycle-name]
        ```
    *   Create brain directory structure:
        ```
        mkdir -p 1000xbrain/[domain]/[cycle-name]/knowledge
        mkdir -p 1000xbrain/[domain]/[cycle-name]/processes
        mkdir -p 1000xbrain/[domain]/[cycle-name]/operational_feedback
        ```
    *   **(Error Handling)**: If any directory creation fails, revert changes and stop

3.  **Create Command Files**:
    *   Create command files 1.md through 7.md in 1000xcommands/[domain]/[cycle-name]/
    *   Create README.md with cycle documentation
    *   Each command file should follow the standard template with:
        - Correct title
        - Reference to corresponding process file
        - Appropriate description
        - Next step information
    *   **(Error Handling)**: If any file creation fails, revert changes and stop

4.  **Create Process Files**:
    *   Create standard process files in 1000xbrain/[domain]/[cycle-name]/processes/:
        - initiation-process.md
        - requirement-analysis-process.md
        - planning-process.md
        - implementation-process.md
        - verification-process.md
        - refinement-process.md
        - completion-process.md
        - Any additional specialized process files required
    *   **(Error Handling)**: If any file creation fails, revert changes and stop

5.  **Create Knowledge Files**:
    *   Create baseline knowledge files in 1000xbrain/[domain]/[cycle-name]/knowledge/
    *   For domain-specific cycles, create specialized knowledge files
    *   **(Error Handling)**: If any file creation fails, revert changes and stop

6.  **Create Operational Feedback Structure**:
    *   Create operational feedback templates in 1000xbrain/[domain]/[cycle-name]/operational_feedback/:
        - current_cycle.md
        - potential_enhancements.md
        - Other relevant tracking files
    *   **(Error Handling)**: If any file creation fails, revert changes and stop

7.  **Update Command Index**:
    *   Update the appropriate command index to include the new cycle
    *   **(Error Handling)**: If index update fails, log error but continue

8.  **Validate Cycle Structure**:
    *   Verify that all required files have been created
    *   Verify that files follow the standardized formats
    *   Verify that the cycle is ready for use
    *   **(Error Handling)**: If validation fails, log issues but continue

9.  **Document Creation**:
    *   Log the creation of the new cycle
    *   Document any customizations or special considerations
    *   Provide usage instructions

## Detailed File Templates

### Command File Templates

#### 1.md (Initiation)
```markdown
# Cycle Initiation | Part 1

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/[domain]/[cycle-name]/processes/initiation-process.md
# --- END DYNAMIC EXECUTION ---

# This command initializes a new [cycle-name] cycle and prepares the environment.

# Next Step: Invoke `run command:[domain]/[cycle-name]/2`
# (Actual invocation requires external orchestration - will be handled by Tyler) 
```

#### 2.md (Requirement Analysis)
```markdown
# Requirement Analysis | Part 2

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/[domain]/[cycle-name]/processes/requirement-analysis-process.md
# --- END DYNAMIC EXECUTION ---

# This command analyzes requirements and determines the execution mode.

# Next Step: Invoke `run command:[domain]/[cycle-name]/3`
# (Actual invocation requires external orchestration - will be handled by Tyler) 
```

[Templates for 3.md through 7.md follow the same pattern]

### Process File Templates

#### initiation-process.md
```markdown
# Process: Initiation

# Defines the steps for initializing a new [cycle-name] cycle.

## Goal: Initialize a new cycle and prepare the environment.

## Steps:

1.  **Create Cycle Tracking Information**:
    *   [Implementation details]
    *   **(Error Handling)**: [Error handling approach]

2.  **Generate Unique Cycle Identifier**:
    *   [Implementation details]
    
3.  **Create USER REQUEST SECTION Template**:
    *   [Implementation details]

4.  **Establish Operational Feedback Structure**:
    *   [Implementation details]

5.  **Prepare Execution Environment**:
    *   [Implementation details]

6.  **Signal Completion**:
    *   [Implementation details]
```

[Templates for other process files follow a similar pattern]

### Operational Feedback Templates

#### current_cycle.md
```markdown
# Current [Cycle-Name] Cycle

**Cycle ID**: [ID]
**Status**: Initialized
**Date Started**: [current-date]

## Current Phase

Initialization complete. Ready for requirement analysis.
```

#### potential_enhancements.md
```markdown
# Potential Enhancements

This document tracks potential enhancements for autonomous operation of the [cycle-name] cycle.

## [Enhancement Title 1]
**Priority**: [High/Medium/Low]
**Description**: [Detailed description]
**Impact**: [Expected impact]
**Implementation Notes**: [Implementation considerations]

## [Enhancement Title 2]
**Priority**: [High/Medium/Low]
**Description**: [Detailed description]
**Impact**: [Expected impact]
**Implementation Notes**: [Implementation considerations]
```

## Special Considerations

1. **Domain-Specific Customization**:
   * System domain cycles may need additional security considerations
   * Front-end domain cycles may need UI component knowledge
   * Back-end domain cycles may need API or database knowledge

2. **Purpose-Specific Templates**:
   * Cycles for different purposes may need specialized templates
   * Templates should be adjusted based on the specific cycle purpose

3. **Unified Model Implementation**:
   * All created cycles must implement the unified model
   * Process files should include logic for both autonomous and user-directed operation 