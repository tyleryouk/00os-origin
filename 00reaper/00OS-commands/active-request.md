# Active Request - Current Development Cycle

## REQ-001: Create `reaper-overwrite` process

### Description
Create a new 00OS process named `reaper-overwrite`. This process will read all files within a specified source directory located under `/00os/` and overwrite a specified target context file with the consolidated content from the source files.

### Goal
Provide a command that allows automated updating of context files based on the current content of specific 00OS source directories.

### Acceptance Criteria

1.  **Process Creation**: Create a new process file at `00os/processes/00reaper/reaper-overwrite.md`.
2.  **Command Syntax**: The process should handle the command `> reaper-overwrite <source_directory> <target_context_file>`.
3.  **Input Handling**: Accept two mandatory arguments:
    *   `source_directory`: The path of the source directory *relative to the `/00os/` root* (e.g., `config`, `core`, `processes/system`).
    *   `target_context_file`: The full path of the context file to overwrite (e.g., `00reaper/00OS-commands/context-00OS-current-state/config.md`).
4.  **Directory Listing**: Use the `list_dir` tool call to find all files within the specified `source_directory` (inside `/00os/`).
5.  **File Reading**: Use the `read_file` tool call to read the *entire content* of each file found in the source directory. Address potential large file sizes if necessary (e.g., sequential chunk reads if `should_read_entire_file` fails or has limits, although the goal is full content).
6.  **Content Consolidation**: Concatenate the full content of all files read from the source directory into a single string. Include clear separators or headers indicating the original file path for each content block.
7.  **File Overwriting**: Use the `edit_file` tool call to *completely overwrite* the `target_context_file` with the consolidated content.
8.  **Error Handling**: Implement basic error handling (e.g., source directory not found, target file not specified, read/write errors).
9.  **Output**: Provide clear success or failure messages to the user.

### Technical Notes

*   The process will reside in the `00reaper` category due to its system administration/workflow nature.
*   Need to construct the full source path by prepending `/00os/` to the `source_directory` argument.
*   Pay attention to the `edit_file` usage for complete file overwriting (providing only the new content in `code_edit`).
*   Conciseness vs. completeness: Ensure the consolidation format is readable but includes all source content.

### Cycle Steps (Estimated)

1.  Read User Request REQ: ✅
2.  Read Relevant Context: ⏳
3.  Update Core Workflow Files (Create Plan): ⏱️
4.  Make Changes (Create Process File): ⏱️
5.  Update Supporting Materials (Docs/Tests): ⏱️
6.  Reset Core Workflow Files & Sync Changes: ⏱️

## REQ-XXX: No Active Request

// File reset at end of REQ-001 cycle. Awaiting next user request. // 