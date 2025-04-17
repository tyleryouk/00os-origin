# 00OS Core: Current State Assessment

## System Overview

00OS is a terminal-like operating system built on Cursor's rules system, designed to transform the standard AI chat interface into a powerful command-line environment while preserving natural language capabilities. The system implements a dual-mode interface that allows users to seamlessly switch between conversational interactions and structured command execution.

### Dual-Mode Interface

1. **Conversational Mode (Default)**
   - Natural language interaction with the AI
   - Technical expertise and system knowledge
   - No special syntax required
   - Responds to any input not prefixed with `>`

2. **Command Mode**
   - Detects and processes input prefixed with `>`
   - Structured command syntax: `> [command] [subcommand] [arguments] [--flags]`
   - Command parsing, routing, and execution via process files
   - Formatted responses with status indicators (✅, ❌, ⚠️)

## Core Architecture

The 00OS core is built on a process-based architecture with several key components working together to provide a cohesive command-line experience:

```
                        ┌─────────────────┐
                        │   User Input    │
                        └────────┬────────┘
                                 │
                        ┌────────▼────────┐
                        │ Command Handler │
                        └────────┬────────┘
                                 │
              ┌─────────────────┼─────────────────┐
              │                 │                 │
     ┌────────▼─────┐  ┌────────▼─────┐  ┌────────▼─────┐
     │    Parser    │  │   Registry   │  │ Permissions  │
     └────────┬─────┘  └────────┬─────┘  └────────┬─────┘
              │                 │                 │
              └─────────────────▼─────────────────┘
                                │
                        ┌────────▼────────┐
                        │    Executor     │
                        └────────┬────────┘
                                 │
                        ┌────────▼────────┐
                        │ State Manager   │
                        └─────────────────┘
```

### Key Components

1. **Command Handler**
   - Entry point for command processing
   - Identifies commands that start with `>` prefix
   - Routes commands to appropriate process files
   - Integrates with fetch_rules to load process definitions

2. **Parser**
   - Tokenizes and structures raw command input
   - Breaks commands into components (command, subcommand, arguments, flags)
   - Handles quoted strings and escape characters
   - Validates command structure against registry definitions

3. **Command Registry**
   - Central catalog of all available commands
   - Stores command metadata, paths, and requirements
   - Provides command lookup and discovery capabilities
   - Manages command aliasing and shortcuts

4. **Permissions System**
   - Controls access to system resources
   - Defines and enforces permission levels
   - Implements identity-based access control
   - Protects sensitive paths and operations

5. **Process Registry**
   - Maintains catalog of available processes
   - Provides registration and discovery services
   - Validates processes before execution
   - Maps commands to process implementations

6. **Executor**
   - Loads and initializes processes
   - Creates isolated execution environment
   - Maps command arguments to process inputs
   - Manages process lifecycle
   - Handles errors and exceptions

7. **State Manager**
   - Maintains persistent state across command executions
   - Implements hierarchical storage (global, process, user, session)
   - Provides namespaced state access
   - Handles state persistence and retrieval

## Command Flow

When a user enters a command, the system processes it through the following flow:

1. **Command Detection**
   - System checks if input starts with the command prefix (`>`)
   - If yes, processed as command; otherwise, handled as conversation

2. **Command Parsing**
   - Command is parsed into structured components
   - Tokens are identified as command, subcommand, arguments, or flags

3. **Process Lookup**
   - Registry is queried to find the appropriate process
   - Process rule is fetched using `fetch_rules`

4. **Permission Check**
   - System verifies user has permission to execute the process
   - Access to resources is controlled based on identity

5. **Process Execution**
   - Process is executed with provided arguments
   - Execution occurs in isolated context with appropriate tools

6. **Response Formatting**
   - Result is formatted according to system standards
   - Status indicators (✅, ❌, ⚠️) are added
   - Formatted response is returned to user

## Identity Framework

00OS currently operates under a single primary identity:

**00reaper**: System administrator and architect responsible for:
   - Managing system configuration
   - Designing system components
   - Maintaining system architecture
   - Processing commands prefixed with `>`
   - Fetching process rules
   - Executing tool calls defined in process rules
   - Managing the `00reaper` and `00os` directories
   - Syncing `00os` changes to `.cursor/rules`

