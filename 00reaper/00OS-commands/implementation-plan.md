# Implementation Plan - Current Development Cycle

## Current Cycle: REQ-XXX No Active Plan

// File reset at end of REQ-001 cycle. Awaiting next active request and plan definition. // 

# Implementation Plan for REQ-001: Fix reaper-overwrite

## 1. Goal
Modify the `reaper-overwrite` process (`00os/processes/00reaper/reaper-overwrite.md`) to reliably update context files with concise summaries of source directory contents, preventing failures caused by `edit_file` size limitations when handling large concatenated content. The output should resemble the concise example provided in REQ-001.

## 2. Analysis
The previous implementation failed because it concatenated the *entire content* of all source files, resulting in a large string that exceeded the `edit_file` tool's capacity for overwriting. The user's request emphasizes creating a *concise summary* (like the example), not just a concatenation.

## 3. Chosen Approach: Metadata Extraction and Summarization
Instead of concatenating full file contents, the updated process will:
1. List files in the source directory.
2. For each file, read its content (focusing on the header/metadata section).
3. Parse key metadata (e.g., Purpose/Description, Location, Status, Key Tools) from the file's content or frontmatter.
4. Construct a concise summary string in Markdown format, similar to the user's example, using only the extracted metadata.
5. Overwrite the target context file with this *much smaller* summary string using `edit_file`.

This approach directly addresses the size limitation issue by generating a small, targeted summary instead of large, raw content.

## 4. Implementation Steps

**Phase 1: Modify `reaper-overwrite.md` Process Logic**

1.  **Refine File Reading:** Update the loop that iterates through files found by `list_dir`. Instead of reading the entire file content into `consolidatedContent`, use `read_file` to read enough lines (e.g., first 50-100, or use `should_read_entire_file` but *only parse needed parts*) to reliably capture the metadata or description section.
2.  **Implement Metadata Parsing:** Add JavaScript logic within the process's `<execution>` block to parse the read content (string manipulation or regex) to extract:
    *   File Path/Location (already available from `list_dir` result)
    *   Purpose/Description (look for specific headings or frontmatter keys)
    *   Status (if available in metadata)
    *   Key Tools (if mentioned in metadata)
3.  **Build Summary String:** Instead of appending full content, append formatted Markdown lines to a `summaryContent` variable for each file, using the extracted metadata. Structure it similar to the user's example (`## [Process Name]`, `- **Purpose**: ...`, `- **Location**: ...`, etc.).
4.  **Overwrite with Summary:** Modify the final `edit_file` call to use the `summaryContent` string (which will be significantly smaller) instead of the large `consolidatedContent`. Update the `instructions` parameter for `edit_file` accordingly.

**Phase 2: Testing**

1.  Run `> reaper-overwrite processes/00reaper 00reaper/00OS-commands/context-00OS-current-state/00reaper-processes.md` (the command that previously failed).
2.  Verify that the command completes successfully without `edit_file` errors.
3.  Inspect the overwritten `00reaper-processes.md` file to ensure it contains a concise summary matching the desired format and extracted metadata.

**Phase 3: Documentation (Minor Updates)**

1.  Briefly update the description or notes within `reaper-overwrite.md`'s frontmatter or metadata section to reflect that it now generates summaries, not full content concatenations.

## 5. Tool Calls Involved
- `list_dir`: To find files in the source directory.
- `read_file`: To read the initial part (or all, for parsing) of each source file.
- `edit_file`: To overwrite the target file with the generated *summary*.

## 6. Potential Challenges
- Inconsistent metadata formatting across different source files might make parsing difficult. The parsing logic will need to be robust or make assumptions based on current file structures.
- Determining how much of a file to read initially to guarantee capturing the necessary metadata.

## 7. Rollback Plan
- Revert changes to `00os/processes/00reaper/reaper-overwrite.md` using version control. 