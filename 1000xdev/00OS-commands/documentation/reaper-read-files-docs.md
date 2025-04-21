# Documentation: > reaper-read-files

## Description
Reads the content of one or more specified files and returns their contents. This command is specific to the 00reaper identity and utilizes the `read_file` tool.

## Syntax
```
> reaper-read-files [file_path1] [file_path2] ... [--lines=start-end]
```

## Parameters
- `file_path1`, `file_path2`, ... (Required): One or more relative or absolute paths to the files to be read.
- `--lines=start-end` (Optional): Specify a range of lines (1-indexed, inclusive) to read from each file (e.g., `--lines=10-50`). If omitted, the command attempts to read the entire file (subject to tool limitations). *Note: The `read_file` tool has limitations on the number of lines read at once.*

## Returns
A map where keys are the file paths and values are the contents of the files (or the specified line range). If a file cannot be read (e.g., not found, permission error), an error message will be included for that file path.

## Example Usage

### Read a single file
```
> reaper-read-files 00reaper/00OS-commands/active-request.md
```

### Read multiple files
```
> reaper-read-files 00reaper/00OS-commands/implementation-plan.md 00reaper/00OS-commands/cycle-status.md
```

### Read specific lines from a file
```
> reaper-read-files 00os/core/command-handler.md --lines=10-25
```

## Permissions
- Requires `file-read` permission.

## Error Handling
- **File Not Found**: Returns an error message for the specific file path.
- **Permission Denied**: Returns a permission error if 00reaper lacks read access.
- **Tool Error**: Propagates errors from the underlying `read_file` tool. 