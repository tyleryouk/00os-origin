# Process: Refinement

# Defines the steps for refining implemented changes to address issues identified during verification.

## Goal: Address verification issues using a two-phase approach that maintains consistency between guidelines and system-wide changes.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`.
    *   Verify that verification has been completed and identified issues.
    *   **(Error Handling)**: If verification hasn't been completed or no issues were found, log status and suggest appropriate next step.

2.  **Analyze Verification Report**:
    *   Use `read_file` to read `1000xbrain/system/major-changes/operational_feedback/verification_report.md`.
    *   Extract the issues requiring refinement.
    *   Categorize issues into:
        *   Guidelines-related issues (Phase 1)
        *   System-wide implementation issues (Phase 2)
        *   Integration issues (cross-cutting)
    *   Prioritize issues based on severity, dependencies, and phase.
    *   **(Error Handling)**: If report doesn't exist or lacks sufficient information, log error and suggest re-verification.

3.  **Phase 1: Refine Guidelines Updates**:
    *   For each guidelines-related issue:
        *   Read the affected guideline files
        *   Implement necessary corrections or enhancements
        *   Document the changes made
    *   Verify that guideline refinements maintain internal consistency
    *   **(Error Handling)**: If guidelines refinements introduce new inconsistencies, resolve before proceeding.

4.  **Phase 2: Refine System-Wide Implementation**:
    *   For each system implementation issue:
        *   Read the affected system files
        *   Implement necessary corrections based on the refined guidelines
        *   Document the changes made
    *   Verify that system refinements are consistent with the updated guidelines
    *   **(Error Handling)**: Handle errors for each component independently to prevent cascading failures.

5.  **Address Integration Issues**:
    *   For issues that span guidelines and system components:
        *   Implement coordinated changes that maintain consistency
        *   Ensure proper dependency management during refinements
        *   Verify cross-component functionality
    *   **(Error Handling)**: If integration issues persist, document for additional refinement cycle.

6.  **Create Refinement Log**:
    *   Use `edit_file` to create `1000xbrain/system/major-changes/operational_feedback/refinement_log.md`:
        ```markdown
        # Refinement Log

        **Plan Reference**: [reference to implementation plan]
        **Mode**: [USER_DIRECTED/AUTONOMOUS]
        **Status**: Refinement Completed

        ## Phase 1: Guidelines Refinements

        1. **[Issue 1]**:
           * Original Issue: [Description from verification report]
           * Resolution: [Description of fix implemented]
           * Files Modified:
             * [file path 1]
             * [file path 2]
           * Status: [Resolved/Partially Resolved]

        2. **[Issue 2]**:
           * Original Issue: [Description from verification report]
           * Resolution: [Description of fix implemented]
           * Files Modified:
             * [file path]
           * Status: [Resolved/Partially Resolved]

        ## Phase 2: System-Wide Refinements

        1. **[Issue 3]**:
           * Original Issue: [Description from verification report]
           * Resolution: [Description of fix implemented]
           * Files Modified:
             * [file path 1]
             * [file path 2]
           * Status: [Resolved/Partially Resolved]

        2. **[Issue 4]**:
           * Original Issue: [Description from verification report]
           * Resolution: [Description of fix implemented]
           * Files Modified:
             * [file path]
           * Status: [Resolved/Partially Resolved]

        ## Integration Refinements

        1. **[Issue 5]**:
           * Original Issue: [Description from verification report]
           * Resolution: [Description of fix implemented]
           * Files Modified:
             * [file path 1 (guideline)]
             * [file path 2 (system component)]
           * Status: [Resolved/Partially Resolved]

        ## Remaining Issues

        * [Issue X]: [Description of any unresolved issues]
        * [Issue Y]: [Description of any unresolved issues]

        ## Overall Refinement Status

        [Complete/Partial]: [Summary of refinement results]
        ```
    *   **(Error Handling)**: If file creation fails, retry with simplified format.

7.  **Update Cycle Status**:
    *   Use `edit_file` to update `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`:
        *   Update Status to "Refinement Completed"
        *   Update Current Phase to indicate refinement completion
        *   Add reference to the refinement log
    *   **(Error Handling)**: If update fails, log error but proceed.

8.  **Determine Next Steps**:
    *   Evaluate the refinement outcome:
        *   If all issues were successfully addressed:
            *   Recommend proceeding to `run command:system/major-changes/7` (completion).
        *   If substantial changes were made or some issues remain unresolved:
            *   Recommend re-verification with `run command:system/major-changes/5`.
    *   Provide clear guidance on the recommended next step based on the refinement outcome.

9.  **Signal Completion**:
    *   Indicate that refinement is complete.
    *   Summarize key refinements made.
    *   Provide clear recommendation for next step (verification or completion).

## Two-Phase Refinement Approach

The refinement follows a structured two-phase approach to maintain consistency with the implementation strategy:

### Phase 1: Guidelines Refinements

* Address issues in guidelines files first
* Ensure guidelines remain internally consistent
* Maintain the guidelines as the authoritative source of truth
* This phase ensures the foundation is solid before refining dependent systems

### Phase 2: System-Wide Refinements

* Address issues in system components based on the refined guidelines
* Ensure system components remain consistent with guidelines
* Maintain proper dependencies between components
* This phase builds on the refined guidelines foundation

## Refinement Strategies

1. **Prioritized Refinement**:
   * Address critical issues first
   * Ensure core functionality before addressing edge cases
   * Maintain the integrity of the two-phase approach

2. **Incremental Refinement**:
   * Make targeted changes for each issue
   * Verify each refinement before proceeding to the next
   * Document all refinements precisely

3. **Integrated Refinement**:
   * Ensure coordinated changes across guidelines and systems
   * Maintain proper dependency management
   * Verify cross-component functionality after refinements

## Special Considerations

1. **Documentation Updates**:
   * Update documentation to reflect refinements
   * Ensure consistency between refined guidelines and documentation
   * Document any deviations from the original plan

2. **Regression Prevention**:
   * Ensure refinements don't introduce new issues
   * Verify that fixed issues remain fixed
   * Consider broader impact of each refinement 