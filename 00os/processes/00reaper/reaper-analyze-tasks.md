---
name: reaper-analyze-tasks
description: Analyze current tasks and generate action plan
version: 2.0.0
author: 00reaper
category: 00reaper
permissions: [basic, file-read]
inputs:
  - name: focus
    type: string
    required: false
    description: Focus area (reliability, file-ops, formatting, sync, handler)
  - name: detail-level
    type: string
    required: false
    default: normal
    description: Level of detail (minimal, normal, detailed)
  - name: format
    type: string
    required: false
    default: standard
    description: Output format (standard, compact, verbose)
outputs:
  - name: analysis
    type: string
    description: Analysis of current tasks and action plan
---

# Process: reaper-analyze-tasks

## Description
Analyzes the current state of all requests in user_requests.md, identifies highest priority tasks, highlights blocking issues, and generates a suggested action plan with specific next steps.

## Execution

```javascript
/**
 * Main execution function for reaper-analyze-tasks
 */
async function execute() {
  try {
    // Parse and validate input parameters
    const params = parseAndValidateParameters();
    if (!params.valid) {
      return formatError(params.message, params.code);
    }
    
    const { focusArea, detailLevel, outputFormat } = params;
    
    // Read user_requests.md to get current tasks
    const tasksDataResult = await readUserRequestsFile();
    if (!tasksDataResult.success) {
      return formatError(tasksDataResult.message, tasksDataResult.code);
    }
    
    // Parse tasks from the file content
    try {
      const tasks = parseTasks(tasksDataResult.content);
      
      // Analyze tasks for priority and dependencies
      const analysis = analyzeTasksAndGeneratePlan(tasks, focusArea, detailLevel);
      
      // Format the output based on requested format
      return formatAnalysisOutput(analysis, outputFormat);
    } catch (error) {
      return formatError(`Error processing tasks: ${error.message}`, "TASK_PROCESSING_ERROR");
    }
  } catch (error) {
    return formatError(`Unexpected error during task analysis: ${error.message}`, "EXECUTION_ERROR");
  }
}

/**
 * Parse and validate input parameters
 * @returns {Object} Validated parameters or error information
 */
function parseAndValidateParameters() {
  try {
    // Get input parameters with defaults
    const focusArea = inputs.focus || null;
    const detailLevel = inputs["detail-level"] || "normal";
    const outputFormat = inputs.format || "standard";
    
    // Validate focus area if provided
    if (focusArea) {
      const validFocusAreas = ['reliability', 'file-ops', 'formatting', 'sync', 'handler'];
      if (!validFocusAreas.includes(focusArea)) {
        return {
          valid: false,
          code: "INVALID_PARAMETER",
          message: `Invalid focus area: ${focusArea}. Valid options are: ${validFocusAreas.join(', ')}`
        };
      }
    }
    
    // Validate detail level
    const validDetailLevels = ['minimal', 'normal', 'detailed'];
    if (!validDetailLevels.includes(detailLevel)) {
      return {
        valid: false,
        code: "INVALID_PARAMETER",
        message: `Invalid detail level: ${detailLevel}. Valid options are: ${validDetailLevels.join(', ')}`
      };
    }
    
    // Validate output format
    const validFormats = ['standard', 'compact', 'verbose'];
    if (!validFormats.includes(outputFormat)) {
      return {
        valid: false,
        code: "INVALID_PARAMETER",
        message: `Invalid output format: ${outputFormat}. Valid options are: ${validFormats.join(', ')}`
      };
    }
    
    return {
      valid: true,
      focusArea,
      detailLevel,
      outputFormat
    };
  } catch (error) {
    return {
      valid: false,
      code: "PARAMETER_PARSING_ERROR",
      message: `Error parsing parameters: ${error.message}`
    };
  }
}

/**
 * Read the user_requests.md file
 * @returns {Object} File content or error information
 */
async function readUserRequestsFile() {
  try {
    const userRequestsPath = "00reaper/00OS-commands/user-directed/user-requests.md";
    
    // Read the file
    const fileResult = await tools.call('read_file', {
      target_file: userRequestsPath,
      should_read_entire_file: true,
      explanation: "Reading user-requests.md to analyze current tasks"
    });
    
    if (!fileResult || !fileResult.content) {
      return {
        success: false,
        code: "FILE_READ_ERROR",
        message: "Failed to read user-requests.md"
      };
    }
    
    return {
      success: true,
      content: fileResult.content
    };
  } catch (error) {
    return {
      success: false,
      code: "FILE_ACCESS_ERROR",
      message: `Error accessing user-requests.md: ${error.message}`
    };
  }
}

/**
 * Parse tasks from the file content
 * @param {string} fileContent - Content of the user-requests.md file
 * @returns {Array} Array of parsed tasks
 */
function parseTasks(fileContent) {
  const tasks = [];
  
  try {
    // Extract REQ sections
    const reqSections = fileContent.match(/### REQ-\d+:.*?(?=### REQ-|$)/gs) || [];
    
    for (const section of reqSections) {
      // Extract REQ ID
      const idMatch = section.match(/### REQ-(\d+):/);
      if (!idMatch) continue;
      
      const id = idMatch[1];
      
      // Extract title
      const titleMatch = section.match(/### REQ-\d+:(.*?)(?=\n|$)/);
      const title = titleMatch ? titleMatch[1].trim() : 'Unnamed Task';
      
      // Extract status (NEW, IN_PROGRESS, COMPLETED, etc.)
      const statusMatch = section.match(/\[([A-Z_]+)\]/);
      const status = statusMatch ? statusMatch[1] : 'UNKNOWN';
      
      // Extract requirements
      const requirementsMatch = section.match(/#### Requirements\s+([\s\S]*?)(?=####|$)/);
      const requirements = requirementsMatch ? parseListItems(requirementsMatch[1]) : [];
      
      // Extract progress updates
      const progressMatch = section.match(/#### Progress Updates\s+([\s\S]*?)(?=####|$)/);
      const progressUpdates = progressMatch ? parseListItems(progressMatch[1]) : [];
      
      // Add to tasks array
      tasks.push({
        id,
        title,
        status,
        requirements,
        progressUpdates,
        priority: determinePriority(status, progressUpdates)
      });
    }
    
    return tasks;
  } catch (error) {
    throw new Error(`Error parsing tasks: ${error.message}`);
  }
}

/**
 * Parse list items from a markdown string
 * @param {string} content - Markdown content with list items
 * @returns {Array} Array of list items
 */
function parseListItems(content) {
  if (!content) return [];
  
  // Split by lines and filter out empty lines
  const lines = content.split('\n').filter(line => line.trim());
  
  // Extract list items (lines starting with - or #. or number.)
  return lines
    .filter(line => /^[-*#\d]/.test(line.trim()))
    .map(line => line.replace(/^[-*#\d.]\s*/, '').trim());
}

/**
 * Determine task priority based on status and progress
 * @param {string} status - Task status
 * @param {Array} progressUpdates - Array of progress updates
 * @returns {string} Priority level (HIGH, MEDIUM, LOW)
 */
function determinePriority(status, progressUpdates) {
  if (status === 'NEW') return 'HIGH';
  if (status === 'IN_PROGRESS') return 'MEDIUM';
  if (status === 'COMPLETED') return 'LOW';
  
  // If there are recent progress updates, consider it medium priority
  if (progressUpdates.length > 0) return 'MEDIUM';
  
  // Default to medium priority
  return 'MEDIUM';
}

/**
 * Identify dependencies between tasks
 * @param {Object} task - Current task
 * @param {Array} allTasks - All available tasks
 * @returns {Array} Dependencies for the current task
 */
function identifyDependencies(task, allTasks) {
  const dependencies = [];
  
  // Look for mentions of other REQs in requirements
  if (task.details && task.details.requirements) {
    for (const req of task.details.requirements) {
      const reqMatches = req.match(/REQ-(\d+)/g) || [];
      
      for (const match of reqMatches) {
        const reqId = match.replace('REQ-', '').padStart(3, '0');
        
        // Skip self-references
        if (reqId === task.id) continue;
        
        // Find the referenced task
        const depTask = allTasks.find(t => t.id === reqId);
        if (depTask) {
          dependencies.push({
            id: reqId,
            title: depTask.title,
            status: depTask.status
          });
        }
      }
    }
  }
  
  return dependencies;
}

/**
 * Identify potential blockers for a task
 * @param {Object} task - Task to analyze
 * @returns {Array} Potential blockers
 */
function identifyBlockers(task) {
  const blockers = [];
  
  // Check if task has dependencies that are not completed
  if (task.dependencies) {
    for (const dep of task.dependencies) {
      if (dep.status !== 'COMPLETED') {
        blockers.push({
          type: 'DEPENDENCY',
          id: dep.id,
          title: dep.title,
          message: `Dependent task REQ-${dep.id} is not completed`
        });
      }
    }
  }
  
  // Check for blockers mentioned in progress updates
  if (task.details && task.details.progressUpdates) {
    for (const update of task.details.progressUpdates) {
      if (update.toLowerCase().includes('block') || update.toLowerCase().includes('issue')) {
        blockers.push({
          type: 'PROGRESS_BLOCKER',
          message: update
        });
      }
    }
  }
  
  return blockers;
}

/**
 * Analyze tasks and generate action plan
 * @param {Array} tasks - Array of parsed tasks
 * @param {string} focusArea - Optional focus area filter
 * @param {string} detailLevel - Detail level (minimal, normal, detailed)
 * @returns {Object} Analysis results and action plan
 */
function analyzeTasksAndGeneratePlan(tasks, focusArea, detailLevel) {
  // Filter by focus area if provided
  let filteredTasks = tasks;
  if (focusArea) {
    filteredTasks = tasks.filter(task => 
      task.title.toLowerCase().includes(focusArea.toLowerCase()) ||
      (task.requirements && task.requirements.some(req => req.toLowerCase().includes(focusArea.toLowerCase())))
    );
  }
  
  // Sort by priority
  const sortedTasks = [...filteredTasks].sort((a, b) => {
    const priorityMap = { HIGH: 3, MEDIUM: 2, LOW: 1 };
    return priorityMap[b.priority] - priorityMap[a.priority];
  });
  
  // Identify highest priority task
  const highestPriorityTask = sortedTasks.length > 0 ? sortedTasks[0] : null;
  
  // Count tasks by status
  const tasksByStatus = {
    NEW: filteredTasks.filter(t => t.status === 'NEW').length,
    IN_PROGRESS: filteredTasks.filter(t => t.status === 'IN_PROGRESS').length,
    COMPLETED: filteredTasks.filter(t => t.status === 'COMPLETED').length,
    OTHER: filteredTasks.filter(t => !['NEW', 'IN_PROGRESS', 'COMPLETED'].includes(t.status)).length
  };
  
  // Identify most recent activity
  const recentActivity = identifyRecentActivity(filteredTasks);
  
  // Generate action plan
  const actionPlan = generateActionPlan(highestPriorityTask, filteredTasks);
  
  return {
    summary: {
      totalTasks: filteredTasks.length,
      tasksByStatus,
      highestPriorityTask: highestPriorityTask ? {
        id: highestPriorityTask.id,
        title: highestPriorityTask.title,
        status: highestPriorityTask.status,
        priority: highestPriorityTask.priority
      } : null,
      recentActivity
    },
    tasks: detailLevel === 'minimal' ? 
      sortedTasks.slice(0, 3).map(simplifyTask) :
      (detailLevel === 'normal' ? 
        sortedTasks.map(simplifyTask) : 
        sortedTasks),
    actionPlan,
    focusArea,
    detailLevel
  };
}

/**
 * Identify recent activity from tasks
 * @param {Array} tasks - Array of tasks
 * @returns {Object} Recent activity information
 */
function identifyRecentActivity(tasks) {
  // Process all progress updates to find the most recent one
  const updates = [];
  
  for (const task of tasks) {
    if (task.progressUpdates && task.progressUpdates.length > 0) {
      for (const update of task.progressUpdates) {
        // Try to extract date information
        const dateMatch = update.match(/(\d{4}-\d{2}-\d{2})/);
        const date = dateMatch ? new Date(dateMatch[1]) : null;
        
        updates.push({
          taskId: task.id,
          taskTitle: task.title,
          update,
          date
        });
      }
    }
  }
  
  // Sort updates by date (if available) or assume the first update is the most recent
  updates.sort((a, b) => {
    if (a.date && b.date) return b.date - a.date;
    if (a.date) return -1;
    if (b.date) return 1;
    return 0;
  });
  
  return updates.length > 0 ? updates[0] : null;
}

/**
 * Generate an action plan based on tasks
 * @param {Object} highestPriorityTask - Highest priority task
 * @param {Array} tasks - All tasks
 * @returns {Object} Action plan
 */
function generateActionPlan(highestPriorityTask, tasks) {
  const newTasks = tasks.filter(t => t.status === 'NEW');
  const inProgressTasks = tasks.filter(t => t.status === 'IN_PROGRESS');
  
  let recommendedAction = null;
  let reason = null;
  
  if (highestPriorityTask) {
    if (highestPriorityTask.status === 'NEW') {
      recommendedAction = `Start work on REQ-${highestPriorityTask.id}: ${highestPriorityTask.title}`;
      reason = 'This is the highest priority new task.';
    } else if (highestPriorityTask.status === 'IN_PROGRESS') {
      recommendedAction = `Continue work on REQ-${highestPriorityTask.id}: ${highestPriorityTask.title}`;
      reason = 'This is the highest priority in-progress task.';
    }
  } else if (newTasks.length > 0) {
    const nextTask = newTasks[0];
    recommendedAction = `Start work on REQ-${nextTask.id}: ${nextTask.title}`;
    reason = 'This is the next new task to work on.';
  } else if (inProgressTasks.length > 0) {
    const nextTask = inProgressTasks[0];
    recommendedAction = `Continue work on REQ-${nextTask.id}: ${nextTask.title}`;
    reason = 'This is an in-progress task that needs attention.';
  } else {
    recommendedAction = 'No specific action required at this time.';
    reason = 'There are no new or in-progress tasks.';
  }
  
  return {
    recommendedAction,
    reason,
    nextSteps: generateNextSteps(highestPriorityTask, tasks)
  };
}

/**
 * Generate specific next steps for the action plan
 * @param {Object} highestPriorityTask - Highest priority task
 * @param {Array} tasks - All tasks
 * @returns {Array} Next steps
 */
function generateNextSteps(highestPriorityTask, tasks) {
  const steps = [];
  
  if (highestPriorityTask) {
    // Add steps based on task status
    if (highestPriorityTask.status === 'NEW') {
      steps.push(`Read and understand the requirements for REQ-${highestPriorityTask.id}`);
      steps.push('Update active-request.md with the task details');
      steps.push('Create an implementation plan');
    } else if (highestPriorityTask.status === 'IN_PROGRESS') {
      steps.push('Review current progress on the task');
      steps.push('Update cycle-status.md with your current status');
      steps.push('Implement the next part of the plan');
    }
    
    // Add dependency-related steps
    if (highestPriorityTask.dependencies) {
      for (const dep of highestPriorityTask.dependencies) {
        if (dep.status !== 'COMPLETED') {
          steps.push(`Resolve dependency: REQ-${dep.id} - ${dep.title}`);
        }
      }
    }
  } else {
    steps.push('Review all current tasks to identify priorities');
    steps.push('Check for any unidentified dependencies between tasks');
    steps.push('Consider creating new tasks if needed');
  }
  
  return steps;
}

/**
 * Simplify task object for output
 * @param {Object} task - Full task object
 * @returns {Object} Simplified task
 */
function simplifyTask(task) {
  return {
    id: task.id,
    title: task.title,
    status: task.status,
    priority: task.priority
  };
}

/**
 * Format analysis output based on requested format
 * @param {Object} analysis - Analysis results
 * @param {string} format - Output format (standard, compact, verbose)
 * @returns {string} Formatted output
 */
function formatAnalysisOutput(analysis, format) {
  let output = '';
  
  if (format === 'compact') {
    // Generate compact output
    output = `# Task Analysis Summary\n\n`;
    output += `Total Tasks: ${analysis.summary.totalTasks} | `;
    output += `New: ${analysis.summary.tasksByStatus.NEW} | `;
    output += `In Progress: ${analysis.summary.tasksByStatus.IN_PROGRESS} | `;
    output += `Completed: ${analysis.summary.tasksByStatus.COMPLETED}\n\n`;
    
    if (analysis.summary.highestPriorityTask) {
      output += `Highest Priority Task: REQ-${analysis.summary.highestPriorityTask.id} - ${analysis.summary.highestPriorityTask.title}\n\n`;
    }
    
    output += `Recommended Action: ${analysis.actionPlan.recommendedAction}\n`;
    
    // Return successful response with the compact output
    return formatSuccess(output);
  } 
  else if (format === 'verbose') {
    // Generate verbose output with complete task details
    output = `# Detailed Task Analysis\n\n`;
    
    output += `## Summary\n`;
    output += `Total Tasks: ${analysis.summary.totalTasks}\n`;
    output += `New Tasks: ${analysis.summary.tasksByStatus.NEW}\n`;
    output += `In Progress: ${analysis.summary.tasksByStatus.IN_PROGRESS}\n`;
    output += `Completed: ${analysis.summary.tasksByStatus.COMPLETED}\n`;
    
    if (analysis.summary.highestPriorityTask) {
      output += `\n## Highest Priority Task\n`;
      output += `* REQ-${analysis.summary.highestPriorityTask.id}: ${analysis.summary.highestPriorityTask.title}\n`;
      output += `* Status: ${analysis.summary.highestPriorityTask.status}\n`;
      output += `* Priority: ${analysis.summary.highestPriorityTask.priority}\n`;
    }
    
    output += `\n## All Tasks\n`;
    for (const task of analysis.tasks) {
      output += `\n### REQ-${task.id}: ${task.title}\n`;
      output += `* Status: ${task.status}\n`;
      output += `* Priority: ${task.priority}\n`;
      
      if (task.requirements && task.requirements.length > 0) {
        output += `* Requirements:\n`;
        for (const req of task.requirements) {
          output += `  - ${req}\n`;
        }
      }
      
      if (task.progressUpdates && task.progressUpdates.length > 0) {
        output += `* Progress Updates:\n`;
        for (const update of task.progressUpdates) {
          output += `  - ${update}\n`;
        }
      }
    }
    
    output += `\n## Action Plan\n`;
    output += `* Recommended Action: ${analysis.actionPlan.recommendedAction}\n`;
    output += `* Reason: ${analysis.actionPlan.reason}\n`;
    
    output += `\n### Next Steps\n`;
    for (const step of analysis.actionPlan.nextSteps) {
      output += `* ${step}\n`;
    }
    
    // Return successful response with the verbose output
    return formatSuccess(output);
  }
  else {
    // Standard format
    output = `# Task Analysis\n\n`;
    
    output += `## Summary\n`;
    output += `- Total Tasks: ${analysis.summary.totalTasks}\n`;
    output += `- New: ${analysis.summary.tasksByStatus.NEW} | In Progress: ${analysis.summary.tasksByStatus.IN_PROGRESS} | Completed: ${analysis.summary.tasksByStatus.COMPLETED}\n`;
    
    if (analysis.summary.recentActivity) {
      output += `- Recent Activity: ${analysis.summary.recentActivity.update}\n`;
    }
    
    if (analysis.summary.highestPriorityTask) {
      output += `\n## Priority Focus\n`;
      output += `REQ-${analysis.summary.highestPriorityTask.id}: ${analysis.summary.highestPriorityTask.title} (${analysis.summary.highestPriorityTask.status})\n`;
    }
    
    output += `\n## Action Plan\n`;
    output += `${analysis.actionPlan.recommendedAction}\n`;
    output += `Reason: ${analysis.actionPlan.reason}\n`;
    
    output += `\n### Next Steps\n`;
    for (const step of analysis.actionPlan.nextSteps) {
      output += `1. ${step}\n`;
    }
    
    if (analysis.tasks.length > 0) {
      output += `\n## Task Overview\n`;
      for (const task of analysis.tasks.slice(0, 5)) {
        output += `- REQ-${task.id}: ${task.title} (${task.status})\n`;
      }
      
      if (analysis.tasks.length > 5) {
        output += `- ...and ${analysis.tasks.length - 5} more tasks\n`;
      }
    }
    
    // Return successful response with the standard output
    return formatSuccess(output);
  }
}

