# 00OS User Requests and Implementation Tracking

## Request Details
### REQ-003: Enhance 00reaper and system 00OS Processes to focus on dynamic Tool Calls sequences [NEW]
#### Requirements
1. Execute @Web tool calls to perform extensive research on Cursor Tool Calls. Fill in the currently empty research file with your findings:
00reaper\00OS-commands\research-cursor\research-cursor-tool-call.md

(Tool calls are also embedded in your knowledge, since this message is within the Cursor Chat interface. Cursor has done a great job embedding tool call knowledge for you to utilize tool calls for enhanced AI development)

2. Read all research to gain understanding of our goals of 00OS and cursor rule manipulation.

3. Read all context on the current state of 00OS. After reading, you will be able to see that there are a total of 10 processes, including 8 00reaper processes and 2 system processes (0 1000xdev processes for now). The two system processes help and version should be the only two system processes for now.

4. Revise all process files to focus on dynamic tool call execution. 00OS is not a real operating system. It is an system based on operating system principles to manipulate Cursor Rules for faster development for Tyler Youk (allows Tyler Youk to send 00OS commands prefixed with > for faster AI-augmented development). Some of the process files are ambiguous and sometimes you do not run tool calls. Each process should trigger a strict set of a tool calls. This is either an issue within /core 00OS files or the /processes files itself.


### REQ-007: [Tyler]
# Dynamic Command Discovery for 00OS commands by running list_dir tool calls to read all  
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

### REQ-008: Workflow Simplification - Streamlined active-request.md
#### Requirements
1. **Simplified Content Structure**:
   - Convert active-request.md to a pure requirements document with no metadata
   - Remove cycle ID, stage references, and status indicators
   - Include only a title and detailed requirements sections

2. **Update Pattern**:
   - Update ONLY during step 1 of the workflow
   - Treat as a read-only reference document throughout steps 2-6
   - No updates unless requirements fundamentally change

3. **Proposed Template**:
```markdown
# [Request Title]

## Requirements
1. [Requirement 1]
2. [Requirement 2]
3. [Requirement 3]
...
```

4. **Benefits**:
   - Clearer focus on actual requirements
   - Reduced file maintenance overhead
   - Eliminated redundancy with cycle-status.md
   - Simplified mental model for workflow

### REQ-009: Workflow Simplification - File Update Pattern Standardization
#### Requirements
1. **Clear File Update Boundaries**:
   - Step 1: Update ONLY active-request.md
   - Step 2: No file updates (research/knowledge gathering only)
   - Step 3: Update ONLY implementation-plan.md
   - Steps 4-6: Update ONLY cycle-status.md

2. **Workflow Document Specialization**:
   - active-request.md: Requirements document (WHAT needs to be done)
   - implementation-plan.md: Blueprint document (HOW it will be done)
   - cycle-status.md: Progress tracking document (WHERE we are in the process)

3. **Benefits**:
   - Eliminated confusion about which file to update when
   - Reduced cognitive load during development
   - Clearer purpose for each workflow document
   - Simplified training for new contributors

### REQ-010: Workflow Simplification - Automated Workflow Transitions
#### Requirements
1. **Command Shortcuts for Stage Advancement**:
   - Create simple commands to mark completion of current stage
   - Automatically update cycle-status.md with timestamp
   - Pre-populate templates for next stage details

2. **Quick-Copy Templates**:
   - Add standardized templates for each stage update in cycle-status.md
   - Include placeholders for common stage-specific information
   - Enforce consistent formatting across stages

3. **Automated Status Dating**:
   - Automatically add timestamps to status updates
   - Track time spent in each stage
   - Provide metrics on workflow efficiency

4. **Implementation Approach**:
   - Add new 00reaper processes for stage advancement
   - Create standardized templates for each stage
   - Implement simple command syntax like `> reaper-advance-stage`

5. **Benefits**:
   - Reduced manual overhead in workflow transitions
   - Consistent documentation across cycles
   - Better metrics on development process
   - Simplified training for contributors


