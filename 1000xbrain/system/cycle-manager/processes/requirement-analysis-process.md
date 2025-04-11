# Process: Requirement Analysis

# Defines the steps for analyzing requirements and determining the execution mode.

## Goal: Analyze user input or potential enhancements to determine execution mode and requirements.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md`.
    *   Verify that initialization has been completed.
    *   **(Error Handling)**: If initialization is not complete, log error and suggest running initialization.

2.  **Check for User Input**:
    *   Use `read_file` to read `1000xplans/system/notes.md`.
    *   Extract the content from the USER REQUEST SECTION.
    *   Determine if the section contains valid user input (beyond templated placeholders).
    *   **NEW**: Parse `# Directive:` and `# Target Cycle:` lines if present.
    *   **(Error Handling)**: If the file doesn't exist or the section is missing, log error and suggest creating it.

3.  **Determine Operation Mode**:
    *   Based on user input check:
        *   If valid user input exists, set mode to USER_DIRECTED.
        *   If no valid user input (empty or just template), set mode to AUTONOMOUS.
    *   Update current cycle with the determined mode:
        ```
        edit_file("1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md", "Update operation mode", "...")
        ```
    *   **(Error Handling)**: Document mode determination process.

4.  **Process User-Directed Mode** (if applicable):
    *   If mode is USER_DIRECTED:
        *   Parse the user request into structured components:
            *   **NEW**: Directive (if parsed)
            *   **NEW**: Target Cycle (if parsed)
            *   Change request description
            *   Requirements
            *   Priority
            *   Additional notes
        *   Create a requirements document (`change_request.md`):
            ```
            edit_file("1000xbrain/system/cycle-manager/operational_feedback/change_request.md", "Document user request including directives", "...")
            ```
        *   Use this updated template:
            ```markdown
            # Change Request Details

            **Date Requested**: [current-date]
            **Requestor**: Tyler Youk
            **Status**: Analysis Pending
            **Directive**: [Parsed Directive or N/A]
            **Target Cycle**: [Parsed Target Cycle or N/A]
            **Priority**: [from user input]

            ## Request Description

            [User request description]

            ## Requirements

            [Extracted/analyzed requirements]

            ## Scope

            [Defined scope based on analysis]

            ## Success Criteria

            [Defined success criteria based on requirements]

            ## Special Considerations

            [Any special notes or considerations]
            ```
    *   **(Error Handling)**: If user input is ambiguous, document uncertainties and assumptions. If directives are missing, mark as N/A.

5.  **Process Autonomous Mode** (if applicable):
    *   If mode is AUTONOMOUS:
        *   Use `read_file` to check `1000xbrain/system/cycle-manager/operational_feedback/potential_enhancements.md`.
        *   If the file exists:
            *   Select the highest priority enhancement based on:
                *   Priority rating
                *   Complexity
                *   Dependencies
            *   Create an enhancement implementation document:
                ```
                edit_file("1000xbrain/system/cycle-manager/operational_feedback/change_request.md", "Document selected enhancement", "...")
                ```
            *   Use this template:
                ```markdown
                # Enhancement Implementation Details

                **Date Selected**: [current-date]
                **Enhancement**: [Enhancement title]
                **Status**: Analysis Completed
                **Priority**: [from enhancement]

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
        *   If the file doesn't exist or no suitable enhancements are found:
            *   Create a basic system scan enhancement:
                ```
                edit_file("1000xbrain/system/cycle-manager/operational_feedback/change_request.md", "Create basic system scan", "...")
                ```
            *   Use a template for a system scan enhancement
    *   **(Error Handling)**: If enhancement selection fails, create a basic enhancement opportunity.

6.  **Analyze Requirements**:
    *   Regardless of mode, analyze the requirements:
        *   Identify affected components
        *   Determine technical approach
        *   Identify potential challenges
        *   Establish success criteria if not already defined
    *   Update the change_request.md with the analysis:
        ```
        edit_file("1000xbrain/system/cycle-manager/operational_feedback/change_request.md", "Update with analysis", "...")
        ```
    *   **(Error Handling)**: If analysis reveals impossible requirements, document concerns.

7.  **Update Cycle Status**:
    *   Use `edit_file` to update `1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md`:
        *   Update Status to "Requirements Analyzed"
        *   Update Current Phase to indicate requirement analysis is complete
        *   Add reference to the change_request.md
        *   Document the determined operation mode

8.  **Signal Completion**:
    *   Indicate that requirement analysis is complete.
    *   Summarize the operation mode and key requirements.
    *   Note that the next step is planning using `run command:system/cycle-manager/3`.

## Operation Mode Determination

The determination between USER_DIRECTED and AUTONOMOUS modes is a critical function:

### USER_DIRECTED Mode Criteria

* USER REQUEST SECTION in notes.md contains non-template content
* Change request section contains specific instructions
* Requirements section contains concrete requirements

### AUTONOMOUS Mode Criteria

* USER REQUEST SECTION is empty or contains only template text
* No specific change request is provided
* System will select enhancement from potential_enhancements.md

## Template Structures

### Change Request Template (USER_DIRECTED)

```markdown
# Change Request Details

**Date Requested**: [current-date]
**Requestor**: Tyler Youk
**Status**: Analysis Pending
**Directive**: [Enhancement/Fix/Refactor/N/A]
**Target Cycle**: [system/cycle-name | frontend/cycle-name | backend/cycle-name | N/A]
**Priority**: [High/Medium/Low]

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

### Enhancement Template (AUTONOMOUS)

```markdown
# Enhancement Implementation Details

**Date Selected**: [current-date]
**Enhancement**: [Enhancement title]
**Status**: Analysis Completed
**Priority**: [High/Medium/Low]

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

## Special Considerations

1. **Mode Detection Accuracy**:
   * Apply careful analysis to determine the correct mode
   * If in doubt, default to USER_DIRECTED if any user input exists

2. **Requirement Clarity**:
   * Ensure requirements are clear and actionable
   * Document any assumptions made during analysis
   * Identify any ambiguities for clarification

3. **Enhancement Selection**:
   * In autonomous mode, select enhancements strategically
   * Consider system improvement value, not just priority

4. **Success Criteria Definition**:
   * Always define clear, measurable success criteria
   * These will be crucial for verification 