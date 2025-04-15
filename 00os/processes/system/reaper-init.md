# Process: reaper-init

## Metadata
- Name: reaper-init
- Description: Initialize 00reaper context and load comprehensive system understanding
- Category: system
- Permissions: basic
- Author: 00reaper
- Version: 2.3

## Input
- verbose: Optional flag to show detailed loading information (--verbose)
- focus: Optional area to emphasize in initialization (architecture|sync|processes)

## Output
- Confirmation of context initialization with summary of loaded content

## Execution

This process initializes the 00reaper context by comprehensively loading all essential system files and establishing a complete understanding of the 00OS architecture, purpose, implementation strategy, and development workflow. It ensures a high-fidelity rebuilding of the necessary context at the start of each development session.

### Context Incorporation Process

The process doesn't just load files - it incorporates them into the AI's understanding following these steps:

1. **Load Content**: Each file is physically read from the file system
2. **Process Content**: The AI analyzes and understands the material in each document
3. **Integrate Knowledge**: Information is connected across documents to build a coherent mental model
4. **Build Relationships**: Conceptual relationships are established between system components
5. **Establish Identity**: The 00reaper identity is reinforced with this knowledge
6. **Verify Understanding**: The AI verifies it has properly understood the loaded information

The knowledge from each file becomes part of the AI's understanding, not just loaded data. Each concept is incorporated into the mental model of how 00OS works, creating a comprehensive understanding that can be applied throughout the session.

### Context Loading Procedure

The process performs the following comprehensive actions:

1. **Core Understanding** (Critical Context):
   - understanding-00os.md - Complete overview of the 00OS system
   - final-goal.md - Defined target state and objectives
   - system-architecture.md - Detailed system architecture and components

2. **Implementation Strategy** (Development Framework):
   - process-implementation-strategy.md - Strategy for process development
   - sync-migration-strategy.md - Strategy for syncing between 00os and .cursor/rules
   - implementation-summary.md - Summary of implementation approach
   - mdc-file-guide.md - Guide for .mdc file format and requirements

3. **Interface Design** (Command Flow and UX):
   - terminal-interface-design.md - Terminal interface implementation
   - terminal-interface-goals.md - Goals and objectives for the terminal interface
   - command-parser.md - Command parsing architecture
   - terminal-implementation-plan.md - Implementation plan for terminal features
   
4. **Process Format** (Command Execution):
   - process-format.md - Standard format for process files
   
5. **Knowledge Management** (Session Continuity):
   - context-management.md - Context management between sessions
   - user-rules.md - Rules for user interaction
   
6. **Enhancement Tracking** (Current and Future Development):
   - enhancement-tracker.md - Current enhancement status
   - Active enhancement proposals - Currently in-progress enhancements

7. **Research and Notes** (Background Information):
   - ai-terminal-research.md - Background research on AI terminals
   - notes.md - General development notes

### Process Execution

