# Context: System Current State

This file provides context on the contents of the `processes/system` directory.

## help
- **Purpose**: Display help information for commands
- **Location**: `00os/processes/system/help.md`
- **Status**: Implemented with enhanced dynamic tool call execution
- **Key Tools**: list_dir, read_file
- **Error Handling**: Comprehensive error handling with suggestions
- **Response Format**: Uses standardized ✅/❌ status indicators
- **Features**: Supports help for specific commands and command categories
- **Implementation**: Improved command-handler integration

## version
- **Purpose**: Display system version information
- **Location**: `00os/processes/system/version.md`
- **Status**: Implemented with standardized tool call patterns
- **Key Tools**: read_file
- **Error Handling**: Enhanced error handling with error codes
- **Response Format**: Uses standardized ✅/❌ status indicators
- **Features**: Displays version information with formatted output
