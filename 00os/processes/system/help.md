---
name: help
description: Display help information for commands
version: 1.0.0
author: 00reaper
permissions: [basic]
inputs:
  - name: command
    type: string
    required: false
    description: Command to get help for
  - name: verbose
    type: boolean
    required: false
    default: false
    description: Show detailed help
outputs:
  - name: help
    type: object
    description: Help information
---

# Process: Help

## Metadata
- Description: Provides help information for the 00OS terminal interface
- Category: system
- Permissions: user.basic
- Author: 00reaper
- Version: 1.0

## Input
- command: Optional command to get help about

## Output
- Formatted help information based on the query

## Execution
When the user enters `> help` or `> help [command]`, this process provides information about available commands or detailed help for a specific command.

### General Help (no command specified)

If the user doesn't specify a command (`> help`), the process should display general help information:

```
================================
  00OS TERMINAL HELP
================================

00OS is a command-line interface for interacting with your AI assistant.
Commands use the prefix '>' followed by a command and optional subcommands, arguments, and flags.

COMMAND CATEGORIES:
  system    - System management and configuration
  file      - File operations and navigation
  process   - Process management and execution
  identity  - Identity and permission management
  tools     - Utility tools and external operations

COMMON COMMANDS:
  > help                    - Display this help information
  > help [command]          - Get detailed help for a specific command
  > system status           - Check system status
  > file list [directory]   - List files in a directory
  > version                 - Display system version

EXAMPLES:
  > help file               - Get help about file commands
  > file list /00os         - List files in the /00os directory
  > system config list      - List system configuration

For detailed help on a specific command, type:
  > help [command]

To start a regular conversation, simply type without the '>' prefix.
```

### Command-Specific Help

If the user specifies a command (`> help [command]`), the process should display detailed help for that command:

#### System Commands
```
> help system

COMMAND: system
DESCRIPTION: System management and configuration commands

SUBCOMMANDS:
  status            - Display system status and information
  config [get|set]  - Configure system settings
  update            - Update system components
  restart           - Restart system services
  version           - Display system version information

EXAMPLES:
  > system status
  > system config list
  > system config set debug true
  > system update
```

#### File Commands
```
> help file

COMMAND: file
DESCRIPTION: File operations and navigation

SUBCOMMANDS:
  list              - List files in a directory
  read              - Display file contents
  edit              - Edit a file
  create            - Create a new file
  delete            - Delete a file

ALIASES:
  > ls              - Alias for 'file list'
  > cd              - Change current directory
  > pwd             - Show current directory

EXAMPLES:
  > file list /00os
  > file read /00os/core/parser.md
  > file edit /00os/processes/system/help.md
  > ls /00os --detailed
```

#### Process Commands
```
> help process

COMMAND: process
DESCRIPTION: Process management and execution

SUBCOMMANDS:
  list              - List available processes
  run               - Execute a process
  stop              - Stop a running process
  create            - Create a new process

EXAMPLES:
  > process list
  > process run system/backup
  > process create my-process
```

#### Identity Commands
```
> help identity

COMMAND: identity
DESCRIPTION: Identity and permission management

SUBCOMMANDS:
  status            - Display current identity
  switch            - Switch to another identity
  permissions       - Manage permissions

EXAMPLES:
  > identity status
  > identity switch 00reaper
  > identity permissions list
```

#### Tools Commands
```
> help tools

COMMAND: tools
DESCRIPTION: Utility tools and external operations

SUBCOMMANDS:
  list              - List available tools
  run               - Run a specific tool
  shell             - Execute shell commands

EXAMPLES:
  > tools list
  > tools run calculator
  > shell echo "Hello, world!"
```

### Handle Unknown Commands

If the user asks for help about a command that doesn't exist, the process should display an error message with suggestions:

```
❌ Unknown command: [command]

Available command categories:
  system, file, process, identity, tools

For general help, type:
  > help
```

### Implementation Notes

