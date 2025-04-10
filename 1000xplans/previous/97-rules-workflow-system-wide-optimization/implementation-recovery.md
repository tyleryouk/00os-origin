# Implementation: File Reading Recovery System

## 1. Overview

This document details the implementation of a recovery system that automatically handles incomplete file reads. The system will identify truncation points, implement multi-pass reading, and ensure cognitive continuity throughout the recovery process.

## 2. Current State Analysis

Currently, when a file read is incomplete:
1. No automatic recovery is attempted
2. Context is permanently lost
3. Implementation errors occur due to missing information
4. Manual chunking must be implemented ad-hoc
5. No standardized approach exists for handling large files

## 3. Implementation Approach

### 3.1 Sequential Recovery Protocol

```typescript
// Recovery function for truncated files
async function recoverTruncatedFile(filePath, partialContent, truncationInfo) {
  // Start with existing content
  let fullContent = partialContent;
  
  // Calculate starting position for recovery
  const startPosition = truncationInfo.truncationPoint || estimateTruncationPoint(partialContent);
  
  // Track recovery attempts
  let attempts = 0;
  const maxAttempts = 3;
  
  // Sequential chunk reading
  while (attempts < maxAttempts) {
    attempts++;
    
    // Read next chunk - optimal chunk size of 250 lines
    const nextChunk = await read_file(filePath, startPosition + (attempts - 1) * 250, 250);
    
    // Add to accumulated content
    fullContent += nextChunk;
    
    // Verify if complete after adding chunk
    const verification = verifyCompleteReading(fullContent, filePath);
    if (verification.complete) {
      return {
        content: fullContent,
        complete: true,
        verified: true,
        attempts: attempts
      };
    }
    
    // Exit if we're getting empty content
    if (nextChunk.trim().length === 0) {
      break;
    }
  }
  
  // Return best effort result
  return {
    content: fullContent,
    complete: false,
    verified: false,
    attempts: attempts,
    partialRecovery: true
  };
}
```

### 3.2 Smart Boundary Detection

```typescript
// Detect optimal recovery boundaries to maintain semantic coherence
function findRecoveryBoundaries(content, fileType) {
  // Boundary detection strategies by file type
  const strategies = {
    'markdown': findMarkdownBoundaries,
    'javascript': findCodeBoundaries,
    'typescript': findCodeBoundaries,
    'python': findCodeBoundaries,
    'json': findDataBoundaries,
    'yaml': findDataBoundaries,
    'text': findTextBoundaries
  };
  
  // Apply appropriate strategy or default
  return (strategies[fileType] || findTextBoundaries)(content);
}
```

### 3.3 Semantic Section Recovery

```typescript
// Recover specific sections of a file when structure is known
async function recoverSpecificSections(filePath, partialContent, missingElements) {
  // Identify important missing sections
  const criticalSections = identifyCriticalSections(missingElements);
  
  // Estimate section locations
  const sectionLocations = estimateSectionLocations(filePath, criticalSections);
  
  // Target recovery of critical sections
  const recoveredSections = {};
  
  for (const section of criticalSections) {
    const location = sectionLocations[section];
    
    if (location) {
      // Read specific section
      recoveredSections[section] = await read_file(
        filePath, 
        location.startLine,
        location.lineCount
      );
    }
  }
  
  // Reconstruct content with recovered sections
  return reconstructWithSections(partialContent, recoveredSections);
}
```

## 4. Recovery Strategies

### 4.1 Sequential Reading
- Start from estimated truncation point
- Read fixed-size chunks (250 lines each)
- Verify after each chunk
- Continue until complete or max attempts

### 4.2 Section-Based Recovery
- Estimate missing sections
- Target specific sections
- Read each section independently
- Reconstruct complete document

### 4.3 Structure-Aware Recovery
- Analyze partial content for structure
- Identify logical boundaries
- Read chunks at boundary points
- Preserve semantic coherence

### 4.4 Context Preservation
- Maintain mental model between chunks
- Track cross-references
- Ensure cognitive continuity
- Merge context from all sections

## 5. Recovery Reporting

```typescript
// Report recovery actions for transparency
function reportRecovery(filePath, recoveryResult) {
  // Generate recovery report
  const report = {
    file: filePath,
    recoverySuccess: recoveryResult.complete,
    attemptsMade: recoveryResult.attempts,
    recoveredLines: estimateRecoveredLines(recoveryResult),
    timestamp: new Date().toISOString()
  };
  
  // Log report
  logRecoveryReport(report);
  
  // Return report for transparency
  return report;
}
```

## 6. Implementation Plan

### 6.1 Brain-File Changes

Create `1000xbrain/core/tools/file-reading-recovery.md`:
- Include recovery function implementations
- Add boundary detection algorithms
- Include section recovery methods
- Add context preservation strategies
- Include recovery reporting

### 6.2 Testing Implementation

Create recovery test cases:
- Various truncation scenarios
- Different file types and sizes
- Edge cases for each recovery strategy
- Performance measurement

## 7. Integration with Verification

```typescript
// Complete reading workflow with verification and recovery
async function completeReadingWorkflow(filePath) {
  // Initial read attempt
  const initialContent = await read_file(filePath, should_read_entire_file=true);
  
  // Verify completeness
  const verification = verifyCompleteReading(initialContent, filePath);
  
  // Automatic recovery if needed
  if (!verification.complete) {
    // Select recovery strategy based on verification results
    const recoveryStrategy = selectRecoveryStrategy(verification);
    
    // Execute recovery
    const recoveryResult = await executeRecovery(
      filePath, 
      initialContent, 
      verification, 
      recoveryStrategy
    );
    
    // Report recovery
    reportRecovery(filePath, recoveryResult);
    
    // Return recovered content
    return recoveryResult;
  }
  
  // Return verified complete content
  return {
    content: initialContent,
    complete: true,
    verified: true,
    attempts: 1
  };
}
```

## 8. Success Metrics

1. **Recovery Success Rate**: >95% successful recovery
2. **Performance Overhead**: <2x normal read time
3. **Context Preservation**: 100% important context maintenance
4. **Integration Success**: Seamless operation with verification
5. **Transparency**: Clear reporting of recovery actions

## 9. Next Steps

1. Implement recovery brain-file
2. Create test suite for recovery strategies
3. Integrate with verification system
4. Test with various file types and sizes
5. Document usage patterns 