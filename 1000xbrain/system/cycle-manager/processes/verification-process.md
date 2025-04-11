# Process: Verification

# Defines the steps for verifying that cycle implementations meet requirements and standards.

## Goal: Ensure that cycles and cycle-related components meet all requirements and adhere to standards.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md`.
    *   Verify that implementation has been completed.
    *   **(Error Handling)**: If implementation is not complete, log error and suggest running implementation.

2.  **Gather Verification Sources**:
    *   Use `read_file` to read:
        *   `1000xbrain/system/cycle-manager/operational_feedback/change_request.md` (if exists)
        *   `1000xbrain/system/cycle-manager/operational_feedback/implementation_plan.md` (if exists)
        *   `1000xbrain/system/cycle-manager/operational_feedback/implementation_log.md` (if exists)
        *   `1000xbrain/system/guidelines/cycle-standardization.md`
    *   **(Error Handling)**: If any critical file doesn't exist, log error and request appropriate file creation.

3.  **Define Verification Criteria**:
    *   Based on gathered sources, define specific verification criteria:
        *   Structure compliance
        *   Content standards
        *   Functionality requirements
        *   Success criteria from change request/implementation plan

4.  **Verify Structure Compliance**:
    *   Check that the cycle follows the standard structure:
        *   7 sequential commands (1.md through 7.md)
        *   README.md with appropriate documentation
        *   Proper directory structure
        *   Appropriate process files
    *   Document any structural issues

5.  **Verify Content Standards**:
    *   Check that files follow content standards:
        *   Command files use correct format
        *   Process files include appropriate sections
        *   Knowledge files are well-structured
        *   Documentation is comprehensive
    *   Document any content issues

6.  **Verify Unified Model Implementation**:
    *   Check that the cycle correctly implements the unified model:
        *   Mode detection in requirement analysis
        *   Handling for both autonomous and user-directed operation
        *   Enhancement documentation capabilities
    *   Document any implementation issues

7.  **Verify Functional Requirements**:
    *   For each specific requirement from the change request:
        *   Check that it has been implemented correctly
        *   Verify that success criteria are met
        *   Document verification status (verified/not verified)
    *   Document any unmet requirements

8.  **Create Verification Report**:
    *   Use `edit_file` to create/update `1000xbrain/system/cycle-manager/operational_feedback/verification_report.md`:
        ```markdown
        # Verification Report

        **Date**: [current-date]
        **Change Request**: [reference to change_request.md]
        **Implementation Plan**: [reference to implementation_plan.md]
        **Implementation Log**: [reference to implementation_log.md]

        ## Verification Status Summary

        [SUCCESSFUL/PARTIALLY SUCCESSFUL/FAILED]: [Brief summary]

        ## Requirements Verification

        1. **[Requirement 1]**:
           * Status: [Verified/Not Verified]
           * Evidence: [Specific evidence]
           * Notes: [Any relevant notes]

        [Additional requirements as verified]

        ## Structure Verification

        1. **Command Files**:
           * Status: [Verified/Not Verified]
           * Evidence: [Specific evidence]
           * Notes: [Any relevant notes]

        2. **Process Files**:
           * Status: [Verified/Not Verified]
           * Evidence: [Specific evidence]
           * Notes: [Any relevant notes]

        3. **Knowledge Files**:
           * Status: [Verified/Not Verified]
           * Evidence: [Specific evidence]
           * Notes: [Any relevant notes]

        4. **Operational Feedback**:
           * Status: [Verified/Not Verified]
           * Evidence: [Specific evidence]
           * Notes: [Any relevant notes]

        ## Unified Model Verification

        * **Mode Detection**:
          * Status: [Verified/Not Verified]
          * Evidence: [Specific evidence]
          * Notes: [Any relevant notes]

        * **Autonomous Operation**:
          * Status: [Verified/Not Verified]
          * Evidence: [Specific evidence]
          * Notes: [Any relevant notes]

        * **User-Directed Operation**:
          * Status: [Verified/Not Verified]
          * Evidence: [Specific evidence]
          * Notes: [Any relevant notes]

        ## Issues Requiring Refinement

        1. **[Issue 1]**: [Description and potential fix]
        2. **[Issue 2]**: [Description and potential fix]

        [Additional issues as identified]

        ## Overall Verification Status

        [SUCCESSFUL/PARTIALLY SUCCESSFUL/FAILED]: [Detailed conclusion]

        ## Next Steps

        [Recommendations for next steps - refinement or completion]
        ```

9.  **Update Cycle Status**:
    *   Use `edit_file` to update `1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md`:
        *   Update Status to "Verification Completed"
        *   Update Current Phase to indicate verification is complete
        *   Add reference to the verification report
        *   Indicate next steps (refinement or completion)

10. **Signal Completion**:
    *   Indicate that verification is complete.
    *   Summarize verification results.
    *   If issues were found, recommend refinement using `run command:system/cycle-manager/6`.
    *   If no issues were found, recommend completion using `run command:system/cycle-manager/7`.

## Verification Standards Reference

### Command File Standards

* Files named 1.md through 7.md
* Each file includes:
  * Clear title
  * Appropriate process reference
  * Next step information
  * Dynamic execution markers

### Process File Standards

* Clear goal statement
* Well-defined steps
* Error handling for each step
* Appropriate templates
* Complete implementation

### Knowledge File Standards

* Clear organization
* Comprehensive content
* Cross-referencing
* Up-to-date information

### Unified Model Standards

* USER REQUEST SECTION template
* Mode detection logic
* Equivalent execution paths
* Enhancement documentation

## Special Considerations

1. **Self-Verification**:
   * When verifying the cycle-manager itself, apply extra scrutiny
   * The cycle-manager should exemplify best practices

2. **Critical Versus Non-Critical Issues**:
   * Distinguish between critical issues (requiring immediate refinement)
   * And non-critical issues (can be addressed in future cycles)

3. **Documentation Quality**:
   * Pay special attention to documentation quality
   * Clear documentation is essential for cycle management

4. **Standards Evolution**:
   * Consider whether standards themselves need updating
   * Recommend standards improvements when appropriate 