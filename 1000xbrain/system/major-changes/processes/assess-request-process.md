# Process: Requirement Analysis

# Defines the steps for analyzing requirements and determining the execution mode.

## Goal: Analyze user input or determine an autonomous enhancement to identify system-wide changes that need to be implemented.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`.
    *   Verify that initialization has been completed.
    *   **(Error Handling)**: If initialization is not complete, log error and suggest running initialization.

2.  **Initialize Cycle Information**:
    *   Define the output path for cycle list:
        ```
        $cycleListPath = "1000xbrain/system/major-changes/operational_feedback/cycle_list.md"
        ```
    *   Use `run_terminal_cmd` to run the list-cycles script with direct output:
        ```
        run_terminal_cmd("1000xscripts/system/list-cycles.ps1 -OutputFile \"$cycleListPath\" | cat", is_background=false)
        ```
    *   Read the cycle list file to verify it was created/updated:
        ```
        read_file("1000xbrain/system/major-changes/operational_feedback/cycle_list.md", should_read_entire_file=true)
        ```
    *   **(Error Handling)**: If the script fails, log the error but continue with previously stored cycle information if available.

3.  **Check for User Input**:
    *   Use `read_file` to read `1000xplans/system/user_request.md`.
    *   Extract the content from the USER REQUEST SECTION.
    *   Determine if the section contains valid user input (beyond templated placeholders).
    *   Parse directive information:
        * Extract `# Directive:` value if present 
        * Extract `# Target Cycle:` value if present
        * Extract `# Enhancement Name:` value if present
        * Extract `# Priority:` value if present
    *   Validate directive values:
        * Check if Directive is one of: Enhancement, Fix, Refactor, Analysis
        * Verify Target Cycle follows format: domain/cycle-name and exists in the list from step 2
        * Check Priority is one of: High, Medium, Low
    *   **(Error Handling)**: 
        * If the file doesn't exist or the section is missing, log error and suggest creating it.
        * If directive values are invalid, note this but continue processing with available values.

4.  **Determine Operation Mode**:
    *   Based on user input check:
        *   If valid user input exists, set mode to USER_DIRECTED.
        *   If no valid user input (empty or just template), set mode to AUTONOMOUS.
    *   Update current cycle with the determined mode:
        ```
        edit_file("1000xbrain/system/major-changes/operational_feedback/current_cycle.md", "Update operation mode", "...")
        ```
    *   **(Error Handling)**: Document mode determination process.

5.  **Process User-Directed Mode** (if applicable):
    *   If mode is USER_DIRECTED:
        *   Parse the user request into structured components:
            *   Directive (validated from step 3)
            *   Target Cycle (validated from step 3)
            *   Enhancement Name (from step 3)
            *   Priority (validated from step 3)
            *   Change request description
            *   Requirements
            *   Additional notes
        *   Create a requirements document:
            ```
            edit_file("1000xbrain/system/major-changes/operational_feedback/change_request.md", "Document user request including directives", "...")
            ```
        *   Use this updated template:
            ```markdown
            # Change Request Details

            **Requestor**: Tyler Youk
            **Status**: Analysis Completed
            **Directive**: [Validated Directive or N/A]
            **Target Cycle**: [Validated Target Cycle or N/A]
            **Enhancement Name**: [Parsed Enhancement Name or N/A]
            **Priority**: [Validated Priority or Medium]

            ## Request Description

            [User request description]

            ## Requirements

            [Extracted/analyzed requirements]

            ## Scope

            [Defined scope based on analysis with focus on identifying system-wide components that need changes]

            ## Success Criteria

            [Defined success criteria based on requirements]

            ## Special Considerations

            [Any special notes, with focus on guidelines updates that will be needed]
            ```
        *   If directive validation identified issues, document them in Special Considerations.
    *   **(Error Handling)**: If user input is ambiguous, document uncertainties and assumptions. If directives are missing or invalid, use defaults and document the decision.

6.  **Process Autonomous Mode** (if applicable):
    *   If mode is AUTONOMOUS:
        *   Check for pending system-wide improvements:
            *   Review guidelines for planned updates
            *   Identify knowledge gaps or inconsistencies
            *   Look for technical debt or documentation needs
        *   Create an enhancement implementation document:
            ```
            edit_file("1000xbrain/system/major-changes/operational_feedback/change_request.md", "Document selected enhancement", "...")
            ```
        *   Use this template:
            ```markdown
            # Enhancement Implementation Details

            **Requestor**: Autonomous System
            **Status**: Analysis Completed
            **Directive**: Enhancement
            **Target Cycle**: system/major-changes
            **Enhancement Name**: [System-Wide Enhancement]
            **Priority**: Medium

            ## Enhancement Description

            [Description of the system-wide enhancement]

            ## Implementation Requirements

            [Specific requirements for implementation]

            ## Scope

            [Defined scope with list of affected components]

            ## Success Criteria

            [Defined success criteria]

            ## Special Considerations

            [Special notes on guidelines integration]
            ```
    *   **(Error Handling)**: If enhancement selection fails, create a basic system scan enhancement.

7.  **Analyze Guidelines Impact**:
    *   Identify which guidelines in `1000xbrain/system/guidelines/` will be affected by the requested changes.
    *   Determine how guidelines will need to be updated before implementing system-wide changes.
    *   Document the guidelines impact in the change_request.md:
        ```
        edit_file("1000xbrain/system/major-changes/operational_feedback/change_request.md", "Update with guidelines impact analysis", "...")
        ```
    *   **(Error Handling)**: If analysis reveals impossible requirements, document concerns.

8.  **Update Cycle Status**:
    *   Use `edit_file` to update `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`:
        *   Update Status to "Requirements Analyzed"
        *   Update Current Phase to indicate requirement analysis is complete
        *   Update Operation Mode to reflect the determined mode
        *   Add reference to the change_request.md
        *   Include directive and target cycle information if available

9.  **Signal Completion**:
    *   Indicate that requirement analysis is complete.
    *   Summarize the operation mode and key requirements.
    *   Include directive and target cycle in the summary if available.
    *   Note that the next step is planning using `run command:system/major-changes/3`.

## Operation Mode Determination

The determination between USER_DIRECTED and AUTONOMOUS modes is a critical function:

### USER_DIRECTED Mode Criteria

* USER REQUEST SECTION in user_request.md contains non-template content
* Change request section contains specific instructions
* Requirements section contains concrete requirements

### AUTONOMOUS Mode Criteria

* USER REQUEST SECTION is empty or contains only template text
* No specific change request is provided
* System will select enhancement from potential system-wide improvements

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

## Guidelines Impact Analysis

For major-changes cycles, it's critical to identify which guidelines will be affected:

1. **Identification**: Determine which guideline files need updates
2. **Dependency Analysis**: Identify systems that depend on these guidelines
3. **Sequence Planning**: Determine the order of updates (guidelines first, then systems)
4. **Documentation Needs**: Identify documentation that must be updated

This analysis ensures that system-wide changes maintain consistency and backward compatibility. 