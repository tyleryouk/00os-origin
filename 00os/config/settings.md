# 00OS System Settings

## Overview
This file contains the system settings for 00OS. These settings control various aspects of the operating system's behavior and are used by the core components and processes.

## System Configuration

```json
{
  "system": {
    "name": "00OS",
    "version": "0.1.0",
    "description": "Terminal-like operating system for AI interactions"
  },
  
  "parser": {
    "_prefixComment": "NOTE: The '>' command prefix is hardcoded in core components and cannot be changed through settings",
    "commandPrefix": ">",
    "subcommandRequired": false,
    "caseSensitive": false,
    "maxCommandLength": 1000,
    "allowPiping": false,
    "allowChaining": false
  },
  
  "execution": {
    "defaultTimeout": 30000,
    "maxConcurrentProcesses": 5,
    "logLevel": "info",
    "debugMode": false
  },
  
  "identity": {
    "default": "00reaper",
    "autoSwitch": true,
    "identityIndicators": {
      "00reaper": "🔧",
      "1000xdev": "💻"
    }
  },
  
  "paths": {
    "processes": "/00os/processes",
    "logs": "/00os/logs",
    "config": "/00os/config",
    "temp": "/00os/temp"
  },
  
  "display": {
    "showCommandPrefix": false,
    "showExecutionTime": true,
    "formatOutput": true,
    "colorOutput": true,
    "colors": {
      "error": "red",
      "warning": "yellow",
      "success": "green",
      "info": "blue"
    }
  },
  
  "security": {
    "enforcePermissions": true,
    "logPermissionDenials": true,
    "restrictedPaths": [
      "/.cursor/rules",
      "/00os/core"
    ]
  },
  
  "advanced": {
    "enableExperimentalFeatures": false,
    "developmentMode": true,
    "allowJavaScriptEval": true,
    "maxProcessMemory": 100000000
  },
  
  "compatibility": {
    "supportLegacyCommands": true,
    "legacyCommandPrefix": "run command:",
    "emulate1000xdev": true
  }
}
```

## Settings Definitions

### System Settings

- **name**: The name of the operating system
- **version**: Current version number
- **description**: Brief description of the system

### Parser Settings

- **commandPrefix**: Prefix required for commands (empty for none)
- **subcommandRequired**: Whether subcommands are required for all commands
- **caseSensitive**: Whether commands are case-sensitive
- **maxCommandLength**: Maximum length of a command in characters
- **allowPiping**: Whether command piping is supported (future)
- **allowChaining**: Whether command chaining is supported (future)

### Execution Settings

- **defaultTimeout**: Default timeout for process execution in milliseconds
- **maxConcurrentProcesses**: Maximum number of processes running concurrently
- **logLevel**: System-wide logging level (debug, info, warn, error)
- **debugMode**: Enable debug mode for additional information

### Identity Settings

- **default**: Default identity to use
- **autoSwitch**: Automatically switch identity based on command
- **identityIndicators**: Visual indicators for each identity in responses

### Path Settings

- **processes**: Base path for process files
- **logs**: Path for log files
- **config**: Path for configuration files
- **temp**: Path for temporary files

### Display Settings

- **showCommandPrefix**: Show command prefix in responses
- **showExecutionTime**: Show execution time in responses
- **formatOutput**: Format output for readability
- **colorOutput**: Use color in output
- **colors**: Color definitions for different message types

### Security Settings

- **enforcePermissions**: Enforce the permission system
- **logPermissionDenials**: Log permission denial events
- **restrictedPaths**: Additional paths with restricted access

### Advanced Settings

- **enableExperimentalFeatures**: Enable experimental features
- **developmentMode**: Enable development mode
- **allowJavaScriptEval**: Allow JavaScript evaluation in processes
- **maxProcessMemory**: Maximum memory per process in bytes

### Compatibility Settings

- **supportLegacyCommands**: Support legacy 1000xcommands format
- **legacyCommandPrefix**: Prefix for legacy commands
- **emulate1000xdev**: Emulate 1000xdev behavior for compatibility

## Accessing Settings

Settings are accessed by processes through the system tools:

```javascript
// Get a system setting
const timeout = tools.getSystemSetting('execution.defaultTimeout');

// Check if a feature is enabled
const isPipingEnabled = tools.getSystemSetting('parser.allowPiping');

// Get all settings in a category
const securitySettings = tools.getSystemSetting('security');
```

## Updating Settings

System settings can be updated by processes with appropriate permissions:

```javascript
// Update a setting (requires system-write permission)
const result = tools.updateSystemSetting('display.showExecutionTime', false);

// Update multiple settings in a category
const updateResult = tools.updateSystemSetting('parser', {
  caseSensitive: true,
  maxCommandLength: 2000
});
```

## Setting Persistence

Settings are persisted between sessions in the configuration files. The system automatically saves changes to ensure consistency across restarts. 