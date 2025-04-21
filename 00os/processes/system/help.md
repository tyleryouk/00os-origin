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

# Help

USE WHEN you want to execute help

## Description

The help command provides information about available commands in the 00OS system. When run without arguments, it lists all available commands. When run with a command name, it provides detailed help for that specific command.

## Usage

```
> help [command]
```

## Examples

- `> help` - Lists all available commands
- `> help reaper-sync` - Shows help for the reaper-sync command

## Implementation

```javascript
async function executeHelp(args) {
  // Parse arguments
  const commandToShow = args.length > 0 ? args[0] : null;
  
  try {
    // If a specific command help is requested
    if (commandToShow) {
      return await showCommandHelp(commandToShow);
    } else {
      // Show general help with all commands
      return await showGeneralHelp();
    }
  } catch (error) {
    return formatError(`Error showing help: ${error.message}`, "HELP_ERROR");
  }
}

async function showGeneralHelp() {
  try {
    // Get all command directories
    const systemResult = await tools.call('list_dir', {
      relative_workspace_path: "/00OS/processes/system",
      explanation: "Listing system processes for help command"
    });
    
    const reaperResult = await tools.call('list_dir', {
      relative_workspace_path: "/00OS/processes/00reaper",
      explanation: "Listing 00reaper processes for help command"
    });
    
    // Extract commands from directory listing
    const systemCommands = systemResult.items
      .filter(item => item.name.endsWith('.md'))
      .map(item => item.name.replace('.md', ''));
    
    const reaperCommands = reaperResult.items
      .filter(item => item.name.endsWith('.md'))
      .map(item => item.name.replace('.md', ''));
    
    // Format the help output
    const helpContent = formatHelpContent(systemCommands, reaperCommands);
    
    return formatSuccess("Available Commands", helpContent);
  } catch (error) {
    return formatError(`Error retrieving command list: ${error.message}`, "LIST_ERROR");
  }
}

async function showCommandHelp(commandName) {
  // Determine which directory to look in based on command prefix
  const isReaperCommand = commandName.startsWith('reaper-');
  const directory = isReaperCommand ? 
    "/00OS/processes/00reaper" : 
    "/00OS/processes/system";
  
  try {
    // Read the command file
    const fileResult = await tools.call('read_file', {
      target_file: `${directory}/${commandName}.md`,
      should_read_entire_file: true,
      explanation: `Reading documentation for ${commandName} command`
    });
    
    // Extract relevant sections from the command file
    const helpSections = extractHelpSections(fileResult.content);
    
    return formatSuccess(`Help for command '${commandName}'`, helpSections);
  } catch (error) {
    return formatError(
      `Command '${commandName}' not found or could not be read.`, 
      "COMMAND_NOT_FOUND",
      [
        "Check the command name for typos",
        "Use '> help' to see all available commands",
        "Make sure the command file exists in the expected directory"
      ]
    );
  }
}

function formatHelpContent(systemCommands, reaperCommands) {
  let content = {
    systemCommands: {},
    reaperCommands: {}
  };
  
  // Add system commands with descriptions
  for (const cmd of systemCommands) {
    content.systemCommands[cmd] = getCommandDescription("/00OS/processes/system", cmd);
  }
  
  // Add reaper commands with descriptions
  for (const cmd of reaperCommands) {
    content.reaperCommands[cmd] = getCommandDescription("/00OS/processes/00reaper", cmd);
  }
  
  return content;
}

function getCommandDescription(directory, commandName) {
  // In a real implementation, this would read the file and extract the description
  // For now, return a placeholder
  return `${commandName} command`;
}

function extractHelpSections(fileContent) {
  // Extract sections from command file
  const sections = {
    description: extractSection(fileContent, "Description"),
    usage: extractSection(fileContent, "Usage"),
    examples: extractSection(fileContent, "Examples")
  };
  
  return sections;
}

function extractSection(content, sectionName) {
  // Simple section extraction
  const sectionPattern = new RegExp(`## ${sectionName}\\s*([\\s\\S]*?)(?:##|$)`, 'i');
  const match = content.match(sectionPattern);
  return match ? match[1].trim() : `No ${sectionName.toLowerCase()} available`;
}

function formatSuccess(message, data = null) {
  return `✅ ${message}${data ? '\n\n' + JSON.stringify(data, null, 2) : ''}`;
}

function formatError(message, code = "ERROR", suggestions = []) {
  let output = `❌ Error [${code}]: ${message}`;
  
  if (suggestions && suggestions.length > 0) {
    output += "\n\nSuggestions:";
    for (const suggestion of suggestions) {
      output += `\n- ${suggestion}`;
    }
  }
  
  return output;
}

// Execute the help command with the provided arguments
return executeHelp(args);
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