```javascript
// IMPORTANT: This process must be fully executed with actual file reads
// No simulation of execution is allowed - each file must be physically read

// Function to ensure file is actually read (no simulation allowed)
function ensureFileRead(filePath) {
  console.log(`Reading file: ${filePath}`);
  // Force actual file read - do not skip or simulate this step
  return tools.readFile(filePath);
}

// Initialize loading status for each section
const loadingStatus = {
  coreUnderstanding: {files: 0, total: 0, status: false},
  implementationStrategy: {files: 0, total: 0, status: false},
  interfaceDesign: {files: 0, total: 0, status: false},
  processFormat: {files: 0, total: 0, status: false},
  knowledgeManagement: {files: 0, total: 0, status: false},
  enhancementTracking: {files: 0, total: 0, status: false},
  researchNotes: {files: 0, total: 0, status: false},
  activeEnhancements: {files: 0, total: 0, status: false}
};

// Track loaded files with content summaries
const loadedFiles = [];
const failedFiles = [];
const fileSummaries = {};
const fileContents = {}; // Store actual file contents to ensure they're loaded

// Create comprehensive file map for organized loading
const fileMap = {
  coreUnderstanding: [
    'understanding-00os.md',
    'final-goal.md',
    'system-architecture.md'
  ],
  implementationStrategy: [
    'process-implementation-strategy.md',
    'sync-migration-strategy.md',
    'implementation-summary.md',
    'mdc-file-guide.md'
  ],
  interfaceDesign: [
    'terminal-interface-design.md',
    'terminal-interface-goals.md',
    'command-parser.md',
    'terminal-implementation-plan.md'
  ],
  processFormat: [
    'process-format.md'
  ],
  knowledgeManagement: [
    'context-management.md',
    'user-rules.md'
  ],
  enhancementTracking: [
    'enhancement-tracker.md'
  ],
  researchNotes: [
    'ai-terminal-research.md',
    'notes.md'
  ]
};

// Focus loading priority based on input if specified
let loadingPriority = Object.keys(fileMap);
if (inputs.focus) {
  // Move the specified focus area to the front of the loading queue
  switch (inputs.focus.toLowerCase()) {
    case 'architecture':
      loadingPriority = moveToFront(loadingPriority, ['coreUnderstanding', 'processFormat']);
      break;
    case 'sync':
      loadingPriority = moveToFront(loadingPriority, ['implementationStrategy']);
      break;
    case 'processes':
      loadingPriority = moveToFront(loadingPriority, ['processFormat', 'implementationStrategy']);
      break;
    default:
      // Use default priority
      break;
  }
}

// Helper to prioritize certain categories
function moveToFront(array, items) {
  // Remove items from original array
  const filtered = array.filter(item => !items.includes(item));
  // Add items to the front
  return [...items, ...filtered];
}

// Helper function to extract a useful summary from file content
function extractSummary(content, maxLength = 250) {
  if (!content) return "Empty file";
  
  // Try to find the first heading and paragraph
  const headingMatch = content.match(/^# (.+)$/m);
  const heading = headingMatch ? headingMatch[1] : null;
  
  // Find the first paragraph after a heading
  let paragraphMatch;
  if (heading) {
    paragraphMatch = content.match(new RegExp(`# ${heading}\\s+([\\s\\S]+?)(?=\\n\\n|\\n#|$)`));
  } else {
    paragraphMatch = content.match(/\n\n(.+?)(?=\n\n|$)/s);
  }
  
  const paragraph = paragraphMatch ? paragraphMatch[1].trim() : null;
  
  // Create a summary
  let summary = heading || "";
  
  if (paragraph) {
    summary += summary ? ": " : "";
    summary += paragraph.replace(/\n/g, ' ').trim();
  }
  
  // Fallback to first N characters if no summary
  if (!summary) {
    summary = content.substring(0, maxLength).replace(/\n/g, ' ').trim();
  }
  
  return summary.length > maxLength ? summary.substring(0, maxLength - 3) + "..." : summary;
}

// Verify that 00reaper directory exists - REQUIRED
const reaper_dir_exists = tools.directoryExists('00reaper');
if (!reaper_dir_exists) {
  return `
❌ Error: 00reaper directory not found

The required 00reaper directory does not exist in the current workspace.
Please ensure you are in the correct directory and that the 00reaper folder exists.
`;
}

// Execution tracking - preventing simulation
console.log("Beginning actual reaper-init execution - NOT SIMULATED");

