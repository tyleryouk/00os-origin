# 00OS User Requests and Implementation Tracking

## Request Details
### REQ-001: [NEW]
- Optimize 00reaper/00OS-commands folder for better workflow and communication between you (00reaper) and I (Tyler). The workflow should follow a strict cyclical approach as defined below.
1. Read user_request REQ
2. Read relevant files in context, documentation, templates, and/or testing
3. Make changes to the three core workflow files: current-implementation.md, current-task.md, and major-changes.md.
4. Make changes to 00OS
5. Make changes to context, documentation, templates, and/or testing (will likely happen most times, because most changes to 00OS will result in necessary changes to context, documentation, testing, and/or testing to ensure alignment)
6. Update/clear core workflow files to start a new cycle. The core workflow files should be focused on one cycle at a time.

The goal is for me to write requests like these, and for you to intelligently make changes to the base workflow files in 00reaper\00OS-commands along with changes to 00OS. If you find ways to enhance this cycle, please let me know before we start making changes. Let's try to define the cycle as best as possible within the three core workflow files before making major structural changes. Note that for this request, ALL changes should be made to 00reaper\00OS-commands. When in this workflow, you will only need to read/change files in 00reaper\00OS-commands and 00OS.

### REQ-002: [NEW]
#### Requirements:
- Ensure 1 to 1 alignment between 00OS commands (commands sent from the Cursor prompt) with 00OS processes. 
- There needs to be some type of system to ensure alignment between the 00OS commands listed in > help and > command-registry and all 00OS processes in 00OS/processes/. We should also probably delete system commands that are not all that accurate. Let's try to define this 00OS command to 00OS processes alignment plan as best as possible before moving forward. 

Questions:
Should we define 00OS processes as 00OS command processes or 00OS processes? 
Is it currently clear that the 00OS commands execute as follows:
1. AI Agent received 00OS command starting with > 
2. AI Agent makes fetch_rules call to 00OS process associated with 00OS command (00OS process filename should have exact same name as 00OS command)
3. AI Agent perform ALL tool calls defined within the 00OS process.


### REQ-003: Update Core 00OS Commands to Use Tool Calls
#### Requirements
- Identify essential 00OS commands for initial update
- Rewrite processes to emphasize the utilization of tool calls
- Ensure proper parameter validation and error handling
- Test commands with various inputs by running live communication tests with Tyler
- Read documented command behaviors, which are documented by Tyler Youk. Utilize the /testing folder for this cycle.


#### Progress Updates
- 2023-05-22: Identified priority commands for implementation

### REQ-004: Implement Fetch-Rules Integration
#### Requirements
- Create process for fetching command definitions using fetch_rules
- Implement command name to process file mapping
- Handle subcommands and parameter passing
- Ensure error handling for missing commands
- Document implementation pattern

#### Implementation Plan
- Design standardized approach for fetch_rules usage
- Create mapping between command names and process files
- Implement parameter extraction and validation
- Add error handling for missing or invalid commands
- Test with various command formats

#### Progress Updates
- 2023-05-22: Initial concept defined based on tool call approach

### REQ-005: Create Command Testing Framework
#### Requirements
- Design testing framework for command verification
- Include unit tests for command functions
- Create integration tests for command interactions
- Implement automated testing for command validation
- Document testing patterns and requirements

#### Implementation Plan
- Follow test-driven development approach
- Create test cases for various command scenarios
- Implement test helpers for common operations
- Document standard testing patterns
- Apply to all new commands

#### Progress Updates
- 2023-05-22: Initial concept defined in testing-framework.md

### REQ-006: Improve Error Handling for Tool Calls
#### Requirements
- Standardize error codes and messages
- Create helpful suggestions for common errors
- Implement recovery mechanisms for failed tool calls
- Ensure consistent formatting for error responses
- Document error handling patterns

