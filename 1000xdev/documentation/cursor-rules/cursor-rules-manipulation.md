# 00OS & Cursor Rules: Development Workflow

This document details the development workflow for creating and managing 00OS components (core systems and processes) within the Cursor Rules framework. Understanding this workflow is crucial for maintaining consistency and ensuring the proper functioning of 00OS.

## 1. Introduction: 00OS and Cursor Rules

00OS transforms the Cursor chat interface into a terminal-like environment by leveraging Cursor's built-in rules system.

*   **00OS:** Provides a structured command-line interface (`> command`) within the chat. Commands map to underlying "processes".
*   **Cursor Rules:** The underlying mechanism. Rules are files (`.mdc`) containing instructions (like system prompts) that guide the AI's behavior. They can be triggered automatically (based on file context or always) or manually fetched by the AI.

00OS utilizes rules to define its core logic, command handling, and individual command processes.

## 2. The Core Workflow: Dev -> Sync -> Prod

00OS development follows a strict three-stage workflow to ensure that development artifacts are correctly transformed into active Cursor rules:

1.  **Development (`00os/`):** All development work (creating/editing core components or command processes) happens exclusively within the `/00os/` directory using standard Markdown (`.md`) files. These files contain the source logic and necessary metadata.
2.  **Synchronization (`> reaper-sync`):** The `> reaper-sync` command is executed. This command invokes underlying scripts (`Sync-00OS-Complete.ps1`, `Update-MdcRuleTypes.ps1`) that:
    *   Read the `.md` source files from `/00os/`.
    *   Transform them into the production Cursor Rule format (`.mdc`).
    *   Add the necessary rule-activation frontmatter (`description`, `globs`, `alwaysApply`).
    *   Copy the resulting `.mdc` files to the corresponding location within the `/.cursor/rules/` directory.
3.  **Production (`/.cursor/rules/`):** The `/.cursor/rules/` directory contains the *active* Cursor rules (`.mdc` files) that the AI uses during chat interactions. **These files should NEVER be edited directly.** They are the output of the synchronization process.

**Critical:** Direct modification of files in `/.cursor/rules/` will be overwritten during the next sync and bypasses the intended workflow.

## 3. Development Environment (`/00os/`)

*   **Location:** `/00os/`
*   **File Type:** Standard Markdown (`.md`)
*   **Structure:** Mirrors the production rule structure:
    *   `/00os/core/`: Core system components.
    *   `/00os/config/`: System configuration rules.
    *   `/00os/processes/system/`: System command processes.
    *   `/00os/processes/00reaper/`: 00reaper-specific command processes.
    *   `/00os/processes/1000xdev/`: 1000xdev-specific command processes.
*   **Content:**
    *   **Metadata Frontmatter:** `.md` files (especially process files) should include a YAML frontmatter block defining metadata like `name`, `description`, `version`, `author`, `permissions`, `inputs`, `outputs`, etc. This metadata is used by 00OS but is *not* the rule-activation frontmatter.
    *   **Logic/Instructions:** The body of the `.md` file contains the core logic, instructions, or JavaScript execution blocks for the component or process.

## 4. Synchronization Process (`> reaper-sync`)

*   **Command:** `> reaper-sync`
*   **Purpose:** To bridge the development environment (`/00os/`) and the production environment (`/.cursor/rules/`) by transforming `.md` files into `.mdc` rules and applying the correct activation frontmatter.
*   **Underlying Scripts:**
    *   `00reaper/00scripts/Sync-00OS-Complete.ps1`: Main orchestration script.
    *   `00reaper/00scripts/Update-MdcRuleTypes.ps1`: Helper script responsible for determining and adding the rule-activation frontmatter based on the file's location/type.
*   **Actions Performed:**
    1.  Reads all `.md` files within `/00os/`.
    2.  Determines the appropriate rule activation frontmatter for each file based on its path (see Section 6: Rule Types).
    3.  Creates corresponding `.mdc` files in `/.cursor/rules/`.
    4.  Prepends the determined rule-activation frontmatter (`description`, `globs`, `alwaysApply`) to the `.mdc` file content.
    5.  Appends the original `.md` file content (including its metadata frontmatter and logic) to the `.mdc` file.
    6.  Optionally detects and removes "orphan" `.mdc` files in `/.cursor/rules/` that no longer have a corresponding `.md` source file in `/00os/`.
