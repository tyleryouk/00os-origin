---
name: command-verify
description: Verify command-process alignment across the 00OS system
version: 1.0.0
author: 00reaper
category: system
permissions: [basic, file-read, system-read]
inputs:
  - name: fix
    type: boolean
    required: false
    default: false
    description: Attempt to fix alignment issues
  - name: detailed
    type: boolean
    required: false
    default: false
    description: Show detailed information about each command
outputs:
  - name: result
    type: object
    description: Verification results
---

# Process: command-verify

## Description
Verifies the alignment between 00OS commands and their corresponding process files. This ensures each command has exactly one process file in the correct category directory, following the naming convention.

## Execution

```javascript
// Main execution function
async function execute() {
  try {
    // Get options from inputs
    const shouldFix = inputs.fix === true;
    const showDetailed = inputs.detailed === true;
    
    tools.log("Starting command-process alignment verification...");
    
    // 1. First, get all entries from the command registry
    const registryCommands = await getRegistryCommands();
    tools.log(`Found ${registryCommands.length} commands in the registry.`);
    
    // 2. Next, scan the process directories for actual process files
    const processFiles = await scanProcessDirectories();
    tools.log(`Found ${processFiles.length} process files on disk.`);
    
    // 3. Verify alignment between registry and process files
    const verificationResults = verifyAlignment(registryCommands, processFiles);
    
    // 4. Generate the report
    const report = generateReport(verificationResults, showDetailed);
    
    // 5. If fix option is enabled, attempt to fix misalignments
    let fixReport = "";
    if (shouldFix && verificationResults.issues.length > 0) {
      fixReport = await fixMisalignments(verificationResults.issues);
    }
    
    // Combine the regular report with fix report if any
    const finalReport = fixReport ? `${report}\n\n${fixReport}` : report;
    
    return {
      success: verificationResults.issues.length === 0,
      message: finalReport,
      data: verificationResults
    };
    
  } catch (error) {
    return {
      success: false,
      message: `❌ Error verifying command-process alignment: ${error.message}`,
      error: error.message
    };
  }
}

// Function to get commands from registry
async function getRegistryCommands() {
  const commands = [];
  
  try {
    // Use command-registry to get the list of commands
    // For now, we'll read the command registry file directly
    const registryContent = await tools.call('read_file', {
      target_file: '00reaper/00OS-commands/documentation/command-registry.md',
      should_read_entire_file: true,
      explanation: 'Reading command registry to verify command-process alignment'
    });
    
    if (!registryContent || !registryContent.content) {
      tools.log('Warning: Could not read command registry file.');
      return commands;
    }
    
    const content = registryContent.content;
    
    // Parse the file to extract command information
    // Find tables with command listings
    const systemTableRegex = /## System Commands[\s\S]*?\| Command \| Status \| Process File \| Description \|[\s\S]*?(?=##|$)/;
    const reaperTableRegex = /## 00reaper-specific Commands[\s\S]*?\| Command \| Status \| Process File \| Description \|[\s\S]*?(?=##|$)/;
    const devTableRegex = /## 1000xdev-specific Commands[\s\S]*?\| Command \| Status \| Process File \| Description \|[\s\S]*?(?=##|$)/;
    
    // Extract commands from tables
    const systemMatch = content.match(systemTableRegex);
    const reaperMatch = content.match(reaperTableRegex);
    const devMatch = content.match(devTableRegex);
    
    if (systemMatch) {
      const systemCommands = parseCommandTable(systemMatch[0], 'system');
      commands.push(...systemCommands);
    }
    
    if (reaperMatch) {
      const reaperCommands = parseCommandTable(reaperMatch[0], '00reaper');
      commands.push(...reaperCommands);
    }
    
    if (devMatch) {
      const devCommands = parseCommandTable(devMatch[0], '1000xdev');
      commands.push(...devCommands);
    }
    
    return commands;
  } catch (error) {
    tools.log(`Error reading command registry: ${error.message}`);
    return [];
  }
}

// Parse a command table from the command registry
function parseCommandTable(tableText, category) {
  const commands = [];
  const lines = tableText.split('\n');
  
  // Skip header lines
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();
    if (line.startsWith('|') && !line.startsWith('| Command') && !line.startsWith('|--')) {
      const parts = line.split('|').map(part => part.trim());
      if (parts.length >= 5) {  // Format: | Command | Status | Process File | Description |
        const commandName = parts[1].replace(/`/g, '').trim();
        const status = parts[2].trim();
        const processFile = parts[3].trim();
        const description = parts[4].trim();
        
        if (commandName && commandName !== 'No commands implemented yet') {
          commands.push({
            name: commandName,
            category,
            status,
            processFile,
            description
          });
        }
      }
    }
  }
  
  return commands;
}

