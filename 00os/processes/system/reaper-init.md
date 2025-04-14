# Process: reaper-init

## Metadata
- Name: reaper-init
- Description: Initialize 00reaper context and load comprehensive system understanding
- Category: system
- Permissions: basic
- Author: 00reaper
- Version: 2.0

## Input
- verbose: Optional flag to show detailed loading information (--verbose)
- focus: Optional area to emphasize in initialization (architecture|sync|processes)

## Output
- Confirmation of context initialization with summary of loaded content

## Execution

This process initializes the 00reaper context by comprehensively loading all essential system files and establishing a complete understanding of the 00OS architecture, purpose, implementation strategy, and development workflow. It ensures a high-fidelity rebuilding of the necessary context at the start of each development session.

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
// Initialize loading status for each section
const loadingStatus = {
  coreUnderstanding: false,
  implementationStrategy: false,
  interfaceDesign: false,
  processFormat: false,
  knowledgeManagement: false,
  enhancementTracking: false,
  researchNotes: false
};

// Track loaded files
const loadedFiles = [];
const failedFiles = [];

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

// Process each category in priority order
for (const category of loadingPriority) {
  try {
    for (const file of fileMap[category]) {
      try {
        const content = tools.readFile(`00reaper/${file}`);
        if (content) {
          loadedFiles.push(file);
        }
      } catch (error) {
        failedFiles.push({file, error: error.message});
      }
    }
    loadingStatus[category] = true;
  } catch (error) {
    console.error(`Error loading ${category} files: ${error.message}`);
  }
}

// Load enhancement files
try {
  // Parse the enhancement tracker to load active enhancements
  const trackerContent = tools.readFile('00reaper/enhancement-tracker.md');
  if (trackerContent) {
    // Extract active enhancements (simplified implementation)
    const activeEnhancements = parseEnhancements(trackerContent);
    
    // Load each active enhancement
    for (const enhancement of activeEnhancements) {
      if (enhancement.status === 'In Progress' || enhancement.status === 'Planned') {
        try {
          const enhancementFile = `00reaper/enhancements/${enhancement.filename}`;
          const content = tools.readFile(enhancementFile);
          if (content) {
            loadedFiles.push(`enhancements/${enhancement.filename}`);
          }
        } catch (enhError) {
          failedFiles.push({file: `enhancements/${enhancement.filename}`, error: enhError.message});
        }
      }
    }
  }
} catch (error) {
  console.error(`Error processing enhancements: ${error.message}`);
}

// Helper function to parse enhancements from tracker
function parseEnhancements(trackerContent) {
  // This would parse the markdown table in the tracker
  // Simplified implementation for example
  return [
    { id: 'ENH001', name: 'Command Composition', status: 'In Progress', filename: 'command-composition.md' },
    { id: 'ENH002', name: 'Context Management System', status: 'Planned', filename: 'context-management-system.md' },
    { id: 'ENH003', name: 'Process Permission System', status: 'In Progress', filename: 'process-permission-system.md' }
  ];
}

// Calculate statistics
const allCategories = Object.keys(loadingStatus);
const loadedCategories = allCategories.filter(cat => loadingStatus[cat]);
const successRate = Math.round((loadedFiles.length / (loadedFiles.length + failedFiles.length)) * 100);
const systemUnderstandingLevel = Math.round((loadedCategories.length / allCategories.length) * 100);