*   **Flags:**
    *   `--detect-orphans`: Lists orphan `.mdc` files without deleting them.
    *   `--remove-orphans`: Deletes orphan `.mdc` files.
    *   `--dry-run`: Shows what actions *would* be taken without actually modifying any files.

## 5. Production Environment (`/.cursor/rules/`)

*   **Location:** `/.cursor/rules/`
*   **File Type:** Cursor Rule Files (`.mdc`)
*   **Origin:** These files are *generated* by the `> reaper-sync` process. **Do not edit manually.**
*   **Structure:** Mirrors the `/00os/` structure.
*   **Content:** Each `.mdc` file consists of:
    1.  **Rule Activation Frontmatter:** A YAML block added by the sync script (`description`, `globs`, `alwaysApply`) that tells Cursor *how* and *when* to load the rule.
    2.  **Original `.md` Content:** The full content from the corresponding source `.md` file (including its metadata frontmatter and logic).

## 6. Rule Types & Frontmatter Configuration

Cursor determines how a rule (`.mdc` file) is activated based on its frontmatter. The `> reaper-sync` process automatically generates the correct activation frontmatter based on the source file's location within `/00os/`.

| Rule Type         | `description`   | `globs`         | `alwaysApply` | Activation Trigger           | 00OS Usage                    | Source Location (`/00os/`) |
| :---------------- | :-------------- | :-------------- | :------------ | :--------------------------- | :---------------------------- | :------------------------- |
| **Always Rule**   | blank           | blank           | `true`        | Always loaded                | Core Systems, Config          | `core/`, `config/`         |
| **Agent Select**  | **Populated**   | blank/Populated | `false`       | AI Fetches via Description   | Command Processes             | `processes/`               |
| **Auto Rule**     | blank           | **Populated**   | `false`       | File Match via Globs         | *Not currently used by sync*  | *(N/A via current sync)*   |
| **Manual Rule**   | blank           | blank           | `false`       | User `@` Mention             | *Not currently used by sync*  | *(N/A via current sync)*   |

**How `> reaper-sync` Assigns Types:**

*   Files in `/00os/core/` and `/00os/config/` are synced to `/.cursor/rules/core/` and `/.cursor/rules/config/` respectively, and are given `alwaysApply: true` frontmatter, making them **Always Rules**.
*   Files in `/00os/processes/` are synced to `/.cursor/rules/processes/` and are given `alwaysApply: false` and a populated `description` field (typically derived from the `.md` metadata or a standard template like "USE WHEN you want to execute [command-name]"), making them **Agent Select Rules**.
*   The current sync script *does not* automatically create Auto or Manual rules based on source file location or metadata.

## 7. Best Practices & Troubleshooting

*   **Always Develop in `/00os/`:** Never edit `.mdc` files in `/.cursor/rules/` directly.
*   **Run `> reaper-sync` After Changes:** Ensure your changes in `/00os/` are reflected in the active rules.
*   **Verify Process Filenames:** Process `.md` files in `/00os/processes/` must match the command name (e.g., `system-status.md` for `> system status`, `file-list.md` for `> file list`). Use hyphens for spaces.
*   **Check Frontmatter:** Ensure `.md` files have correct metadata frontmatter. Remember this is *different* from the rule-activation frontmatter added during sync.
*   **Orphan Management:** Periodically run `> reaper-sync --detect-orphans` and `> reaper-sync --remove-orphans` to keep `/.cursor/rules/` clean.
*   **Restart Cursor:** Sometimes, Cursor may need a restart to fully recognize changes in `/.cursor/rules/`.
*   **Use `.gitignore`:** Consider adding `/.cursor/rules/` to your `.gitignore` if multiple developers are involved and syncing is part of the standard workflow, to avoid committing generated files. However, for solo development or controlled team environments, committing them might be acceptable to ensure consistency.