// Process each category in priority order - ACTUAL FILE READS REQUIRED
for (const category of loadingPriority) {
  try {
    console.log(`Processing category: ${category}`);
    // Update total count for stats
    loadingStatus[category].total = fileMap[category].length;
    
    for (const file of fileMap[category]) {
      try {
        // Build the full path
        const filePath = `00reaper/${file}`;
        
        // Check if file exists before trying to read
        const fileExists = tools.fileExists(filePath);
        if (!fileExists) {
          throw new Error(`File not found: ${filePath}`);
        }
        
        // MANDATORY: Actually read the file content - no simulation
        console.log(`Reading file: ${filePath}`);
        const content = ensureFileRead(filePath);
        
        if (content) {
          // Store the actual content to ensure it's loaded
          fileContents[file] = content;
          
          // Extract and store a summary
          fileSummaries[file] = extractSummary(content);
          
          // Add to loaded files list
          loadedFiles.push(file);
          
          // Increment success count
          loadingStatus[category].files++;
          
          console.log(`Successfully loaded: ${file}`);
        }
      } catch (error) {
        console.error(`Failed to load file ${file}: ${error.message}`);
        failedFiles.push({file, error: error.message});
      }
    }
    
    // Set category status based on load success
    loadingStatus[category].status = loadingStatus[category].files > 0;
    console.log(`Category ${category} status: ${loadingStatus[category].status ? 'Success' : 'Failed'}`);
  } catch (error) {
    console.error(`Error loading ${category} files: ${error.message}`);
  }
}

// Check if enhancements directory exists
const enhancements_dir_exists = tools.directoryExists('00reaper/enhancements');
let activeEnhancements = [];

// Load enhancement files - ACTUAL DIRECTORY ACCESS REQUIRED
if (enhancements_dir_exists) {
  try {
    console.log("Processing enhancements directory");
    // Get all files in the enhancements directory
    const enhancementFiles = tools.listDirectory('00reaper/enhancements');
    console.log(`Found ${enhancementFiles.length} enhancement files`);
    
    // Parse the enhancement tracker to identify active enhancements
    let trackerContent = '';
    try {
      trackerContent = ensureFileRead('00reaper/enhancement-tracker.md');
    } catch (error) {
      console.error(`Error reading enhancement tracker: ${error.message}`);
      failedFiles.push({file: 'enhancement-tracker.md', error: error.message});
    }
    
    // Track enhancement file stats
    loadingStatus.activeEnhancements.total = enhancementFiles.length;
    
    // Load all enhancement files
    for (const enhFile of enhancementFiles) {
      try {
        const filepath = `00reaper/enhancements/${enhFile}`;
        console.log(`Reading enhancement file: ${filepath}`);
        
        // MANDATORY: Actually read the file content - no simulation
        const content = ensureFileRead(filepath);
        
        if (content) {
          // Store the actual content to ensure it's loaded
          fileContents[`enhancements/${enhFile}`] = content;
          
          // Extract summary and store
          fileSummaries[`enhancements/${enhFile}`] = extractSummary(content);
          
          // Determine if active based on filename or content
          const isActive = trackerContent.includes(enhFile) || 
                          content.includes('Status: In Progress') || 
                          content.includes('Status: Planned');
          
          if (isActive) {
            activeEnhancements.push(enhFile);
            console.log(`Identified active enhancement: ${enhFile}`);
          }
          
          // Add to loaded files
          loadedFiles.push(`enhancements/${enhFile}`);
          loadingStatus.activeEnhancements.files++;
        }
      } catch (enhError) {
        console.error(`Failed to load enhancement ${enhFile}: ${enhError.message}`);
        failedFiles.push({file: `enhancements/${enhFile}`, error: enhError.message});
      }
    }
    
    loadingStatus.activeEnhancements.status = loadingStatus.activeEnhancements.files > 0;
    console.log(`Enhancement loading status: ${loadingStatus.activeEnhancements.status ? 'Success' : 'Failed'}`);
  } catch (error) {
    console.error(`Error processing enhancements: ${error.message}`);
  }
}