## Directory Structure

```
00os/                     # Development source files
├── core/                 # Core system components
├── processes/            # Command implementations
│   ├── system/           # System management commands
│   ├── tools/            # Utility commands
│   └── examples/         # Example commands
└── config/               # System configuration

.cursor/rules/            # Production environment
├── core/                 # Core system components (.mdc)
├── processes/            # Command implementations (.mdc)
```

## State Management

The state management system provides persistent storage across commands with multiple scopes:

1. **Global State**
   - Accessible to all processes with appropriate permissions
   - Used for system-wide configuration and shared data

2. **Process State**
   - Isolated to specific processes
   - Namespaced by process name
   - Enables stateful applications

3. **User State**
   - Associated with the current user
   - Persists user preferences and settings

4. **Session State**
   - Only persists for the current session
   - Temporary storage that's cleared on restart

State is automatically persisted for global, user, and process scopes, with configurable persistence intervals and size limits.

## Permissions System

The permission system implements a hierarchical access control model:

### Permission Levels

- **basic**: Basic operations, no system access
- **file-read**: Read access to files
- **file-write**: Write access to files
- **system-read**: Read system configuration
- **system-write**: Modify system configuration
- **network**: Network access
- **execution**: Execute other processes
- **admin**: Administrative privileges

### Permission Sets

- **MINIMAL**: Just basic operations
- **FILE_OPS**: File operations (read/write)
- **SYSTEM_MONITOR**: System monitoring (read-only)
- **SYSTEM_ADMIN**: System administration (read/write)
- **FULL_ACCESS**: Complete system access (00reaper only)

### Path-Based Rules

The permission system includes path-based access control, restricting access to sensitive directories like `/00os/` and `/.cursor/rules/` to admin-level permissions.

## Development Workflow

1. Development occurs in the `00os/` directory using standard markdown (`.md`)
2. Changes are synchronized to `.cursor/rules/` as `.mdc` files
3. Enhancements are tracked and documented in enhancement trackers
4. Context is preserved between sessions using `reaper-init` and `reaper-update`

## Essential Commands

- `> help` - Display help information
- `> system status` - Display system status
- `> reaper-init` - Initialize 00reaper context 
- `> reaper-update` - Update context state
- `> reaper-sync` - Synchronize 00OS content to rules
- `> file list [path]` - List directory contents
- `> echo [message]` - Echo a message

## Rule Type Management

Rules in 00OS follow specific configurations:
- Core components: `alwaysApply: true`
- Process files: `alwaysApply: false` with descriptive triggers
- Descriptions start with "USE WHEN" for process files

## Process File Structure

Process files define commands and are structured as Markdown with sections:

1. **Metadata**
   - Description, category, permissions, author, version
   - Input and output specifications

2. **Execution Block**
   - JavaScript code that executes when the command is run
   - Access to context, inputs, state, and system tools

3. **Output Block**
   - Logic for formatting the command's response
   - Status indicators and structured information

## Current Limitations

1. **Identity Management**
   - Currently limited to a single identity (00reaper)
   - No multi-user capabilities yet

2. **Process Isolation**
   - Limited isolation between process executions
   - No true sandboxing or resource constraints

3. **Integration**
   - Manual synchronization between `00os/` and `.cursor/rules/`
   - No automatic deployment or versioning

## Future Development Areas

1. **Enhanced Process Isolation**
   - Execute processes in isolated sandbox environments
   - Prevent processes from affecting each other

2. **Resource Constraints**
   - Set execution time limits for processes
   - Limit memory and CPU usage

3. **Execution Optimization**
   - Process caching for frequently used processes
   - Parallel execution for independent processes

4. **Advanced Debugging**
   - Step-by-step execution for debugging
   - Execution tracing and logging

5. **Multi-Identity Support**
   - Support for multiple operational identities
   - Identity-based permission and state isolation

## Conclusion

The 00OS core components form a sophisticated command-line interface system built on Cursor's rules framework. The current implementation provides a solid foundation for a terminal-like experience within the AI chat interface, with structured command processing, state persistence, and permission-based access control.

The modular architecture allows for ongoing development and enhancement, with clear separation of concerns between system components. While there are areas for future improvement, the current state represents a functional and extensible command system capable of supporting a wide range of command-line interactions.
