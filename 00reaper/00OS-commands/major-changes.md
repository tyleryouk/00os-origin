[Tyler] Written by Tyler Youk
[00reaper] Written by 00reaper

### [Tyler] Goal of 00OS commands 
The goal of 00OS commands is to create processes **based on tool call patterns** to automate the development process.

Somewhere in the latest planning process and changes to 00OS, there is confusion for our goals that we are trying to achieve. Some of the 00OS commands run a terminal command with the 00OS command as the terminal command, which will never work. 

The process for 00OS commands is:
1. I send you 00OS command starting with > 
2. You make fetch_rules tool call the appropriate process
3. You start running tool calls based on the process file

#### [Tyler] Example of desired functionality of 00OS command: 
> reaper-read-files 00reaper/00OS-commands
First, you should read the Cursor Rule .cursor\rules\processes\system\reaper-read-files.mdc, which should instruct you to make the following set of tool calls:
list dir tool call to 00reaper/00OS-commands
read file tool calls to read all the files in 00reaper/00OS-commands 

This 00OS command should work as if you just receive the user prompt: `00reaper, read all of the files in 00reaper/00OS-creation. Read-only, do not edit any files`

#### [Tyler] Major Changes
1. Change the base workflow files in 00reaper/00OS-commands/ to ensure proper changes are made to 00OS so that the processes efficiently utilize Cursor Tool Calls and execute Cursor Tool Calls.
2. Define plans to change 00OS within 00reaper/00OS-commands/current-implementation.md and 00reaper/00OS-commands/user_requests.md.

#### [00reaper] Research: Cursor Tool Calling

## Cursor Tool Calls: Core Capabilities

Based on comprehensive research of Cursor's documentation and community resources, here's what we've learned about Cursor tool calls that can inform 00OS command development:

### Available Tool Types

Cursor provides several categories of tools that agents can use:

1. **Search Tools**
   - `read_file`: Reads the contents of a file (up to 750 lines in MAX mode, 250 lines in other modes)
   - `list_dir`: Shows directory structure without reading file contents
   - `codebase_search`: Performs semantic search within indexed codebase
   - `grep_search`: Searches for exact keywords or patterns within files
   - `file_search`: Quickly finds files by name using fuzzy matching
   - `web_search`: Performs web searches for up-to-date information

2. **Edit Tools**
   - `edit_file`: Suggests and applies edits to files
   - `reapply`: Re-applies an edit if the previous attempt wasn't fully successful
   - `delete_file`: Autonomously deletes files

3. **Terminal Tools**
   - `run_terminal_cmd`: Executes terminal commands and monitors output

4. **Other Tools**
   - `fetch_rules`: Retrieves specific Cursor rules based on type and description

### Tool Call Execution Model

- Cursor's Agent mode has a **25 tool call limit** per request by default
- In MAX mode (Claude 3.7 Sonnet MAX or Gemini 2.5 Pro MAX), this increases to **200 tool calls**
- When the limit is reached, Cursor asks if you want to continue, which counts as a new request
- Each tool call is charged as a separate request in MAX mode (in addition to the initial prompt)

### Best Practices for Tool Calls

1. **File Reading Strategy**
   - Prefer reading larger sections of files at once over multiple smaller calls
   - Stop tool calls once you've found the relevant information
   - In MAX mode, read_file can process up to 750 lines vs 250 lines in regular mode

2. **Command Execution**
   - Always provide clear explanations for terminal commands
   - Consider security implications when running commands
   - Use auto-run carefully for production environments

3. **Code Editing**
   - Use context markers (`// ... existing code ...`) to indicate unchanged code
   - Include sufficient context around changes to resolve ambiguity
   - Apply edits in logical sequences (multiple small edits vs. one large edit)

### Tool Call Implementation Patterns

The following patterns are especially relevant for 00OS command development:

1. **Multi-Step Workflows**
   - Tool calls can be sequenced to create complex workflows
   - Each tool call can build on the results of previous calls
   - Models maintain context between tool calls within the same request

2. **Content Processing**
   - Content from tool call results can be processed and used for subsequent actions
   - Large file content can be analyzed in chunks if necessary
   - Search results can inform targeted file edits

3. **Error Handling**
   - Tool calls include error information that can be processed
   - Subsequent tool calls can adapt based on previous failures
   - Multiple approaches can be attempted if initial attempts fail

### Implementation Considerations for 00OS

1. **Process File Structure**
   - Process files should be designed to guide an autonomous sequence of tool calls
   - Tool call sequences should be explicitly defined with clear dependencies
   - Error handling should be incorporated into the process flow

2. **Tool Call Efficiency**
   - Minimize unnecessary tool calls to avoid hitting limits
   - Use targeted searches before file reads to limit scope
   - Chain operations logically to reduce redundant operations

