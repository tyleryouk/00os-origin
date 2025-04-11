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
    *   **NEW**: Parse directive information:
        * Extract `# Directive:` value if present 
        * Extract `# Target Cycle:` value if present
        * Extract `# Enhancement Name:` value if present
        * Extract `# Priority:` value if present
    *   **NEW**: Validate directive values:
        * Check if Directive is one of: Enhancement, Fix, Refactor, Analysis
        * Verify Target Cycle follows format: domain/cycle-name
        * Check Priority is one of: High, Medium, Low
    *   **(Error Handling)**: 
        * If the file doesn't exist or the section is missing, log error and suggest creating it.
        * If directive values are invalid, note this but continue processing with available values.

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
            *   **NEW**: Directive (validated from step 2)
            *   **NEW**: Target Cycle (validated from step 2)
            *   **NEW**: Enhancement Name (from step 2)
            *   Priority (validated from step 2)
            *   Change request description
            *   Requirements
            *   Additional notes
        *   Create a requirements document (`change_request.md`):
            ```
            edit_file("1000xbrain/system/cycle-manager/operational_feedback/change_request.md", "Document user request including directives", "...")
            ```
        *   Use this updated template:
            ```markdown
            # Change Request Details

            **Requestor**: Tyler Youk
            **Status**: Analysis Pending
            **Directive**: [Validated Directive or N/A]
            **Target Cycle**: [Validated Target Cycle or N/A]
            **Enhancement Name**: [Parsed Enhancement Name or N/A]
            **Priority**: [Validated Priority or Medium]

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
        *   **NEW**: If directive validation identified issues, document them in Special Considerations.
    *   **(Error Handling)**: If user input is ambiguous, document uncertainties and assumptions. If directives are missing or invalid, use defaults and document the decision.

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

                **Requestor**: Autonomous System
                **Status**: Analysis Completed
                **Enhancement**: [Enhancement title]
                **Priority**: [from enhancement]
                **Directive**: Enhancement
                **Target Cycle**: [determined from context or default to cycle-manager]

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
        *   **NEW**: For directive-based requirements, include directive-specific analysis:
            * For Enhancement: Focus on feature integration and user experience
            * For Fix: Focus on root cause analysis and regression prevention
            * For Refactor: Focus on maintaining functionality while improving structure
            * For Analysis: Focus on thorough examination without implementation bias
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
        *   **NEW**: Include directive and target cycle information if available

8.  **Signal Completion**:
    *   Indicate that requirement analysis is complete.
    *   Summarize the operation mode and key requirements.
    *   **NEW**: Include directive and target cycle in the summary if available.
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

## Directive Validation Rules

* **Directive Values**: Must be one of:
  * Enhancement - Request for new features or improvements
  * Fix - Request to correct problems or issues
  * Refactor - Request to restructure without changing functionality 
  * Analysis - Request for assessment without implementation

* **Target Cycle Format**: Must follow pattern domain/cycle-name, where:
  * domain is one of: system, frontend, backend
  * cycle-name is a valid cycle name within that domain
  
* **Priority Values**: Must be one of:
  * High - Urgent or critical changes
  * Medium - Important but not immediate
  * Low - Desirable but can be deferred

## Template Structures

### Change Request Template (USER_DIRECTED)

```markdown
# Change Request Details

**Requestor**: Tyler Youk
**Status**: Analysis Pending
**Directive**: [Enhancement/Fix/Refactor/Analysis]
**Target Cycle**: [system/cycle-name | frontend/cycle-name | backend/cycle-name]
**Enhancement Name**: [Brief descriptive name]
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

**Requestor**: Autonomous System
**Status**: Analysis Completed
**Enhancement**: [Enhancement title]
**Priority**: [High/Medium/Low]
**Directive**: Enhancement
**Target Cycle**: [system/cycle-name | N/A]

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
   
5. **Directive Validation**:
   * Validate directive values but allow processing to continue with defaults if invalid
   * Document validation issues in the special considerations section
   * For missing directives in user-directed mode, default to "Enhancement"

6. **Optimized 1000xplans Usage**:
   * Follow the guidelines in `1000xbrain/system/cycle-manager/knowledge/1000xplans-usage.md`
   * Remember that 1000xplans is primarily Tyler's domain for input
   * Only read from notes.md; write all analysis to the operational_feedback directory
   * Ensure all implementation tracking occurs in operational_feedback files 