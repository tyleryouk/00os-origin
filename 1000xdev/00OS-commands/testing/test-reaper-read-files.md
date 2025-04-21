# Test Plan: > reaper-read-files

## Objective
Verify the functionality and robustness of the `> reaper-read-files` command.

## Test Cases

### TC-RRF-001: Read Single Existing File (Full)
- **Command**: `> reaper-read-files 00reaper/00OS-commands/README.md`
- **Expected**: ✅ Success message. Output contains the full content of `README.md` mapped to its path.

### TC-RRF-002: Read Multiple Existing Files (Full)
- **Command**: `> reaper-read-files 00reaper/00OS-commands/active-request.md 00reaper/00OS-commands/cycle-status.md`
- **Expected**: ✅ Success message. Output contains the full content of both files, each mapped to its respective path.

### TC-RRF-003: Read Non-Existent File
- **Command**: `> reaper-read-files non_existent_file.txt`
- **Expected**: ⚠️ Partial success or ❌ Error message. Output indicates an error for `non_existent_file.txt` (e.g., 'File not found').

### TC-RRF-004: Read Mix of Existing and Non-Existent Files
- **Command**: `> reaper-read-files 00reaper/00OS-commands/README.md non_existent_file.txt`
- **Expected**: ⚠️ Partial success message. Output contains the content of `README.md` and an error message for `non_existent_file.txt`.

### TC-RRF-005: Read File with Specific Line Range
- **Command**: `> reaper-read-files 00reaper/00OS-commands/README.md --lines=2-4`
- **Expected**: ✅ Success message. Output contains lines 2 through 4 (inclusive) of `README.md`.

### TC-RRF-006: Read File with Invalid Line Range (e.g., end < start)
- **Command**: `> reaper-read-files 00reaper/00OS-commands/README.md --lines=10-5`
- **Expected**: ❌ Error message indicating an invalid line range provided via the flag, or an error from the `read_file` tool.

### TC-RRF-007: Read File with Out-of-Bounds Line Range
- **Command**: `> reaper-read-files 00reaper/00OS-commands/README.md --lines=1000-1010` (Assuming README has < 1000 lines)
- **Expected**: ✅ Success message or ⚠️ Warning. Output contains lines from 1000 up to the end of the file, or potentially an empty string if the start is beyond the last line, depending on `read_file` tool behavior.

### TC-RRF-008: Read File with No Arguments
- **Command**: `> reaper-read-files`
- **Expected**: ❌ Error message indicating that at least one file path argument is required.

### TC-RRF-009: Read File with Permission Denied (Simulated/If Possible)
- **Command**: `> reaper-read-files /path/to/restricted/file` (Requires setup of a file 00reaper cannot access)
- **Expected**: ❌ Error message indicating a permission error for the specified file.

### TC-RRF-010: Read Multiple Files with Line Range
- **Command**: `> reaper-read-files 00reaper/00OS-commands/README.md 00reaper/00OS-commands/active-request.md --lines=1-5`
- **Expected**: ✅ Success message. Output contains lines 1-5 from *both* files, mapped to their respective paths. 