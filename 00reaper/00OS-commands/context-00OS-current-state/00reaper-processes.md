# Context: 00reaper Current State

This file provides context on the contents of the `processes/00reaper` directory.

## reaper-overwrite
- **Purpose**: Reads all files in a source /00os/ subdirectory and generates a concise context file with basic information.
- **Location**: `00os/processes/00reaper/reaper-overwrite.md`
- **Status**: Implemented

## reaper-update
- **Purpose**: Updates the 00reaper context state (placeholder).
- **Location**: `00os/processes/00reaper/reaper-update.md`
- **Status**: Implemented

## reaper-os-commands-workflow
- **Purpose**: Orchestrate the cyclical workflow for 00OS commands development as defined in @00reaper/00OS-commands/README.md, supporting subcommands for each workflow step.
- **Location**: `00os/processes/00reaper/reaper-os-commands-workflow.md`
- **Status**: Implemented

## reaper-sync
- **Purpose**: Synchronize 00os contents to .cursor/rules
- **Location**: `00os/processes/00reaper/reaper-sync.md`
- **Status**: Implemented
- **Key Tools**: run_terminal_cmd

## reaper-implement
- **Purpose**: Reads the current task defined in 00reaper/00OS-commands/current-task.md and executes the necessary changes to 00OS process files and tracking documents.
- **Location**: `00os/processes/00reaper/reaper-implement.md`
- **Status**: Implemented
- **Key Tools**: read_file, edit_file

## reaper-analyze-tasks
- **Purpose**: Analyze current tasks and generate action plan
- **Location**: `00os/processes/00reaper/reaper-analyze-tasks.md`
- **Status**: Implemented
- **Key Tools**: read_file

## reaper-init
- **Purpose**: Initialize 00reaper context and load comprehensive system understanding
- **Location**: `00os/processes/00reaper/reaper-init.md`
- **Status**: Implemented
- **Key Tools**: list_dir, read_file

## reaper-read-files
- **Purpose**: Read all files in a specified directory
- **Location**: `00os/processes/00reaper/reaper-read-files.md`
- **Status**: Implemented
- **Key Tools**: list_dir, read_file
