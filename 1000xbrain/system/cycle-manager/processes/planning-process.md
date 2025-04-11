# Process: Planning

# Defines the steps for creating an implementation plan based on analyzed requirements.

## Goal: Develop a comprehensive implementation plan for the current cycle.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md`.
    *   Verify that requirement analysis has been completed.
    *   **(Error Handling)**: If requirement analysis is not complete, log error and suggest running requirement analysis.

2.  **Review Requirements**:
    *   Use `read_file` to read `1000xbrain/system/cycle-manager/operational_feedback/change_request.md`.
    *   Extract key information:
        *   Request/enhancement description
        *   Specific requirements
        *   Scope definition
        *   Success criteria
        *   Priority level
        *   Special considerations
    *   **(Error Handling)**: If file doesn't exist or lacks critical information, log error and suggest re-running requirement analysis.

3.  **Determine Operation Context**:
    *   Check the operation mode from current_cycle.md (USER_DIRECTED or AUTONOMOUS).
    *   Adapt planning approach based on the mode:
        *   For USER_DIRECTED: Focus on meeting explicit user requirements
        *   For AUTONOMOUS: Focus on optimal enhancement implementation
    *   **(Error Handling)**: If mode is unclear, default to USER_DIRECTED for safety.

4.  **Analyze Technical Requirements**:
    *   Identify all technical components affected:
        *   Command files
        *   Process files
        *   Knowledge files
        *   Operational feedback structures
        *   Other system components
    *   Identify dependencies between components.
    *   Determine complexity and scope of changes needed.
    *   **(Error Handling)**: If analysis reveals unexpected complexity, document it clearly.

5.  **Develop Implementation Strategy**:
    *   Determine high-level approach:
        *   New component creation
        *   Existing component modification
        *   Component removal
        *   Combination approach
    *   Break down into logical implementation phases.
    *   Create sequence of implementation steps.
    *   Consider testing and verification requirements.
    *   **(Error Handling)**: If strategy development is complex, break into smaller sub-strategies.

6.  **Create Implementation Plan**:
    *   Use `edit_file` to create `1000xbrain/system/cycle-manager/operational_feedback/implementation_plan.md`:
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

        ### Phase 1: [First Major Phase]

        * [Key tasks for this phase]

        ### Phase 2: [Second Major Phase]

        * [Key tasks for this phase]

        [Additional phases as needed]

        ## Detailed Task Breakdown

        ### Phase 1: [First Major Phase]

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

        ## Success Criteria

        * [Measurable criteria derived from change_request.md]

        ## Risk Assessment

        * [Potential risks and mitigation strategies]

        ## Next Steps

        After plan approval, proceed to implementation phase by executing:
        `run command:system/cycle-manager/4`
        ```
    *   **(Error Handling)**: If file creation fails, retry with simplified format.

7.  **Validate Implementation Plan**:
    *   Review the plan for:
        *   Completeness (addresses all requirements)
        *   Feasibility (can be executed with available resources)
        *   Clarity (provides clear guidance for implementation)
        *   Measurability (includes clear success criteria)
    *   Refine as needed.
    *   **(Error Handling)**: If validation reveals gaps, update the plan.

8.  **Update Cycle Status**:
    *   Use `edit_file` to update `1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md`:
        *   Update Status to "Plan Created"
        *   Update Current Phase to indicate planning is complete
        *   Add reference to the implementation plan
    *   **(Error Handling)**: If update fails, log error but proceed.

9.  **Signal Completion**:
    *   Indicate that planning is complete.
    *   Summarize key aspects of the implementation plan.
    *   Note that the next step is to implement the changes using `run command:system/cycle-manager/4`.

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

## Plan Structure Guidelines

The implementation plan should:

1. **Be Comprehensive**:
   * Cover all requirements
   * Include all affected components
   * Address all success criteria

2. **Be Structured**:
   * Organize into logical phases
   * Break down into specific tasks
   * Define clear dependencies

3. **Be Actionable**:
   * Provide specific implementation guidance
   * Define concrete next steps
   * Include enough detail for execution

4. **Be Measurable**:
   * Include clear success criteria
   * Define verification approach
   * Provide basis for validation

## Special Considerations

1. **Scope Management**:
   * Be realistic about implementation scope
   * Consider breaking larger changes into multiple cycles
   * Document scope limitations clearly

2. **Risk Management**:
   * Identify potential risks
   * Provide mitigation strategies
   * Consider contingency approaches

3. **Dependency Management**:
   * Clearly identify dependencies
   * Sequence tasks to respect dependencies
   * Consider external dependencies

4. **Implementation Efficiency**:
   * Optimize for efficient implementation
   * Reuse existing components when possible
   * Consider long-term maintainability

5. **Optimized 1000xplans Usage**:
   * Follow the guidelines in `1000xbrain/system/cycle-manager/knowledge/1000xplans-usage.md`
   * Do not create implementation plans in 1000xplans directory
   * Always store plans in operational_feedback for proper tracking
   * Remember that implementation artifacts belong in operational_feedback, not 1000xplans 