// Scan process directories for actual process files
async function scanProcessDirectories() {
  const processFiles = [];
  
  // Categories to scan
  const categories = ['system', '00reaper', '1000xdev'];
  
  for (const category of categories) {
    try {
      const dirPath = `00os/processes/${category}`;
      const dirContent = await tools.call('list_dir', {
        relative_workspace_path: dirPath,
        explanation: `Listing process files in ${dirPath}`
      });
      
      if (!dirContent || !dirContent.entries) {
        tools.log(`Warning: Could not read directory ${dirPath}.`);
        continue;
      }
      
      // Filter for .md files
      const mdFiles = dirContent.entries.filter(entry => 
        !entry.is_directory && entry.path.endsWith('.md'));
      
      // Extract command info from file names
      for (const file of mdFiles) {
        const fileName = file.path.split('/').pop();
        const commandName = fileName.replace('.md', '');
        
        processFiles.push({
          name: commandName,
          category,
          filePath: file.path
        });
      }
    } catch (error) {
      tools.log(`Error scanning directory 00os/processes/${category}: ${error.message}`);
    }
  }
  
  return processFiles;
}

// Verify alignment between registry commands and process files
function verifyAlignment(registryCommands, processFiles) {
  const result = {
    correctlyAligned: [],
    issues: []
  };
  
  // Track commands processed to find duplicates
  const processedCommands = new Set();
  
  // Check registry commands against process files
  for (const regCmd of registryCommands) {
    // Normalize command name for comparison
    // Extract base command name without subcommand if present
    const commandParts = regCmd.name.split(' ');
    const baseCommand = commandParts[0];
    const subcommand = commandParts.length > 1 ? commandParts[1] : null;
    
    // Create expected file name
    const expectedFileName = subcommand 
      ? `${baseCommand}-${subcommand}`
      : baseCommand;
    
    // Create a unique identifier for this command
    const commandId = regCmd.name;
    
    // Check if command is already processed (duplicate)
    if (processedCommands.has(commandId)) {
      result.issues.push({
        type: 'DUPLICATE_REGISTRY',
        command: regCmd.name,
        category: regCmd.category,
        description: `Command appears multiple times in the registry.`
      });
      continue;
    }
    
    processedCommands.add(commandId);
    
    // Find matching process file
    const matchingProcess = processFiles.find(proc => 
      proc.name === expectedFileName && proc.category === regCmd.category);
    
    if (matchingProcess) {
      // Command is correctly aligned
      result.correctlyAligned.push({
        command: regCmd.name,
        category: regCmd.category,
        processFile: matchingProcess.filePath
      });
    } else {
      // No matching process file
      result.issues.push({
        type: 'MISSING_PROCESS',
        command: regCmd.name,
        category: regCmd.category,
        expectedFileName: expectedFileName,
        description: `No process file found for command in category ${regCmd.category}.`
      });
    }
  }
  
  // Now check for process files that don't have a registry entry
  for (const procFile of processFiles) {
    // Check if this is a base command or a subcommand
    const commandName = procFile.name.includes('-')
      ? procFile.name.split('-')[0] + ' ' + procFile.name.split('-').slice(1).join('-')
      : procFile.name;
    
    // Check if command exists in registry
    const registryMatch = registryCommands.find(cmd => 
      (cmd.name === commandName || cmd.name === procFile.name) && 
      cmd.category === procFile.category);
    
    if (!registryMatch) {
      // Process file doesn't have a registry entry
      result.issues.push({
        type: 'MISSING_REGISTRY',
        command: commandName,
        category: procFile.category,
        processFile: procFile.filePath,
        description: `Process file exists but no registry entry found.`
      });
    }
  }
  
  return result;
}

