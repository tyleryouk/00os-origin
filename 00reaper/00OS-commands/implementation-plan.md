# Implementation Plan: Cycle 4 - Expand Command Simplification

## Objective
Convert all currently implemented system and 00reaper commands to the simplified, direct tool-call format as defined in the command standards and template.

## Reference Standards
- `documentation/command-template-core.md`
- `documentation/command-standards-core.md`
- `user-directed/00OS-simplification-roadmap.md`

## Commands to Convert
- System: help, version
- 00reaper: reaper-sync, reaper-init, reaper-read-files, reaper-analyze-tasks

---

## Step-by-Step Plan

### 1. Review Current Implementations
- Read each process file and identify any legacy/complex validation, error handling, or multi-step logic.
- Note any deviations from the 3-step pattern or direct tool-call approach.

### 2. For Each Command, Apply the Following Checklist:
- [ ] Remove unnecessary validation, error handling, or abstraction.
- [ ] Ensure the process consists of a direct, minimal sequence of tool calls.
- [ ] Use only the required metadata and sections as per the template.
- [ ] Add or update examples to reflect the simplified usage.
- [ ] Ensure permissions and inputs are minimal and accurate.
- [ ] Test the command for correct execution and output.

---

## Command-Specific Notes

### help (system)
- Remove any custom formatting or logic not required for listing or describing commands.
- Use list_dir and read_file tool calls only.
- Ensure output is clear and uses standard response formatting.

### version (system)
- Remove custom flag parsing and error handling.
- Use a single tool call to read version/config info, or hardcode as needed.
- Output should be minimal and clear.

### reaper-sync (00reaper)
- Already mostly simplified; verify only one tool call is used.
- Ensure only one flag is supported per invocation.
- Update examples if needed.

### reaper-init (00reaper)
- Already uses a direct sequence of read_file tool calls.
- Confirm no extra logic is present.
- Ensure all required context files are loaded.

### reaper-read-files (00reaper)
- Remove any complex argument parsing or error handling.
- Use list_dir and read_file tool calls only.
- Output should be a simple, structured result.

### reaper-analyze-tasks (00reaper)
- Remove complex parameter validation and error handling.
- Use read_file and minimal parsing only.
- Output should be a clear, actionable analysis.

---

## Final Steps
- [ ] Test all commands after conversion.
- [ ] Update documentation/examples as needed.
- [ ] Run `> reaper-sync` to synchronize changes.
