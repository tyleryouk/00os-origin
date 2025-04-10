# Directory Organization (`1000xcommands`)

## Overview

This file explains the standard directory structure for `1000xcommands` definition files (`.md`), ensuring commands are organized logically by domain and component.

## Top-Level Domains

The `1000xcommands/` directory is divided into three top-level domain directories, mirroring the overall architecture:

*   **`1000xcommands/system/`**: Contains commands related to managing the 1000xdev system itself.
*   **`1000xcommands/frontend/`**: Contains commands related to developing the target front-end application.
*   **`1000xcommands/backend/`**: Contains commands related to developing the target back-end application.

## System Domain Components (`1000xcommands/system/`)

Within the `system` domain, commands are further organized by the component they primarily manage:

*   **`1000xcommands/system/brain/`**: Commands for managing `1000xbrain` content (knowledge, processes) within any domain, including system-wide analysis or bootstrapping application domain brain structures.
    *   *Examples*: `analyze-knowledge-gaps`, `create-process-template`, `bootstrap-app-domain`.
*   **`1000xcommands/system/rules/`**: Commands for managing `1000xrules` files.
    *   *Examples*: `create-rule`, `update-rule`, `verify-rule-syntax`.
*   **`1000xcommands/system/commands/`**: Commands for managing `1000xcommands` files themselves (meta-commands).
    *   *Examples*: `create-command`, `update-command-structure`, `list-domain-commands`.
*   **`1000xcommands/system/plans/`**: Commands for managing `1000xplans` files and planning processes.
    *   *Examples*: `create-plan`, `update-progress-log`, `verify-plan-requirements`.
*   **`1000xcommands/system/scripts/`**: Commands for managing `1000xscripts` files.
    *   *Examples*: `create-script`, `update-script`, `verify-script-syntax`.
*   **`1000xcommands/system/` (Root)**: Commands performing system-wide actions or coordinating across multiple components.
    *   *Examples*: `verify-system-integrity`, `update-documentation`, `propagate-guideline-change`.

## Application Domains (`frontend`/`backend`)

Commands within `1000xcommands/frontend/` and `1000xcommands/backend/` should be organized based on the features or architectural components of the target application.

*   *Example (`frontend`)*: `1000xcommands/frontend/authentication/`, `1000xcommands/frontend/components/`, `1000xcommands/frontend/testing/`
*   *Example (`backend`)*: `1000xcommands/backend/api/users/`, `1000xcommands/backend/database/migrations/`, `1000xcommands/backend/testing/`

The specific structure will evolve based on the application's needs.

## Command Naming Conventions

*   Use lowercase letters.
*   Use hyphens (`-`) to separate words.
*   Use verb-noun pairings where possible (e.g., `create-rule`, `verify-command`).
*   Be descriptive and unambiguous.

## Invocation Path Reminder

Remember that the invocation path `run command:<domain>/<path>/<command-name>` uses the path *relative* to the domain directory.

*   `run command:system/rules/create-rule` refers to `1000xcommands/system/rules/create-rule.md`.
*   `run command:system/verify-system-integrity` refers to `1000xcommands/system/verify-system-integrity.md`.
*   `run command:frontend/authentication/implement-login-ui` refers to `1000xcommands/frontend/authentication/implement-login-ui.md`. 