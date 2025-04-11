# Process: Unified Execution Process

# Defines the standard process for handling both autonomous and user-directed modes within a cycle.

## Goal: Ensure consistent execution logic for cycles regardless of operation mode.

## Steps:

1.  **Check Operation Mode**:
    *   Use `read_file` to read the current cycle file:
        ```
        read_file("1000xbrain/<domain>/<cycle-name>/operational_feedback/current_cycle.md", should_read_entire_file=true)
        ```
    *   Check if the USER REQUEST SECTION contains valid user input beyond template/placeholders
    *   Determine which mode to operate in:
        ```
        if (contains_valid_user_input(user_request_section)) {
            operation_mode = "USER_DIRECTED";
        } else {
            operation_mode = "AUTONOMOUS";
        }
        ```
    *   **(Error Handling)**: If the file doesn't exist or is improperly formatted, create a proper cycle file with empty USER REQUEST SECTION and default to autonomous mode.

2.  **Process User-Directed Operation** (if applicable):
    *   If operation_mode is USER_DIRECTED:
        *   Parse the user request into structured requirements
        *   Extract key components: change request, requirements, priority, notes
        *   Document the parsed requirements in `change_request.md`:
            ```
            edit_file("1000xbrain/<domain>/<cycle-name>/operational_feedback/change_request.md", "Document user request", "...")
            ```
        *   Update the current cycle status to indicate user-directed operation:
            ```
            edit_file("1000xbrain/<domain>/<cycle-name>/operational_feedback/current_cycle.md", "Update operation mode", "...")
            ```
    *   **(Error Handling)**: If user input parsing fails, document the issue and request clarification.

3.  **Process Autonomous Operation** (if applicable):
    *   If operation_mode is AUTONOMOUS:
        *   Check for potential enhancements:
            ```
            read_file("1000xbrain/<domain>/<cycle-name>/operational_feedback/potential_enhancements.md", should_read_entire_file=true)
            ```
        *   If enhancements exist:
            *   Select the highest priority enhancement based on criteria
            *   Update its status to "Selected"
            *   Document it as the current requirement:
                ```
                edit_file("1000xbrain/<domain>/<cycle-name>/operational_feedback/change_request.md", "Document selected enhancement", "...")
                ```
            *   Update the current cycle status to indicate autonomous operation:
                ```
                edit_file("1000xbrain/<domain>/<cycle-name>/operational_feedback/current_cycle.md", "Update operation mode", "...")
                ```
        *   If no enhancements exist:
            *   Create a basic scan enhancement that reviews the system for potential improvements
            *   Document this as the current cycle's focus
    *   **(Error Handling)**: If no enhancements can be processed, document the issue and signal completion.

4.  **Unify Execution Path**:
    *   At this point, regardless of source (user or autonomous), a change_request.md exists
    *   The rest of the cycle can proceed with a single unified execution path
    *   Use the same planning approach for both modes
    *   Use the same implementation, verification, and refinement processes
    *   Tailor the actual operations to the specific requirements, not the source

5.  **Plan Implementation**:
    *   Create an implementation plan based on the requirements (regardless of source):
        ```
        edit_file("1000xbrain/<domain>/<cycle-name>/operational_feedback/implementation_plan.md", "Create implementation plan", "...")
        ```
    *   Structure the implementation plan with phases, tasks, dependencies, and success criteria
    *   Ensure the plan addresses all requirements documented in change_request.md
    *   **(Error Handling)**: If planning cannot proceed, document the issues and signal for refinement.

6.  **Execute Implementation**:
    *   Proceed with implementation according to the plan:
        *   Create/modify files as required
        *   Execute necessary commands
        *   Log implementation progress
    *   Document all changes made:
        ```
        edit_file("1000xbrain/<domain>/<cycle-name>/operational_feedback/implementation_log.md", "Document implementation", "...")
        ```
    *   **(Error Handling)**: Handle and document any errors during implementation.

7.  **Verify Implementation**:
    *   Verify that implementation meets the requirements (regardless of source):
        *   Compare against success criteria
        *   Check file integrity
        *   Document verification results:
            ```
            edit_file("1000xbrain/<domain>/<cycle-name>/operational_feedback/verification_report.md", "Document verification", "...")
            ```
    *   **(Error Handling)**: If verification fails, document issues for refinement.

8.  **Refine If Needed**:
    *   If verification identified issues:
        *   Address the issues through refinement
        *   Re-verify after refinement
        *   Update the implementation log and verification report
    *   **(Error Handling)**: If refinement cannot resolve issues, document limitations.

9.  **Complete Cycle**:
    *   Update cycle status to mark completion:
        ```
        edit_file("1000xbrain/<domain>/<cycle-name>/operational_feedback/current_cycle.md", "Mark cycle as complete", "...")
        ```
    *   If user-directed, summarize changes made to fulfill the request
    *   If autonomous, update the enhancement status to "Completed"
    *   Document potential future enhancements for subsequent autonomous operations:
        ```
        edit_file("1000xbrain/<domain>/<cycle-name>/operational_feedback/potential_enhancements.md", "Update enhancements", "...")
        ```
    *   **(Error Handling)**: Ensure consistent completion state even if previous steps had issues.

10. **Signal Completion & Next Steps**:
    *   Indicate that the unified execution process is complete.
    *   Provide recommendations for next steps.
    *   If more cycles are needed, suggest the appropriate cycle to run next.

## Mode-Specific Templates

### User-Directed: change_request.md Template:

```markdown
# Change Request Details

**Date Requested**: [current-date]
**Requestor**: Tyler Youk
**Status**: Analysis Completed

## Request Description

[User request description]

## Requirements

[Extracted/analyzed requirements]

## Scope

[Defined scope]

## Success Criteria

[Defined success criteria]

## Special Considerations

[Any special notes or considerations]
```

### Autonomous: change_request.md Template:

```markdown
# Enhancement Implementation Details

**Date Selected**: [current-date]
**Enhancement**: [Enhancement title]
**Status**: Analysis Completed

## Enhancement Description

[Description from potential_enhancements.md]

## Implementation Requirements

[Extracted/analyzed requirements]

## Scope

[Defined scope]

## Success Criteria

[Defined success criteria]

## Special Considerations

[Any special notes or considerations]
```

### potential_enhancements.md Template:

```markdown
# Potential Enhancements

## [Enhancement Title 1]

* **Priority**: [High/Medium/Low]
* **Complexity**: [High/Medium/Low]
* **Dependencies**: [List of dependencies, if any]
* **Description**: [Detailed description]
* **Implementation Notes**: [Key implementation details]
* **Success Criteria**: [Verification criteria]
* **Status**: [Pending/Selected/Completed/Deferred]
* **Date Added**: [YYYY-MM-DD]

## [Enhancement Title 2]

* [Details as above]
```

## Integration with Command Sequence

This unified execution process should be referenced from multiple command steps:
* Primary integration in command 2 (Requirement Analysis)
* Partial reference in commands 3-7 to ensure consistent handling
* Complete reference in command 1 for initialization of USER REQUEST SECTION
