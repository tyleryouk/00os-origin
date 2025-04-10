# Test Cheatsheet: Adaptive File Reading System

## 1. Overview

This cheatsheet outlines testing procedures for the **Adaptive Sequential Reading** system, ensuring it reliably handles files of various sizes and types.

## 2. Core Functionality Testing

### 2.1 Complete Reading (Files < 250 lines)

*   **Test**: Read small files (Markdown, Python, JSON).
*   **Expected**: `read_file(should_read_entire_file=true)` returns full content. Verification passes. No chunking triggered. Status: `✅ Complete file read`.

### 2.2 Adaptive Chunking Trigger (Files > 250 lines)

*   **Test**: Read medium files (e.g., 500 lines Markdown).
*   **Expected**: Initial read is likely truncated. Verification fails. `readFileInChunks` is triggered. Content is combined with `--- CHUNK ---` markers. Status: `🔄 Sequential chunking applied (X chunks)`.

### 2.3 Overlapping Chunk Logic

*   **Test**: Read a 400-line file. Examine the combined content.
*   **Expected**: Chunk 1 should contain lines 1-150. Chunk 2 should start around line 136 and contain lines 136-285. Chunk 3 should start around 271. Markers should reflect correct line ranges (1-150, 136-285, 271-420, etc.).

### 2.4 End-of-File Detection in Chunking

*   **Test**: Read a file where the total lines are not a multiple of (chunkSize - overlap), e.g., 350 lines.
*   **Expected**: The last `read_file` call within `readFileInChunks` should return fewer than 150 lines. Chunking loop terminates correctly. Status: `🔄 Sequential chunking applied (X chunks)`.

### 2.5 Chunk Limit Handling (Files > 4500 lines)

*   **Test**: Read a very large file (e.g., 5000 lines).
*   **Expected**: Chunking proceeds until the 30-chunk limit is hit. The loop terminates. Status: `⚠️ Chunking limit reached (30 chunks): [filename] (potentially incomplete)`.

## 3. Verification Logic Testing (`verifyCompleteness`)

### 3.1 Markdown Verification
*   **Test**: Provide truncated Markdown (missing conclusion). Provide complete Markdown.
*   **Expected**: Truncated fails verification. Complete passes.

### 3.2 Code Verification (Brace Balance)
*   **Test**: Provide code with unbalanced braces. Provide code with balanced braces.
*   **Expected**: Unbalanced fails verification. Balanced passes.

### 3.3 JSON Verification
*   **Test**: Provide invalid JSON. Provide valid JSON.
*   **Expected**: Invalid fails verification. Valid passes.

### 3.4 Primary Indicator Simulation (if possible)
*   **Test**: Simulate `read_file` returning fewer lines than a large request (e.g., request 1-1000, return 600).
*   **Expected**: Verification logic correctly identifies this as likely complete.
*   **Test**: Simulate `read_file` returning exactly the number of lines requested for a large chunk.
*   **Expected**: Verification logic treats this as potentially truncated (unless secondary indicators strongly suggest completeness).

## 4. Context Preservation Testing

*   **Test**: Read a file with code/logic spanning the 150-line chunk boundaries.
*   **Expected**: Analyze the combined, chunked content. Verify that the 15-line overlap successfully preserves the necessary context for understanding the code/logic across the `--- CHUNK ---` marker.

## 5. Signaling and Reporting

*   **Test**: Perform reads resulting in each status (✅, 🔄, ⚠️).
*   **Expected**: Ensure the AI's response accurately reflects the status reported by the `adaptiveReadFile` pattern.

## 6. Brain-File Implementation Verification

*   **Test**: After dev-mode implementation, read the modified `1000xbrain` files (`core-essentials.md`, `file-reading-enforcement.md`, `file-reading-patterns.md`).
*   **Expected**: Verify the content matches the changes specified in `implementation-robust-file-reading.md`.

## 7. Regression Testing

*   **Test**: Re-run tests for workflows that heavily rely on file reading.
*   **Expected**: Ensure existing functionality is not broken by the new reading system.

## 8. Internal Testing Framework

### 8.1 Test Suite Configuration

```typescript
// Test suite configuration
const testConfig = {
  // File size categories
  fileSizes: {
    small: 100,     // Small files (<250 lines)
    medium: 500,    // Medium files (250-750 lines)
    large: 1200,    // Large files (>750 lines)
    veryLarge: 3000 // Very large files (>2000 lines)
  },
  
  // File types to test
  fileTypes: ['markdown', 'code', 'json', 'yaml', 'text'],
  
  // Test categories
  categories: ['verification', 'recovery', 'chunking', 'integration', 'performance'],
  
  // Test verbosity
  logLevel: 'detailed' // 'minimal', 'standard', 'detailed'
}
```

### 8.2. Test Execution