3. **Response Formatting**
   - Create standard formats for tool call responses
   - Include status indicators (✅, ❌, ⚠️) for clear visual feedback
   - Provide helpful context in error messages

For 00OS commands, the pattern should be:
1. Command received (prefixed with `>`)
2. Process fetched via fetch_rules
3. Autonomous execution of tool calls as defined in the process
4. Consistent response formatting based on the results

This implementation approach will ensure 00OS commands can effectively leverage Cursor's tool capabilities without unnecessary terminal command execution.

#### [00reaper] Reserach: Defining Tool Call Processes within Cursor Rules to enhance development workflow within Cursor IDE

## Cursor Rules for Process Definitions

Building on the previous research, I've investigated how to effectively structure and define processes within Cursor Rules to enhance the 00OS command system. Here are the key findings:

### Cursor Rules Structure

Cursor Rules provide a powerful mechanism for defining structured processes:

1. **Rule File Organization**
   - Modern Cursor Rules use `.mdc` files in the `.cursor/rules/` directory
   - Each process can be defined in its own rule file with specific metadata
   - Rules can be organized hierarchically by directories (system, tools, etc.)

2. **Rule File Components**
   - **Description**: Brief explanation of the rule's purpose (required)
   - **Globs**: Patterns determining when the rule applies (required)
   - **Content**: The actual process definition and implementation

3. **Process File Structure**
   - **Metadata**: Command name, description, version, permissions
   - **Input Definition**: Parameters, flags, and arguments
   - **Execution Blocks**: Code sections for initialization, execution, and output

### Process Execution Model

The ideal process execution model for 00OS follows these steps:

1. **Command Detection**: Identify input prefixed with `>` as a command
2. **Process Selection**: Fetch the appropriate process rule using `fetch_rules`
3. **Parameter Parsing**: Extract arguments, options, and flags
4. **Tool Call Execution**: Execute a sequence of tool calls as defined in the process
5. **Response Formatting**: Format results with consistent indicators (✅, ❌, ⚠️)

### Process Implementation Guidelines

1. **Define Clear Process Components**
   - Each process should have well-defined input requirements
   - Processes should be broken into logical execution steps
   - Error handling should be incorporated at each step

2. **Optimize Tool Call Sequences**
   - Use targeted search operations before broad file reads
   - Chain dependent operations efficiently
   - Cache results to avoid redundant tool calls

3. **Standardize Response Formatting**
   ```
   ✅ Command executed successfully:
   [Command output]
   ```

   ```
   ❌ Error: [Error message]
   [Troubleshooting suggestions]
   ```

   ```
   ⚠️ Warning: [Warning message]
   [Command output with caveats]
   ```

### Example Process Structure

```javascript
/**
 * Process: file-read
 * Description: Read and display file contents
 * Usage: > file read <filepath>
 */

// Metadata
const metadata = {
  name: "file-read",
  description: "Read and display file contents",
  version: "1.0.0",
  category: "tools",
  permissions: ["file-read"]
};

// Input validation
function validateInput(args) {
  if (args.length === 0) {
    return {
      valid: false,
      error: "No file path provided",
      suggestions: ["Specify a file path to read"]
    };
  }
  
  return { valid: true };
}

// Main execution
async function execute(args, flags) {
  // Validate input
  const validation = validateInput(args);
  if (!validation.valid) {
    return {
      success: false,
      message: `❌ Error: ${validation.error}`,
      suggestions: validation.suggestions
    };
  }
  
  const filepath = args[0];
  
  try {
    // Read file content using read_file tool
    const fileContent = await tools.read_file(filepath);
    
    // Format and return response
    return {
      success: true,
      message: `✅ File content for ${filepath}:`,
      content: fileContent
    };
  } catch (error) {
    return {
      success: false,
      message: `❌ Error reading file: ${error.message}`,
      suggestions: [
        "Check if the file exists",
        "Verify file path is correct",
        "Ensure you have permission to read the file"
      ]
    };
  }
}
```

### Integration with 00OS Architecture

This research aligns perfectly with the 00OS architecture defined in the core components:

1. **Command Handler**: Detects commands and routes to appropriate processes
2. **Parser**: Breaks commands into components (command, subcommand, arguments, flags)
3. **Registry**: Maintains catalog of available processes and validation rules
4. **Executor**: Manages process lifecycle from initialization to completion
5. **Permissions**: Controls access to system features based on identity

The process definition approach outlined here provides a structured way to implement these core components while leveraging Cursor's tool calling capabilities effectively.

### Next Steps for 00OS Development

