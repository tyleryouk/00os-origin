# Symbol Usage Guidelines

## Overview

This document defines the essential standards for using symbols within the cognitive architecture, with a focus on the `@` symbol and file extension usage, ensuring clarity between different file types.

## File Types and Extension Guidelines

### Extension Distinction

Files in the cognitive architecture system follow a strict distinction between file types:

1.  **Core Rule Files (.md)**:
    *   **Location**: `1000xrules/core/` and subdirectories.
    *   **Purpose**: Define 1000xdev's core identity, communication, tools.
    *   **Editable**: Yes, by 1000xdev.
    *   **Syncs to `.mdc`**: Yes.
    *   **Reference**: Use path `1000xrules/core/.../file.md` in documentation.

2.  **1000xcommand Definition Files (.md)**:
    *   **Location**: `1000xrules/1000xcommands/<domain>/`.
    *   **Purpose**: Define sequences of tool calls for specific tasks.
    *   **Editable**: Yes, by 1000xdev.
    *   **Syncs to `.mdc`**: Yes.
    *   **Reference**: Use path `1000xrules/1000xcommands/.../file.md` in documentation; use `@1000xcommands/.../file` for invocation.

3.  **Brain Knowledge/Process Files (.md)**:
    *   **Location**: `1000xbrain/` and subdirectories (`brain/`, `rules/`, `front-end/`, etc.).
    *   **Purpose**: Contain domain-specific knowledge, processes, guidelines used by 1000xdev or referenced by `1000xcommands`.
    *   **Editable**: Yes, by 1000xdev.
    *   **Syncs to `.mdc`**: No.
    *   **Reference**: Use path `1000xbrain/.../file.md` in documentation.

4.  **Cursor Rule Files (.mdc)**:
    *   **Location**: `.cursor/rules/`.
    *   **Purpose**: The actual rules applied by the Cursor engine.
    *   **Editable**: **NO**, never by 1000xdev. Only by Tyler via UI.
    *   **Syncs to `.mdc`**: N/A (These *are* the `.mdc` files, generated from `1000xrules`).
    *   **Reference**: Use path `.cursor/rules/.../file.mdc` when discussing the applied rules; use `fetch_rules` with `1000xrules/.../file.mdc` path for reading.

## @ Symbol Usage Guidelines

### ⚠️ CRITICAL: @ Symbol Protection Requirements ⚠️

To avoid hallucinations and incorrect tool calls, 1000xdev MUST:

1.  **ALWAYS use backticks (``) around `@` symbols** when used in regular documentation text (e.g., `` `@1000xcommands/...` ``).
2.  **ONLY use unwrapped `@` symbols for actual `1000xcommand` invocation** when communicating with Tyler Youk.
3.  **NEVER reference `.mdc` files for editing**.
4.  **Maintain absolute clarity** when distinguishing between `.md` files (source/editable) and `.mdc` files (applied/read-only for AI).
5.  **Keep `@` symbol references minimal** in documentation to prevent parsing issues.

### Allowed @ Symbol Usage

1.  **1000xcommand Invocation (by Tyler)**:
    *   The primary use case for an unwrapped `@`.
    *   Format: `@1000xcommands/domain/command-name`.

2.  **Backtick-Wrapped Examples (in Documentation)**:
    *   Used to safely show command invocation syntax.
    *   Example: `` `@1000xcommands/brain/analyze-system-structure` ``.

3.  **Code Block Examples (in Documentation)**:
    *   Used within code blocks for illustrative purposes, ensuring proper context.

### Prohibited @ Symbol Usage

1.  **Direct Usage in Documentation Text**: 
    *   Never use `@` followed by a path directly in prose.
    *   INCORRECT: `1000xdev uses @1000xcommands/brain/analyze...`
    *   CORRECT: `1000xdev uses `@1000xcommands/brain/analyze...``

2.  **In File Names or Headers**: 
    *   Never include `@` in file names or Markdown headers.

## Command Invocation Format Summary

*   **Standard Format**: `@1000xcommands/domain/command-name`
*   **Domains**: `brain`, `front-end`, `back-end`, `scripts`, `rules`.
*   **Reference**: `1000xrules/core/communication/1000xcommands-guidelines.md`.

