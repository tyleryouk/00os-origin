# Process: Verification

# Defines the steps for verifying the implemented changes against requirements and success criteria.

## Goal: Verify both guidelines updates and system-wide changes for correctness, completeness, and consistency.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`.
    *   Verify that implementation has been completed.
    *   **(Error Handling)**: If implementation is not complete, log error and suggest running implementation.

2.  **Gather Verification Sources**:
    *   Use `read_file` to read:
        *   `1000xbrain/system/major-changes/operational_feedback/change_request.md` (for requirements and success criteria)
        *   `1000xbrain/system/major-changes/operational_feedback/implementation_plan.md` (for planned tasks)
        *   `1000xbrain/system/major-changes/operational_feedback/implementation_log.md` (for executed tasks)
    *   **(Error Handling)**: If any file doesn't exist, log error and request appropriate file creation.

3.  **Phase 1: Verify Guidelines Updates**:
    *   For each guideline file updated in the implementation:
        *   Read the updated guideline files
        *   Verify that all required changes were implemented correctly
        *   Check for consistency within the guidelines system
        *   Ensure documentation clarity and completeness
        *   Document verification status for each guideline update
    *   **(Error Handling)**: If guideline verification fails, document specific issues for refinement.

4.  **Phase 2: Verify System-Wide Implementation**:
    *   For each system component updated in the implementation:
        *   Read the updated files
        *   Verify that changes are consistent with the updated guidelines
        *   Check for proper functionality and integration
        *   Ensure backward compatibility where required
        *   Document verification status for each system component
    *   **(Error Handling)**: If system verification fails, document specific issues for refinement.

5.  **Verify Requirements and Success Criteria**:
    *   For each requirement and success criterion from the change request:
        *   Check if the implemented changes fulfill the requirement
        *   Determine if success criteria have been met
        *   Document verification status with specific evidence
    *   **(Error Handling)**: If any requirements are not met, document the gaps for refinement.

6.  **Create Verification Report**:
    *   Use `edit_file` to create `1000xbrain/system/major-changes/operational_feedback/verification_report.md`:
        ```markdown
        # Verification Report

        **Plan Reference**: [reference to implementation plan]
        **Mode**: [USER_DIRECTED/AUTONOMOUS]
        **Status**: Verification Completed

        ## Phase 1: Guidelines Updates Verification

        1. **[Guideline 1]**:
           * Status: [Verified/Not Verified]
           * Evidence: [Description of verification evidence]
           * Notes: [Any relevant details]

        2. **[Guideline 2]**:
           * Status: [Verified/Not Verified]
           * Evidence: [Description of verification evidence]
           * Notes: [Any relevant details]

        [Additional guidelines as verified]

        ## Phase 2: System-Wide Implementation Verification

        1. **[System Component 1]**:
           * Status: [Verified/Not Verified]
           * Evidence: [Description of verification evidence]
           * Notes: [Any relevant details]

        2. **[System Component 2]**:
           * Status: [Verified/Not Verified]
           * Evidence: [Description of verification evidence]
           * Notes: [Any relevant details]

        [Additional components as verified]

        ## Requirements Verification

        1. **[Requirement 1]**:
           * Status: [Verified/Not Verified]
           * Evidence: [Description of verification evidence]
           * Notes: [Any relevant details]

        2. **[Requirement 2]**:
           * Status: [Verified/Not Verified]
           * Evidence: [Description of verification evidence]
           * Notes: [Any relevant details]

        [Additional requirements as verified]

        ## Success Criteria Verification

        1. **[Criterion 1]**:
           * Status: [Met/Not Met]
           * Evidence: [Description of verification evidence]
           * Notes: [Any relevant details]

        2. **[Criterion 2]**:
           * Status: [Met/Not Met]
           * Evidence: [Description of verification evidence]
           * Notes: [Any relevant details]

        ## Integration Verification

        * Status: [Passed/Failed]
        * Notes: [Description of integration verification results]

        ## Overall Verification Status

        [PASSED/FAILED]: [Summary of verification results]

        ## Issues Requiring Refinement

        * [Issue 1]: [Description of issue and potential resolution]
        * [Issue 2]: [Description of issue and potential resolution]
        ```
    *   **(Error Handling)**: If file creation fails, retry with simplified format.

7.  **Determine Next Steps**:
    *   Based on verification results:
        *   If any issues were found, mark verification as FAILED and recommend refinement
        *   If all checks pass, mark verification as PASSED and recommend completion
    *   **(Error Handling)**: If determination is unclear, default to recommending refinement.

8.  **Update Cycle Status**:
    *   Use `edit_file` to update `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`:
        *   Update Status to "Verification Completed"
        *   Update Current Phase to indicate verification result (Pass/Fail)
        *   Add reference to the verification report
    *   **(Error Handling)**: If update fails, log error but proceed.

9.  **Signal Completion & Next Steps**:
    *   Indicate that verification is complete.
    *   Clearly state the verification result (PASSED/FAILED).
    *   If issues were found (FAILED), recommend `run command:system/major-changes/6` (refinement).
    *   If no issues were found (PASSED), recommend `run command:system/major-changes/7` (completion).

## Two-Phase Verification Approach

The verification follows a strict two-phase approach to match the implementation strategy:

### Phase 1: Guidelines Updates Verification

* Verify that all required guidelines have been updated correctly
* Check for internal consistency within the guidelines
* Ensure guidelines documentation is clear and complete
* This phase verifies the foundation for all system-wide changes

### Phase 2: System-Wide Implementation Verification

* Verify that all system components have been updated correctly
* Check for consistency with the updated guidelines
* Ensure proper integration between components
* This phase verifies the implementation built on the guidelines foundation

## Verification Strategies

1. **Documentation Verification**:
   * Check for clarity, completeness, and correctness
   * Ensure consistency across documentation
   * Verify that documentation accurately reflects implemented changes

2. **Implementation Verification**:
   * Check that code/files match the intended implementation
   * Verify functionality based on requirements
   * Ensure proper integration between components

3. **Success Criteria Verification**:
   * Map each success criterion to specific verification evidence
   * Provide clear pass/fail assessment for each criterion
   * Document any unexpected results or ambiguities

## Special Considerations

1. **Dependency Chain Verification**:
   * Verify that dependencies between components are respected
   * Check that changes flow correctly from guidelines to dependent systems
   * Ensure no circular dependencies were introduced

2. **Backward Compatibility**:
   * Verify that changes maintain required backward compatibility
   * Check for unintended breaking changes
   * Ensure migration paths work as expected if breaking changes were necessary 