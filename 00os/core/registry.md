# 00OS Process Registry

## Overview
The Process Registry maintains a catalog of all available processes within the 00OS environment. It provides services for registering, discovering, and validating processes before execution.

## Registry Implementation

```javascript
/**
 * 00OS Process Registry
 * 
 * Central repository for all processes available in the system.
 * Handles registration, discovery, and validation of processes.
 */

// Main registry storage
const processRegistry = {
  // System commands
  system: {
    name: 'system',
    description: 'Manage system settings and operations',
    requiresSubcommand: true,
    subcommands: {
      status: {
        name: 'status',
        description: 'Show system status',
        processPath: '/00os/processes/system/status.md'
      },
      update: {
        name: 'update',
        description: 'Update system components',
        processPath: '/00os/processes/system/update.md'
      },
      config: {
        name: 'config',
        description: 'Configure system settings',
        processPath: '/00os/processes/system/config.md',
        requiredArgs: 1
      }
    }
  },
  
  // Help command
  help: {
    name: 'help',
    description: 'Display help information',
    processPath: '/00os/processes/system/help.md'
  },
  
  // Process management
  process: {
    name: 'process',
    description: 'Manage processes',
    requiresSubcommand: true,
    subcommands: {
      list: {
        name: 'list',
        description: 'List available processes',
        processPath: '/00os/processes/system/process-list.md'
      },
      info: {
        name: 'info',
        description: 'Show information about a process',
        processPath: '/00os/processes/system/process-info.md',
        requiredArgs: 1
      },
      create: {
        name: 'create',
        description: 'Create a new process',
        processPath: '/00os/processes/system/process-create.md',
        requiredArgs: 1
      }
    }
  },
  
  // Development operations
  dev: {
    name: 'dev',
    description: 'Execute development tasks',
    requiresSubcommand: true,
    subcommands: {
      execute: {
        name: 'execute',
        description: 'Execute a development task',
        processPath: '/00os/processes/apps/dev-execute.md',
        requiredArgs: 1
      },
      analyze: {
        name: 'analyze',
        description: 'Analyze code or project',
        processPath: '/00os/processes/apps/dev-analyze.md',
        requiredArgs: 1
      },
      create: {
        name: 'create',
        description: 'Create new code or component',
        processPath: '/00os/processes/apps/dev-create.md',
        requiredArgs: 1
      }
    }
  },
  
  // File operations
  file: {
    name: 'file',
    description: 'File management operations',
    requiresSubcommand: true,
    subcommands: {
      read: {
        name: 'read',
        description: 'Read file contents',
        processPath: '/00os/processes/tools/file-read.md',
        requiredArgs: 1
      },
      write: {
        name: 'write',
        description: 'Write to a file',
        processPath: '/00os/processes/tools/file-write.md',
        requiredArgs: 2
      },
      list: {
        name: 'list',
        description: 'List directory contents',
        processPath: '/00os/processes/tools/file-list.md',
        requiredArgs: 1
      }
    }
  }
};

/**
 * Get a process definition from the registry
 * @param {string} command - Primary command name
 * @param {string} subcommand - Subcommand name (optional)
 * @returns {Object} Process definition or null if not found
 */
function getProcess(command, subcommand = null) {
  const commandDef = processRegistry[command];
  if (!commandDef) {
    return null;
  }
  
  // If command requires subcommand but none provided, return null
  if (commandDef.requiresSubcommand && !subcommand) {
    return null;
  }
  
  // If command has subcommands, return the specific subcommand
  if (commandDef.subcommands && subcommand) {
    return commandDef.subcommands[subcommand] || null;
  }
  
  // Otherwise return the command itself
  return commandDef;
}

/**
 * List all available commands
 * @param {string} category - Optional category filter
 * @returns {Array} Array of command definitions
 */
function listCommands(category = null) {
  const commands = [];
  
  Object.keys(processRegistry).forEach(commandName => {
    const command = processRegistry[commandName];
    
    // Apply category filter if provided
    if (category && command.category !== category) {
      return;
    }
    
    // Add command to list
    commands.push({
      name: command.name,
      description: command.description,
      hasSubcommands: command.requiresSubcommand
    });
  });
  
  return commands;
}

/**
 * List all subcommands for a command
 * @param {string} commandName - Command name
 * @returns {Array} Array of subcommand definitions
 */
function listSubcommands(commandName) {
  const command = processRegistry[commandName];
  if (!command || !command.subcommands) {
    return [];
  }
  
  const subcommands = [];
  Object.keys(command.subcommands).forEach(subName => {
    const sub = command.subcommands[subName];
    subcommands.push({
      name: sub.name,
      description: sub.description
    });
  });
  
  return subcommands;
}

/**
 * Register a new process in the registry
 * @param {string} commandName - Command name
 * @param {string} subcommandName - Subcommand name (optional)
 * @param {Object} processDefinition - Process definition
 * @returns {boolean} Success status
 */
function registerProcess(commandName, subcommandName = null, processDefinition) {
  // If command doesn't exist, create it
  if (!processRegistry[commandName]) {
    processRegistry[commandName] = {
      name: commandName,
      description: processDefinition.description || `${commandName} command`,
      subcommands: {}
    };
  }
  
  // If subcommand provided, add to command
  if (subcommandName) {
    if (!processRegistry[commandName].subcommands) {
      processRegistry[commandName].subcommands = {};
    }
    
    processRegistry[commandName].subcommands[subcommandName] = {
      name: subcommandName,
      description: processDefinition.description || `${subcommandName} subcommand`,
      processPath: processDefinition.processPath,
      requiredArgs: processDefinition.requiredArgs || 0
    };
    
    // Ensure command is marked as requiring subcommand
    processRegistry[commandName].requiresSubcommand = true;
  } else {
    // Update command directly
    processRegistry[commandName] = {
      ...processRegistry[commandName],
      ...processDefinition,
      name: commandName
    };
  }
  
  return true;
}

/**
 * Load and parse a process file
 * @param {string} processPath - Path to process file
 * @returns {Object} Process definition and execution blocks
 */
async function loadProcess(processPath) {
  try {
    // In actual implementation, this would read the file
    // and parse the process definition
    const processContent = await readProcessFile(processPath);
    
    // Parse the process metadata and blocks
    const { metadata, blocks } = parseProcessFile(processContent);
    
    return {
      metadata,
      blocks,
      path: processPath
    };
  } catch (error) {
    console.error(`Error loading process: ${processPath}`, error);
    return null;
  }
}

// Export functions for system use
module.exports = {
  getProcess,
  listCommands,
  listSubcommands,
  registerProcess,
  loadProcess
};
```

