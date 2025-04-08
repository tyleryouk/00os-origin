# 1000xcommand: Testing Procedures

## Overview

This document describes the procedures 1000xdev uses to test and verify the tool call sequences within newly created or modified `1000xcommand` definition files (`.md`) before they are considered fully operational.

## Testing Goal

The primary goal is to ensure the sequence of tool calls within a command is syntactically correct, logically sound, and effectively achieves the command's intended purpose, while adhering to all core rules and standards.

## Testing Methods

Due to the nature of `1000xcommands` (silent execution upon invocation by Tyler), direct execution testing by 1000xdev is not performed. Instead, verification relies on careful analysis and mental walkthroughs:

1.  **Syntax Verification**: 
    *   **Action**: Automatically review each tool call line against the known schemas and `core/tools/tool-usage-standards.mdc`.
    *   **Checks**: Correct tool name, presence of required parameters, correct parameter types (string, boolean, list), proper formatting (quotes, commas).
    *   **Reference**: `1000xbrain/knowledge/1000xcommands/command-structure.md`.

2.  **Structural Verification**: 
    *   **Action**: Automatically review the overall file structure.
    *   **Checks**: Single H1 header on the first line, only tool calls and optional comments follow, correct file location and naming.
    *   **Reference**: `1000xbrain/knowledge/1000xcommands/command-structure.md`, `directory-organization.md`.

3.  **Logical Sequence Walkthrough (Mental Simulation)**:
    *   **Action**: Perform a step-by-step mental simulation of the tool call sequence.
    *   **Checks**:
        *   Does the sequence start correctly (e.g., reading necessary context or knowledge files)?
        *   Is information gathered before it's needed (e.g., `read_file` before `edit_file`)?
        *   Are file paths likely to be correct based on the command's domain and purpose?
        *   Are standard protocols followed (e.g., full file reading)?
        *   Does the *entire sequence* logically lead to the command's intended outcome?
        *   Are there any obvious error conditions or edge cases missed?

4.  **Knowledge Abstraction Check**: 
    *   **Action**: Review the tool calls in relation to `1000xbrain`.
    *   **Checks**: Ensure complex logic, detailed instructions, or conditional steps are appropriately handled by tools reading knowledge files from `1000xbrain`, rather than being implicitly required by the command sequence itself. The command should be a simple initiator.

## Verification during Creation Process

Steps 1-4 are integrated into the standard `creation-process.md` that 1000xdev follows when creating a new command.

## Post-Creation Verification (By Tyler Youk)

Since 1000xdev cannot directly test the *live execution* of a command (as it requires invocation), the final verification often involves:

1.  **Manual Review**: Tyler Youk reviews the created `.md` command file.
2.  **Trial Invocation**: Tyler Youk invokes the command (`@1000xcommands/...`) in a controlled context.
3.  **Observation**: Tyler Youk observes the sequence of tool calls executed by 1000xdev.
4.  **Feedback**: If issues arise, Tyler provides feedback or updated requirements, leading to a refinement cycle (potentially involving another `1000xcommand` like `update-command`).

## Related Documents

*   `1000xrules/core/communication/1000xcommands-guidelines.md`
*   `1000xbrain/knowledge/1000xcommands/creation-process.md`
*   `1000xbrain/knowledge/1000xcommands/command-structure.md`
*   `core/tools/tool-usage-standards.mdc` 