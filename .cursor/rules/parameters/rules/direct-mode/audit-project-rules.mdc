# Audit Project Rules

## File Purpose and Relationship

This file defines the comprehensive process for auditing project-rule-parameters within the 1000xbrain cognitive architecture. It should be consulted when:

- Performing a systematic review of all project rules
- Ensuring consistency across rule documentation
- Validating rule alignment with message-commands
- Identifying gaps or redundancies in rule coverage

## Required Context

To perform a comprehensive project rule audit, the following context is required:

1. Access to all 1000xbrain files, particularly in the knowledge/rules/rules directory
2. Understanding of the message-command system and current standards
3. Knowledge of the expected structure and content of project-rule-parameters

## Process Steps

### 1. Inventory Collection

First, collect a complete inventory of all project rules and message-commands:

```typescript
// List all project rule files
list_dir("1000xbrain/knowledge/rules/rules")

// Get file count to understand scope
run_terminal_cmd("Get-ChildItem -Path '1000xbrain/knowledge/rules/rules' -File | Measure-Object | Select-Object -ExpandProperty Count", false, false)

// Extract all message-commands
grep_search(":[\\s]", false, "1000xbrain/**/*.md")
```

### 2. Structure Consistency Verification

Verify that all project rules follow consistent structure:

```typescript
// Check for required headers
grep_search("^## File Purpose and Relationship|^## Usage as Project-Rule-Parameter|^## Command Format|^## Required Context|^## Process Steps|^## Expected Outputs|^## Error Handling", false, "1000xbrain/knowledge/rules/rules/*.md")

// Identify missing sections
run_terminal_cmd("foreach ($file in Get-ChildItem -Path '1000xbrain/knowledge/rules/rules' -Filter '*.md') { $content = Get-Content $file.FullName; if (-not($content -match '## Expected Outputs')) { Write-Output $file.Name + ' missing Expected Outputs section' } }", false, false)
```

### 3. Format Validation

Validate that all project rules follow proper formatting standards:

```typescript
// Check for proper frontmatter
grep_search("^---", false, "1000xbrain/knowledge/rules/rules/*.md")

// Check for proper level 1 header
grep_search("^# ", false, "1000xbrain/knowledge/rules/rules/*.md")

// Check for inconsistent header formatting
grep_search("^##[^#]|^###[^#]", false, "1000xbrain/knowledge/rules/rules/*.md")
```

### 4. Reference Consistency

Verify that all references follow consistent patterns:

