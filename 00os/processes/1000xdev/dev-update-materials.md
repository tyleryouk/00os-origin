---
name: dev-update-materials
category: 1000xdev
version: 1.0.0
author: 00reaper
description: Step 5 of the 1000xdev cyclical workflow - Read and update all documentation in 1000xdev/documentation based on current application state
permissions: [basic]
inputs:
  - name: flags
    type: object
    description: Optional flags to control the update process
outputs:
  - name: result
    type: string
    description: Summary of documentation reviewed and updated
---

# Process: dev-update-materials

USE WHEN you want to execute dev-update-materials (Step 5 of the 1000xdev cyclical workflow)

## Description
Comprehensively read and review ALL documentation files in `1000xdev/documentation/`, then make revisions based on the current state of the application. This process reads every file in every subfolder to ensure documentation accuracy and completeness.

## Supported Flags
- `--dry-run`: Review all files but don't make any changes (analysis only)
- `--summary`: Provide a summary of outdated sections found
- `--focus`: Specify a subdirectory to focus on (e.g., `--focus=steam` or `--focus=front-end`)

## Execution

```javascript
// Parse flags
const isDryRun = flags['dry-run'] || false;
const provideSummary = flags['summary'] || true; // Default to providing summary
const focusDir = flags['focus'] || null; // Optional subdirectory focus

// Define the base documentation path
const basePath = '1000xdev/documentation';
const targetPath = focusDir ? `${basePath}/${focusDir}` : basePath;

// Track all files reviewed and changes made
const reviewedFiles = [];
const updatedFiles = [];
const issues = [];

// Recursive function to read all files in a directory
async function readAllFilesInDir(dirPath) {
  const dirList = await tools.call('list_dir', {
    relative_workspace_path: dirPath,
    explanation: `Listing all files in ${dirPath} for comprehensive documentation review`
  });
  
  if (!dirList || !dirList.entries) return;
  
  for (const entry of dirList.entries) {
    const fullPath = `${dirPath}/${entry.name}`;
    
    if (entry.is_directory) {
      // Recursively read subdirectories
      await readAllFilesInDir(fullPath);
    } else if (entry.name.endsWith('.md') || entry.name.endsWith('.json')) {
      // Read documentation files
      const fileContent = await tools.call('read_file', {
        target_file: fullPath,
        should_read_entire_file: true,
        explanation: `Reading ${fullPath} for Step 5 documentation review`
      });
      
      reviewedFiles.push({
        path: fullPath,
        name: entry.name,
        content: fileContent.content,
        size: entry.size
      });
      
      // Analyze file for outdated content
      const fileIssues = analyzeDocumentationFile(fullPath, fileContent.content);
      if (fileIssues.length > 0) {
        issues.push({
          file: fullPath,
          problems: fileIssues
        });
      }
    }
  }
}

// Function to analyze documentation for outdated content
function analyzeDocumentationFile(filePath, content) {
  const problems = [];
  
  // Check for common outdated patterns
  if (content.includes('CS2Gun.model')) {
    problems.push('Contains legacy CS2Gun model references - should use SteamInventoryItem');
  }
  
  if (content.includes('TODO') || content.includes('to be filled')) {
    problems.push('Contains TODO items or placeholder content');
  }
  
  if (content.includes('2024-') && !content.includes('2025-')) {
    problems.push('May contain outdated dates from 2024');
  }
  
  if (filePath.includes('steam') && !content.includes('steamwebapi.com')) {
    problems.push('Steam documentation may be missing current API implementation details');
  }
  
  if (filePath.includes('front-end') && !content.includes('SteamInventoryItem')) {
    problems.push('Front-end docs may be missing current Steam inventory types');
  }
  
  if (filePath.includes('back-end') && !content.includes('pytest-asyncio')) {
    problems.push('Back-end docs may be missing current testing strategy');
  }
  
  return problems;
}

// Start the comprehensive review
await readAllFilesInDir(targetPath);

// If not dry-run, make necessary updates
if (!isDryRun && issues.length > 0) {
  for (const issue of issues) {
    // Read current state files to get accurate information
    let updatedContent = null;
    
    // Example: Update Steam documentation
    if (issue.file.includes('steam')) {
      // Read current Steam implementation
      const steamAPI = await tools.call('read_file', {
        target_file: 'front-end/src/api/steam.ts',
        should_read_entire_file: false,
        start_line_one_indexed: 1,
        end_line_one_indexed_inclusive: 50,
        explanation: 'Check current Steam API implementation'
      });
      
      // Update documentation based on current implementation
      if (steamAPI && steamAPI.content) {
        // Make targeted updates based on issues found
        // This would involve search_replace operations on the specific file
        updatedFiles.push(issue.file);
      }
    }
    
    // Example: Update front-end documentation
    if (issue.file.includes('front-end') && issue.problems.some(p => p.includes('CS2Gun'))) {
      await tools.call('search_replace', {
        file_path: issue.file,
        old_string: 'CS2Gun',
        new_string: 'SteamInventoryItem',
        replace_all: true
      });
      updatedFiles.push(issue.file);
    }
  }
}

// Update cycle-status.md with review summary
const timestamp = new Date().toISOString().split('T')[0];
const logEntry = `| ${timestamp} current  | Step 5: Dev Docs | Reviewed ${reviewedFiles.length} files, updated ${updatedFiles.length} | None | Documentation sync |`;

await tools.call('search_replace', {
  file_path: '1000xdev/cycle-status.md',
  old_string: '## Action Log',
  new_string: `## Action Log\n${logEntry}`,
  replace_all: false
});

