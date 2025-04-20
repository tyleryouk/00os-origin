# Active Request - Current Development Cycle

This file tracks the current user request (REQ) being implemented in the active development cycle. It provides the complete requirement details, acceptance criteria, and any clarifications needed.

## Current Request

### REQ-002: Command-Process Alignment

#### Requirements:
- Ensure 1 to 1 alignment between 00OS commands (commands sent from the Cursor prompt) with 00OS processes.
- Establish a system to ensure alignment between the 00OS commands listed in `> help` and `> command-registry` and all 00OS processes in `/00os/processes/`.
- Consider removing inaccurate or outdated system commands.
- Define a clear 00OS command to 00OS processes alignment plan.

#### Key Questions:
- Should we define 00OS processes as "00OS command processes" or simply "00OS processes"?
- Is the command execution flow clear and consistent?
  1. AI Agent receives 00OS command starting with `>`
  2. AI Agent makes `fetch_rules` call to 00OS process associated with 00OS command (00OS process filename should match 00OS command name)
  3. AI Agent performs ALL tool calls defined within the 00OS process

#### Priority: High

#### Dependencies:
- Command registry structure
- Process categorization architecture
- Command handler implementation

## Clarifications and Additional Context

This section contains any additional clarifications or context gathered during the cycle:

- **Terminology Standardization**: We should standardize on "00OS processes" as the term for the process definitions that implement commands
- **Naming Convention**: Process filenames should exactly match command names (with hyphens for spaces)
- **Execution Flow**: The 3-step flow should be consistently implemented for all commands
- **Registry Verification**: Need to verify all commands in registry have corresponding process files

## Related Previous Requests

- REQ-001: Established the cyclical workflow for 00OS-commands development 