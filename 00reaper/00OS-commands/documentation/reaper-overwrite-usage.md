# reaper-overwrite Command

## Overview
The `reaper-overwrite` command reads all files in a source directory within `/00os/` and generates a concise context file with basic information about each file. This command is particularly useful for generating context files for different parts of the 00OS system.

## Syntax
```
> reaper-overwrite <source_directory> <target_context_file>
```

### Parameters
- `source_directory`: The source directory path relative to `/00os/` (e.g., 'config', 'processes/system')
- `target_context_file`: The full path to the target context file to overwrite

## Examples
```
> reaper-overwrite processes/00reaper 00reaper/00OS-commands/context-00OS-current-state/00reaper-processes.md
```
Generates a context file with information about all processes in the 00reaper directory.

```
> reaper-overwrite config 00reaper/00OS-commands/context-00OS-current-state/config.md
```
Generates a context file with information about the 00OS configuration files.

## Workflow
1. The command lists all markdown files (`.md`) in the specified source directory
2. It reads each file and extracts key information:
   - File name
   - Purpose/description (from frontmatter or specific sections)
   - Location path
   - Implementation status
   - Key tools used (extracted from the code)
3. It generates a concise context file following a consistent format
4. The target file is overwritten with the generated context

## Output Format
The generated context file follows this format:
```md
# Context: [Directory] Current State

This file provides context on the contents of the `[directory]` directory.

## [filename1]
- **Purpose**: [Description extracted from the file]
- **Location**: `[file path]`
- **Status**: [Implementation status]
- **Key Tools**: [tools used, if any]

## [filename2]
- **Purpose**: [Description extracted from the file]
- **Location**: `[file path]`
- **Status**: [Implementation status]
- **Key Tools**: [tools used, if any]
```

## Notes
- Only processes markdown files (`.md`)
- Attempts to extract metadata from frontmatter first, then falls back to markdown headings
- Can determine implementation status from the presence of code in the file
- Automatically extracts tool usages from the code

## Related Commands
- `reaper-read-files`: For reading individual files or specific content
- `reaper-sync`: For syncing changes between the 00os directory and .cursor/rules 