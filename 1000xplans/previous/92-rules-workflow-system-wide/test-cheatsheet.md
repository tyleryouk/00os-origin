# System-Wide Optimization Testing Cheatsheet

This document provides commands and testing scenarios for verifying the implementation of the system-wide optimization.

## Line Count Verification Commands

```powershell
# Count total lines in core directory
(Get-ChildItem -Path "1000xbrain/core/" -Recurse -Filter "*.md" | Where-Object { $_.Name -ne "README.md" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum

# Count lines in specific files or directories
(Get-ChildItem -Path "1000xbrain/core/identity/" -Recurse -Filter "*.md" | Where-Object { $_.Name -ne "README.md" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum

# Check total vs. target
$totalLines = (Get-ChildItem -Path "1000xbrain/core/" -Recurse -Filter "*.md" | Where-Object { $_.Name -ne "README.md" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum
Write-Host "Current total: $totalLines lines"
Write-Host "Target: Under 2000 lines"
Write-Host "Status: $(if ($totalLines -lt 2000) { 'Target achieved' } else { 'Target not yet achieved' })"
```

## File Structure Verification Commands

```powershell
# List all directories in knowledge with pattern check
Get-ChildItem -Path "1000xbrain/knowledge/rules/" -Directory | Select-Object Name

# List all files in a specific directory
Get-ChildItem -Path "1000xbrain/parameters/rules/plan-mode/" -File | Select-Object Name

# Check for README.md vs. index.md
$readmeFiles = Get-ChildItem -Path "1000xbrain/" -Recurse -Filter "README.md" | Where-Object { $_.DirectoryName -ne "1000xbrain" }
$indexFiles = Get-ChildItem -Path "1000xbrain/" -Recurse -Filter "index.md"
Write-Host "README.md files (should only be in root): $($readmeFiles.Count)"
Write-Host "index.md files (should be in subdirectories): $($indexFiles.Count)"
```

## Project-Rule-Parameter Verification Commands

```powershell
# Check for system-wide-optimization parameters
Test-Path "1000xbrain/parameters/rules/plan-mode/system-wide-optimization.md"
Test-Path "1000xbrain/parameters/rules/dev-mode/system-wide-optimization.md"

# Check parameter header format
$parameterContent = Get-Content "1000xbrain/parameters/rules/plan-mode/system-wide-optimization.md" -First 1
Write-Host "Header format correct: $($parameterContent -like '# workflow: rules-workflow | pathway: system-wide-optimization | message-command: plan-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/plan-mode/system-wide-optimization.mdc')"
```

## Testing Scenarios

### Phase 1: Planning and Preparation Testing

| Test Case | Steps | Expected Result | Verification Method |
|-----------|-------|----------------|---------------------|
| Project-Rule-Parameter Creation | Check parameters directory | Parameters exist with correct headers | File inspection |
| Planning Folder Creation | Check planning directory | All required folders exist | Directory listing |
| Requirements Documentation | Check requirements.md in each folder | Requirements are appropriately documented | File inspection |
| Architecture Analysis | Review documentation | Architecture is properly mapped | Documentation review |

### Phase 2: Core Subsystem Testing

| Test Case | Steps | Expected Result | Verification Method |
|-----------|-------|----------------|---------------------|
| Core Line Count | Run line count commands | Total under 2000 lines | PowerShell commands |
| Message-Command Format | Test with new format | Command properly parsed | Manual testing |
| Common-Words Standardization | Check documentation | Consistent terminology usage | Documentation review |
| Mode System Documentation | Review documentation | Clear, concise mode documentation | Documentation review |

### Phase 3: Knowledge and Parameters Testing

| Test Case | Steps | Expected Result | Verification Method |
|-----------|-------|----------------|---------------------|
| Knowledge Organization | Check directory structure | Pathway-based organization | Directory inspection |
| Parameter Enhancement | Review parameters | Standardized fetch_rules pattern | File inspection |
| README to index Conversion | Check file structure | index.md files in appropriate locations | Directory listing |
| Knowledge Access | Test fetch_rules patterns | Efficient knowledge retrieval | Manual testing |

## Message-Command Testing

### Current Format Testing

```
plan-mode: rules-workflow
dev-mode: rules-workflow
direct-mode: rules-workflow
```

### New Format Testing

```
plan-mode: rules-workflow system-wide-optimization @parameters/rules/plan-mode/system-wide-optimization.mdc
dev-mode: rules-workflow system-wide-optimization @parameters/rules/dev-mode/system-wide-optimization.mdc
direct-mode: rules-workflow system-wide-optimization @parameters/rules/direct-mode/system-wide-optimization.mdc
```

## Integration Testing Checklist

- [ ] Core subsystem functionality maintained after optimization
- [ ] Message-command parsing works with new format
- [ ] Knowledge access patterns function correctly
- [ ] Mode transitions operate as expected
- [ ] Project-rule-parameters load appropriate knowledge
- [ ] Context Pills loading functions correctly
- [ ] Common-words are used consistently across documentation
- [ ] Cross-system dependencies function properly

## Success Verification Checklist

- [ ] Core-brain-files total under 2000 lines
- [ ] Auto-attached rules accurately describe workflow cycle
- [ ] Context Pills loading is clearly documented
- [ ] Planning folder structure is standardized
- [ ] 1000x development principles are preserved
- [ ] 1000xdev identity is maintained
- [ ] Role separation is clearly defined
- [ ] Cognitive efficiency is improved
- [ ] Knowledge is more accessible
- [ ] Subsystems are better integrated
- [ ] Self-enhancement capability is maintained 