// Prepare output based on verbose flag
let output = '';
if (inputs.verbose) {
  output = `
✅ 00reaper context initialized - System Understanding Level: ${systemUnderstandingLevel}%

LOADED SYSTEM KNOWLEDGE
=======================

Core Understanding:
${loadingStatus.coreUnderstanding ? '✓ Loaded' : '✗ Failed'}
${fileMap.coreUnderstanding.map(f => `  ${loadedFiles.includes(f) ? '✓' : '✗'} ${f}`).join('\n')}

Implementation Strategy:
${loadingStatus.implementationStrategy ? '✓ Loaded' : '✗ Failed'}
${fileMap.implementationStrategy.map(f => `  ${loadedFiles.includes(f) ? '✓' : '✗'} ${f}`).join('\n')}

Interface Design:
${loadingStatus.interfaceDesign ? '✓ Loaded' : '✗ Failed'}
${fileMap.interfaceDesign.map(f => `  ${loadedFiles.includes(f) ? '✓' : '✗'} ${f}`).join('\n')}

Process Format:
${loadingStatus.processFormat ? '✓ Loaded' : '✗ Failed'}
${fileMap.processFormat.map(f => `  ${loadedFiles.includes(f) ? '✓' : '✗'} ${f}`).join('\n')}

Knowledge Management:
${loadingStatus.knowledgeManagement ? '✓ Loaded' : '✗ Failed'}
${fileMap.knowledgeManagement.map(f => `  ${loadedFiles.includes(f) ? '✓' : '✗'} ${f}`).join('\n')}

Enhancement Tracking:
${loadingStatus.enhancementTracking ? '✓ Loaded' : '✗ Failed'}
${fileMap.enhancementTracking.map(f => `  ${loadedFiles.includes(f) ? '✓' : '✗'} ${f}`).join('\n')}

Research and Notes:
${loadingStatus.researchNotes ? '✓ Loaded' : '✗ Failed'}
${fileMap.researchNotes.map(f => `  ${loadedFiles.includes(f) ? '✓' : '✗'} ${f}`).join('\n')}

Active Enhancements:
${loadedFiles.filter(f => f.startsWith('enhancements/')).map(f => `  ✓ ${f}`).join('\n') || '  None loaded'}

STATISTICS
==========
Total Files: ${loadedFiles.length + failedFiles.length}
Successfully Loaded: ${loadedFiles.length} (${successRate}%)
Failed to Load: ${failedFiles.length}
System Understanding: ${systemUnderstandingLevel}%

${failedFiles.length > 0 ? 'FAILED FILES\n===========\n' + failedFiles.map(f => `${f.file}: ${f.error}`).join('\n') : ''}

Ready for system administration tasks.
`;
} else {
  // Simple output for non-verbose mode
  const sectionStatus = [];
  if (loadingStatus.coreUnderstanding) sectionStatus.push("Core Understanding");
  if (loadingStatus.implementationStrategy) sectionStatus.push("Implementation Strategy");
  if (loadingStatus.interfaceDesign) sectionStatus.push("Interface Design");
  if (loadingStatus.processFormat) sectionStatus.push("Process Format");
  if (loadingStatus.knowledgeManagement) sectionStatus.push("Knowledge Management");
  if (loadingStatus.enhancementTracking) sectionStatus.push("Enhancement Tracking");
  
  output = `
✅ 00reaper context initialized - System Understanding Level: ${systemUnderstandingLevel}%

00OS SYSTEM KNOWLEDGE LOADED
============================

System Architecture:
- ${loadingStatus.coreUnderstanding ? '✓' : '✗'} Core architecture, purpose and design principles
- ${loadingStatus.coreUnderstanding ? '✓' : '✗'} Terminal-based command system architecture
- ${loadingStatus.coreUnderstanding ? '✓' : '✗'} Dual-mode interface (conversational/command)

Implementation:
- ${loadingStatus.implementationStrategy ? '✓' : '✗'} Process implementation strategy
- ${loadingStatus.implementationStrategy ? '✓' : '✗'} 00OS to Cursor rules synchronization
- ${loadingStatus.processFormat ? '✓' : '✗'} Process format specifications

Interface:
- ${loadingStatus.interfaceDesign ? '✓' : '✗'} Terminal interface design
- ${loadingStatus.interfaceDesign ? '✓' : '✗'} Command parsing workflow
- ${loadingStatus.interfaceDesign ? '✓' : '✗'} Response formatting standards

Workflows:
- ${loadingStatus.enhancementTracking ? '✓' : '✗'} Enhancement tracking system
- ${loadingStatus.knowledgeManagement ? '✓' : '✗'} Context management techniques
- ${loadingStatus.knowledgeManagement ? '✓' : '✗'} Development session workflow

Statistics:
- Total Files Loaded: ${loadedFiles.length}/${loadedFiles.length + failedFiles.length}
- Categories Initialized: ${loadedCategories.length}/${allCategories.length}
- System Understanding: ${systemUnderstandingLevel}%

Ready to continue 00OS development and administration.
${failedFiles.length > 0 ? `\n⚠️ Warning: ${failedFiles.length} files failed to load. Use --verbose for details.` : ''}`;
}

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