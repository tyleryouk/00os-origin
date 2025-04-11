# Process: Refinement

# Defines the steps for refining cycle implementations to address verification issues.

## Goal: Address issues identified during verification to ensure cycles meet all requirements and standards.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md`.
    *   Verify that verification has been completed and identified issues.
    *   **(Error Handling)**: If verification hasn't been completed or no issues were found, log status and suggest appropriate next step.

2.  **Analyze Verification Report**:
    *   Use `read_file` to read `1000xbrain/system/cycle-manager/operational_feedback/verification_report.md`.
    *   Extract the issues requiring refinement.
    *   Prioritize issues based on severity and dependencies.
    *   **(Error Handling)**: If report doesn't exist or lacks issues section, log error and stop.

3.  **Group Issues by Type**:
    *   Categorize issues:
        *   Structure Issues (missing files, incorrect structure)
        *   Content Issues (incorrect format, missing sections)
        *   Functional Issues (requirements not met)
        *   Unified Model Issues (mode handling, enhancement documentation)
        *   Documentation Issues (incomplete, unclear documentation)
    *   Identify common patterns or root causes.
    *   Determine refinement approach for each category.

4.  **Develop Refinement Plan**:
    *   Create a structured plan for addressing all issues:
        *   Prioritize critical issues first
        *   Address structural issues before content issues
        *   Define specific actions for each issue
        *   Identify files to modify
    *   **(Error Handling)**: If planning cannot proceed, document challenges and request clarification.

5.  **Address Structure Issues**:
    *   Fix issues with directory structure or missing files:
        *   Create missing command files
        *   Create missing process files
        *   Create missing knowledge files
        *   Ensure proper structure in all components
    *   **(Error Handling)**: If file creation fails, document errors and try alternative approaches.

6.  **Address Content Issues**:
    *   Fix issues with file content:
        *   Update command files to follow correct format
        *   Enhance process files with missing sections
        *   Improve knowledge file organization
        *   Fix documentation issues
    *   **(Error Handling)**: Handle each file independently to prevent cascading failures.

7.  **Address Functional Issues**:
    *   Fix issues with functionality:
        *   Implement missing requirements
        *   Correct implementation errors
        *   Enhance existing implementations
        *   Ensure all success criteria are met
    *   **(Error Handling)**: If implementation is complex, break down into smaller steps.

8.  **Address Unified Model Issues**:
    *   Fix issues with unified model implementation:
        *   Enhance mode detection
        *   Improve handling of both operation modes
        *   Enhance enhancement documentation capabilities
        *   Ensure seamless mode transitions
    *   **(Error Handling)**: This is a critical area - ensure proper implementation.

9.  **Create Refinement Log**:
    *   Use `edit_file` to create/update `1000xbrain/system/cycle-manager/operational_feedback/refinement_log.md`:
        ```markdown
        # Refinement Log

        **Date**: [current-date]
        **Verification Report**: [reference to verification_report.md]

        ## Refinement Actions

        ### Structure Refinements

        1. **[Issue Description]**:
           * Action Taken: [Description of refinement]
           * Files Modified: [List of files]
           * Status: [Resolved/Partially Resolved]
           * Notes: [Any relevant notes]

        ### Content Refinements

        1. **[Issue Description]**:
           * Action Taken: [Description of refinement]
           * Files Modified: [List of files]
           * Status: [Resolved/Partially Resolved]
           * Notes: [Any relevant notes]

        ### Functional Refinements

        1. **[Issue Description]**:
           * Action Taken: [Description of refinement]
           * Files Modified: [List of files]
           * Status: [Resolved/Partially Resolved]
           * Notes: [Any relevant notes]

        ### Unified Model Refinements

        1. **[Issue Description]**:
           * Action Taken: [Description of refinement]
           * Files Modified: [List of files]
           * Status: [Resolved/Partially Resolved]
           * Notes: [Any relevant notes]

        ### Documentation Refinements

        1. **[Issue Description]**:
           * Action Taken: [Description of refinement]
           * Files Modified: [List of files]
           * Status: [Resolved/Partially Resolved]
           * Notes: [Any relevant notes]

        ## Remaining Issues

        * **[Issue 1]**: [Reason unresolved and recommendation]
        * **[Issue 2]**: [Reason unresolved and recommendation]

        ## Overall Refinement Status

        [SUCCESSFUL/PARTIALLY SUCCESSFUL]: [Summary of refinement results]

        ## Next Steps

        [Recommendation for re-verification or completion]
        ```

10. **Update Cycle Status**:
    *   Use `edit_file` to update `1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md`:
        *   Update Status to "Refinement Completed"
        *   Update Current Phase to indicate refinement is complete
        *   Add reference to the refinement log
        *   Indicate next steps (re-verification or completion)

11. **Signal Completion**:
    *   Indicate that refinement is complete.
    *   Summarize refinement results.
    *   If all issues were addressed, recommend re-verification using `run command:system/cycle-manager/5`.
    *   If some issues could not be resolved, document limitations and recommend completion using `run command:system/cycle-manager/7`.

## Refinement Strategies

### Structure Refinement

* Focus on creating missing files
* Ensure proper directory structure
* Follow standard templates
* Verify file naming conventions

### Content Refinement

* Update file content to follow standard formats
* Add missing sections
* Improve organization
* Enhance clarity

### Functional Refinement

* Implement missing requirements
* Fix implementation errors
* Enhance existing implementations
* Test functionality after refinement

### Unified Model Refinement

* Ensure proper mode detection
* Verify handling of both operation modes
* Enhance enhancement documentation
* Fix any mode-specific issues

### Documentation Refinement

* Improve documentation clarity
* Add missing information
* Fix documentation errors
* Ensure documentation is up-to-date

## Special Considerations

1. **Prioritization**:
   * Address critical issues first
   * Focus on issues that affect usability
   * Consider dependencies between issues

2. **Incremental Refinement**:
   * Refine in small, manageable steps
   * Test each refinement before proceeding
   * Document progress throughout

3. **Standards Alignment**:
   * Ensure all refinements maintain standards compliance
   * Consider whether standards need updating

4. **Feedback Loop**:
   * If refinement is extensive, consider re-verification
   * For minor refinements, proceed to completion 