1. **Standardize Process Definitions**: Create a template for all new process files
2. **Implement Core Processes**: Build essential commands using this structure
3. **Develop Process Registry**: Automate discovery and registration of processes
4. **Enhance Error Handling**: Add robust error recovery mechanisms
5. **Optimize Tool Call Efficiency**: Minimize unnecessary tool calls for better performance

This research provides a solid foundation for developing more efficient, reliable, and standardized 00OS commands that fully leverage Cursor's tool calling capabilities while maintaining a consistent user experience.

#### [00reaper] Research: Latest Cursor Advanced Features for Command Automation

## Enhanced Cursor Auto-run (YOLO Mode) Capabilities

Based on recent web research and user experiences with Cursor's Auto-run feature (formerly called YOLO mode), I've discovered additional capabilities that can significantly enhance 00OS command development:

### Advanced Auto-run Features and Benefits

1. **Fully Autonomous Workflows**
   - Auto-run allows for complete end-to-end automation of complex tasks without requiring user approval
   - Can execute sequences of tool calls, terminal commands, and code edits with zero intervention
   - Capable of self-correction by running tests, analyzing failure output, and iterating on solutions

2. **Real-world Applications for 00OS Development**
   - **Automated Testing Cycles**: Creates test files, runs tests, fixes failures, and re-runs tests until all pass
   - **Self-documenting Development**: Can generate code and automatically document it with comments and supporting files
   - **Continuous Integration**: Runs commands to verify builds and automatically fixes any build failures
   - **Process File Development**: Could create and test new 00OS process files with minimal supervision

3. **Optimal Configuration for 00OS Development**
   ```
   Allow List:
   - npm run test
   - node
   - jest
   - mkdir
   - touch
   - npm run build
   - npm run lint
   ```
   ```

4. **Safety Considerations**
   - Important to establish comprehensive rules in `.cursorrules` to guide behavior
   - Keep requests focused on specific tasks rather than open-ended objectives
   - Consider implementing "safety checks" in process files for destructive operations

### Enhanced Test-Driven Development for 00OS Commands 

Expanding on our TDD approach by incorporating insights from experienced Auto-run users:

1. **Multi-stage Testing Strategy**
   - Define clear testing stages from unit tests to integration tests
   - Auto-run can progressively work through each stage, fixing issues before advancing
   - Example testing workflow:
     1. Syntax validation
     2. Unit tests for command functions
     3. Integration tests for command interaction
     4. End-to-end tests for complete user scenarios

2. **Continuous Documentation**
   - Auto-run can maintain development diaries in structured formats (markdown, JSON)
   - Documents decisions, changes, and test results for each iteration
   - Creates living documentation that serves as both reference and learning material

3. **Example Auto-run Prompt for Command Development**
   ```
   Create a new 00OS command "file-search" with the following requirements:
   1. First draft a process file with proper metadata and input validation
   2. Create a test file with various test cases covering normal operation and error states
   3. Run the tests and fix any issues
   4. Ensure the command follows our error handling standards
   5. Document the process with examples and explanations
   6. Keep iterating until all tests pass consistently
   
   Log your progress and decision-making in a development diary markdown file.
   ```

### Optimizing Context Management

Recent user reports highlight the importance of context management when using Auto-run for complex tasks:

1. **Context Preservation Techniques**
   - Use structured logging to maintain context between sessions
   - Create a `development_diary.json` to track progress and decisions
   - Reference previous steps explicitly when making changes

2. **Overcoming Context Limitations**
   - Break complex commands into logical modules with clear boundaries
   - Use a structured testing approach that clearly identifies failures
   - Implement checkpointing in longer processes to allow resuming after the 25 tool call limit

3. **Terminal Output Handling**
   - Configure tools to output focused, information-dense results
   - Filter unnecessary output that might consume context window
   - Use structured formats (JSON, tables) for test results to improve parsing

### Implementation Strategy for 00OS

To maximize the benefits of these advanced features for 00OS command development:

1. **Establish an Auto-run Development Environment**
   - Set up dedicated workspace with appropriate safeguards
   - Configure standard testing frameworks and utilities
   - Create template files for new command development

2. **Define a Structured Command Development Lifecycle**
   - Planning: Define command specifications and test criteria
   - Implementation: Develop initial command process
   - Testing: Automated testing with Auto-run
   - Refinement: Iterative improvement based on test results
   - Documentation: Auto-generate docs with examples and explanations
   - Integration: Add to command registry

3. **Create Command Development Utilities**
   - Test harness for command processes
   - Documentation generator for command syntax and examples
   - Validation tools for ensuring command standard compliance

By implementing these advanced strategies, 00OS command development can become more efficient, consistent, and reliable, while maintaining the high standards needed for a robust operating system interface.