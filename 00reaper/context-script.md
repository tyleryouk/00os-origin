# Context Initialization Script

This script defines the actual implementation logic for properly loading and integrating the 00OS system context during AI initialization.

## Initialization Sequence

```javascript
// CONTEXT INITIALIZATION SCRIPT
// For use with reaper-init command version 3.0+

// Load configuration
const config = loadConfiguration();
const profile = determineProfile(config);
const focusAreas = determineFocusAreas(config, profile);
const categories = determineCategories(config, profile);

// Initialize tracking
const loadingStatus = initializeLoadingStatus(categories);
const fileContents = {};
const loadedFiles = [];
const failedFiles = [];
const startTime = new Date();

// PHASE 1: Foundation Layer
// Load core understanding files
await loadCategoryFiles('coreUnderstanding', profile.parallelLoading);
await loadFile('folder-structure.md', 'Knowledge Structure');

// PHASE 2: Implementation Layer
await loadCategoryFiles('implementationStrategy', profile.parallelLoading);
await loadCategoryFiles('processFormat', profile.parallelLoading);

// PHASE 3: Interface Layer
await loadCategoryFiles('interfaceDesign', profile.parallelLoading);

// PHASE 4: Operational Context
await loadCategoryFiles('knowledgeManagement', profile.parallelLoading);
await loadCategoryFiles('enhancementTracking', profile.parallelLoading);
await loadCategoryFiles('researchNotes', profile.parallelLoading);

// PHASE 5: Current State
await loadLatestStateFile();
await loadEnhancementProposals();
await loadResearchFiles();

// PHASE 6: Integration
integrateCrossReferences();
resolveContradictions();
buildMentalModels();

// PHASE 7: Validation
const integrityResult = validateContextIntegrity();
const understandingLevel = calculateUnderstandingLevel();

// PHASE 8: State Preservation
saveContextState(understandingLevel);

// HELPER FUNCTIONS

// Load configuration using profile
function loadConfiguration() {
  try {
    return JSON.parse(readFile('00reaper/config/reaper-init.config.json'));
  } catch (error) {
    // Use default configuration if file not found
    return {
      version: "3.0",
      profiles: {
        default: {
          categories: ["all"],
          parallelLoading: true,
          maxConcurrent: 5,
          criticalCategories: ["coreUnderstanding"]
        }
      }
    };
  }
}

// Determine which profile to use
function determineProfile(config) {
  const profileName = inputs.profile || 'default';
  return config.profiles[profileName] || config.profiles.default;
}

// Determine focus areas based on input and profile
function determineFocusAreas(config, profile) {
  if (inputs.focus) {
    const focusInput = inputs.focus.toLowerCase();
    const focusMap = config.focusAreas || {};
    return focusMap[focusInput] || [focusInput];
  }
  return profile.focusAreas || [];
}

// Determine categories to load
function determineCategories(config, profile) {
  // Handle specific categories request
  if (inputs.categories) {
    return inputs.categories.split(',');
  }
  
  // Handle skip categories
  let categories = profile.categories;
  if (categories.includes('all')) {
    categories = [
      'coreUnderstanding',
      'implementationStrategy',
      'interfaceDesign',
      'processFormat',
      'knowledgeManagement',
      'enhancementTracking',
      'researchNotes',
      'activeEnhancements'
    ];
  }
  
  // Remove skipped categories
  if (inputs['skip-categories']) {
    const skipCategories = inputs['skip-categories'].split(',');
    categories = categories.filter(cat => !skipCategories.includes(cat));
  }
  
  return categories;
}

// Initialize loading status tracking
function initializeLoadingStatus(categories) {
  const status = {};
  categories.forEach(category => {
    status[category] = {files: 0, total: 0, status: false};
  });
  return status;
}

// Load all files in a category
async function loadCategoryFiles(category, useParallel) {
  const files = getFilesForCategory(category);
  loadingStatus[category].total = files.length;
  
  if (useParallel) {
    // Load files in parallel with concurrency limit
    // Implementation depends on available parallel capabilities
  } else {
    // Load files sequentially
    for (const file of files) {
      await loadFile(file, category);
    }
  }
  
  loadingStatus[category].status = loadingStatus[category].files > 0;
}

// Get files for a specific category
function getFilesForCategory(category) {
  const categoryMap = {
    'coreUnderstanding': ['understanding-00os.md', 'system-architecture.md', 'final-goal.md'],
    'implementationStrategy': ['process-implementation-strategy.md', 'sync-migration-strategy.md', 
                              'implementation-summary.md', 'mdc-file-guide.md'],
    'interfaceDesign': ['terminal-interface-design.md', 'terminal-interface-goals.md', 
                        'command-parser.md', 'terminal-implementation-plan.md'],
    'processFormat': ['process-format.md'],
    'knowledgeManagement': ['context-management.md', 'user-rules.md', 'brain-builder.md'],
    'enhancementTracking': ['enhancement-tracker.md'],
    'researchNotes': ['ai-terminal-research.md', 'notes.md']
  };
  
  return categoryMap[category] || [];
}

// Load a specific file
async function loadFile(filename, category) {
  try {
    const filePath = `00reaper/${filename}`;
    
    // Check if file exists
    const fileExists = fileSystem.fileExists(filePath);
    if (!fileExists) {
      throw new Error(`File not found: ${filePath}`);
    }
    
    // Actually read the file
    const content = await fileSystem.readFile(filePath);
    
    if (content) {
      // Store content
      fileContents[filename] = content;
      
      // Extract summary
      const summary = extractSummary(content);
      
      // Add to loaded files
      loadedFiles.push({
        filename,
        category,
        summary,
        timestamp: new Date()
      });
      
      // Update loaded count
      if (loadingStatus[category]) {
        loadingStatus[category].files++;
      }
      
      return true;
    }
    return false;
  } catch (error) {
    failedFiles.push({
      filename,
      category,
      error: error.message
    });
    return false;
  }
}

// Load the latest state file
async function loadLatestStateFile() {
  try {
    const stateDir = '00reaper/state';
    const stateFiles = fileSystem.listDirectory(stateDir);
    
    // Sort by timestamp (newest first)
    stateFiles.sort().reverse();
    
    if (stateFiles.length > 0) {
      const latestStateFile = stateFiles[0];
      const content = await fileSystem.readFile(`${stateDir}/${latestStateFile}`);
      
      if (content) {
        const stateData = JSON.parse(content);
        // Process state data
        return stateData;
      }
    }
    return null;
  } catch (error) {
    console.error(`Failed to load state file: ${error.message}`);
    return null;
  }
}

// Load enhancement proposals
async function loadEnhancementProposals() {
  try {
    const enhancementsDir = '00reaper/enhancements';
    const enhancementFiles = fileSystem.listDirectory(enhancementsDir);
    
    loadingStatus.activeEnhancements = {files: 0, total: enhancementFiles.length, status: false};
    
    // Get enhancement tracker data to identify active enhancements
    const trackerContent = fileContents['enhancement-tracker.md'];
    
    for (const enhFile of enhancementFiles) {
      try {
        const filePath = `${enhancementsDir}/${enhFile}`;
        const content = await fileSystem.readFile(filePath);
        
        if (content) {
          // Store content
          fileContents[`enhancements/${enhFile}`] = content;
          
          // Determine if active based on tracker or content
          const isActive = isActiveEnhancement(enhFile, content, trackerContent);
          
          if (isActive) {
            // Add to loaded files with special priority for active
            loadedFiles.push({
              filename: `enhancements/${enhFile}`,
              category: 'activeEnhancements',
              priority: 'high',
              summary: extractSummary(content)
            });
          } else {
            // Add as regular enhancement
            loadedFiles.push({
              filename: `enhancements/${enhFile}`,
              category: 'enhancements',
              summary: extractSummary(content)
            });
          }
          
          loadingStatus.activeEnhancements.files++;
        }
      } catch (error) {
        failedFiles.push({
          filename: `enhancements/${enhFile}`,
          category: 'enhancements',
          error: error.message
        });
      }
    }
    
    loadingStatus.activeEnhancements.status = loadingStatus.activeEnhancements.files > 0;
    return loadingStatus.activeEnhancements.files;
  } catch (error) {
    console.error(`Failed to load enhancements: ${error.message}`);
    return 0;
  }
}

// Check if an enhancement is currently active
function isActiveEnhancement(filename, content, trackerContent) {
  // Check if mentioned in tracker as In Progress or Testing
  if (trackerContent && 
      (trackerContent.includes(`${filename} | In Progress`) ||
       trackerContent.includes(`${filename} | Testing`) ||
       trackerContent.includes(`${filename} | Planned`))) {
    return true;
  }
  
  // Check content for status
  if (content && 
      (content.includes('Status: In Progress') || 
       content.includes('Status: Testing') ||
       content.includes('Status: Planned'))) {
    return true;
  }
  
  return false;
}

// Load research files
async function loadResearchFiles() {
  try {
    const researchDir = '00reaper/research';
    const researchFiles = fileSystem.listDirectory(researchDir);
    
    for (const resFile of researchFiles) {
      try {
        const filePath = `${researchDir}/${resFile}`;
        const content = await fileSystem.readFile(filePath);
        
        if (content) {
          // Store content
          fileContents[`research/${resFile}`] = content;
          
          // Add to loaded files
          loadedFiles.push({
            filename: `research/${resFile}`,
            category: 'research',
            summary: extractSummary(content)
          });
        }
      } catch (error) {
        failedFiles.push({
          filename: `research/${resFile}`,
          category: 'research',
          error: error.message
        });
      }
    }
    
    return researchFiles.length;
  } catch (error) {
    console.error(`Failed to load research files: ${error.message}`);
    return 0;
  }
}

// Extract a useful summary from file content
function extractSummary(content, maxLength = 250) {
  if (!content) return "Empty file";
  
  // Find the first heading
  const headingMatch = content.match(/^# (.+)$/m);
  const heading = headingMatch ? headingMatch[1] : null;
  
  // Find the first paragraph after the heading
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
  
  // Fallback to first N characters
  if (!summary) {
    summary = content.substring(0, maxLength).replace(/\n/g, ' ').trim();
  }
  
  return summary.length > maxLength ? 
    summary.substring(0, maxLength - 3) + "..." : summary;
}

// Integrate cross-references between files
function integrateCrossReferences() {
  // Implementation would identify relationships between files
  // and build a knowledge graph of concepts
}

// Resolve any contradictions in the loaded content
function resolveContradictions() {
  // Implementation would identify and resolve contradictions
  // based on file timestamps and priorities
}

// Build mental models of the system
function buildMentalModels() {
  // Implementation would construct hierarchical understanding
  // of how the system components fit together
}

// Validate the integrity of the loaded context
function validateContextIntegrity() {
  const missingCriticalFiles = [];
  const criticalFiles = [
    'understanding-00os.md',
    'system-architecture.md',
    'process-format.md',
    'enhancement-tracker.md'
  ];
  
  // Check for missing critical files
  for (const file of criticalFiles) {
    if (!fileContents[file]) {
      missingCriticalFiles.push(file);
    }
  }
  
  // Check for dependency violations
  const dependencyIssues = [];
  const dependencies = {
    'terminal-interface-design.md': ['terminal-interface-goals.md'],
    'implementation-summary.md': ['process-implementation-strategy.md']
  };
  
  for (const [file, deps] of Object.entries(dependencies)) {
    if (fileContents[file]) {
      for (const dep of deps) {
        if (!fileContents[dep]) {
          dependencyIssues.push(`${file} depends on ${dep} which is missing`);
        }
      }
    }
  }
  
  return {
    complete: missingCriticalFiles.length === 0 && dependencyIssues.length === 0,
    missingCriticalFiles,
    dependencyIssues
  };
}

// Calculate the system understanding level
function calculateUnderstandingLevel() {
  const allCategories = Object.keys(loadingStatus);
  const loadedCategories = allCategories.filter(cat => loadingStatus[cat].status);
  
  // Calculate files loaded percentage
  const totalFiles = loadedFiles.length + failedFiles.length;
  const filesLoadedPercentage = totalFiles > 0 ? 
    Math.round((loadedFiles.length / totalFiles) * 100) : 0;
  
  // Calculate categories loaded percentage
  const categoriesPercentage = allCategories.length > 0 ? 
    Math.round((loadedCategories.length / allCategories.length) * 100) : 0;
  
  // Calculate critical files percentage
  const criticalFiles = [
    'understanding-00os.md',
    'system-architecture.md',
    'process-format.md',
    'enhancement-tracker.md'
  ];
  
  const loadedCriticalFiles = criticalFiles.filter(file => fileContents[file]);
  const criticalPercentage = Math.round((loadedCriticalFiles.length / criticalFiles.length) * 100);
  
  // Weighted average for overall understanding
  const understandingLevel = Math.round(
    (criticalPercentage * 0.5) + 
    (categoriesPercentage * 0.3) + 
    (filesLoadedPercentage * 0.2)
  );
  
  return {
    understandingLevel,
    filesLoadedPercentage,
    categoriesPercentage,
    criticalPercentage,
    loadedCategories,
    loadedFiles: loadedFiles.length,
    totalFiles
  };
}

// Save the current context state
function saveContextState(understandingLevel) {
  try {
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const stateFilename = `context-state-${timestamp}.json`;
    
    // Create state object
    const stateObject = {
      timestamp: new Date().toISOString(),
      name: "reaper-init",
      loadedFiles: loadedFiles.length,
      totalFiles: loadedFiles.length + failedFiles.length,
      processVersion: "3.0",
      understandingLevel: understandingLevel.understandingLevel,
      actualExecution: true,
      categories: Object.keys(loadingStatus).map(cat => ({
        name: cat,
        loaded: loadingStatus[cat].files,
        total: loadingStatus[cat].total,
        status: loadingStatus[cat].status
      }))
    };
    
    // Write state file
    fileSystem.writeFile(`00reaper/state/${stateFilename}`, 
                        JSON.stringify(stateObject, null, 2));
    
    return stateFilename;
  } catch (error) {
    console.error(`Error saving state: ${error.message}`);
    return null;
  }
}
```

## Implementation Requirements

The reaper-init command should use this script as the logical foundation for context initialization, adapting it to the specific execution environment and available file system operations. Key requirements:

1. Actual file reads must be performed (no simulation)
2. Sequential dependencies must be respected
3. Error handling must be robust
4. State must be properly preserved
5. Results must be accurately reported

## Usage

This script should be incorporated into the reaper-init implementation, replacing the existing loading logic with this more comprehensive approach. Configuration should be loaded from the reaper-init.config.json file, which provides parameters for customization.