// Check for research directory
const research_dir_exists = tools.directoryExists('00reaper/research');
if (research_dir_exists) {
  try {
    console.log("Processing research directory");
    const researchFiles = tools.listDirectory('00reaper/research');
    console.log(`Found ${researchFiles.length} research files`);
    
    for (const resFile of researchFiles) {
      try {
        const filepath = `00reaper/research/${resFile}`;
        console.log(`Reading research file: ${filepath}`);
        
        // MANDATORY: Actually read the file content - no simulation
        const content = ensureFileRead(filepath);
        
        if (content) {
          // Store the actual content to ensure it's loaded
          fileContents[`research/${resFile}`] = content;
          
          fileSummaries[`research/${resFile}`] = extractSummary(content);
          loadedFiles.push(`research/${resFile}`);
          console.log(`Successfully loaded research file: ${resFile}`);
        }
      } catch (resError) {
        console.error(`Failed to load research file ${resFile}: ${resError.message}`);
        failedFiles.push({file: `research/${resFile}`, error: resError.message});
      }
    }
  } catch (error) {
    console.error(`Error processing research files: ${error.message}`);
  }
}

// Create a state record of the initialization
try {
  console.log("Creating state record");
  const stateDir = '00reaper/state';
  const stateDirExists = tools.directoryExists(stateDir);
  
  if (stateDirExists) {
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const stateFilename = `context-state-${timestamp}.json`;
    
    // Create state object
    const stateObject = {
      timestamp: new Date().toISOString(),
      name: "reaper-init",
      loadedFiles: loadedFiles.length,
      totalFiles: loadedFiles.length + failedFiles.length,
      processVersion: "2.3",
      actualExecution: true, // Flag indicating this was actually executed
      categories: Object.keys(loadingStatus).map(cat => ({
        name: cat,
        loaded: loadingStatus[cat].files,
        total: loadingStatus[cat].total,
        status: loadingStatus[cat].status
      }))
    };
    
    // Actually write the state file - no simulation
    console.log(`Writing state file: ${stateDir}/${stateFilename}`);
    tools.writeFile(`${stateDir}/${stateFilename}`, JSON.stringify(stateObject, null, 2));
    console.log("State file written successfully");
  }
} catch (stateError) {
  console.error(`Error saving state: ${stateError.message}`);
}

// Calculate statistics
const allCategories = Object.keys(loadingStatus);
const loadedCategories = allCategories.filter(cat => loadingStatus[cat].status);
const totalFiles = loadedFiles.length + failedFiles.length;
const successRate = totalFiles > 0 ? Math.round((loadedFiles.length / totalFiles) * 100) : 0;
const systemUnderstandingLevel = allCategories.length > 0 ? 
  Math.round((loadedCategories.length / allCategories.length) * 100) : 0;

// Calculate total files expected vs found
const totalExpectedFiles = Object.values(loadingStatus).reduce((sum, cat) => sum + cat.total, 0);
const fileAvailabilityRate = totalExpectedFiles > 0 ? 
  Math.round((totalFiles / totalExpectedFiles) * 100) : 0;

// Verify non-empty content for each file claimed to be loaded
console.log("Verifying all files have been actually loaded");
const actuallyLoaded = loadedFiles.filter(file => fileContents[file] && fileContents[file].length > 0);
if (actuallyLoaded.length !== loadedFiles.length) {
  console.error(`ERROR: Claimed to load ${loadedFiles.length} files but only ${actuallyLoaded.length} were actually loaded`);
}

