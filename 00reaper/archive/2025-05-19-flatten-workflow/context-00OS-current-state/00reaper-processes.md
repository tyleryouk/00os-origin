# Context: 00reaper Current State

This file provides context on the contents of the `processes/00reaper` directory.

## reaper-analyze-tasks
- **Purpose**: Analyze the current state of all requests in user_requests.md, identifies highest priority tasks, highlights blocking issues, and generates a suggested action plan with specific next steps.
- **Location**: `00OS/processes/00reaper/reaper-analyze-tasks.md`
- **Status**: Implemented
- **Key Tools**: read_file

## reaper-implement
- **Purpose**: Reads the current task defined in 00reaper/current-task.md and executes the necessary changes to 00OS process files and tracking documents.
- **Location**: `00OS/processes/00reaper/reaper-implement.md`
- **Status**: Implemented
- **Key Tools**: read_file, edit_file

## reaper-init
- **Purpose**: Initializes the 00reaper context by loading essential system files and establishing understanding of the 00OS architecture, purpose, and workflow.
- **Location**: `00OS/processes/00reaper/reaper-init.md`
- **Status**: Implemented
- **Key Tools**: list_dir, read_file

## reaper-os-commands-workflow
- **Purpose**: Orchestrate the cyclical workflow for 00OS commands development
- **Location**: `00OS/processes/00reaper/reaper-os-commands-workflow.md`
- **Status**: Implemented
- **Key Tools**: read_file, list_dir

## reaper-overwrite
- **Purpose**: Reads all files in a source /00os/ subdirectory and generates a concise context file with basic information.
- **Location**: `00OS/processes/00reaper/reaper-overwrite.md`
- **Status**: Implemented
- **Key Tools**: list_dir, read_file, edit_file

## reaper-read-files
- **Purpose**: Read all files in a specified directory
- **Location**: `00OS/processes/00reaper/reaper-read-files.md`
- **Status**: Implemented
- **Key Tools**: list_dir, read_file

## reaper-sync
- **Purpose**: Synchronize 00os contents to .cursor/rules
- **Location**: `00OS/processes/00reaper/reaper-sync.md`
- **Status**: Implemented
- **Key Tools**: list_dir, read_file

## reaper-update
- **Purpose**: Updates the 00reaper context state with latest information from workflow files
- **Location**: `00OS/processes/00reaper/reaper-update.md`
- **Status**: Implemented
- **Key Tools**: list_dir, read_file
