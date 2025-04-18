---
name: command-registry
description: Manage the command registry
version: 1.0.0
author: 00reaper
permissions: [basic, system-read]
inputs:
  - name: action
    type: string
    required: false
    default: list
    description: Action to perform (list, refresh, search, info)
  - name: query
    type: string
    required: false
    description: Query term for search or command name for info
  - name: category
    type: string
    required: false
    description: Filter commands by category
outputs:
  - name: result
    type: object
    description: Command registry operation result
---

# Process: command-registry

## Metadata
- Description: Manage the command registry
- Category: system
- Permissions: [basic, system-read]
- Author: 00reaper
- Version: 1.0.0

## Input
- action: Action to perform (list, refresh, search, info)
- query: Query term for search or command name for info
- category: Filter commands by category

## Output
- Command registry operation result

## Execution
```javascript
// Main execution function
async function execute() {
  try {
    // Get action from inputs (default to list)
    const action = inputs.action ? inputs.action.toLowerCase() : 'list';
    
    // Execute requested action
    switch (action) {
      case 'list':
        return await listCommands(inputs.category);
      case 'refresh':
        return await refreshRegistry();
      case 'search':
        return await searchCommands(inputs.query);
      case 'info':
        return await getCommandInfo(inputs.query);
      default:
        return formatError(`Unknown action: ${action}`, [
          'Available actions: list, refresh, search, info',
          'Example: command-registry list',
          'Example: command-registry search file'
        ]);
    }
  } catch (error) {
    return formatError(`Error executing command: ${error.message}`);
  }
}

// List available commands
async function listCommands(categoryFilter) {
  try {
    // Get all commands from registry
    const commands = await getRegisteredCommands();
    
    // Apply category filter if provided
    const filteredCommands = categoryFilter
      ? commands.filter(cmd => cmd.category.toLowerCase() === categoryFilter.toLowerCase())
      : commands;
    
    if (filteredCommands.length === 0) {
      if (categoryFilter) {
        return formatError(`No commands found in category: ${categoryFilter}`, [
          'Available categories: system, tools, examples, apps',
          'Try without a category filter to see all commands'
        ]);
      } else {
        return formatError('No commands registered in the system');
      }
    }
    
    // Group commands by category
    const commandsByCategory = groupCommandsByCategory(filteredCommands);
    
    // Format the output
    let output = `✅ Registered Commands\n\n`;
    
    if (categoryFilter) {
      output += `Commands in category "${categoryFilter}":\n\n`;
    } else {
      output += `Commands by category:\n\n`;
    }
    
    // Add commands by category
    for (const category in commandsByCategory) {
      output += `${category.toUpperCase()}:\n`;
      
      commandsByCategory[category].forEach(cmd => {
        output += `  ${cmd.name.padEnd(15)} ${cmd.description}\n`;
      });
      
      output += '\n';
    }
    
    // Add usage hint
    output += `Use 'command-registry info <command>' for detailed information about a specific command.`;
    
    return output;
  } catch (error) {
    return formatError(`Error listing commands: ${error.message}`);
  }
}

// Refresh the command registry
async function refreshRegistry() {
  try {
    // Get current command count before refresh
    const beforeCommands = await getRegisteredCommands();
    const before = beforeCommands.length;
    
    // Discover all commands by scanning the process directories
    const commands = await discoverAllCommands();
    const after = commands.length;
    
    // Identify new commands
    const newCommands = commands.filter(newCmd => 
      !beforeCommands.some(oldCmd => oldCmd.name === newCmd.name)
    );
    
    let output = `✅ Command Registry Refreshed\n\n`;
    output += `Commands before refresh: ${before}\n`;
    output += `Commands after refresh: ${after}\n`;
    output += `New commands detected: ${newCommands.length}\n\n`;
    
    if (newCommands.length > 0) {
      output += `New Commands:\n`;
      newCommands.forEach(cmd => {
        output += `- ${cmd.name} (${cmd.category})\n`;
      });
    }
    
    return output;
  } catch (error) {
    return formatError(`Error refreshing registry: ${error.message}`);
  }
}

// Search for commands
async function searchCommands(query) {
  try {
    if (!query) {
      return formatError('No search query provided', [
        'Provide a search term to find matching commands',
        'Example: command-registry search file'
      ]);
    }
    
    // Get all commands from registry
    const commands = await getRegisteredCommands();
    
    // Filter commands by query (search in name and description)
    const matchingCommands = commands.filter(cmd => 
      cmd.name.toLowerCase().includes(query.toLowerCase()) || 
      cmd.description.toLowerCase().includes(query.toLowerCase())
    );
    
    if (matchingCommands.length === 0) {
      return formatError(`No commands found matching query: ${query}`, [
        'Try a different search term',
        'Use broader terms for more results'
      ]);
    }
    
    // Format the output
    let output = `✅ Search Results for "${query}"\n\n`;
    output += `Found ${matchingCommands.length} matching commands:\n\n`;
    
    // Group results by relevance
    const nameMatches = matchingCommands.filter(cmd => 
      cmd.name.toLowerCase().includes(query.toLowerCase())
    );
    
    const descriptionMatches = matchingCommands.filter(cmd => 
      !cmd.name.toLowerCase().includes(query.toLowerCase()) &&
      cmd.description.toLowerCase().includes(query.toLowerCase())
    );
    
    // Show name matches first
    if (nameMatches.length > 0) {
      output += `Name Matches:\n`;
      nameMatches.forEach(cmd => {
        output += `  ${cmd.name.padEnd(15)} ${cmd.description} (${cmd.category})\n`;
      });
      output += '\n';
    }
    
    // Then show description matches
    if (descriptionMatches.length > 0) {
      output += `Description Matches:\n`;
      descriptionMatches.forEach(cmd => {
        output += `  ${cmd.name.padEnd(15)} ${cmd.description} (${cmd.category})\n`;
      });
    }
    
    return output;
  } catch (error) {
    return formatError(`Error searching commands: ${error.message}`);
  }
}

// Get detailed information about a command
async function getCommandInfo(commandName) {
  try {
    if (!commandName) {
      return formatError('No command name provided', [
        'Provide a command name to get detailed information',
        'Example: command-registry info echo'
      ]);
    }
    
    // Get all commands from registry
    const commands = await getRegisteredCommands();
    
    // Find the requested command
    const command = commands.find(cmd => cmd.name.toLowerCase() === commandName.toLowerCase());
    
    if (!command) {
      return formatError(`Command not found: ${commandName}`, [
        'Use command-registry list to see available commands',
        'Check the spelling of the command name'
      ]);
    }
    
    // Format the output
    let output = `✅ Command Information: ${command.name}\n\n`;
    
    // Basic command information
    output += `Name: ${command.name}\n`;
    output += `Description: ${command.description}\n`;
    output += `Category: ${command.category}\n`;
    output += `Version: ${command.version}\n`;
    output += `Author: ${command.author}\n\n`;
    
    // Command usage
    output += `Usage: > ${command.name} ${command.usage || ''}\n\n`;
    
    // Input parameters
    if (command.inputs && command.inputs.length > 0) {
      output += `Input Parameters:\n`;
      command.inputs.forEach(input => {
        const required = input.required ? '(required)' : '(optional)';
        const defaultValue = input.default ? `default: ${input.default}` : '';
        output += `  ${input.name}: ${input.type} ${required} - ${input.description} ${defaultValue}\n`;
      });
      output += '\n';
    }
    
    // Examples
    if (command.examples && command.examples.length > 0) {
      output += `Examples:\n`;
      command.examples.forEach(example => {
        output += `  > ${example}\n`;
      });
    }
    
    return output;
  } catch (error) {
    return formatError(`Error getting command info: ${error.message}`);
  }
}

// Helper function to get all registered commands by scanning process directories
async function getRegisteredCommands() {
  try {
    // Get commands by discovering all process files
    return await discoverAllCommands();
  } catch (error) {
    tools.log(`Error getting registered commands: ${error.message}`);
    // Return empty array as fallback
    return [];
  }
}

// Helper function to discover all commands from process directories
async function discoverAllCommands() {
  try {
    const allCommands = [];
    
    // Get list of process directories
    const processDir = await tools.call('list_dir', {
      relative_workspace_path: '00os/processes',
      explanation: 'Listing process directories for command discovery'
    });
    
    // Process each category directory
    if (processDir) {
      for (const dirEntry of processDir) {
        if (dirEntry.startsWith('[dir]')) {
          // Extract directory name
          const categoryMatch = dirEntry.match(/\[dir\]\s+(\w+)/);
          if (categoryMatch && categoryMatch[1]) {
            const category = categoryMatch[1].toLowerCase();
            
            // List files in the category directory
            const files = await tools.call('list_dir', {
              relative_workspace_path: `00os/processes/${category}`,
              explanation: `Listing process files in ${category} for command discovery`
            });
            
            // Process each file
            if (files) {
              for (const fileEntry of files) {
                if (fileEntry.includes('.md')) {
                  // Extract filename
                  const fileMatch = fileEntry.match(/\[file\]\s+(\S+)\.md/);
                  if (fileMatch && fileMatch[1]) {
                    const filename = fileMatch[1];
                    
                    // Read process file to extract command information
                    const commandInfo = await extractCommandInfo(filename, category);
                    if (commandInfo) {
                      allCommands.push(commandInfo);
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    // If no commands were discovered, fall back to a minimal set
    if (allCommands.length === 0) {
      return getFallbackCommands();
    }
    
    return allCommands;
  } catch (error) {
    tools.log(`Error discovering commands: ${error.message}`);
    // Return fallback commands if discovery fails
    return getFallbackCommands();
  }
}

// Helper function to extract command information from a process file
async function extractCommandInfo(filename, category) {
  try {
    // Read the file header to extract metadata
    const filePath = `00os/processes/${category}/${filename}.md`;
    
    const fileContent = await tools.call('read_file', {
      target_file: filePath,
      offset: 1,
      limit: 50, // Read just enough to get the header
      explanation: `Reading process file header from ${filePath} for command discovery`
    });
    
    if (!fileContent) {
      return null;
    }
    
    // Extract YAML frontmatter between --- tags
    const content = fileContent;
    const frontmatterMatch = content.match(/---\n([\s\S]*?)\n---/);
    
    if (frontmatterMatch) {
      const frontmatter = frontmatterMatch[1];
      
      // Parse frontmatter lines to extract command info
      const lines = frontmatter.split('\n');
      const commandInfo = {
        category: category // Default category from directory
      };
      
      for (const line of lines) {
        // Extract key-value pairs from YAML lines
        const match = line.match(/^\s*(\w+):\s*(.*)/);
        if (match) {
          const [_, key, value] = match;
          
          // Extract specific metadata fields
          if (key === 'name') {
            commandInfo.name = value.trim();
          } else if (key === 'description') {
            commandInfo.description = value.trim();
          } else if (key === 'version') {
            commandInfo.version = value.trim();
          } else if (key === 'author') {
            commandInfo.author = value.trim();
          } else if (key === 'usage') {
            commandInfo.usage = value.trim();
          }
        }
        
        // Look for inputs section
        if (line.match(/^\s*inputs:/)) {
          commandInfo.inputs = [];
          continue;
        }
        
        // Extract input parameters (simplified, might need enhancements)
        if (commandInfo.inputs && line.match(/^\s*-\s*name:/)) {
          const inputMatch = line.match(/^\s*-\s*name:\s*(.*)/);
          if (inputMatch) {
            const inputName = inputMatch[1].trim();
            const input = { name: inputName };
            
            // Try to extract next lines for input details
            const inputIndex = lines.indexOf(line);
            if (inputIndex >= 0 && inputIndex < lines.length - 1) {
              // Extract type
              const typeMatch = lines[inputIndex + 1].match(/^\s*type:\s*(.*)/);
              if (typeMatch) {
                input.type = typeMatch[1].trim();
              }
              
              // Extract required
              const requiredMatch = lines[inputIndex + 2].match(/^\s*required:\s*(.*)/);
              if (requiredMatch) {
                input.required = requiredMatch[1].trim() === 'true';
              }
              
              // Extract default value
              const defaultMatch = lines[inputIndex + 3].match(/^\s*default:\s*(.*)/);
              if (defaultMatch) {
                input.default = defaultMatch[1].trim();
              }
              
              // Extract description
              const descMatch = lines[inputIndex + 4].match(/^\s*description:\s*(.*)/);
              if (descMatch) {
                input.description = descMatch[1].trim();
              }
            }
            
            commandInfo.inputs.push(input);
          }
        }
        
        // Look for examples section
        if (line.match(/^\s*examples:/)) {
          commandInfo.examples = [];
          continue;
        }
        
        // Extract examples
        if (commandInfo.examples && line.match(/^\s*-\s*/)) {
          const exampleMatch = line.match(/^\s*-\s*(.*)/);
          if (exampleMatch) {
            commandInfo.examples.push(exampleMatch[1].trim());
          }
        }
      }
      
      // If name is missing, use filename
      if (!commandInfo.name) {
        commandInfo.name = filename.replace(/-/g, ' ');
      }
      
      // If description is missing, provide a default
      if (!commandInfo.description) {
        commandInfo.description = `${filename} command`;
      }
      
      // If version is missing, use default
      if (!commandInfo.version) {
        commandInfo.version = '1.0.0';
      }
      
      // If author is missing, use default
      if (!commandInfo.author) {
        commandInfo.author = '00reaper';
      }
      
      return commandInfo;
    }
    
    // If frontmatter parsing fails, create basic info from filename
    return {
      name: filename.replace(/-/g, ' '),
      description: `${filename} command`,
      category: category,
      version: '1.0.0',
      author: '00reaper'
    };
  } catch (error) {
    tools.log(`Error extracting command info from ${filename}: ${error.message}`);
    // Return null if extraction fails
    return null;
  }
}

// Fallback list of commands in case dynamic discovery fails
function getFallbackCommands() {
  return [
    {
      name: 'help',
      description: 'Display help information',
      category: 'system',
      version: '1.0.0',
      author: '00reaper',
      usage: '[command]',
      inputs: [
        { name: 'command', type: 'string', required: false, description: 'Command to get help for' },
        { name: 'verbose', type: 'boolean', required: false, default: false, description: 'Show verbose output' }
      ],
      examples: ['help', 'help echo', 'help --verbose']
    },
    {
      name: 'echo',
      description: 'Echo a message',
      category: 'system',
      version: '1.0.0',
      author: '00reaper',
      usage: '<message>',
      inputs: [
        { name: 'message', type: 'string', required: true, description: 'Message to echo' }
      ],
      examples: ['echo Hello, world!', 'echo "Multiple words"']
    },
    {
      name: 'system-status',
      description: 'Display system status',
      category: 'system',
      version: '1.0.0',
      author: '00reaper'
    },
    {
      name: 'file-list',
      description: 'List directory contents',
      category: 'tools',
      version: '1.0.0',
      author: '00reaper'
    }
  ];
}

// Helper function to group commands by category
function groupCommandsByCategory(commands) {
  const result = {};
  
  commands.forEach(cmd => {
    const category = cmd.category || 'uncategorized';
    
    if (!result[category]) {
      result[category] = [];
    }
    
    result[category].push(cmd);
  });
  
  return result;
}

// Format error messages
function formatError(message, suggestions = []) {
  let output = `❌ Error: ${message}\n\n`;
  
  if (suggestions && suggestions.length > 0) {
    output += 'Suggestions:\n';
    suggestions.forEach(suggestion => {
      output += `- ${suggestion}\n`;
    });
  }
  
  return output;
}
```

