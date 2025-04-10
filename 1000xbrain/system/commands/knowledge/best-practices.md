# 1000xcommand: Best Practices

## Overview

This document provides best practices for designing, creating, and maintaining effective `1000xcommands` (defined in `1000xbrain/commands/`) to maximize efficiency and reliability within the 1000xdev workflow.

## Design Principles

1.  **Simplicity is Key**: Commands should contain simple sequences of tool calls for context gathering or fixed actions. Avoid embedding complex, conditional logic directly.
2.  **Leverage `1000xbrain` for Complexity**: Abstract detailed instructions, conditional logic, and multi-step implementation processes into `1000xbrain/{domain}/processes/` files. Reference relevant `.../knowledge/` files within the process definition.
3.  **Trigger Dynamic Execution**: Use the `# --- BEGIN DYNAMIC EXECUTION ---` marker (followed by `Process:` and optional `Knowledge:` lines) in the command file to explicitly delegate complex execution flow to the AI, guided by the specified process file. See `1000xbrain/commands/knowledge/command-structure.md`.
4.  **Single Responsibility**: Each command should have a single, well-defined purpose (e.g., 'initiate analysis', 'execute planned changes', 'finalize component X').
5.  **Idempotency (Where Possible)**: Design commands or the processes they trigger so that re-execution is safe where applicable.
6.  **Context Gathering First**: Commands should typically start by explicitly listing tool calls (`read_file`, `list_dir`) needed to gather context *before* the dynamic execution marker. **Exception:** If context (like target domain) is passed conceptually via the invocation, the dynamic process can handle loading.
7.  **Parameterization (Conceptual)**: For commands intended to operate across different domains (e.g., planning continuation), design them to conceptually accept a domain parameter via invocation. The dynamic process file referenced by the command will then be responsible for identifying this domain and loading the appropriate context files (e.g., `1000xplans/<domain>/plan.md`). This promotes reusability over creating domain-specific command variants.

## Creation Best Practices

*   **Follow the Process**: Adhere strictly to `1000xbrain/brain/knowledge/commands/creation-process.md`.
*   **Use Descriptive Names**: Choose clear, kebab-case names that reflect the action (e.g., `analyze-component-dependencies.md`).
*   **Correct Domain**: Place the command file in the appropriate domain subdirectory within `1000xbrain/commands/` (e.g., `1000xbrain/commands/frontend/`).
*   **Validate Tool Calls**: Double-check tool names, parameters, and syntax against `1000xrules/core/tools/tool-usage-standards.mdc` and individual tool schemas.
*   **Mental Walkthrough**: Perform the logical sequence testing described in `1000xbrain/brain/knowledge/commands/testing-procedures.md`.
*   **Minimalism**: Include only the necessary tool calls. Avoid extraneous steps.

## Maintenance Best Practices

*   **Update Processes/Knowledge First**: If underlying logic needs changing, prioritize updating the `1000xbrain` process and knowledge files rather than adding complex explicit calls to the command file.
*   **Refactor for Reusability**: If common sequences of tool calls appear in multiple commands, consider creating a more specific, reusable command or a dedicated knowledge file.
*   **Deprecate Clearly**: If a command becomes obsolete, consider renaming it with a `-deprecated` suffix or documenting its status clearly before eventual removal.
*   **Version Control**: Leverage Git history to track changes to command definitions.

## Invocation Best Practices (Guidance for Tyler Youk)

*   **Use the Right Command**: Use the `run command:domain/command-name` syntax, selecting the command whose name and domain best match the intended task.
*   **Provide Context (If Needed)**: While commands execute silently, providing brief context in a preceding `chat ` message can help 1000xdev maintain overall situational awareness, although the command itself operates independently based on its definition and any knowledge files it reads.
*   **Trust the Abstraction**: Understand that the command's explicit calls may only be for setup, with the core logic triggered dynamically via the specified process file.

## Related Documents

*   `1000xrules/core/communication/1000xcommands-guidelines.md`
*   `1000xbrain/brain/knowledge/commands/creation-process.md`
*   `1000xbrain/brain/knowledge/commands/testing-procedures.md`
*   `1000xbrain/brain/knowledge/commands/command-structure.md`
*   `1000xbrain/brain/knowledge/commands/directory-organization.md` 