This process should:
1. Parse the input to determine if a specific command was requested
2. Look up the help information for that command or category
3. Present the help information in a clear, well-formatted manner
4. Provide examples and suggestions appropriate to the context

The help system should be designed to be easily extended as new commands are added to the system.

### Command-Specific Help Library

This process should maintain a library of help information for all available commands. The library should be organized by command category and should include:
- Command name
- Description
- Subcommands
- Arguments
- Flags
- Examples
- Related commands

The library can be extended as new commands are added to the system.

## Initialization
```javascript
// Initialize variables
const commandName = inputs.command || null;
const isVerbose = inputs.verbose || false;
const registry = require('/00os/core/registry.js');

// Initialize output structure
const output = {
  title: null,
  description: null,
  usage: null,
  options: [],
  commands: [],
  examples: []
};
```

## Execution
```javascript
// If no command specified, show general help
if (!commandName) {
  // Set general help information
  output.title = "00OS Help";
  output.description = "OS-like command interface for AI assistance";
  output.usage = "command [subcommand] [options] [arguments]";
  
  // List all available commands
  const commands = registry.listCommands();
  
  commands.forEach(cmd => {
    output.commands.push({
      name: cmd.name,
      description: cmd.description,
      hasSubcommands: cmd.hasSubcommands
    });
  });
  
  // Add general examples
  output.examples.push("help system");
  output.examples.push("dev execute project");
  output.examples.push("file list /path/to/dir");
  
} else {
  // Show help for specific command
  const command = registry.getProcess(commandName);
  
  if (!command) {
    throw new Error(`Command '${commandName}' not found`);
  }
  
  // Set command-specific help information
  output.title = `${command.name} Command`;
  output.description = command.description;
  
  // Generate usage info
  if (command.requiresSubcommand) {
    output.usage = `${command.name} <subcommand>`;
    
    // List all subcommands
    const subcommands = registry.listSubcommands(commandName);
    
    subcommands.forEach(sub => {
      output.commands.push({
        name: sub.name,
        description: sub.description
      });
    });
    
  } else {
    // Generate usage for command without subcommands
    let usage = command.name;
    
    // Add required arguments to usage
    if (command.requiredArgs > 0) {
      for (let i = 0; i < command.requiredArgs; i++) {
        usage += ` <arg${i + 1}>`;
      }
    }
    
    // Add optional arguments
    if (command.optionalArgs > 0) {
      for (let i = 0; i < command.optionalArgs; i++) {
        usage += ` [arg${i + 1}]`;
      }
    }
    
    output.usage = usage;
    
    // Add options if available and verbose
    if (isVerbose && command.options) {
      Object.keys(command.options).forEach(optName => {
        output.options.push({
          name: optName,
          description: command.options[optName].description,
          required: command.options[optName].required
        });
      });
    }
    
    // Add examples if available
    if (command.examples) {
      output.examples = command.examples;
    }
  }
}
```

## Output
```javascript
// Format the help output as a string
let helpText = `# ${output.title}\n\n`;
helpText += `${output.description}\n\n`;
helpText += `## Usage\n\n\`\`\`\n${output.usage}\n\`\`\`\n\n`;

// Add commands section if any
if (output.commands.length > 0) {
  helpText += `## Commands\n\n`;
  
  output.commands.forEach(cmd => {
    helpText += `- **${cmd.name}** - ${cmd.description}\n`;
  });
  
  helpText += '\n';
}

// Add options section if any
if (output.options.length > 0) {
  helpText += `## Options\n\n`;
  
  output.options.forEach(opt => {
    helpText += `- **${opt.name}** - ${opt.description}${opt.required ? ' (Required)' : ''}\n`;
  });
  
  helpText += '\n';
}

// Add examples section if any
if (output.examples.length > 0) {
  helpText += `## Examples\n\n`;
  
  output.examples.forEach(example => {
    helpText += `\`\`\`\n${example}\n\`\`\`\n\n`;
  });
}

// Return the formatted help text and structured data
return {
  helpText: helpText,
  structured: output
};
``` 