## Usage Examples

### List Commands
```
> command-registry list
✅ Registered Commands

Commands by category:

SYSTEM:
  help           Display help information
  echo           Echo a message
  system-status  Display system status
  version        Show version information
  reaper-init    Initialize 00reaper context
  chain          Execute multiple commands in sequence

TOOLS:
  file-list      List directory contents
  file-read      Read file contents
  system-monitor Monitor system resources and component status

EXAMPLES:
  counter        Example counter application

Use 'command-registry info <command>' for detailed information about a specific command.
```

### Get Command Info
```
> command-registry info chain
✅ Command Information: chain

Name: chain
Description: Execute multiple commands in sequence
Category: system
Version: 1.0.0
Author: 00reaper

Usage: > chain <commands> [--verbose]

Input Parameters:
  commands: string (required) - Commands to execute separated by | or ;
  verbose: boolean (optional) - Show detailed execution information default: false

Examples:
  > chain echo Hello | echo World
  > chain echo Hello | help --verbose
```

### Search Commands
```
> command-registry search monitor
✅ Search Results for "monitor"

Found 1 matching commands:

Name Matches:
  system-monitor  Monitor system resources and component status (tools)
```

### Refresh Registry
```
> command-registry refresh
✅ Command Registry Refreshed

Commands before refresh: 16
Commands after refresh: 18
New commands detected: 2

New Commands:
- chain (system)
- system-monitor (tools)
```