## Process Metadata

Each process in the registry contains metadata that describes its capabilities and requirements:

- **name**: Process name (matches command or subcommand)
- **description**: Human-readable description
- **processPath**: Path to the process file
- **requiredArgs**: Number of required arguments
- **options**: Supported options with descriptions
- **category**: Process category for organization
- **permissions**: Required permissions to execute
- **version**: Process version

## Directory-Based Process Loading

The registry can dynamically load processes from the file system:

```javascript
/**
 * Load all processes from a directory
 * @param {string} directoryPath - Path to processes directory
 */
async function loadProcessDirectory(directoryPath) {
  // Get all .md files in the directory
  const files = await listDirectory(directoryPath);
  
  // Load each process file
  for (const file of files) {
    if (file.endsWith('.md')) {
      try {
        // Load and parse process file
        const process = await loadProcess(`${directoryPath}/${file}`);
        
        // Register process in the registry
        if (process && process.metadata) {
          registerProcess(
            process.metadata.command,
            process.metadata.subcommand,
            {
              description: process.metadata.description,
              processPath: `${directoryPath}/${file}`,
              requiredArgs: process.metadata.inputs?.filter(i => i.required).length || 0,
              category: process.metadata.category || 'uncategorized'
            }
          );
        }
      } catch (error) {
        console.error(`Error loading process file: ${file}`, error);
      }
    }
  }
}
```

## Process Validation

The registry provides validation functions to ensure processes meet requirements:

```javascript
/**
 * Validate a process definition
 * @param {Object} process - Process definition
 * @returns {Object} Validation result
 */
function validateProcess(process) {
  const errors = [];
  
  // Check required metadata
  if (!process.metadata) {
    errors.push('Process missing metadata');
  } else {
    // Check required metadata fields
    if (!process.metadata.name) errors.push('Process missing name');
    if (!process.metadata.description) errors.push('Process missing description');
  }
  
  // Check execution blocks
  if (!process.blocks || !process.blocks.execution) {
    errors.push('Process missing execution block');
  }
  
  return {
    valid: errors.length === 0,
    errors
  };
}
```

## Integration with Command Parser

The registry works closely with the command parser to validate and execute commands:

1. Parser identifies command and subcommand
2. Registry provides process definition
3. Parser validates arguments against process requirements
4. Registry loads process file
5. Execution engine runs the process

## Future Enhancements

1. **Process Versioning**
   - Support for multiple versions of the same process
   - Version selection based on compatibility

2. **Process Dependencies**
   - Declare and manage dependencies between processes
   - Ensure all required processes are available

3. **Dynamic Loading**
   - Hot-reloading of processes when files change
   - Dynamic discovery of new processes

4. **Advanced Permission Management**
   - Fine-grained permission control
   - Permission inheritance for related processes 