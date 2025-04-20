# Active Request - Current Development Cycle

This file tracks the current user request (REQ) being implemented in the active development cycle. It provides the complete requirement details, acceptance criteria, and any clarifications needed.

## Current Request

### REQ-002: Command-Process Alignment

### Description
Ensure a 1:1 mapping between commands and processes, with each command having a single corresponding process that manages its execution. This alignment should be reflected in the directory structure and file naming convention.

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

### Technical Notes
- Process categorization is critical for maintaining system integrity
- Process file/command name alignment simplifies maintenance and reduces confusion
- Commands should follow the defined tool call sequence in their corresponding process
- When running commands, the `fetch_rules` tool must always be used to retrieve the appropriate process definition
- The three-category architecture provides clear separation between global and agent-specific commands

### Cycle Steps
1. **Read User Request REQ**: Analyze REQ-002 to understand the command-process alignment requirements
2. **Read Relevant Context**: Review current command registry and process implementations
3. **Update Core Workflow Files**: Document the approach in implementation-plan.md and cycle-status.md
4. **Make Changes to 00OS**: Implement the command-process alignment in the 00OS system
5. **Update Supporting Materials**: Update documentation to reflect the new command-process structure
6. **Reset Core Workflow Files & Sync Changes**: Clear/update core workflow files for the next cycle and run `> reaper-sync` to sync the 00OS changes to .cursor/rules

### Implementation Priority
1. First ensure all commands have a corresponding process implementation
2. Then verify process naming and location conform to the three-category architecture
3. Update the command registry to accurately reflect the new structure
4. Test each command to ensure it properly calls its associated process

### Dependent Requirements
- REQ-001: Command Registry Implementation (prerequisite)

## Clarifications and Additional Context

This section contains any additional clarifications or context gathered during the cycle:

- **Terminology Standardization**: We should standardize on "00OS processes" as the term for the process definitions that implement commands
- **Naming Convention**: Process filenames should exactly match command names (with hyphens for spaces)
- **Execution Flow**: The 3-step flow should be consistently implemented for all commands
- **Registry Verification**: Need to verify all commands in registry have corresponding process files

## Related Previous Requests

- REQ-001: Established the cyclical workflow for 00OS-commands development 