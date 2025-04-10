# Implementation: Adaptive File Reading System

## 1. Overview

I will enhance my file reading capabilities to ensure reliable processing of files regardless of size, addressing the limitations of the `read_file` tool. This plan adopts the **Adaptive Sequential Reading** strategy, replacing the previous complex multi-layer approach.

## 2. Problem Recap

The `read_file` tool, even with `should_read_entire_file=true`, can truncate files larger than ~250 lines, leading to incomplete context and errors.

## 3. Core Solution: Adaptive Sequential Reading

The refined strategy involves three steps:

1.  **Initial Complete Read Attempt**: Always use `read_file(filename, should_read_entire_file=true)` first.
2.  **Completeness Verification**: Check if the returned content represents the full file using basic file-type structural checks and primarily by verifying if the tool returned content indicating the end-of-file was reached (e.g., fewer lines returned than a large requested chunk size would imply).
3.  **Adaptive Chunking (if incomplete)**: If the initial read seems truncated, re-read the file sequentially in overlapping chunks.
    *   **Chunk Size**: 150 lines (compatible with lower-tier models).
    *   **Overlap**: 15 lines (e.g., read 1-150, then 136-285, etc.) to preserve context.
    *   **Chunk Limit**: Increase limit to 30 chunks (~4500 lines), reporting a warning if exceeded.
    *   **Markers**: Add clear markers (`--- CHUNK X (LINES Y-Z) ---`) between chunks in the combined output.

This approach is model-agnostic and focuses on practical reliability.

## 4. Target `1000xbrain` Modifications

This strategy requires modifying **two existing** files and creating **one new** file within the `1000xbrain` directory:

### 4.1 `1000xbrain/core/core-essentials.md` (Modification)

Update the "MANDATORY File Reading Standard" section:

```markdown
## ⚠️ MANDATORY File Reading Standard ⚠️

* I will ALWAYS attempt to read entire files using `should_read_entire_file=true` first.
* I will VERIFY if the reading was complete using basic structural checks and end-of-file indicators.
* If reading appears incomplete, I will IMPLEMENT the Adaptive Sequential Chunking protocol (150-line chunks, 15-line overlap, up to 30 chunks).
* I will use clear boundary markers (`--- CHUNK...`) when chunking is applied.
* I will SIGNAL explicitly in my response whether chunking was used or if the chunk limit was reached.
* I will DOCUMENT verification results (complete read, chunked read, possible partial read if chunk limit hit) in my internal processing notes and signal the outcome clearly.
* NO exceptions to these requirements are permitted.

## Internal File Reading Status Indicators

* ✅ `[filename]` - Verified complete read (initial attempt).
* 🔄 `[filename]` - Chunking applied successfully (within 30 chunks).
* ⚠️ `[filename]` - Chunking limit reached (potentially incomplete).
```

### 4.2 `1000xbrain/core/tools/file-reading-enforcement.md` (Modification)

Update the content to reflect the 3-step adaptive process:

```markdown
# Mandatory Adaptive File Reading Enforcement

## ⚠️ CRITICAL ENFORCEMENT REQUIREMENT ⚠️

I MUST follow this exact 3-step procedure for EVERY file reading operation:

1.  **Attempt Full Read**: ALWAYS call `read_file` with `should_read_entire_file=true` initially.
2.  **Verify Completeness**: Analyze the returned content.
    *   Primary Check: Does the content indicate the end-of-file was reached (e.g., fewer lines returned than a large requested chunk implies)?
    *   Secondary Check: Perform basic structural checks (e.g., balanced braces for code, conclusion markers for markdown).
    *   Determine if the file seems complete or truncated.
3.  **Apply Adaptive Chunking (If Truncated)**:
    *   If step 2 indicates truncation, re-read using the sequential, overlapping chunking protocol (150 lines, 15 overlap, max 30 chunks).
    *   Combine chunks with clear `--- CHUNK ---` markers.
    *   If the 30-chunk limit is hit, proceed with the combined content but signal a potential partial read.

## Verification and Signaling

*   For every read operation, determine the outcome: Complete, Chunked, or Potentially Partial (limit reached).
*   Signal this outcome clearly in the response to the user (e.g., "Read file X.", "Read file Y using sequential chunking (Z chunks).", "Read file W using chunking, but limit reached; content may be partial.").
*   Document the outcome internally for cognitive continuity.
```

### 4.3 `1000xbrain/knowledge/rules/patterns/tool/file-reading-patterns.md` (New File)

Create this new file to document the specific implementation patterns:

```markdown
# File Reading Implementation Patterns

## Overview

These patterns implement the Adaptive Sequential Reading strategy to handle potential `read_file` tool limitations.

## Core Pattern: `adaptiveReadFile`

This pattern encapsulates the 3-step process:

```typescript
// Conceptual Implementation Pattern for Adaptive File Reading
async function adaptiveReadFile(filename) {
  // 1. Initial Complete Read Attempt
  const initialReadResult = await read_file(filename, {
    should_read_entire_file: true,
    explanation: `Attempting complete read of ${filename}`
  });
  const initialContent = initialReadResult.read_file_response.results[0]; // Adapt based on actual tool response structure

  // 2. Completeness Verification
  const isComplete = verifyCompleteness(initialContent, filename); // Implement verification logic

  if (isComplete) {
    return {
      content: initialContent,
      chunked: false,
      complete: true,
      status: `✅ Complete file read: ${filename}`
    };
  } else {
    // 3. Adaptive Chunking
    return await readFileInChunks(filename);
  }
}

// Helper: Completeness Verification (Conceptual)
function verifyCompleteness(content, filename) {
  // Basic check: Does content seem truncated (e.g., ends abruptly)?
  // Primary Indicator: Was EOF likely reached based on read characteristics? (Needs better tool feedback ideally)
  // Secondary: File-type specific checks (balanced braces, markdown conclusions)
  // Return true if likely complete, false otherwise.
  // Example (needs refinement based on actual tool behavior):
  const lineCount = (content.match(/\n/g) || []).length + 1;
  if (lineCount < 250 && !content.endsWith("...") ) { // Simple heuristic, needs improvement
      return true; // Assume small files are complete unless clearly truncated
  }
  // Add more robust checks here based on file type and potential EOF indicators
  return false; // Default to assuming larger files might be truncated without strong evidence otherwise
}

// Helper: Sequential Chunking (Conceptual)
async function readFileInChunks(filename) {
  let fullContent = '';
  let currentLine = 1;
  const chunkSize = 150;
  const overlap = 15;
  const maxChunks = 30;
  let chunkCount = 0;
  let endReached = false;

  while (chunkCount < maxChunks) {
    chunkCount++;
    const startLine = currentLine;
    const endLine = currentLine + chunkSize - 1;

    const chunkResult = await read_file(filename, {
      start_line_one_indexed: startLine,
      end_line_one_indexed_inclusive: endLine,
      explanation: `Reading chunk ${chunkCount} (${startLine}-${endLine}) of ${filename}`
    });
    const chunkContent = chunkResult.read_file_response.results[0]; // Adapt based on actual tool response structure
    const actualLinesRead = (chunkContent.match(/\n/g) || []).length + 1;

    fullContent += `\n\n--- CHUNK ${chunkCount} (LINES ${startLine}-${endLine}) ---\n\n`;
    fullContent += chunkContent;

    // Check if end of file was likely reached in this chunk
    if (actualLinesRead < chunkSize) {
        endReached = true;
        break;
    }

    currentLine = startLine + chunkSize - overlap; // Move start position for next chunk
  }

  const complete = endReached;
  let status;
  if (complete) {
      status = `🔄 Sequential chunking applied: ${filename} (${chunkCount} chunks)`;
  } else {
      status = `⚠️ Chunking limit reached (${maxChunks} chunks): ${filename} (potentially incomplete)`;
  }

  return {
    content: fullContent,
    chunked: true,
    complete: complete,
    status: status,
    chunkCount: chunkCount
  };
}
```

## Verification Logic Details (`verifyCompleteness`)

*   **Primary Indicator:** The most reliable indicator of completeness *should* be if the `read_file` tool returns fewer lines than requested in a large chunk (e.g., requesting lines 1-1000 and getting only 600). This requires the tool to behave predictably near EOF. *Further testing is needed to confirm this behavior.*
*   **Secondary Indicators:**
    *   **Markdown:** Presence of concluding sections (`## Conclusion`, `## References`, final `---`).
    *   **Code:** Balanced braces/parentheses/brackets. Absence of abruptly ending statements.
    *   **JSON/YAML:** Valid syntax according to parser.
    *   **Generic:** Absence of common truncation markers like `...` or dangling sentences.

## Usage in Workflows

When file reading is required, internal logic should call the `adaptiveReadFile` pattern (or equivalent logic) instead of directly calling `read_file`. The status message from the result should be used in communication.

## 5. Rationale

This adaptive approach provides the best balance:
*   **Efficiency**: Attempts a full read first.
*   **Reliability**: Falls back to chunking when needed.
*   **Compatibility**: Works across model tiers.
*   **Context**: Overlapping chunks help maintain context.
*   **Transparency**: Clear signaling of the reading method used.

## 6. Testing & Validation

Testing will focus on:
*   Files of various sizes (below 250 lines, 250-1500 lines, 1500-4500 lines, >4500 lines).
*   Different file types (Markdown, Python, TypeScript, JSON).
*   Verification logic accuracy.
*   Context preservation across chunks.
*   Correct signaling in responses.