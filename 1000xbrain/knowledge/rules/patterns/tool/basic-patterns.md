# USE WHEN implementing basic tool operations, learning fundamental tool patterns, or establishing tool usage foundations

# Basic Tool Patterns

## Overview

This document provides fundamental patterns for effective tool usage in the 1000xbrain cognitive architecture. These patterns represent the core approach to selecting, configuring, and applying tools in various contexts.

## Pattern: Tool Selection Pattern

### Overview
Pattern for selecting the most appropriate tool for a specific task.

### Context
Use this pattern when deciding which tool to use for a particular operation.

### Pattern Structure

```
┌────────────────────────────────────────────────────────┐
│                                                        │
│                  Tool Selection Pattern                 │
│                                                        │
│  ┌───────────┐     ┌───────────┐     ┌───────────┐     │
│  │           │     │           │     │           │     │
│  │ Determine │     │ Evaluate  │     │ Select    │     │
│  │ Task Type │────▶│ Available │────▶│ Optimal   │     │
│  │           │     │ Tools     │     │ Tool      │     │
│  └───────────┘     └───────────┘     └───────────┘     │
│                                                        │
└────────────────────────────────────────────────────────┘
```

### Implementation Guide

1. **Determine Task Type**:
   - Analysis: Understanding existing code or content
   - Discovery: Finding relevant code or files
   - Implementation: Making changes to code or content
   - Verification: Checking results or execution

2. **Evaluate Available Tools**:
   - Identify tools capable of performing the task
   - Consider each tool's strengths and limitations
   - Assess contextual factors (file type, operation scale, etc.)

3. **Select Optimal Tool**:
   - Choose the tool that best matches the task requirements
   - Consider efficiency, precision, and reliability
   - Select alternatives if primary tool is unavailable

### Examples

```typescript
// DISCOVERY TASK: Find relevant code
// Tool selection: codebase_search (semantic understanding needed)
codebase_search("implementation of user authentication")

// DISCOVERY TASK: Find specific text pattern
// Tool selection: grep_search (exact pattern matching needed)
grep_search("USER_AUTHENTICATION_ENABLED")

// ANALYSIS TASK: Understand file content
// Tool selection: read_file (file content analysis needed)
read_file("auth/authentication.js", should_read_entire_file=true)
```

### Related Patterns
- [Tool Parameter Configuration Pattern](parameter-configuration.md)
- [Tool Combination Pattern](combinations.md)

## Pattern: Tool Parameter Configuration Pattern

### Overview
Pattern for configuring tool parameters for optimal effectiveness.

### Context
Use this pattern when preparing to invoke a tool with specific parameters.

### Pattern Structure

```
┌────────────────────────────────────────────────────────┐
│                                                        │
│            Tool Parameter Configuration Pattern         │
│                                                        │
│  ┌───────────┐     ┌───────────┐     ┌───────────┐     │
│  │           │     │           │     │           │     │
│  │ Identify  │     │ Configure │     │ Validate  │     │
│  │ Required  │────▶│ Parameter │────▶│ Parameter │     │
│  │ Parameters│     │ Values    │     │ Set       │     │
│  └───────────┘     └───────────┘     └───────────┘     │
│                                                        │
└────────────────────────────────────────────────────────┘
```

### Implementation Guide

1. **Identify Required Parameters**:
   - Determine which parameters are required for the tool
   - Identify optional parameters that may enhance tool function
   - Understand parameter dependencies and relationships

2. **Configure Parameter Values**:
   - Set required parameters with appropriate values
   - Configure optional parameters as needed
   - Ensure parameter values match expected formats

3. **Validate Parameter Set**:
   - Verify all required parameters are provided
   - Ensure parameter values are within valid ranges
   - Check for potential conflicts or issues

### Examples

```typescript
// TOOL: codebase_search
// PARAMETER CONFIGURATION
codebase_search({
  // Required parameter
  query: "implementation of user authentication",
  
  // Optional parameters
  target_directories: ["auth/", "users/"],
  explanation: "Finding authentication implementation to understand the current approach"
})

// TOOL: read_file
// PARAMETER CONFIGURATION
read_file({
  // Required parameter
  target_file: "auth/authentication.js",
  
  // Optional parameters with proper configuration
  should_read_entire_file: true,
  // When not reading entire file, provide both offset and limit
  // offset: 10,
  // limit: 50
})
```

