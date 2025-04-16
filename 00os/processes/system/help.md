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
- Formatted help information

## Execution
When the user enters `> help` or `> help [command]`, this process provides information about available commands or detailed help for a specific command.

```javascript
// Main execution function
function execute() {
  try {
    // Get specified command (if any)
    const commandName = inputs.command;
    
    if (!commandName) {
      // No command specified, show general help
      return formatGeneralHelp();
    } else {
      // Show help for specific command
      return formatCommandHelp(commandName);
    }
  } catch (error) {
    return formatError(`Error processing help request: ${error.message}`, 'HELP_ERROR');
  }
}

// Function to dynamically discover available commands
async function discoverCommands() {
  const commandCategories = {
    "SYSTEM COMMANDS": [],
    "FILE OPERATIONS": [],
    "REAPER COMMANDS": [],
    "TOOL COMMANDS": [],
    "EXAMPLE COMMANDS": []
  };
  
  try {
    // Check processes directory for command files
    const systemDir = await tools.call('list_dir', { 
      relative_workspace_path: '00OS/processes/system/',
      explanation: 'Discovering system commands for help'
    });
    
    const toolsDir = await tools.call('list_dir', { 
      relative_workspace_path: '00OS/processes/tools/',
      explanation: 'Discovering tool commands for help'
    });
    
    const examplesDir = await tools.call('list_dir', { 
      relative_workspace_path: '00OS/processes/examples/',
      explanation: 'Discovering example commands for help'
    });
    
    // Process system commands
    if (systemDir && systemDir.entries) {
      for (const entry of systemDir.entries) {
        if (!entry.is_directory && entry.path.endsWith('.md')) {
          const fileName = entry.path.split('/').pop().replace('.md', '');
          
          // Categorize commands
          if (fileName.startsWith('reaper-')) {
            commandCategories["REAPER COMMANDS"].push(getCommandDetails(fileName));
          } else if (fileName === 'system-status') {
            commandCategories["SYSTEM COMMANDS"].push(getCommandDetails('system status'));
          } else {
            commandCategories["SYSTEM COMMANDS"].push(getCommandDetails(fileName));
          }
        }
      }
    }
    
    // Process tool commands
    if (toolsDir && toolsDir.entries) {
      for (const entry of toolsDir.entries) {
        if (!entry.is_directory && entry.path.endsWith('.md')) {
          const fileName = entry.path.split('/').pop().replace('.md', '');
          
          // Handle file operations
          if (fileName.startsWith('file-')) {
            const subCommand = fileName.replace('file-', '');
            commandCategories["FILE OPERATIONS"].push(getCommandDetails(`file ${subCommand}`));
          } else {
            commandCategories["TOOL COMMANDS"].push(getCommandDetails(fileName));
          }
        }
      }
    }
    
    // Process example commands
    if (examplesDir && examplesDir.entries) {
      for (const entry of examplesDir.entries) {
        if (!entry.is_directory && entry.path.endsWith('.md')) {
          const fileName = entry.path.split('/').pop().replace('.md', '');
          commandCategories["EXAMPLE COMMANDS"].push(getCommandDetails(fileName));
        }
      }
    }
    
    return commandCategories;
  } catch (error) {
    tools.log(`Error discovering commands: ${error.message}`);
    // Return fallback categories if discovery fails
    return commandCategories;
  }
}

// Get command details (description and usage)
function getCommandDetails(commandName) {
  // Command descriptions mapping (fallback if metadata can't be read)
  const descriptions = {
    'help': 'Display help information',
    'system status': 'Display system status',
    'echo': 'Echo a message',
    'version': 'Show version information',
    'file list': 'List files in directory',
    'reaper-init': 'Initialize 00reaper context',
    'reaper-update': 'Update context state',
    'reaper-sync': 'Sync 00OS to rules',
    'reaper-read-files': 'Read all files in a directory',
    'state': 'Manage system state',
    'counter': 'Example counter application',
    'calculator': 'Perform calculations'
  };
  
  // Command usage patterns
  const usage = {
    'echo': 'echo [message]',
    'file list': 'file list [path]',
    'counter': 'counter [start|stop|reset]',
    'calculator': 'calculator [expression]'
  };
  
  return {
    name: commandName,
    description: descriptions[commandName] || 'Command description not available',
    usage: usage[commandName] || commandName
  };
}

// Format general help output with all available commands
async function formatGeneralHelp() {
  const commandCategories = await discoverCommands();
  
  let output = `✅ 00OS Command Help\n\n`;
  output += `Available Commands:\n`;
  output += `-----------------\n`;
  
  // Add commands by category
  for (const [category, commands] of Object.entries(commandCategories)) {
    // Only show categories with commands
    if (commands.length > 0) {
      output += `${category}:\n`;
      
      for (const cmd of commands) {
        const usageStr = cmd.usage || cmd.name;
        output += `  > ${usageStr.padEnd(25)} ${cmd.description}\n`;
      }
      
      output += `\n`;
    }
  }
  
  // Add help usage examples
  output += `For detailed help on a specific command, type:\n`;
  output += `  > help [command]\n\n`;
  output += `Example:\n`;
  output += `  > help file list\n`;
  
  return output;
}

// Format help for a specific command
function formatCommandHelp(commandName) {
  // This would need to read the actual process file metadata for complete info
  // For now, we'll provide basic command help based on known commands
  
  const commandHelp = {
    'help': `
