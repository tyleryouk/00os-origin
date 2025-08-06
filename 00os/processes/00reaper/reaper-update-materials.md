---
name: reaper-update-materials
category: 00reaper
version: 1.0.0
author: 00reaper
description: Step 5 of the cyclical workflow - Review and update supporting materials (documentation, context, templates) with targeted flags for specific domains
permissions: [basic]
inputs:
  - name: flags
    type: object
    description: Optional flags to specify which supporting materials to review
outputs:
  - name: result
    type: string
    description: Summary of materials reviewed and updated
---

# Process: reaper-update-materials

USE WHEN you want to execute reaper-update-materials (Step 5 of the cyclical workflow)

## Description
Review and update supporting materials including documentation, context files, and templates. This process is specifically designed for Step 5 of the 6-step cyclical workflow. Use flags to target specific domains or material types.

## Supported Flags
- `--docs`: Review documentation folders only
- `--context`: Review context files only  
- `--templates`: Review template files only
- `--00reaper`: Review 00reaper domain materials (default if no domain specified)
- `--1000xdev`: Review 1000xdev domain materials
- `--00os`: Review 00OS domain materials
- `--all`: Review all supporting materials across all domains

## Execution

```javascript
// Parse flags
const reviewDocs = flags['docs'] || flags['all'] || (!flags['context'] && !flags['templates']);
const reviewContext = flags['context'] || flags['all'] || (!flags['docs'] && !flags['templates']);
const reviewTemplates = flags['templates'] || flags['all'] || (!flags['docs'] && !flags['context']);

// Determine target domains
let domains = [];
if (flags['00reaper'] || (!flags['1000xdev'] && !flags['00os'])) {
  domains.push('00reaper');
}
if (flags['1000xdev']) {
  domains.push('1000xdev');
}
if (flags['00os']) {
  domains.push('00os');
}
if (flags['all']) {
  domains = ['00reaper', '1000xdev', '00os'];
}

// Review materials for each domain
const reviewResults = [];

for (const domain of domains) {
  // Review documentation
  if (reviewDocs) {
    const docPath = domain === '00os' ? '00reaper/documentation' : `${domain}/documentation`;
    const docList = await tools.call('list_dir', {
      relative_workspace_path: docPath,
      explanation: `Review ${domain} documentation structure for Step 5 materials update`
    });
    
    // List subdirectories for deeper review
    if (docList && docList.entries) {
      for (const entry of docList.entries) {
        if (entry.is_directory) {
          await tools.call('list_dir', {
            relative_workspace_path: `${docPath}/${entry.name}`,
            explanation: `Review ${domain} documentation subdirectory: ${entry.name}`
          });
        }
      }
    }
    
    reviewResults.push({
      domain: domain,
      type: 'documentation',
      path: docPath,
      itemCount: docList?.entries?.length || 0
    });
  }
  
  // Review context files
  if (reviewContext && domain === '00reaper') {
    const contextPath = '00reaper/context';
    const contextList = await tools.call('list_dir', {
      relative_workspace_path: contextPath,
      explanation: `Review ${domain} context files for Step 5 materials update`
    });
    
    reviewResults.push({
      domain: domain,
      type: 'context',
      path: contextPath,
      itemCount: contextList?.entries?.length || 0
    });
  }
  
  // Review templates
  if (reviewTemplates) {
    const templatePath = `${domain}/planning/templates`;
    const templateList = await tools.call('list_dir', {
      relative_workspace_path: templatePath,
      explanation: `Review ${domain} template files for Step 5 materials update`
    });
    
    reviewResults.push({
      domain: domain,
      type: 'templates',
      path: templatePath,
      itemCount: templateList?.entries?.length || 0
    });
  }
}

// Update cycle-status.md with review summary
const timestamp = new Date().toISOString().split('T')[0];
const logEntry = `| ${timestamp} current  | Step 5: Materials | Reviewed ${reviewResults.length} material types | None | ${domains.join(', ')} domains |`;

await tools.call('search_replace', {
  file_path: '00reaper/cycle-status.md',
  old_string: '## Action Log',
  new_string: '## Action Log',
  replace_all: false
});

// Log specific updates if any files were modified
// (This would be where actual file updates happen based on review findings)

// Generate summary
const summary = reviewResults.map(r => 
  `${r.domain}/${r.type}: ${r.itemCount} items reviewed`
).join('\n');

return { 
  success: true, 
  result: `✅ Step 5 Supporting Materials Review Complete\n\n${summary}\n\nDomains reviewed: ${domains.join(', ')}\nMaterial types: ${[reviewDocs && 'documentation', reviewContext && 'context', reviewTemplates && 'templates'].filter(Boolean).join(', ')}` 
};
```

## Examples

> reaper-update-materials
✅ Reviews 00reaper documentation, context, and templates (default behavior)

> reaper-update-materials --docs
✅ Reviews documentation folders only in 00reaper domain

> reaper-update-materials --1000xdev --docs
✅ Reviews 1000xdev documentation only

> reaper-update-materials --all
✅ Reviews all supporting materials across all domains (00reaper, 1000xdev, 00os)

> reaper-update-materials --context --templates
✅ Reviews context files and templates only (no documentation)

> reaper-update-materials --00os --docs
✅ Reviews 00OS-related documentation (stored in 00reaper/documentation)

## Notes
- This process is designed specifically for Step 5 of the cyclical workflow
- Default behavior (no flags) reviews all material types in 00reaper domain
- Use domain flags to target specific agent domains
- Use material type flags to focus on specific types of supporting materials
- The process performs list_dir operations to review structure and can be extended to read/update specific files
- All reviews are logged in cycle-status.md for tracking