// Generate human-readable report
function generateReport(verificationResults, showDetailed) {
  const { correctlyAligned, issues } = verificationResults;
  
  let report = `# Command-Process Alignment Verification Report\n\n`;
  
  // Summary
  report += `## Summary\n\n`;
  report += `- Total commands: ${correctlyAligned.length + issues.length}\n`;
  report += `- Correctly aligned: ${correctlyAligned.length}\n`;
  report += `- Issues found: ${issues.length}\n\n`;
  
  // Issue breakdown
  if (issues.length > 0) {
    const missingProcess = issues.filter(i => i.type === 'MISSING_PROCESS').length;
    const missingRegistry = issues.filter(i => i.type === 'MISSING_REGISTRY').length;
    const duplicateRegistry = issues.filter(i => i.type === 'DUPLICATE_REGISTRY').length;
    
    report += `## Issue Breakdown\n\n`;
    report += `- Missing process files: ${missingProcess}\n`;
    report += `- Missing registry entries: ${missingRegistry}\n`;
    report += `- Duplicate registry entries: ${duplicateRegistry}\n\n`;
    
    // Detailed issues
    report += `## Issues\n\n`;
    
    // Group issues by type
    if (missingProcess > 0) {
      report += `### Missing Process Files\n\n`;
      for (const issue of issues.filter(i => i.type === 'MISSING_PROCESS')) {
        report += `- Command \`${issue.command}\` in category \`${issue.category}\`\n`;
        report += `  Expected file: \`00os/processes/${issue.category}/${issue.expectedFileName}.md\`\n\n`;
      }
    }
    
    if (missingRegistry > 0) {
      report += `### Missing Registry Entries\n\n`;
      for (const issue of issues.filter(i => i.type === 'MISSING_REGISTRY')) {
        report += `- Process \`${issue.processFile}\` has no registry entry\n`;
        report += `  Expected registry entry for \`${issue.command}\` in category \`${issue.category}\`\n\n`;
      }
    }
    
    if (duplicateRegistry > 0) {
      report += `### Duplicate Registry Entries\n\n`;
      for (const issue of issues.filter(i => i.type === 'DUPLICATE_REGISTRY')) {
        report += `- Command \`${issue.command}\` appears multiple times in registry\n\n`;
      }
    }
  }
  
  // Detailed listing of correctly aligned commands if requested
  if (showDetailed && correctlyAligned.length > 0) {
    report += `## Correctly Aligned Commands\n\n`;
    
    // Group by category
    const byCategory = {};
    for (const cmd of correctlyAligned) {
      if (!byCategory[cmd.category]) {
        byCategory[cmd.category] = [];
      }
      byCategory[cmd.category].push(cmd);
    }
    
    for (const [category, commands] of Object.entries(byCategory)) {
      report += `### ${category} Commands\n\n`;
      
      for (const cmd of commands) {
        report += `- \`${cmd.command}\` -> \`${cmd.processFile}\`\n`;
      }
      
      report += `\n`;
    }
  }
  
  return report;
}

// Fix misalignments if requested
async function fixMisalignments(issues) {
  // For now, just return recommendations for fixing
  let fixReport = `## Fix Recommendations\n\n`;
  
  const missingProcess = issues.filter(i => i.type === 'MISSING_PROCESS');
  const missingRegistry = issues.filter(i => i.type === 'MISSING_REGISTRY');
  const duplicateRegistry = issues.filter(i => i.type === 'DUPLICATE_REGISTRY');
  
  if (missingProcess.length > 0) {
    fixReport += `### Create Missing Process Files\n\n`;
    for (const issue of missingProcess) {
      fixReport += `1. Create file \`00os/processes/${issue.category}/${issue.expectedFileName}.md\`\n`;
      fixReport += `   - Use the command template from \`00reaper/00OS-commands/templates/command-template.md\`\n`;
      fixReport += `   - Set name to \`${issue.expectedFileName}\`\n`;
      fixReport += `   - Set category to \`${issue.category}\`\n\n`;
    }
  }
  
  if (missingRegistry.length > 0) {
    fixReport += `### Add Missing Registry Entries\n\n`;
    fixReport += `1. Edit file \`00reaper/00OS-commands/documentation/command-registry.md\`\n`;
    fixReport += `2. Add the following entries to the appropriate categories:\n\n`;
    
    for (const issue of missingRegistry) {
      fixReport += `   - For \`${issue.category}\` category:\n`;
      fixReport += `     \`\`\`\n`;
      fixReport += `     | \`${issue.command}\` | ✅ | ${issue.category}/${issue.command}.md | [Add description] |\n`;
      fixReport += `     \`\`\`\n\n`;
    }
  }
  
  if (duplicateRegistry.length > 0) {
    fixReport += `### Fix Duplicate Registry Entries\n\n`;
    fixReport += `1. Edit file \`00reaper/00OS-commands/documentation/command-registry.md\`\n`;
    fixReport += `2. Remove duplicate entries for the following commands:\n\n`;
    
    for (const issue of duplicateRegistry) {
      fixReport += `   - \`${issue.command}\` in category \`${issue.category}\`\n`;
    }
  }
  
  return fixReport;
}

// Execute the process
execute();
```

## Output

```javascript
// Assuming all state variables are available from the execution phase
return state.result;
```

## Example Usage

### Basic Check
```
> command-verify
```

### Detailed Check
```
> command-verify --detailed
```

### With Fix Suggestions
```
> command-verify --fix
``` 