```typescript
// Execute all test suites
async function runAllTests() {
  // 1. Set up test environment
  const testEnv = createMockEnvironment();
  
  // 2. Run unit tests for each component
  const unitResults = {
    verification: await runVerificationTests(),
    recovery: await runRecoveryTests(),
    chunking: await runChunkingTests()
  };
  
  // 3. Run integration tests
  const integrationResults = await runIntegrationTests();
  
  // 4. Run performance tests
  const performanceResults = await runPerformanceTests();
  
  // 5. Generate comprehensive report
  return generateTestReport({
    unit: unitResults,
    integration: integrationResults,
    performance: performanceResults
  });
}
```

## 9. Verification Tests

| Test ID | Description | Expected Outcome | Validation |
|---------|-------------|------------------|------------|
| V1 | Verify complete file | Detect as complete | `result.complete === true` |
| V2 | Verify truncated file | Detect truncation | `result.complete === false` |
| V3 | Identify file type | Correct type detection | Check against known type |
| V4 | Validate structure | Detect structure issues | Check structure validity |
| V5 | Locate truncation point | Accurate location | Verify position |

## 10. Recovery Tests

| Test ID | Description | Expected Outcome | Validation |
|---------|-------------|------------------|------------|
| R1 | Recover truncated file | Complete recovery | Compare with original |
| R2 | Recover missing sections | Section restoration | Check for missing content |
| R3 | Handle multiple chunks | Seamless combination | Verify coherence |
| R4 | Edge case: Empty file | Graceful handling | Check handling |
| R5 | Recover partial structure | Structure restoration | Verify structure |

## 11. Chunking Tests

| Test ID | Description | Expected Outcome | Validation |
|---------|-------------|------------------|------------|
| C1 | Structure detection | Identify boundaries | Check boundary accuracy |
| C2 | Semantic chunking | Create logical chunks | Verify chunk coherence |
| C3 | Context preservation | Maintain references | Check cross-references |
| C4 | Boundary respect | Honor logical breaks | Verify chunk boundaries |
| C5 | Recombination | Seamless reassembly | Check completeness |

## 12. Integration Tests

| Test ID | Description | Expected Outcome | Validation |
|---------|-------------|------------------|------------|
| I1 | Complete workflow | End-to-end success | Verify full process |
| I2 | Multi-component interaction | Component harmony | Check interactions |
| I3 | Error propagation | Proper error handling | Verify error paths |
| I4 | Context maintenance | Cognitive continuity | Check mental model |
| I5 | Edge case handling | Robust processing | Verify edge cases |

## 13. Performance Tests

| Test ID | Description | Expected Outcome | Validation |
|---------|-------------|------------------|------------|
| P1 | Verification overhead | <1% of read time | Measure execution time |
| P2 | Recovery overhead | <5% of read time | Measure recovery time |
| P3 | Chunking efficiency | Optimal chunk sizing | Analyze chunk sizes |
| P4 | Memory usage | <10% increase | Monitor memory |
| P5 | Tool call efficiency | Minimal tool calls | Count tool calls |

## 14. Test File Generation

```typescript
// Generate test files with specific characteristics
function generateTestFiles() {
  return {
    // Complete files of various sizes
    complete: {
      small: generateCompleteFile(testConfig.fileSizes.small),
      medium: generateCompleteFile(testConfig.fileSizes.medium),
      large: generateCompleteFile(testConfig.fileSizes.large)
    },
    
    // Truncated files at different points
    truncated: {
      beginning: generateTruncatedFile(testConfig.fileSizes.medium, 0.1),
      middle: generateTruncatedFile(testConfig.fileSizes.medium, 0.5),
      end: generateTruncatedFile(testConfig.fileSizes.medium, 0.9)
    },
    
    // Files with specific structures
    structured: {
      markdown: generateStructuredMarkdown(testConfig.fileSizes.medium),
      code: generateStructuredCode(testConfig.fileSizes.medium),
      json: generateStructuredJSON(testConfig.fileSizes.medium)
    }
  };
}
```

## 15. Validation Methods

| Component | Validation Method | Success Criteria |
|-----------|-------------------|-----------------|
| Verification | Structure comparison | 100% accuracy |
| Recovery | Content equivalence | Perfect recovery |
| Chunking | Semantic coherence | No context loss |
| Integration | End-to-end success | Complete processing |
| Performance | Timing measurements | Within targets |

## 16. Implementation Testing

This testing framework must be run:
1. **Before Implementation**: Baseline the current system
2. **During Development**: Test each component
3. **After Integration**: Verify complete solution
4. **Before Production**: Final verification

## 17. Test Result Reporting

```typescript
// Generate test result report
function generateTestReport(results) {
  return {
    summary: {
      totalTests: countTests(results),
      passedTests: countPassedTests(results),
      failedTests: countFailedTests(results),
      successRate: calculateSuccessRate(results)
    },
    
    details: {
      verification: summarizeResults(results.unit.verification),
      recovery: summarizeResults(results.unit.recovery),
      chunking: summarizeResults(results.unit.chunking),
      integration: summarizeResults(results.integration),
      performance: summarizeResults(results.performance)
    },
    
    recommendations: generateRecommendations(results),
    timestamp: new Date().toISOString()
  };
}
``` 