COMMAND: help
DESCRIPTION: Display help information for commands

USAGE:
  > help                  - Show list of all available commands
  > help [command]        - Show detailed help for a specific command

EXAMPLES:
  > help                  - Show all commands
  > help file list        - Show help for the 'file list' command
  > help system           - Show help for system commands
`,
    'system': `
COMMAND: system
DESCRIPTION: System management and configuration commands

SUBCOMMANDS:
  status            - Display system status and information

EXAMPLES:
  > system status   - Show current system status
`,
    'file': `
COMMAND: file
DESCRIPTION: File operations and navigation

SUBCOMMANDS:
  list              - List files in a directory

EXAMPLES:
  > file list /00os - List files in the /00os directory
`,
    'reaper-init': `
COMMAND: reaper-init
DESCRIPTION: Initialize 00reaper context and load comprehensive system understanding

USAGE:
  > reaper-init               - Standard initialization
  > reaper-init --verbose     - Detailed initialization with file loading status
  > reaper-init --focus=AREA  - Prioritize specific area (architecture|sync|processes)

EXAMPLES:
  > reaper-init               - Initialize standard context
  > reaper-init --verbose     - Show detailed loading information
  > reaper-init --focus=architecture - Focus on architecture components
`,
    'reaper-update': `
COMMAND: reaper-update
DESCRIPTION: Update 00reaper context between sessions

USAGE:
  > reaper-update                        - Simple update
  > reaper-update --message="..."        - Update with context message

EXAMPLES:
  > reaper-update --message="Added new commands" - Update with message
`,
    'echo': `
COMMAND: echo
DESCRIPTION: Echo a message back to the terminal

USAGE:
  > echo [message]           - Display the provided message

EXAMPLES:
  > echo Hello, world!       - Display "Hello, world!"
`,
    'counter': `
COMMAND: counter
DESCRIPTION: Example stateful counter application

USAGE:
  > counter             - Show current count
  > counter start       - Start the counter
  > counter stop        - Stop the counter
  > counter reset       - Reset to zero
  > counter set [n]     - Set counter to specific value

EXAMPLES:
  > counter start       - Start incrementing
  > counter set 10      - Set counter to 10
`
  };
  
  // Check if we have specific help for this command
  if (commandHelp[commandName]) {
    return `✅ Help: ${commandName}\n${commandHelp[commandName]}`;
  }
  
  // Check for compound commands (e.g., "file list")
  const parts = commandName.split(' ');
  if (parts.length > 1 && commandHelp[parts[0]]) {
    return `✅ Help: ${commandName}\n${commandHelp[parts[0]]}`;
  }
  
  // Command not found
  return `❌ Unknown command: ${commandName}\n\nAvailable command categories:\n  system, file, reaper, tools, examples\n\nFor general help, type:\n  > help`;
}

// Format success message
function formatSuccess(message) {
  return `✅ ${message}`;
}

// Format error message
function formatError(message, code, suggestions = []) {
  let output = `❌ Error [${code}]: ${message}\n\n`;
  
  if (suggestions.length > 0) {
    output += "Suggestions:\n";
    for (const suggestion of suggestions) {
      output += `- ${suggestion}\n`;
    }
  }
  
  return output;
}

// Execute and return result
execute();
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