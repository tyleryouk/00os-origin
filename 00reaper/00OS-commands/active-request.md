# Active Request - Current Development Cycle

## REQ-004: Update 00OS-commands Workflow Documentation for Current Structure

### Description
The folder structure within `00reaper/00OS-commands` has been updated recently. This request involves discovering the current structure and updating key documentation files (`README.md` and `user-rules-00OS-commands.md`) to accurately reflect it.

### Goal
Ensure the README provides an accurate overview of the workflow directory structure and that the user rules file correctly represents the intended use of the workflow components.

### Acceptance Criteria

1.  **Discovery**: Discover the current file and folder structure within `00reaper/00OS-commands` (including subdirectories like `user-directed`, `documentation`, `context-00OS-current-state`, etc.).
2.  **README Update**: Update `00reaper/00OS-commands/README.md` to accurately reflect the current structure and purpose of each sub-directory/key file.
3.  **User Rules Update**: Update `00reaper/00OS-commands/user-directed/user-rules-00OS-commands.md` to align with the current structure and workflow purpose.
4.  **Consistency**: Ensure consistency between the README and the user rules file.

### Technical Notes

*   Requires using `list_dir` extensively to map the directory structure.
*   May require `read_file` on specific files if their purpose isn't clear from the name/location.
*   Focus is on accurately documenting the *existing* structure, not changing it.

### Cycle Steps (Estimated)

1.  Read User Request REQ: ✅
2.  Read Relevant Context (Discover Structure): ⏳
3.  Update Core Workflow Files (Create Plan): ⏱️
4.  Make Changes (Update README, User Rules): ⏱️
5.  Update Supporting Materials (If needed): ⏱️
6.  Reset Core Workflow Files & Sync Changes: ⏱️

## REQ-XXX: No Active Request

// File reset at end of REQ-003 cycle. Awaiting next user request. // 