/**
 * Format a success response
 * @param {string} message - Success message
 * @param {Object} data - Optional data to include
 * @returns {string} Formatted success message
 */
function formatSuccess(message, data = null) {
  return `✅ ${message}${data ? '\n\n' + JSON.stringify(data, null, 2) : ''}`;
}

/**
 * Format an error response
 * @param {string} message - Error message
 * @param {string} code - Error code
 * @param {Array} suggestions - Optional suggestions
 * @returns {string} Formatted error message
 */
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

/**
 * Format a warning response
 * @param {string} message - Warning message
 * @param {Object} details - Optional details
 * @returns {string} Formatted warning message
 */
function formatWarning(message, details = null) {
  return `⚠️ Warning: ${message}${details ? '\n\n' + JSON.stringify(details, null, 2) : ''}`;
}

// Execute the process
execute();
```

## Example Usage

### Basic Task Analysis
```
> reaper-analyze-tasks
```

### Focused Analysis
```
> reaper-analyze-tasks --focus=reliability
```

### Detailed Analysis
```
> reaper-analyze-tasks --detail-level=detailed
```

### Compact Output
```
> reaper-analyze-tasks --format=compact
```

## Error Handling

### Missing user_requests.md
```
❌ Error [FILE_ACCESS_ERROR]: Error accessing user_requests.md: File not found

Suggestions:
- Verify the user_requests.md file exists in 00reaper/00OS-commands/
- Run the session initialization command to set up the environment
```

### Invalid Focus Area
```
❌ Error [INVALID_PARAMETER]: Invalid focus area: testing. Valid options are: reliability, file-ops, formatting, sync, handler

Suggestions:
- Check the command syntax and parameter values
- Run '> help reaper-analyze-tasks' for usage information
``` 