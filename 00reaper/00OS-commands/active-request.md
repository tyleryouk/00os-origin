# Active Request - Current Development Cycle

This file tracks the current user request (REQ) being implemented in the active development cycle. It provides the complete requirement details, acceptance criteria, and any clarifications needed.

## Current Request

### REQ-002: Command-Process Alignment

### Description
Ensure a 1:1 mapping between commands and processes, with each command having a single corresponding process that manages its execution. This alignment should be reflected in the directory structure and file naming convention, and properly integrated with the cursor rules system.

### Acceptance Criteria
1. Each command should have exactly one corresponding process implementation
2. Process files should be named according to the command they implement (e.g., `help.js` for the `help` command)
3. Commands should be properly categorized within the three-category architecture:
   - System Processes (Global) in `/00os/processes/system/`
   - 00reaper Processes in `/00os/processes/00reaper/`
   - 1000xdev Processes in `/00os/processes/1000xdev/`
4. Command registry should reflect this 1:1 mapping, ensuring no duplication or gaps
5. Process implementations should correctly match their command definitions
6. Command/process paths should align with the three-category architecture
7. Added and revised commands from REQ-001 should adhere to this architecture
8. Existing commands should be restructured as needed to follow this architecture
9. Implementation should adhere to cursor rules development workflow
10. Changes must be properly synchronized from development to production environment

### Technical Notes
- **Process Categorization**: Strict adherence to the three-category architecture (`system/`, `00reaper/`, `1000xdev/` within `00os/processes/`) is essential for organization and potential future permission models.
- **Naming Convention**: Process `.md` filenames in `00os/processes/` must exactly match the command name (lowercase, hyphens for spaces) to ensure the `fetch_rules` step functions correctly.
- **Execution Flow**: The mandatory sequence (`> detection` -> `fetch_rules` -> `process execution`) must be enforced by the command handler for all commands. No direct execution or self-calls via `run_terminal_cmd`.
- **Cursor Rules Workflow**: This is non-negotiable.
    - **Development**: Occurs *only* in `00os/` using `.md` files.
    - **Synchronization**: Changes *must* be deployed using `> reaper-sync` (which runs the sync script) to generate `.mdc` rules.
    - **Production**: Active rules are *only* in `.cursor/rules/` as `.mdc` files (do not edit directly).
    - **Rule Types**: Core components (`command-handler`, etc.) require `alwaysApply: true` in `.mdc` frontmatter; Process rules require `description: USE WHEN...` in `.mdc` frontmatter.
- **Metadata vs. Rules**: The YAML frontmatter in `.md` files defines command *metadata* (inputs, outputs, etc.). The frontmatter in the generated `.mdc` files defines Cursor *rule behavior* (activation, description).

### Cycle Steps
1. **Read User Request REQ**: Analyze REQ-002 to understand the command-process alignment requirements ✅
2. **Read Relevant Context**: Review current command registry, process implementations, and cursor rules manipulation documentation ✅
3. **Update Core Workflow Files**: Document the approach in `implementation-plan.md` and `cycle-status.md`, ensuring proper cursor rules integration ⏳
4. **Make Changes to 00OS**: Implement the command-process alignment in the `00os/` development directory.
5. **Update Supporting Materials**: Update documentation (`command-registry.md`, guides) to reflect the aligned structure.
6. **Reset Core Workflow Files & Sync Changes**: Clear/update core workflow files for the next cycle and run `> reaper-sync` to sync `00os/` changes to `.cursor/rules`.

### Implementation Priority
1. Ensure command handler enforces correct execution flow (`fetch_rules`, no self-calls).
2. Audit and align all process `.md` files in `00os/processes/` (create/rename/move/delete) to achieve 1:1 mapping with documented commands.
3. Verify process file naming and categorization within `00os/processes/`.
4. Update `documentation/command-registry.md` and user/dev guides.
5. Test the `> reaper-sync` process and verify the generated `.mdc` rules in `.cursor/rules/`.
6. Test command execution using the synced rules.

### Dependent Requirements
- REQ-001: Command Registry Implementation (prerequisite)

## Clarifications and Additional Context

This section contains any additional clarifications or context gathered during the cycle:

- **Terminology Standardization**: "00OS processes" for `.md` files in `00os/`, "command" for `>` invocations, "rule" for `.mdc` files in `.cursor/rules/`.
- **Naming Convention**: Process filenames (`process-name.md`) must exactly match command names (`> process-name`).
- **Execution Flow**: Mandatory `fetch_rules` step is handled by the `command-handler` rule.
- **Registry Verification**: `command-registry.md` must accurately map commands to their `.md` process file paths in `00os/processes/`.
- **Cursor Rules Workflow**: Confirmed: Develop in `00os/` (`.md`) -> Sync via `> reaper-sync` -> Production in `.cursor/rules/` (`.mdc`).
- **Synchronization Process**: `> reaper-sync` command utilizes `00reaper/00scripts/Sync-00OS-Complete.ps1`.
- **Rule Types & Frontmatter**: Core components get `alwaysApply: true`; Processes get `description: USE WHEN...`. This frontmatter is added *during sync* to the `.mdc` files, it's not manually placed in the source `.md` files.

### Additional Insights from Context Review

- **Implemented Commands**: Existing commands in `system/`, `00reaper/`, and `tools/` categories serve as examples but must be verified against REQ-002 criteria.
- **Process File Structure**: `.md` files require standard YAML frontmatter for *metadata*, distinct from the rule-activation frontmatter added to `.mdc` files during sync.
- **Command Handler Requirements**: Must enforce `fetch_rules` and prevent self-execution.
- **Dynamic Discovery**: REQ-007's proposal remains relevant for potential future automation of registry updates.

## Related Previous Requests

- REQ-001: Established the cyclical workflow for 00OS-commands development 
- REQ-007: Proposed dynamic command discovery to improve discoverability and synchronization 