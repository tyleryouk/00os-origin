# mode: plan-mode | workflow: quality-workflow | pathway: none | filepath: @parameters/quality/plan-mode/continue-planning.mdc | optional-standard-parameter(s): none

## Purpose

This parameter defines the process for continuing a previously paused planning or assessment task within the quality-workflow. Its primary function is to re-establish context by reading the relevant progress tracking file.

## Core Logic

1.  **Identify Planning Folder**: Determine the current active planning folder (e.g., based on conversation context or standard location like `/planning/current-task/`).
2.  **Locate Progress File**: Construct the path to `planning-progress.md` within the identified planning folder.
3.  **Read Progress File**: Use `read_file` with `should_read_entire_file=true` to read the contents of `planning-progress.md`.
4.  **Summarize Status**: Briefly summarize the current status, last activity, and next steps based on the progress file content.
5.  **Prompt for Next Action**: Indicate readiness to proceed with the next step outlined in the progress file.

## Implementation Notes

- Assumes the existence of a well-maintained `planning-progress.md` in the active planning directory.
- Focuses solely on context restoration from the progress file.
- Does not initiate complex analysis on its own; relies on the progress file for direction.

## Example Tool Sequence

```typescript
// 1. Read the planning progress file
read_file("planning/[current-task]/planning-progress.md", should_read_entire_file=true)

// 2. Respond with summary and readiness
//    (e.g., "Continuing the quality assessment. Last step was X. Ready to proceed with Y.")
``` 