// Prepare output based on verbose flag
let output = '';
if (inputs.verbose) {
  output = `
✅ 00reaper context initialized - System Understanding Level: ${systemUnderstandingLevel}%

LOADED SYSTEM KNOWLEDGE
=======================

Core Understanding:
${loadingStatus.coreUnderstanding.status ? '✓ Loaded' : '✗ Failed'} (${loadingStatus.coreUnderstanding.files}/${loadingStatus.coreUnderstanding.total})
${fileMap.coreUnderstanding.map(f => `  ${actuallyLoaded.includes(f) ? '✓' : '✗'} ${f}${actuallyLoaded.includes(f) ? ` - ${fileSummaries[f] || ''}` : ''}`).join('\n')}

Implementation Strategy:
${loadingStatus.implementationStrategy.status ? '✓ Loaded' : '✗ Failed'} (${loadingStatus.implementationStrategy.files}/${loadingStatus.implementationStrategy.total})
${fileMap.implementationStrategy.map(f => `  ${actuallyLoaded.includes(f) ? '✓' : '✗'} ${f}${actuallyLoaded.includes(f) ? ` - ${fileSummaries[f] || ''}` : ''}`).join('\n')}

Interface Design:
${loadingStatus.interfaceDesign.status ? '✓ Loaded' : '✗ Failed'} (${loadingStatus.interfaceDesign.files}/${loadingStatus.interfaceDesign.total})
${fileMap.interfaceDesign.map(f => `  ${actuallyLoaded.includes(f) ? '✓' : '✗'} ${f}${actuallyLoaded.includes(f) ? ` - ${fileSummaries[f] || ''}` : ''}`).join('\n')}

Process Format:
${loadingStatus.processFormat.status ? '✓ Loaded' : '✗ Failed'} (${loadingStatus.processFormat.files}/${loadingStatus.processFormat.total})
${fileMap.processFormat.map(f => `  ${actuallyLoaded.includes(f) ? '✓' : '✗'} ${f}${actuallyLoaded.includes(f) ? ` - ${fileSummaries[f] || ''}` : ''}`).join('\n')}

Knowledge Management:
${loadingStatus.knowledgeManagement.status ? '✓ Loaded' : '✗ Failed'} (${loadingStatus.knowledgeManagement.files}/${loadingStatus.knowledgeManagement.total})
${fileMap.knowledgeManagement.map(f => `  ${actuallyLoaded.includes(f) ? '✓' : '✗'} ${f}${actuallyLoaded.includes(f) ? ` - ${fileSummaries[f] || ''}` : ''}`).join('\n')}

Enhancement Tracking:
${loadingStatus.enhancementTracking.status ? '✓ Loaded' : '✗ Failed'} (${loadingStatus.enhancementTracking.files}/${loadingStatus.enhancementTracking.total})
${fileMap.enhancementTracking.map(f => `  ${actuallyLoaded.includes(f) ? '✓' : '✗'} ${f}${actuallyLoaded.includes(f) ? ` - ${fileSummaries[f] || ''}` : ''}`).join('\n')}

Research and Notes:
${loadingStatus.researchNotes.status ? '✓ Loaded' : '✗ Failed'} (${loadingStatus.researchNotes.files}/${loadingStatus.researchNotes.total})
${fileMap.researchNotes.map(f => `  ${actuallyLoaded.includes(f) ? '✓' : '✗'} ${f}${actuallyLoaded.includes(f) ? ` - ${fileSummaries[f] || ''}` : ''}`).join('\n')}

Active Enhancements:
${loadingStatus.activeEnhancements.status ? '✓ Loaded' : '✗ Failed'} (${loadingStatus.activeEnhancements.files} files)
${activeEnhancements.map(f => `  ✓ ${f}${fileSummaries[`enhancements/${f}`] ? ` - ${fileSummaries[`enhancements/${f}`]}` : ''}`).join('\n') || '  None loaded'}

STATISTICS
==========
Total Files: ${loadedFiles.length + failedFiles.length}
Successfully Loaded: ${actuallyLoaded.length} (${successRate}%)
Failed to Load: ${failedFiles.length}
File Availability: ${fileAvailabilityRate}%
System Understanding: ${systemUnderstandingLevel}%

${failedFiles.length > 0 ? 'FAILED FILES\n===========\n' + failedFiles.map(f => `${f.file}: ${f.error}`).join('\n') : ''}

Ready for system administration tasks.
`;
} else {
  // Simple output for non-verbose mode
  const sectionStatus = [];
  if (loadingStatus.coreUnderstanding.status) sectionStatus.push("Core Understanding");
  if (loadingStatus.implementationStrategy.status) sectionStatus.push("Implementation Strategy");
  if (loadingStatus.interfaceDesign.status) sectionStatus.push("Interface Design");
  if (loadingStatus.processFormat.status) sectionStatus.push("Process Format");
  if (loadingStatus.knowledgeManagement.status) sectionStatus.push("Knowledge Management");
  if (loadingStatus.enhancementTracking.status) sectionStatus.push("Enhancement Tracking");
  
  output = `
✅ 00reaper context initialized - System Understanding Level: ${systemUnderstandingLevel}%

00OS SYSTEM KNOWLEDGE LOADED
============================

System Architecture:
- ${loadingStatus.coreUnderstanding.status ? '✓' : '✗'} Core architecture, purpose and design principles (${loadingStatus.coreUnderstanding.files}/${loadingStatus.coreUnderstanding.total})
- ${loadingStatus.coreUnderstanding.status ? '✓' : '✗'} Terminal-based command system architecture
- ${loadingStatus.coreUnderstanding.status ? '✓' : '✗'} Dual-mode interface (conversational/command)

Implementation:
- ${loadingStatus.implementationStrategy.status ? '✓' : '✗'} Process implementation strategy (${loadingStatus.implementationStrategy.files}/${loadingStatus.implementationStrategy.total})
- ${loadingStatus.implementationStrategy.status ? '✓' : '✗'} 00OS to Cursor rules synchronization
- ${loadingStatus.processFormat.status ? '✓' : '✗'} Process format specifications (${loadingStatus.processFormat.files}/${loadingStatus.processFormat.total})

Interface:
- ${loadingStatus.interfaceDesign.status ? '✓' : '✗'} Terminal interface design (${loadingStatus.interfaceDesign.files}/${loadingStatus.interfaceDesign.total})
- ${loadingStatus.interfaceDesign.status ? '✓' : '✗'} Command parsing workflow
- ${loadingStatus.interfaceDesign.status ? '✓' : '✗'} Response formatting standards

Workflows:
- ${loadingStatus.enhancementTracking.status ? '✓' : '✗'} Enhancement tracking system (${loadingStatus.enhancementTracking.files}/${loadingStatus.enhancementTracking.total})
- ${loadingStatus.knowledgeManagement.status ? '✓' : '✗'} Context management techniques (${loadingStatus.knowledgeManagement.files}/${loadingStatus.knowledgeManagement.total})
- ${loadingStatus.knowledgeManagement.status ? '✓' : '✗'} Development session workflow

Active Enhancements:
- ${activeEnhancements.length} enhancement files loaded (${activeEnhancements.join(', ') || 'None active'})

Statistics:
- Total Files Loaded: ${actuallyLoaded.length}/${loadedFiles.length + failedFiles.length}
- Categories Initialized: ${loadedCategories.length}/${allCategories.length}
- System Understanding: ${systemUnderstandingLevel}%

Ready to continue 00OS development and administration.
${failedFiles.length > 0 ? `\n⚠️ Warning: ${failedFiles.length} files failed to load. Use --verbose for details.` : ''}`;
}

