# Tool Usage Standards

## Overview

This document establishes mandatory standards for tool usage within the 1000xbrain cognitive architecture. These standards ensure consistent, reliable, and effective tool operation across all implementation contexts.

## ⚠️ CRITICAL TOOL REQUIREMENTS ⚠️

### File Reading Tools

1. **MANDATORY Full File Reading**:
   - ALWAYS use `should_read_entire_file=true` for initial file reads
   - Follow the complete procedure in core/tools/file-reading-enforcement.md for ALL file operations
   - This supersedes any contradictory guidance in knowledge files

2. **Sequential Reading Protocol**:
   - For large files, implement sequential reading as outlined in file-reading-enforcement.md
   - Never skip sections or make assumptions about file content relevance
   - Always verify complete file integration before implementation

3. **Content Verification**:
   - For all file reads, verify that you have processed the complete content
   - Check for proper structural components (beginning, middle, end)
   - Ensure no abrupt truncation or missing sections

```typescript
// ONLY correct pattern for initial file reads
read_file("target_file.path", should_read_entire_file=true)
```

See core/tools/file-reading-enforcement.md for complete details on mandatory file reading implementation.

### Search Tools

1. **Search Tool Sequencing**:
   - Start with semantic search (codebase_search) for concept-based searching
   - Use grep_search for exact pattern matching only after semantic search
   - Combine search results for comprehensive understanding

2. **Search Scope Optimization**:
   - Begin with broader search parameters
   - Progressively narrow scope based on initial results
   - Use directory targeting when specific locations are known

3. **Result Verification**:
   - Always verify search results by reading the complete files found
   - Never implement based solely on search result snippets
   - Cross-reference search results with full file context

```typescript
// Recommended search sequence
codebase_search("concept or functionality", ["relevant_directories"])
grep_search("exact_pattern", case_sensitive=false, include_pattern="*.ext")
```

### File Editing Tools

1. **Mandatory Pre-Edit Reading**:
   - ALWAYS read the complete file before making any edits
   - Understand the full context and structure of the file
   - Identify dependencies and imports before modification

2. **Context Preservation**:
   - Maintain existing code style and patterns
   - Preserve import structure and organization
   - Follow established naming conventions

3. **Edit Verification**:
   - After editing, verify changes were successfully applied
   - Confirm changes maintain structural integrity
   - Ensure changes do not introduce errors

```typescript
// Required edit sequence
const fileContent = read_file("target_file.path", should_read_entire_file=true)
edit_file("target_file.path", "Implementation purpose", "// code changes")
```

### Command Tools

1. **Safe Command Execution**:
   - Always explain the purpose of commands clearly
   - Use commands for information gathering, not application execution
   - Never run development server commands

2. **Command Piping Requirements**:
   - Always pipe pager commands with `| cat` to avoid blocking
   - Ensure proper chaining for PowerShell commands (use `;` not `&&`)
   - Add appropriate error handling for critical commands

3. **Background Process Management**:
   - Only use background processes for appropriate long-running tasks
   - Properly set is_background=true for non-blocking operations
   - Never run critical commands in background

```typescript
// Safe command patterns
run_terminal_cmd("command | grep pattern | cat", is_background=false)
```

## Tool Combination Patterns

### Reading → Search → Edit Pattern

The optimal sequence for implementation:

1. **Read complete file** for context:
   ```typescript
   const fileContent = read_file("target_file.path", should_read_entire_file=true)
   ```

2. **Search for related patterns**:
   ```typescript
   codebase_search("related functionality", ["relevant_directories"])
   ```

3. **Read related files** completely:
   ```typescript
   const relatedContent = read_file("related_file.path", should_read_entire_file=true)
   ```

4. **Make informed edits**:
   ```typescript
   edit_file("target_file.path", "Implementation purpose", "// code changes")
   ```

5. **Verify edits** were successful:
   ```typescript
   const updatedContent = read_file("target_file.path", should_read_entire_file=true)
   ```

### Research → Implementation Pattern

For exploring and implementing new features:

1. **Broad concept search**:
   ```typescript
   codebase_search("concept or feature", [])
   ```

2. **Directory exploration**:
   ```typescript
   list_dir("relevant_path")
   ```

3. **Complete file reading**:
   ```typescript
   const fileContent = read_file("target_file.path", should_read_entire_file=true)
   ```

4. **Exact pattern search**:
   ```typescript
   grep_search("specific_pattern", case_sensitive=false, include_pattern="*.ext")
   ```

5. **Implementation**:
   ```typescript
   edit_file("target_file.path", "Implementation purpose", "// code changes")
   ```

## Critical Tool Usage Errors to Avoid

1. **Incomplete File Reading**:
   - ❌ Reading only portions of files
   - ❌ Making assumptions about file content
   - ❌ Skipping "unimportant" sections
   - ✅ ALWAYS read entire files with should_read_entire_file=true

2. **Implementation Without Context**:
   - ❌ Editing files without reading them first
   - ❌ Implementing based only on search snippets
   - ❌ Making changes without understanding dependencies
   - ✅ ALWAYS understand complete context before implementation

3. **Unsafe Command Execution**:
   - ❌ Running development server commands
   - ❌ Using command output without piping through cat
   - ❌ Executing commands that modify system state
   - ✅ ALWAYS use commands for information gathering only

## Tool-Based Cognitive Enhancement

These tool standards are designed to enhance cognitive capabilities by:

1. **Ensuring Complete Context**: Always working with complete information
2. **Preserving Mental Models**: Building coherent understanding across file operations
3. **Preventing Fragmentation**: Avoiding partial or disconnected implementation
4. **Enabling Pattern Recognition**: Identifying and following established patterns
5. **Maintaining Consistency**: Ensuring reliable and predictable implementation

## Implementation in Workflows

These standards apply to all workflow types:

1. **Rules Workflow**: For cognitive architecture enhancement
2. **Front-End Workflow**: For front-end application development
3. **Back-End Workflow**: For back-end service implementation
4. **Scripts Workflow**: For utility script development

No exceptions to these standards are permitted for any workflow type.

## Related References

- File Reading Enforcement: core/tools/file-reading-enforcement.md
- Cognitive Load Management: knowledge/rules/patterns/doc/cognitive-load-optimization.md
- Context Preservation: knowledge/rules/patterns/doc/context-preservation-mechanisms.md
- Tool Patterns: knowledge/rules/patterns/tool/basic-patterns.md 