```typescript
// Check for proper reference format
grep_search("@knowledge/rules/rules/[a-z0-9-]+\\.mdc", false, "1000xbrain/knowledge/rules/rules/*.md")

// Check for unwrapped references
grep_search("@[^`]", false, "1000xbrain/knowledge/rules/rules/*.md")

// Check for incorrect extensions
grep_search("@knowledge/rules/rules/[a-z0-9-]+\\.md[^c]", false, "1000xbrain/knowledge/rules/rules/*.md")
```

### 5. Alignment Analysis

Analyze alignment between message-commands and project-rule-parameters:

```typescript
// Extract unique message-commands
run_terminal_cmd("Get-ChildItem -Path '1000xbrain' -Recurse -Include '*.md' | Select-String -Pattern '([a-z-]+):' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique", false, false)

// Compare with existing project-rule-parameters
run_terminal_cmd("$commands = Get-ChildItem -Path '1000xbrain' -Recurse -Include '*.md' | Select-String -Pattern '([a-z-]+):' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique; $rules = Get-ChildItem -Path '1000xbrain/knowledge/rules/rules' -Filter '*.md' | ForEach-Object { $_.BaseName }; foreach ($cmd in $commands) { if ($rules -notcontains $cmd) { Write-Output 'Missing rule for: ' + $cmd } }", false, false)
```

### 6. Content Quality Assessment

Assess the quality and completeness of project rule content:

```typescript
// Check for tool call examples
grep_search("```typescript|```bash", false, "1000xbrain/knowledge/rules/rules/*.md")

// Check for error handling sections
grep_search("## Error Handling", false, "1000xbrain/knowledge/rules/rules/*.md")

// Check for example sections
grep_search("## .* Examples?", false, "1000xbrain/knowledge/rules/rules/*.md")
```

## Expected Outputs

The audit process should produce:

1. A comprehensive audit report detailing findings
2. A list of issues categorized by type and severity
3. Clear recommendations for improvement
4. A prioritized action plan for addressing issues

## Error Handling

Common issues and their resolutions:

| Issue | Resolution |
|-------|------------|
| Missing project rules | Create new project rules to match message-commands |
| Inconsistent structure | Standardize structure across all project rules |
| Reference format issues | Update references to follow `@knowledge/rules/rules/filename.mdc` format |
| Missing content sections | Add required sections to incomplete project rules |
| Unwrapped references | Add backtick protection to @ symbol references |

## Audit Examples

### Basic Audit Report

```
📋 1000xdev [rules-workflow]

Project rules audit complete.

Inventory summary:
- 47 project rules in knowledge/rules/rules directory
- 53 unique message-commands identified
- 6 message-commands without corresponding project rules

Structure findings:
- 42 rules (89%) have all required sections
- 5 rules missing one or more required sections
- Most common missing section: Error Handling (3 rules)

Format findings:
- 45 rules (96%) follow proper formatting standards
- 2 rules have inconsistent header formatting
- No rules with improper frontmatter found

Reference findings:
- 12 instances of unwrapped @ symbol references
- 7 instances of incorrect extensions (.md instead of .mdc)
- 3 instances of inconsistent path formats

Implementation recommendations:
- Priority 1: Create 6 missing project rules
- Priority 2: Add missing sections to 5 incomplete rules
- Priority 3: Fix 22 reference format issues
- Priority 4: Standardize inconsistent formatting
```

### Detailed Alignment Analysis

```
📋 1000xdev [rules-workflow]

Alignment analysis between message-commands and project rules complete.

Missing project rules:
- verify-implementation (referenced 7 times)
- check-references (referenced 4 times)
- validate-changes (referenced 3 times)
- finalize-implementation (referenced 2 times)
- system-wide-validation (referenced 1 time)

Unused project rules:
- legacy-command.md (no references found)
- old-process.md (no references found)
- test-workflow.md (no references found)

Content quality assessment:
- 41 rules (87%) include tool call examples
- 44 rules (94%) include error handling sections
- 39 rules (83%) include example sections

Implementation recommendation:
- Create project rules for most-referenced missing commands first
- Add example sections to 8 rules lacking them
- Add tool call examples to 6 rules lacking them
- Consider archiving 3 unused project rules
```

## Automated Audit

For more efficient auditing, the following tool sequence can be used:

```typescript
// 1. Collect inventory
list_dir("1000xbrain/knowledge/rules/rules")

// 2. Check structure consistency
grep_search("^## File Purpose and Relationship|^## Usage as Project-Rule-Parameter|^## Command Format|^## Required Context|^## Process Steps|^## Expected Outputs|^## Error Handling", false, "1000xbrain/knowledge/rules/rules/*.md")

// 3. Validate references
grep_search("@knowledge/rules/rules/[a-z0-9-]+\\.mdc", false, "1000xbrain/knowledge/rules/rules/*.md")
grep_search("@[^`]", false, "1000xbrain/knowledge/rules/rules/*.md")

// 4. Check for message-command alignment
grep_search(":[\\s]", false, "1000xbrain/**/*.md")

// 5. Document findings
edit_file("1000xbrain/workflows/rules-workflow/audit-results.md", 
          "Document comprehensive audit results",
          "# Project Rules Audit Results\n\n...")
```

This comprehensive audit process ensures that the 1000xbrain cognitive architecture maintains high-quality, consistent project rules that properly align with all message-commands, enhancing system reliability and usability. 