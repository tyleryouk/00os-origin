# Migration Plan: Flatten 00reaper Workflow

## Objective
Move all contents of `00OS-commands/` to the base of `00reaper/`, archive `00OS-creation/`, and update all references for a unified, flat workflow structure.

---

## Step-by-Step Checklist

### 1. Preparation & Backup
- [ ] Backup the entire `00reaper/` directory
- [ ] Notify collaborators of the planned migration and freeze changes during the process

### 2. Inventory & Categorization
- [ ] List all files and folders in `00reaper/00OS-commands/` (user-directed, documentation, context-00OS-current-state, research-cursor, archive, README.md)
- [ ] List all files and folders in `00reaper/00OS-creation/` (for archival)
- [ ] List all files in the base of `00reaper/` and `00scripts/` to check for reference dependencies

### 3. Move Workflow Files
- [ ] Move all subfolders and files from `00OS-commands/` to the base of `00reaper/`:
    - [ ] `user-directed/`
    - [ ] `documentation/`
    - [ ] `context-00OS-current-state/`
    - [ ] `research-cursor/`
    - [ ] `archive/`
    - [ ] `README.md` (rename to `WORKFLOW-README.md` if needed to avoid conflict)
- [ ] Ensure no files are overwritten or lost during the move

### 4. Archive 00OS-creation
- [ ] Move the entire `00OS-creation/` folder into `archive/` (unless any files are still active—review before archiving)
- [ ] Update the archive index if one exists

### 5. Update References
- [ ] Read every file in `00reaper/` and all subfolders (including scripts in `00scripts/`)
- [ ] Update all references to the old `00OS-commands/` path in:
    - [ ] Documentation files
    - [ ] User rules and user-directed files
    - [ ] Research and context files
    - [ ] PowerShell scripts and automation tools
    - [ ] Any process or system files referencing the old structure
- [ ] Update README.md to reflect the new flat structure and migration rationale

### 6. Validation & Testing
- [ ] Check for broken links or outdated references in all files
- [ ] Test all scripts in `00scripts/` to ensure they work with the new structure
- [ ] Verify that all user rules, documentation, and context files are accessible and up to date
- [ ] Confirm that the archive contains all historical files and nothing active is missing

### 7. Final Cleanup
- [ ] Remove any empty folders left after the move
- [ ] Ensure folder and file permissions are correct
- [ ] Communicate the completion of the migration to all collaborators
- [ ] Document the migration in the changelog or archive for future reference

---

## Notes
- Every file in `00reaper/` and its subfolders must be reviewed for reference consistency.
- Consider renaming the main workflow README to avoid confusion with the base `README.md`.
- If any files in `00OS-creation/` are still active, move them to the appropriate new location before archiving.
- Use this checklist to track progress and ensure a smooth, lossless migration. 