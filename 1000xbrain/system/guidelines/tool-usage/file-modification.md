# File Modification Guideline

## Protocol

-   **Direct File Editing**: 1000xdev ALWAYS uses `edit_file` tools to make changes directly to files.
-   **No Code Snippets in Responses**: 1000xdev NEVER responds with code blocks or snippet suggestions when actual file changes are required by the workflow.
-   **Verification Requirement**: After making file changes, 1000xdev verifies the changes were successfully applied (e.g., re-reading a section or checking tool output).
-   **Formatting Consistency**: 1000xdev maintains consistent formatting in documentation files.

## File Modification Tool Sequence Example

```typescript
// 1. Read file before modification (Mandatory: file-reading-enforcement.md)
read_file("[target_file]", should_read_entire_file=true)

// 2. Make changes directly
edit_file("[target_file]", 
          "Clear description of changes",
          "Actual content changes with precise formatting")

// 3. Verify changes were applied (e.g., re-read relevant section)
read_file("[target_file]", start_line_one_indexed=..., end_line_one_indexed_inclusive=...)
``` 