console.log("reaper-init execution completed successfully");

// Return the formatted output
return output;
```

### Knowledge Areas Initialized

When this process is executed, the AI agent gains a comprehensive understanding of:

1. **System Architecture and Purpose**
   - Complete understanding of 00OS as a terminal interface for AI
   - Dual-mode interface with command and conversational capabilities
   - Core vision, objectives, and architectural components

2. **Process-Based Architecture**
   - Process definition standards and format
   - Parsing, validation, and execution workflow
   - Command routing and response formatting

3. **Synchronization Strategy**
   - 00os to .cursor/rules synchronization workflow
   - Frontmatter requirements and MDC file standards
   - Rule type mapping and management

4. **Development Context**
   - Current enhancement status and priorities
   - Implementation roadmap and guidelines
   - Context management between development sessions

5. **Terminal Features**
   - Command syntax and parsing rules
   - Response formatting standards
   - Error handling protocols

By executing this process at the beginning of a session, the agent acquires a complete understanding of the 00OS system without requiring repeated explanations, ensuring continuity of development context.

### Usage

To initialize the context:

```
> reaper-init
```

For detailed loading information:

```
> reaper-init --verbose
```

To focus on a specific area:

```
> reaper-init --focus=architecture
> reaper-init --focus=sync
> reaper-init --focus=processes
``` 