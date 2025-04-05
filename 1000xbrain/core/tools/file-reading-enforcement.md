# Mandatory Full File Reading Enforcement

## Overview

This file establishes a critical mandatory procedure for file reading operations. The system has been encountering issues with incomplete file reading, which leads to implementation errors, context loss, and cognitive fragmentation.

## ⚠️ CRITICAL ENFORCEMENT REQUIREMENT ⚠️

You MUST follow this exact procedure for EVERY file reading operation:

1. **ALWAYS set should_read_entire_file=true for initial reads**
2. **NEVER use offset/limit parameters for initial reads**
3. **IF the file is too large, implement the Multi-Pass Reading Protocol below**
4. **NEVER skip reading parts of a file based on assumptions about content**
5. **ALWAYS verify that you have processed the complete file content**

## Mandatory Implementation

```typescript
// CORRECT PATTERN - ALWAYS USE THIS
read_file("target_file.md", should_read_entire_file=true)

// INCORRECT PATTERNS - NEVER USE THESE
read_file("target_file.md", 0, 250) // WRONG - Partial reading
read_file("target_file.md") // WRONG - Missing explicit should_read_entire_file
```

### Multi-Pass Reading Protocol

For large files that exceed the maximum read size:

1. **First Pass**: Always attempt to read the entire file
   ```typescript
   const fileContent = read_file("target_file.md", should_read_entire_file=true)
   ```

2. **If truncated**, implement systematic sequential reading:
   ```typescript
   // Step 1: Read the file header (first section)
   let content = read_file("target_file.md", 0, 750)
   
   // Step 2: Detect total size from first read
   const totalSize = estimateTotalSize(content)
   
   // Step 3: Read additional chunks sequentially until complete
   let currentOffset = 750
   while (currentOffset < totalSize) {
     const nextChunk = read_file("target_file.md", currentOffset, 750)
     content += nextChunk
     currentOffset += 750
     
     // Verify we're still getting content
     if (nextChunk.trim().length === 0) break
   }
   ```

3. **Always verify** complete file reading:
   ```typescript
   // Validation check - if file seems incomplete or truncated
   if (!hasCompleteStructure(content)) {
     // Read final section for confirmation
     const endContent = read_file("target_file.md", 
                                  Math.max(0, totalSize - 750), 
                                  750)
   }
   ```

## Implementation Requirements

### 1. No Partial Reading Assumptions

NEVER make assumptions about what parts of a file are important. Always read the entire file before determining relevance.

### 2. Sequential Reading Pattern

For large files, implement strictly sequential reading:

```typescript
// Total content accumulation
let completeContent = ""

// First section (0-750)
completeContent += read_file("target_file.md", 0, 750)

// Second section (750-1500)
completeContent += read_file("target_file.md", 750, 750)

// Third section (1500-2250)
completeContent += read_file("target_file.md", 1500, 750)

// Continue until file is complete
```

### 3. Cognitive Integration

After reading all sections, ALWAYS:

1. Integrate all sections into a cohesive mental model
2. Cross-reference information across all sections
3. Verify understanding of the complete content
4. Note any potential inconsistencies between sections

### 4. Verification Requirements

After reading a file, verify completeness by checking for:

- Presence of proper ending structures (closing sections, summary)
- Balanced content sections (introduction, middle, conclusion)
- Overall coherence of the document
- No abrupt truncation or incomplete sections

## Enforcement Mechanism

This pattern is MANDATORY for all file operations and supersedes any contradictory guidance in other files. The only acceptable exception is when reading a specific section of a file after the entire file has already been read once.

## Error Recovery

If a file read operation fails or shows evidence of truncation:

1. **Immediately re-attempt** with sequential reading
2. **Never proceed** with implementation based on incomplete file content
3. **Signal explicitly** if unable to read complete file content
4. **Document the issue** in your response

## Success Validation

A successful file read operation must meet these criteria:

1. The entire file content has been processed
2. All sections have been integrated into your understanding
3. No assumptions were made about "unimportant" parts of the file
4. Implementation decisions reflect complete file context

## Related References

- Tool Usage Standards: core/tools/tool-usage-standards.md
- Cognitive Load Management: knowledge/rules/patterns/doc/cognitive-load-optimization.md
- Context Preservation: knowledge/rules/patterns/doc/context-preservation-mechanisms.md

## CRITICAL: This is a CORE directive that takes precedence over all knowledge files

This directive explicitly supersedes the partial reading patterns documented in knowledge/rules/patterns/tool/file-reading-awareness.md. While that file contains useful conceptual information, the actual implementation MUST follow the mandatory process outlined here. 