### Related Patterns
- [Tool Selection Pattern](#pattern-tool-selection-pattern)
- [Tool Output Processing Pattern](output-processing.md)

## Pattern: Tool Output Processing Pattern

### Overview
Pattern for effectively processing and utilizing tool output.

### Context
Use this pattern when handling the results returned by a tool.

### Pattern Structure

```
┌────────────────────────────────────────────────────────┐
│                                                        │
│              Tool Output Processing Pattern             │
│                                                        │
│  ┌───────────┐     ┌───────────┐     ┌───────────┐     │
│  │           │     │           │     │           │     │
│  │ Capture   │     │ Analyze   │     │ Utilize   │     │
│  │ Tool      │────▶│ Output    │────▶│ Result    │     │
│  │ Output    │     │ Content   │     │ Data      │     │
│  └───────────┘     └───────────┘     └───────────┘     │
│                                                        │
└────────────────────────────────────────────────────────┘
```

### Implementation Guide

1. **Capture Tool Output**:
   - Store the complete output from the tool
   - Handle any error conditions or empty results
   - Recognize output format and structure

2. **Analyze Output Content**:
   - Parse the output to extract relevant information
   - Identify key data points or insights
   - Determine if output meets the task requirements

3. **Utilize Result Data**:
   - Apply the extracted information to the task
   - Use the output to inform subsequent actions
   - Determine if additional tool calls are needed

### Examples

```typescript
// TOOL: codebase_search
// OUTPUT PROCESSING
const searchResult = codebase_search("user authentication implementation")

// Analyze output content
if (searchResult.includes("auth/authentication.js")) {
  // Utilize result data - follow up with read_file
  read_file("auth/authentication.js")
} else {
  // Handle case where expected result wasn't found
  grep_search("authentication", include_pattern: "*.js")
}
```

### Related Patterns
- [Tool Parameter Configuration Pattern](#pattern-tool-parameter-configuration-pattern)
- [Tool Chain Pattern](combinations.md)

## Pattern: Tool Error Handling Pattern

### Overview
Pattern for effectively handling and recovering from tool errors.

### Context
Use this pattern when tools may not execute as expected or may return errors.

### Pattern Structure

```
┌────────────────────────────────────────────────────────┐
│                                                        │
│               Tool Error Handling Pattern               │
│                                                        │
│  ┌───────────┐     ┌───────────┐     ┌───────────┐     │
│  │           │     │           │     │           │     │
│  │ Detect    │     │ Diagnose  │     │ Recover   │     │
│  │ Error     │────▶│ Error     │────▶│ or        │     │
│  │ Condition │     │ Cause     │     │ Alternate │     │
│  └───────────┘     └───────────┘     └───────────┘     │
│                                                        │
└────────────────────────────────────────────────────────┘
```

### Implementation Guide

1. **Detect Error Condition**:
   - Identify when a tool has failed to execute properly
   - Recognize error messages or unexpected output
   - Detect missing or incomplete results

2. **Diagnose Error Cause**:
   - Determine the specific cause of the error
   - Identify if the error is due to tool, parameters, or context
   - Assess severity and impact on the task

3. **Recover or Alternate**:
   - Apply appropriate recovery strategy based on error type
   - Consider alternative tools or approaches
   - Adjust parameters or context as needed

### Examples

```typescript
// TOOL: read_file
// ERROR HANDLING
try {
  read_file("auth/authentication.js")
} catch (error) {
  // Diagnose and handle file not found error
  if (error.includes("Could not find file")) {
    // Recovery: Search for the file first
    file_search(query: "authentication.js", explanation: "Locating authentication file after failed read")
  }
}

// TOOL: edit_file
// ERROR HANDLING
const editResult = edit_file("user/profile.js", "Update user profile validation", "// updated code...")

// Check if edit was applied correctly
if (editResult.includes("was not smart enough to follow your instructions")) {
  // Recovery: Use reapply with clearer instructions
  reapply("user/profile.js")
}
```

### Related Patterns
- [Tool Output Processing Pattern](#pattern-tool-output-processing-pattern)
- [Tool Fallback Pattern](fallback.md)

## Related Knowledge

- [Tool Knowledge Domain](../../reference/domains/tool.md): Comprehensive tool knowledge
- [Tool Combinations](combinations.md): Patterns for combining tools effectively
- [Tool Selection Guide](../../reference/guides/tool-selection.md): Detailed guide for tool selection 