#### Implementation Plan
- Define standard error codes and messages
- Create templates for error formatting
- Implement recovery suggestions
- Standardize response format
- Document best practices

#### Progress Updates
- 2023-05-22: Initial requirements defined

### REQ-007: [Tyler]
# Dynamic Command Discovery for 00OS
## Issue Description

Currently, both `> command-registry` and `> help` commands display an incomplete list of 00OS commands. This is problematic as it prevents users from discovering all available functionality within the 00OS system. Based on a directory scan of the `/00os/processes` folder structure, there are several commands that exist as processes but are not being displayed in the command registry output.

The root cause appears to be that these commands are using hardcoded data rather than dynamically discovering all available processes in the system. This creates a maintenance burden and leads to an inconsistent user experience where commands exist but aren't discoverable through the standard interfaces.

## Proposed Solution

Each process in 00OS has a one-to-one relationship with an 00OS command. The command is inferred (not explicitly stated) by the creation of an 00OS process. To improve discoverability and ensure all commands are properly listed, we should implement the following approach:

1. **Standardize Process Headers**: Establish a consistent header format for all 00OS process files that clearly defines:
   - Command name
   - Description
   - Category
   - Usage syntax (including subcommands, arguments, and flags)
   - Examples
   - Metadata (version, author, etc.)

2. **Dynamic Command Discovery**: Modify the `command-registry` and `help` commands to:
   - Dynamically scan all subdirectories within `/00os/processes`
   - Parse the standardized headers from each process file
   - Build a comprehensive list of all available commands
   - Present this information to users in a consistent format

3. **Implementation Method**:
   - Use the `list_dir` tool to enumerate all process directories and files
   - Read each process file header to extract command information
   - Organize and present the commands based on their categories
   - Cache the results for performance if necessary, with a refresh option

4. **Documentation Updates**:
   - Update documentation in `00reaper/00OS-commands` to reflect the new header requirements
   - Provide templates for process headers to ensure consistency
   - Create guidelines for command naming and categorization

## Additional Considerations

- **PowerShell Commands**: All PowerShell commands must be placed in `00reaper/00scripts`, as PowerShell commands cannot be defined within 00OS directly. Only the `run_terminal_command` tool call should be used, which must call a PowerShell script in the `00reaper/00scripts` directory (see `> reaper-sync` as an example).

- **Backward Compatibility**: Ensure that the dynamic discovery method is backward compatible with existing process files, providing a migration path for those that don't yet follow the standardized header format.

- **Performance**: Consider performance implications of scanning all process files on every `help` or `command-registry` command execution. Implement appropriate caching strategies if needed.

## Implementation Priority

This enhancement should be treated as a high priority, as it directly impacts the discoverability and usability of the 00OS system. Implementing this change will ensure that users have a complete and accurate view of all available commands, improving the overall user experience. 
## END ALL REQUESTS

## Implementation Guidelines

### Tool Call Based Implementation

All 00OS commands must follow this implementation pattern:

1. **Command Detection**: Identify input with `>` prefix
2. **Process Selection**: Use fetch_rules to get the appropriate process
3. **Parameter Parsing**: Extract arguments, options, and flags
4. **Tool Call Execution**: Execute tool calls as defined in the process
5. **Response Formatting**: Format results with standardized indicators

### Key Implementation Notes

- Commands must NEVER try to execute terminal commands that run themselves
- All functionality should be implemented through native Cursor tool calls
- Keep tool calls to a minimum by reading larger sections or using targeted searches
- Provide meaningful error messages and recovery suggestions
- Follow the response format standards (✅, ❌, ⚠️)

## Session Workflow

### Starting a New Session
1. Review major-changes.md for overall approach
2. Check current implementation status
3. Review specific request details

### During Session
- Focus on implementing tool call based commands
- Test command execution with various inputs
- Document progress and findings

### Ending a Session
- Update progress notes for worked-on requests
- Document any new issues encountered
- Identify next steps for implementation
