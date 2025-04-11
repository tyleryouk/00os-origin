# Process: Initiation

# Defines the steps for initializing a new cycle-manager cycle.

## Goal: Initialize a new cycle manager cycle and prepare the environment.

## Steps:

1.  **Create Cycle Tracking Information**:
    *   Use `edit_file` to create/update `1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md`:
        ```markdown
        # Current Cycle

        **Cycle ID**: [identifier]
        **Status**: Initialized

        ## Current Phase

        Initialization complete. Ready for requirement analysis.
        ```
    *   **(Error Handling)**: If file creation fails, retry with alternative path or notify of error

2.  **Generate Unique Cycle Identifier**:
    *   Generate a unique ID based on identifier pattern
    *   Update the ID in the current_cycle.md file
    
3.  **Create USER REQUEST SECTION Template**:
    *   Use `read_file` to check if `1000xplans/system/notes.md` exists
    *   If it exists, extract existing USER REQUEST SECTION if present
    *   Use `edit_file` to update or create `1000xplans/system/notes.md` with standardized USER REQUEST SECTION:
        ```markdown
        ## USER REQUEST SECTION

        [Your change request description goes here]

        # Change Request
        [Specific change request]

        # Requirements
        [Detailed requirements]

        # Priority
        [High/Medium/Low]

        # Additional Notes
        [Any additional context or notes]

        ## END USER REQUEST SECTION
        ```
    *   Preserve other sections of the file if they exist
    *   **(Error Handling)**: If template creation fails, provide clear error message

4.  **Establish Operational Feedback Structure**:
    *   Use `edit_file` to create/update `1000xbrain/system/cycle-manager/operational_feedback/potential_enhancements.md`:
        ```markdown
        # Potential Enhancements

        This document tracks potential enhancements for autonomous operation of the cycle-manager.

        ## Enhance Cycle Creation Templates
        **Priority**: Medium
        **Description**: Improve templates used when creating new cycles
        **Impact**: More consistent cycle implementation
        **Implementation Notes**: Update templates in cycle-creation-process.md

        ## Add Cycle Validation Feature
        **Priority**: High
        **Description**: Add functionality to validate cycles against standards
        **Impact**: Ensures all cycles maintain standards compliance
        **Implementation Notes**: Create new process file for validation
        ```
    *   **(Error Handling)**: If file creation fails, retry with alternative approach

5.  **Initialize Working Environment**:
    *   Check for existing directory structure:
        - 1000xcommands/system/cycle-manager/
        - 1000xbrain/system/cycle-manager/knowledge/
        - 1000xbrain/system/cycle-manager/processes/
        - 1000xbrain/system/cycle-manager/operational_feedback/
    *   Create any missing directories
    *   **(Error Handling)**: If directory checking/creation fails, provide clear error

6.  **Check Previous Execution State**:
    *   Check for any incomplete previous cycle execution
    *   If found, document the state for reference
    *   **(Error Handling)**: If state checking fails, proceed with new cycle

7.  **Signal Completion**:
    *   Log successful initialization
    *   Indicate readiness for requirement analysis
    *   Note that the next step is `run command:system/cycle-manager/2`

## Special Considerations

1. **User Request Template Handling**:
   * If a USER REQUEST SECTION already exists in notes.md, preserve any user input
   * If notes.md doesn't exist, create it with the template
   * Always ensure the USER REQUEST SECTION structure is consistent

2. **Cycle Management**:
   * The cycle-manager should track its own cycles like it would for other cycles
   * This creates a self-referential structure that demonstrates best practices

3. **Initialization Scope**:
   * Initialization should focus on preparation, not execution
   * Detailed analysis and planning will occur in subsequent steps

4. **Potential Enhancements**:
   * Always include some initial potential enhancements
   * These enable autonomous operation if no user input is provided 