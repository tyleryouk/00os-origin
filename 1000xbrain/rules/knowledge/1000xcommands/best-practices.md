# 1000xcommand: Best Practices

## Overview

This document provides best practices for designing, creating, and maintaining effective `1000xcommands` to maximize efficiency and reliability within the 1000xdev workflow.

## Design Principles

1.  **Simplicity is Key**: Commands should be simple sequences of tool calls. Avoid embedding complex logic directly within the command definition file.
2.  **Leverage `1000xbrain` Knowledge**: Abstract detailed instructions, conditional logic, and domain-specific knowledge into `1000xbrain/knowledge/` files. Commands should initiate processes by reading these knowledge files.
3.  **Single Responsibility**: Each command should have a single, well-defined purpose within its domain.
4.  **Idempotency (Where Possible)**: Design commands so that executing them multiple times (if appropriate for the task) yields the same result or doesn't cause adverse effects. This is not always feasible but is a good goal.
5.  **Context Gathering First**: Commands that modify state should typically start by gathering necessary context (e.g., `read_file`, `list_dir`, reading knowledge files).

## Creation Best Practices

*   **Follow the Process**: Adhere strictly to the `1000xbrain/knowledge/1000xcommands/creation-process.md`.
*   **Use Descriptive Names**: Choose clear, kebab-case names that reflect the action (e.g., `analyze-component-dependencies.md`).
*   **Correct Domain**: Place the command file in the appropriate domain subdirectory (`1000xrules/1000xcommands/<domain>/`).
*   **Validate Tool Calls**: Double-check tool names, parameters, and syntax against `core/tools/tool-usage-standards.mdc` and individual tool schemas.
*   **Mental Walkthrough**: Perform the logical sequence testing described in `1000xbrain/knowledge/1000xcommands/testing-procedures.md`.
*   **Minimalism**: Include only the necessary tool calls. Avoid extraneous steps.

## Maintenance Best Practices

*   **Update Knowledge, Not Just Commands**: If underlying logic needs changing, prioritize updating the `1000xbrain` knowledge files that commands read, rather than solely modifying the command's tool calls (unless the sequence itself is flawed).
*   **Refactor for Reusability**: If common sequences of tool calls appear in multiple commands, consider creating a more specific, reusable command or a dedicated knowledge file.
*   **Deprecate Clearly**: If a command becomes obsolete, consider renaming it with a `-deprecated` suffix or documenting its status clearly before eventual removal.
*   **Version Control**: Leverage Git history to track changes to command definitions.

## Invocation Best Practices (Guidance for Tyler Youk)

*   **Use the Right Command**: Select the command whose name and domain best match the intended task.
*   **Provide Context (If Needed)**: While commands execute silently, providing brief context in a preceding message can help 1000xdev maintain overall situational awareness, although the command itself operates independently.
*   **Trust the Abstraction**: Understand that the command's simplicity belies the potentially complex logic handled by 1000xdev via the referenced `1000xbrain` knowledge files.

## Related Documents

*   `1000xrules/core/communication/1000xcommands-guidelines.md`
*   `1000xbrain/knowledge/1000xcommands/creation-process.md`
*   `1000xbrain/knowledge/1000xcommands/testing-procedures.md`
*   `1000xbrain/knowledge/1000xcommands/command-structure.md`
*   `1000xbrain/knowledge/1000xcommands/directory-organization.md` 