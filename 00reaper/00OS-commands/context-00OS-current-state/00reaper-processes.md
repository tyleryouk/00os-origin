# Context: 00reaper Processes Current State

This file provides context on the currently implemented processes specific to the 00reaper identity.

## reaper-init
- **Purpose**: Initializes the 00reaper context, loading essential knowledge about 00OS architecture, workflows, and identity.
- **Location**: `00os/processes/00reaper/reaper-init.md`
- **Status**: Implemented.

## reaper-sync
- **Purpose**: Synchronizes changes made in the `00os/` development directory to the `.cursor/rules/` production directory.
- **Location**: `00os/processes/00reaper/reaper-sync.md`
- **Status**: Implemented.

## reaper-analyze-tasks
- **Purpose**: Analyzes user requests or project goals to generate implementation plans.
- **Location**: `00os/processes/00reaper/reaper-analyze-tasks.md`
- **Status**: Defined (Implementation TBD).

## reaper-implement
- **Purpose**: Executes the steps outlined in an implementation plan.
- **Location**: `00os/processes/00reaper/reaper-implement.md`
- **Status**: Defined (Implementation TBD).

## reaper-read-files
- **Purpose**: Reads the content of specified files using the `read_file` tool.
- **Location**: `00os/processes/00reaper/reaper-read-files.md`
- **Status**: Implemented (as part of REQ-001).
- **Key Tool**: `read_file`

## reaper-overwrite
- **Purpose**: Reads all files in a source `/00os/` subdirectory and generates a concise context file with basic information.
- **Location**: `00os/processes/00reaper/reaper-overwrite.md`
- **Status**: Implemented (as part of REQ-001).
- **Key Tools**: `list_dir`, `read_file`, `edit_file`
