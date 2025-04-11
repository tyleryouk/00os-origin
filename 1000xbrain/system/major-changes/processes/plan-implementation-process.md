# Process: Planning

# Defines the steps for creating an implementation plan based on analyzed requirements.

## Goal: Develop a comprehensive implementation plan for system-wide changes, prioritizing guidelines updates.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`.
    *   Verify that requirement analysis has been completed.
    *   **(Error Handling)**: If requirement analysis is not complete, log error and suggest running requirement analysis.

2.  **Review Requirements**:
    *   Use `read_file` to read `1000xbrain/system/major-changes/operational_feedback/change_request.md`.
    *   Extract key information:
        *   Request/enhancement description
        *   Specific requirements
        *   Scope definition
        *   Success criteria
        *   Priority level
        *   Special considerations
        *   Guidelines impact analysis
    *   **(Error Handling)**: If file doesn't exist or lacks critical information, log error and suggest re-running requirement analysis.

3.  **Determine Operation Context**:
    *   Check the operation mode from current_cycle.md (USER_DIRECTED or AUTONOMOUS).
    *   Adapt planning approach based on the mode:
        *   For USER_DIRECTED: Focus on meeting explicit user requirements
        *   For AUTONOMOUS: Focus on optimal enhancement implementation
    *   **(Error Handling)**: If mode is unclear, default to USER_DIRECTED for safety.

4.  **Analyze Guidelines Impact**:
    *   Identify specific guidelines files that need updates:
        *   Look in `1000xbrain/system/guidelines/`
        *   Identify which guideline files are affected by the requested changes
        *   Determine dependencies between guidelines
    *   Analyze dependencies between guidelines and other systems:
        *   Identify which 1000xsystems are affected by guideline changes
        *   Determine the sequence of updates needed
    *   Develop a guidelines update strategy:
        *   Create plan for updating guidelines first
        *   Create plan for propagating changes to dependent systems
    *   **(Error Handling)**: If guidelines impact analysis is complex, break it into logical phases.

5.  **Analyze System-Wide Technical Requirements**:
    *   Identify all 1000xsystems components affected:
        *   1000xbrain components
        *   1000xcommands components
        *   1000xrules components (excluding .mdc files)
        *   1000xscripts components
        *   Other system components
    *   Identify dependencies between components.
    *   Determine complexity and scope of changes needed.
    *   **(Error Handling)**: If analysis reveals unexpected complexity, document it clearly.

6.  **Develop Two-Phase Implementation Strategy**:
    *   **Phase One: Guidelines Updates**
        *   Determine which guideline files to create/modify
        *   Plan sequence for guideline updates
        *   Develop verification approach for guidelines
    *   **Phase Two: System-Wide Implementation**
        *   Plan changes to other 1000xsystems based on updated guidelines
        *   Determine sequence of system changes
        *   Develop verification approach for system changes
    *   Consider testing and verification requirements for both phases.
    *   **(Error Handling)**: If strategy development is complex, break into smaller sub-strategies.

7.  **Create Implementation Plan**:
    *   Use `edit_file` to create `1000xbrain/system/major-changes/operational_feedback/implementation_plan.md`:
        ```markdown
        # Implementation Plan: [Brief Description]

        **Mode**: [USER_DIRECTED/AUTONOMOUS]
        **Priority**: [from change_request.md]
        **Status**: Planning Phase

        ## Overview

        [Brief description of what will be implemented]

        ## Goal

        [Clear statement of the implementation goal]

        ## Implementation Phases

        ### Phase 1: Guidelines Updates

        * [Key guideline files to update]
        * [Key tasks for guideline updates]

        ### Phase 2: System-Wide Implementation

        * [Key system components to update]
        * [Key tasks for system-wide implementation]

        [Additional phases as needed]

        ## Detailed Task Breakdown

        ### Phase 1: Guidelines Updates

        1. **[Task 1 Title]**:
           * [Subtask details]
           * [Files/components affected]
           * [Implementation approach]

        2. **[Task 2 Title]**:
           * [Subtask details]
           * [Files/components affected]
           * [Implementation approach]

        ### Phase 2: System-Wide Implementation

        1. **[Task 1 Title]**:
           * [Subtask details]
           * [Files/components affected]
           * [Implementation approach]

        2. **[Task 2 Title]**:
           * [Subtask details]
           * [Files/components affected]
           * [Implementation approach]

        [Additional tasks and phases as needed]

        ## Dependencies

        * [List of dependencies between tasks/phases]
        * [Note that Phase 2 is dependent on successful completion of Phase 1]

        ## Success Criteria

        * [Measurable criteria derived from change_request.md]

        ## Risk Assessment

        * [Potential risks and mitigation strategies]

        ## Next Steps

        After plan approval, proceed to implementation phase by executing:
        `run command:system/major-changes/4`
        ```
    *   **(Error Handling)**: If file creation fails, retry with simplified format.

8.  **Validate Implementation Plan**:
    *   Review the plan for:
        *   Completeness (addresses all requirements)
        *   Feasibility (can be executed with available resources)
        *   Clarity (provides clear guidance for implementation)
        *   Measurability (includes clear success criteria)
        *   Phasing (properly separates guidelines updates from system-wide changes)
    *   Refine as needed.
    *   **(Error Handling)**: If validation reveals gaps, update the plan.

9.  **Update Cycle Status**:
    *   Use `edit_file` to update `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`:
        *   Update Status to "Plan Created"
        *   Update Current Phase to indicate planning is complete
        *   Add reference to the implementation plan
    *   **(Error Handling)**: If update fails, log error but proceed.

10. **Signal Completion**:
    *   Indicate that planning is complete.
    *   Summarize key aspects of the implementation plan.
    *   Note that the next step is to implement the changes using `run command:system/major-changes/4`.

## Two-Phase Implementation Strategy

The major-changes cycle uses a two-phase implementation strategy to ensure consistency and backward compatibility:

### Phase 1: Guidelines Updates

Guidelines updates must be implemented first because:
1. Guidelines serve as the authoritative documentation for system behavior
2. Other systems depend on guidelines for their functionality
3. Updates to guidelines provide a record of what changed and why
4. This approach ensures consistency across all systems

This phase focuses on updating all affected guideline files in `1000xbrain/system/guidelines/`.

### Phase 2: System-Wide Implementation

Once guidelines have been updated, changes can be propagated to other systems:
1. Changes to the various 1000xsystems based on the updated guidelines
2. Update of dependent components to maintain consistency
3. Documentation updates to reflect the changes
4. Verification to ensure all systems work together properly

This phase implements changes across multiple 1000xsystems in the correct dependency order.

## Planning Approaches by Mode

### USER_DIRECTED Mode Planning

* Focus on explicit user requirements
* Prioritize requirements based on user-specified priority
* Include all requested components
* Consider user-specified success criteria

### AUTONOMOUS Mode Planning

* Focus on optimal enhancement implementation
* Prioritize based on system impact and efficiency
* Consider broader system improvement
* Define comprehensive success criteria

## Special Considerations for Guidelines Planning

1. **Documentation Clarity**:
   * Guidelines must be clear and unambiguous
   * Updates should maintain consistency with existing documentation
   * Changes should be clearly marked and explained

2. **Backward Compatibility**:
   * Consider backward compatibility requirements
   * Document migration paths if breaking changes are unavoidable
   * Ensure systems can adapt to guideline changes

3. **Testing Strategy**:
   * Define testing strategy for updated guidelines
   * Include verification steps for guideline correctness
   * Include validation steps for system compatibility 