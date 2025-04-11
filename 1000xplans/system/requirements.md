# Requirements: Major Changes Workflow Implementation

## Purpose
Create a new sequential command structure in the `1000xcommands/system/major-changes/` directory, paralleling the autonomous workflow but designed specifically for handling explicit change requests from Tyler Youk.

## Core Requirements

1. **Structural Alignment**
   * Create a folder structure that parallels the autonomous workflow
   * Implement a 7-step sequential command pattern (1.md through 7.md)
   * Establish operational feedback mechanisms similar to autonomous workflow

2. **Process Integration**
   * Reuse existing process and knowledge files where appropriate
   * Implement dynamic execution patterns consistent with system standards
   * Create new process files only when existing ones cannot be repurposed

3. **Operational Requirements**
   * Commands must maintain state between steps
   * Operational feedback must be properly stored and accessible
   * Cycle initiation and completion must be clearly defined

4. **Functional Differentiation**
   * Clear separation between autonomous and major-changes workflows
   * Explicit parameters for handling user-directed change requests
   * Custom assessment process for evaluating change scope

5. **Documentation Requirements**
   * Each command file must include proper header documentation
   * README.md files must explain the purpose and relationship to autonomous workflow
   * Command invocation syntax must be standardized

## Technical Requirements

1. **Command Structure**
   * Follow established dynamic execution pattern
   * Implement proper error handling and state verification
   * Include operational feedback directory existence checks

2. **File Naming & Structure**
   * Use numeric sequence (1.md through 7.md) consistent with autonomous workflow
   * Include descriptive headers in each file
   * Follow established Markdown formatting standards

3. **Process Flow**
   * Implement a logical flow between sequential steps
   * Include explicit state transitions
   * Handle edge cases and failure scenarios

4. **Integration Requirements**
   * Commands must be listed in the system command index
   * Implementation progress must be trackable
   * Workflow must be compatible with larger system architecture

## Constraints

1. **Reuse Existing Components**
   * Maximize reuse of existing process and knowledge files
   * Minimize creation of new components
   * Maintain consistency with established patterns

2. **Minimize Disruption**
   * Implementation should not disrupt existing workflows
   * Changes should be isolated to specified directories
   * Testing should validate both workflows operate independently

3. **Completion Criteria**
   * All seven command files must be implemented
   * Commands must function in proper sequence
   * Documentation must be complete and accurate
   * Test case must demonstrate successful operation

## Acceptance Criteria

The implementation will be considered complete when:

1. All seven command files are created and stored in the correct location
2. Commands correctly implement the dynamic execution pattern
3. Process flow transitions properly between sequential steps
4. Operational feedback is correctly stored and managed
5. Documentation clearly explains the purpose and usage
6. Test case demonstrates successful execution of the complete workflow

## Priority

This implementation has HIGH priority as it establishes a core workflow for explicit change management.

## Enhancements (Cycle CM-003)

1.  **Standardized Notes Structure:**
    *   **Requirement:** Restructure notes files across all cycles to follow the format: `## USER REQUEST SECTION`, `## Tyler Youk notes`, `## 1000XDEV NOTES`.
    *   **Rationale:** Improve clarity and consistency, making active requests highly visible.
    *   **Implementation:** Update `1000xbrain/system/cycle-manager/processes/initiation-process.md` and relevant templates.

2.  **Global Directives Implementation:**
    *   **Requirement:** Implement a system for global directives (e.g., `Analyze Cycle`) recognized within the `USER REQUEST SECTION` to trigger specific, pre-defined system actions.
    *   **Rationale:** Provide a streamlined way to invoke common system operations without a full change request.
    *   **Implementation:**
        *   Create `1000xbrain/system/cycle-manager/knowledge/available-directives.md` to list and define directives.
        *   Modify `1000xbrain/system/cycle-manager/processes/requirement-analysis-process.md` to parse and act on `# Directive:`, `# Target Cycle:`, `# Analysis Focus:`, and `# Directive Notes:` fields.
        *   Enhance `1000xbrain/system/cycle-manager/processes/cycle-analysis-process.md` to accept focus parameters and utilize directive notes.

3.  **Cycle Listing Capability:**
    *   **Requirement:** Create a script (`1000xscripts/system/list-cycles.ps1`) to dynamically list available cycles by scanning `1000xcommands/`.
    *   **Rationale:** Provide an accurate, up-to-date list of cycles for use in directives or requests.
    *   **Implementation:** Develop the PowerShell script.
    *   **Optional:** Create a simple command (`run command:system/info/list-cycles`) to execute the script.

4.  **Updated USER REQUEST SECTION Template:**
    *   **Requirement:** Update the template within `initiation-process.md` (and reflected in `notes.md`) to reference the `available-directives.md` file and the cycle listing script/command.
    *   **Rationale:** Guide the user on how to use the new directive system effectively.
