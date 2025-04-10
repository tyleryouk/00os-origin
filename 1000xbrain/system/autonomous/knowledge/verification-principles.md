# Knowledge: Verification Principles for Autonomous Workflow

## Core Principles

*   **Comprehensive Verification**: Verification must cover all specified aspects of the system that were modified during implementation.
*   **Evidence-Based Assessment**: All verification results must be based on concrete evidence (existence checks, content analysis, runtime behavior).
*   **Structured Reporting**: Verification results must be captured in a structured format to enable automated analysis and decision-making.
*   **Self-Verification**: The verification system itself should be validated for completeness and accuracy periodically.
*   **Progressive Depth**: Verification should proceed from basic (existence) checks to more sophisticated (content, behavior) verification, depending on criticality.

## Verification Categories

### 1. Structural Verification

*   **Existence Verification**: Confirm all required files and directories exist.
*   **Directory Organization**: Verify directory structures match expected patterns.
*   **File Type Consistency**: Ensure file extensions and types align with system expectations.

### 2. Content Verification

*   **Syntax Verification**: Check for valid syntax in relevant file types (Markdown, PowerShell, etc.).
*   **Structure Verification**: Validate expected content structure (headers, sections, tool calls).
*   **Reference Validation**: Verify file references point to existing resources.
*   **Knowledge-Process Alignment**: Confirm knowledge files properly inform their linked processes.

### 3. Behavioral Verification

*   **Command Execution**: Verify commands can be executed without errors.
*   **Tool Call Patterns**: Validate tool call sequences align with best practices.
*   **Error Handling**: Ensure proper error detection and recovery mechanisms.
*   **Completion Signals**: Verify clear completion signals for all processes.

### 4. System Integration

*   **Component Interactions**: Verify components interact properly (knowledge informs process, etc.).
*   **Workflow Continuity**: Ensure workflow transitions correctly between stages.
*   **State Management**: Validate proper state tracking and progression.

## Verification Approaches

*   **Static Analysis**: Direct examination of file contents without execution.
*   **Dynamic Testing**: Execution of commands with observation of behavior.
*   **Comparative Analysis**: Before/after comparisons to validate changes.
*   **Simulation**: Testing behavior in controlled contexts before full deployment.

## Failure Response Guidelines

*   **Categorize Failures**: Group failures by severity (critical, major, minor).
*   **Isolate Scope**: Determine if failure is isolated or systemic.
*   **Document Precisely**: Capture exact conditions, inputs, and outputs.
*   **Prioritize Resolution**: Address critical failures before proceeding to next phase.

## Success Criteria

*   All mandatory checks pass without errors.
*   Documentation is updated to reflect changes.
*   System state is properly updated to reflect verification completion.
*   Clear signal for next phase (refine/complete) is generated. 