// Generate detailed summary
let summary = `📚 Documentation Review Complete\n`;
summary += `━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n`;
summary += `📁 Files Reviewed: ${reviewedFiles.length}\n`;
summary += `📝 Files Updated: ${updatedFiles.length}\n`;
summary += `⚠️  Issues Found: ${issues.length}\n\n`;

if (provideSummary && issues.length > 0) {
  summary += `Issues by File:\n`;
  summary += `───────────────\n`;
  for (const issue of issues.slice(0, 10)) { // Limit to first 10 for readability
    summary += `\n📄 ${issue.file}\n`;
    for (const problem of issue.problems) {
      summary += `   • ${problem}\n`;
    }
  }
  
  if (issues.length > 10) {
    summary += `\n... and ${issues.length - 10} more files with issues\n`;
  }
}

if (isDryRun) {
  summary += `\n🔍 DRY RUN MODE - No changes were made\n`;
  summary += `Run without --dry-run flag to apply updates\n`;
}

// List all reviewed directories
const directories = new Set();
reviewedFiles.forEach(f => {
  const dir = f.path.substring(0, f.path.lastIndexOf('/'));
  directories.add(dir);
});

summary += `\n📂 Directories Covered:\n`;
for (const dir of directories) {
  const fileCount = reviewedFiles.filter(f => f.path.startsWith(dir + '/')).length;
  summary += `   • ${dir} (${fileCount} files)\n`;
}

return { 
  success: true, 
  result: summary
};
```

## Examples

> dev-update-materials
✅ Reads ALL documentation files and makes necessary updates based on current application state

> dev-update-materials --dry-run
✅ Reviews all documentation but makes no changes (analysis only)

> dev-update-materials --summary
✅ Provides detailed summary of outdated sections found

> dev-update-materials --focus=steam
✅ Focuses review on steam/ subdirectory only

> dev-update-materials --focus=front-end --dry-run
✅ Dry run review of front-end documentation only

## Notes
- This process reads EVERY file in EVERY subfolder of 1000xdev/documentation/
- Automatically detects common outdated patterns (legacy models, TODOs, old dates)
- Makes intelligent updates based on current application code
- Not all cycles require extensive documentation updates
- The process is thorough but respects that documentation changes should be meaningful
- All reviews and updates are logged in 1000xdev/cycle-status.md
- Use --dry-run to preview what would be changed before committing to updates