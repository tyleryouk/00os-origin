# File Editing Safety Guidelines

## Overview

This file establishes critical safety guidelines for file editing within the cognitive architecture. 1000xdev MUST adhere to these rules to prevent errors and ensure system stability.

## Critical Safety Rules

### Extension-Based Safety

1.  **Editable Files (.md)**:
    *   1000xdev ONLY edits files with the `.md` extension.
    *   These source files are located in:
        *   `1000xrules/` (for core rules and 1000xcommand definitions)
        *   `1000xbrain/` (for knowledge and process definitions)
        *   `/planning/` (during Planning Mode only, as per mode rules)
        *   `/front-end/`, `/back-end/`, `/1000xscripts/` (during implementation phases, guided by `1000xcommands` or planning)
    *   These `.md` files are the source of truth.

2.  **Cursor Rule Files (.mdc)**:
    *   1000xdev NEVER edits files with the `.mdc` extension.
    *   Location: `.cursor/rules/`.
    *   These are generated automatically from `1000xrules/` by sync scripts.
    *   They are read-only for 1000xdev (can be read via `fetch_rules`).

### Directory-Based Safety

1.  **Editable Directories (Primary)**:
    *   `1000xrules/`
    *   `1000xbrain/`
    *   `/planning/` (Conditional)
    *   `/front-end/`, `/back-end/`, `/1000xscripts/` (Conditional)

2.  **Protected Directories**:
    *   `.cursor/rules/`: NEVER edit directly.
    *   Any directory containing `.mdc` files.

### Role-Based Safety

1.  **1000xdev Role**:
    *   Edits `.md` source files only.
    *   Reads `.mdc` rule files via `fetch_rules` when necessary (e.g., executing a command).
    *   Must respect the synchronization process.

2.  **Automated Synchronization Process**:
    *   `1000xrules` (`.md`) files are the source for `.cursor/rules` (`.mdc`).
    *   Synchronization is handled by scripts in `/1000xscripts/`.
    *   No manual editing of `.mdc` files is ever needed by 1000xdev.

3.  **Synchronization Scripts**:
    *   Located in `/1000xscripts/`.
    *   Handles `1000xrules` -> `.cursor/rules` synchronization.
    *   README.md files are explicitly excluded from sync.

## Safety Verification Process by 1000xdev

1.  **Pre-Edit Checks**:
    *   Verify target file extension is `.md`.
    *   Confirm target file is within an authorized editable directory.
    *   Ensure file is not a `README.md` if within `1000xrules`.
    *   Read the full file content before editing (`file-reading-enforcement.md`).

2.  **Edit Safety**:
    *   Use the `edit_file` tool for all modifications.
    *   Preserve file structure and Markdown formatting.
    *   Do not include frontmatter in `.md` files within `1000xrules`.

3.  **Post-Edit Verification**:
    *   Confirm changes were applied correctly (e.g., by re-reading the edited section).
    *   Understand that sync scripts handle the propagation to `.mdc` files.

## Common Mistakes for 1000xdev to Avoid

1.  **Editing `.mdc` Files**: 
    *   ❌ Attempting to edit `.mdc` files directly.
    *   ✅ Edit the corresponding `.md` file in `1000xrules` instead.

2.  **Editing Outside Authorized Directories**: 
    *   ❌ Targeting `.cursor/rules/` for edits.
    *   ❌ Modifying sync scripts without explicit instruction/planning.
    *   ✅ Work only within authorized `.md` files in `1000xrules`, `1000xbrain`, etc.

3.  **Incorrect File Referencing**: 
    *   ❌ Using `.mdc` extension when intending to edit.
    *   ❌ Using `.md` extension when intending to invoke a command (`@1000xcommands/...`).
    *   ✅ Use `.md` for file paths in `edit_file`, `read_file`, etc. Use `@1000xcommands/...` for invocation.

## Implementation Patterns

1.  **Safe File Creation (`.md`)**:
    ```typescript
    // Create core rule or command definition
    edit_file("1000xrules/core/new-rule.md", "Create new core rule", "# New Rule...")
    edit_file("1000xrules/1000xcommands/brain/new-command.md", "Create new brain command", "# New Command...")
    
    // Create knowledge file
    edit_file("1000xbrain/knowledge/new-topic.md", "Create new knowledge file", "# New Topic...")
    ```

2.  **Safe File Editing (`.md`)**:
    ```typescript
    // Edit existing core rule
    read_file("1000xrules/core/identity/core-identity.md", should_read_entire_file=True)
    edit_file("1000xrules/core/identity/core-identity.md", "Update identity trait", "...")
    ```

3.  **Safe File/Command Referencing (in Documentation)**:
    ```markdown
    See the core identity at `1000xrules/core/identity/core-identity.md`. 
    To execute the analysis, use `@1000xcommands/brain/analyze-structure`.
    ```

## Synchronization Process Summary

*   Changes to `.md` files in `1000xrules` are detected by sync scripts.
*   Scripts convert/copy to `.mdc` files in `.cursor/rules`, preserving necessary frontmatter/structure.
*   1000xdev relies on this process and does not interact with `.mdc` files directly for edits.

## Related References

*   Core Identity: `1000xrules/core/identity/global-rules.md`
*   Symbol Guidelines: `1000xrules/core/communication/symbol-guidelines.md`
*   1000xcommands Guidelines: `1000xrules/core/communication/1000xcommands-guidelines.md` 