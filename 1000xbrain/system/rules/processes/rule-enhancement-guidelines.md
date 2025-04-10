# Guidelines for Managing Rules in `1000xrules`

## Overview

This document describes the overarching process and guidelines for creating and enhancing rule files within the `1000xrules` directory. This directory acts as the **editable source of truth** for the rules that govern 1000xdev's behavior, which are then synchronized to the `.cursor/rules` directory for application by the Cursor engine.

## The `1000xrules` vs. `.cursor/rules` Relationship

1.  **`1000xrules` (Source - `.md` files)**:
    *   Contains all core identity, communication, tool usage, and 1000xcommand definitions as standard Markdown (`.md`) files.
    *   **This is the ONLY directory where 1000xdev edits rule definitions.**
    *   Benefits: Version control via Git, standard Markdown editing, separation of source from applied configuration.
    *   Structure: Organized into `core/` and `1000xcommands/` subdirectories.
    *   Files to Edit: `*.md` files within `1000xrules/`.

2.  **.cursor/rules (Applied - `.mdc` files)**:
    *   Contains the compiled/synchronized rule files (`.mdc`) that the Cursor rule engine reads.
    *   **1000xdev NEVER edits files in this directory directly.**
    *   Content is automatically generated/updated from `1000xrules` by synchronization scripts (managed by Tyler Youk, located in `/1000xscripts/`).
    *   Files to Read (via `fetch_rules`): `*.mdc` files using the `1000xrules/.../file.mdc` path format when executing commands.

## Why Edit `1000xrules`?

*   **Version Control**: Changes are tracked in Git history.
*   **Standard Format**: `.md` files are easier to edit and manage than potentially complex `.mdc` formats.
*   **Safety**: Prevents accidental modification of the live `.cursor/rules` configuration.
*   **Synchronization**: Ensures a consistent, automated process for updating the applied rules.

## General Enhancement Process for Rules (`1000xrules/**/*.md`)

1.  **Identify Need**: Determine the rule(s) requiring creation or modification based on requirements, observed behavior, or self-analysis.
2.  **Locate Source File**: Find the correct `.md` file within the `1000xrules` structure (e.g., `1000xrules/core/identity/core-identity.md` or `1000xrules/1000xcommands/brain/analyze-code.md`).
3.  **Read Context**: Read the target `.md` file(s) and any relevant knowledge files (`1000xbrain`) or process descriptions (`1000xbrain/rules/processes/`) completely to understand the existing state and guidelines.
4.  **Plan Changes**: Formulate the precise modifications needed, ensuring adherence to relevant guidelines (e.g., `core-rule-enhancement-specifics.md`, `1000xcommands-guidelines.md`).
5.  **Implement Edit**: Use the `edit_file` tool to modify the `.md` source file.
    *   **Target**: Always specify the `.md` file path in `1000xrules`.
    *   **Instructions**: Provide clear instructions for the edit.
    *   **Safety**: Double-check you are not targeting `.cursor/rules` or a `.mdc` file.
6.  **Verify Edit**: (Optional but recommended) Re-read the modified section of the `.md` file to confirm the change was applied correctly.
7.  **Synchronization**: Understand that the changes made to the `.md` file will be reflected in the corresponding `.mdc` file in `.cursor/rules` after the synchronization script runs.

## Specific Guidelines

*   **Core Rules (`1000xrules/core/`)**: Follow guidelines in `1000xbrain/rules/processes/core-rule-enhancement-specifics.md`.
*   **1000xcommands (`1000xrules/1000xcommands/`)**: Follow guidelines in `1000xrules/core/communication/1000xcommands-guidelines.md` and knowledge files in `1000xbrain/knowledge/1000xcommands/`.
*   **File Naming**: Use descriptive, kebab-case filenames for new `.md` files.
*   **Formatting**: Maintain consistent Markdown formatting.

## Related Safety

*   Always adhere to `1000xrules/core/communication/file-editing-safety.md`.
*   Never attempt to edit `.mdc` files. 