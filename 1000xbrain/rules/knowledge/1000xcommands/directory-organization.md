# 1000xcommand: Directory Organization

## Overview

This document outlines the mandatory directory structure for organizing `1000xcommand` definition files (`.md` files) within the `1000xrules` system. Proper organization is essential for clarity, maintainability, and correct invocation.

## Root Directory

All `1000xcommand` definition files MUST reside within the following root directory:

```
1000xrules/1000xcommands/
```

## Domain Subdirectories

Within the root directory, commands MUST be organized into subdirectories corresponding to their functional domain. The valid domains and their purposes are:

*   **`brain/`**: Commands related to enhancing or analyzing the `1000xbrain` cognitive architecture itself.
    *   *Example*: `1000xrules/1000xcommands/brain/analyze-knowledge-structure.md`

*   **`front-end/`**: Commands specifically for front-end development tasks within the `/front-end` project directory.
    *   *Example*: `1000xrules/1000xcommands/front-end/refactor-component-props.md`

*   **`back-end/`**: Commands specifically for back-end development tasks within the `/back-end` project directory.
    *   *Example*: `1000xrules/1000xcommands/back-end/add-database-migration.md`

*   **`rules/`**: Meta-commands related to managing the `1000xrules` system itself (including core rules and other 1000xcommands).
    *   *Example*: `1000xrules/1000xcommands/rules/create-new-command.md`

*   **`scripts/`**: Commands related to developing or managing automation scripts within the `/1000xscripts` directory.
    *   *Example*: `1000xrules/1000xcommands/scripts/run-sync-script-dry-run.md`

## File Naming Convention

Command definition files (`.md`) MUST use `kebab-case` (lowercase words separated by hyphens). The name should be descriptive and ideally start with a verb indicating the command's primary action.

*   **Good Examples**: `create-new-rule.md`, `analyze-api-structure.md`, `implement-ui-component.md`
*   **Bad Examples**: `NewRule.md`, `analyze_api.md`, `UIImplementation.md`

## Invocation Path

The invocation path used by Tyler Youk directly mirrors this structure:

```
@1000xcommands/<domain>/<command-name>
```

Where `<command-name>` corresponds to the filename without the `.md` extension.

## Importance of Structure

Strict adherence to this directory structure ensures:

*   **Clarity**: Easy understanding of a command's purpose based on its location.
*   **Discoverability**: Simple browsing and location of commands.
*   **Invocation Accuracy**: Correct resolution of command references during `fetch_rules`.
*   **Maintainability**: Logical grouping for easier updates and management.

## Related Documents

*   `1000xrules/core/communication/1000xcommands-guidelines.md`: Overall system description.
*   `1000xbrain/knowledge/1000xcommands/command-structure.md`: File format requirements. 