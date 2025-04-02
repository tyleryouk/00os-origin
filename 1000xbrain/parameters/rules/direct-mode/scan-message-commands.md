# Scan Message Commands

## File Purpose and Relationship

This file defines the process for scanning and validating message-commands throughout the 1000xbrain cognitive architecture. It should be consulted when:

- Verifying message-command format compliance
- Ensuring consistent message-command syntax
- Identifying missing project-rule-parameters
- Standardizing message-command usage


## Required Context

To perform message-command scanning, the following context is required:

1. Access to all 1000xbrain files
2. Understanding of message-command format standards
3. Knowledge of project-rule-parameter requirements

## Process Steps

### 1. Message-Command Extraction

First, extract all message-commands from the codebase:

```typescript
// Find all message-commands in documentation
grep_search(":[\\s]", false, "1000xbrain/**/*.md")

// Focus on specific message-commands
grep_search("plan-mode:|dev-mode:|continue-planning:|continue-implementation:", false, "1000xbrain/**/*.md")
```

### 2. Format Validation

Validate the format of extracted message-commands:

```typescript
// Check for proper kebab-case format
grep_search("[A-Z].*:", false, "1000xbrain/**/*.md")

// Check for missing spaces after colons
grep_search(":[^ ]", false, "1000xbrain/**/*.md")

// Check for incorrect brackets
grep_search(":\\s*\\[", false, "1000xbrain/**/*.md")
```

### 3. Parameter Validation

Verify that all project-rule-parameters follow proper format:

```typescript
// Check for incorrect extensions
grep_search("@knowledge/rules/[a-z0-9-]+\\.md[^c]", false, "1000xbrain/**/*.md")

// Check for improper path formats
grep_search("@(?!knowledge/rules/)[^\\s]+\\.mdc", false, "1000xbrain/**/*.md")
```

### 4. Backtick Protection Verification

Verify that all message-commands in documentation are properly wrapped in backticks:

```typescript
// Find unwrapped message-commands
grep_search("[a-z-]+:\\s+@[^`]", false, "1000xbrain/**/*.md")
```

### 5. Correspondence Verification

Verify that all message-commands have corresponding project-rule-parameters:

```typescript
// Extract unique message-commands
run_terminal_cmd("Get-ChildItem -Path '1000xbrain' -Recurse -Include '*.md' | Select-String -Pattern '([a-z-]+):' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique", false, false)

// Check for corresponding project-rule-parameters
list_dir("1000xbrain/knowledge/rules")
```

## Expected Outputs

The scanning process should produce:

1. A list of all message-commands used in documentation
2. Validation results for message-command format compliance
3. Identification of missing project-rule-parameters
4. Recommendations for standardization

## Error Handling

Common issues and their resolutions:

| Issue | Resolution |
|-------|------------|
| Incorrect case in message-commands | Convert to lowercase kebab-case |
| Missing space after colon | Add space after colon |
| Brackets around parameters | Remove brackets |
| Incorrect extensions | Change .md to .mdc in references |
| Unwrapped message-commands | Wrap in backticks |

## Scanning Examples

### Basic Scan Report

```
📋 1000xdev [rules-workflow]

Message-command scanning complete.

Commands analyzed:
- 53 unique message-commands found
- 47 have corresponding project-rule-parameters
- 6 missing project-rule-parameters

Format issues:
- 3 instances of improper case (camelCase instead of kebab-case)
- 5 instances of missing spaces after colons
- 2 instances of brackets around parameters

Reference issues:
- 4 instances of incorrect extensions (.md instead of .mdc)
- 7 instances of unwrapped message-commands in documentation

Recommendations:
- Create 6 missing project-rule-parameters
- Standardize format for 10 message-commands
- Fix 11 reference issues
```

### Detailed Message-Command Analysis

```
📋 1000xdev [rules-workflow]

Detailed message-command analysis complete.

Missing project-rule-parameters:
- verify-implementation (referenced 7 times)
- check-references (referenced 4 times)
- validate-changes (referenced 3 times)
- finalize-implementation (referenced 2 times)
- system-wide-validation (referenced 1 time)

Format standardization needed:
- continueImplementation -> continue-implementation (3 instances)
- Dev-Mode -> dev-mode (2 instances)
- verify_planning -> verify-planning (1 instance)

Implementation recommendation:
- Priority 1: Create project-rule-parameters for most referenced missing commands
- Priority 2: Standardize format issues
- Priority 3: Fix backtick wrapping issues
```

## Automated Scanning

For more efficient scanning, the following tool sequence can be used:

```typescript
// 1. Extract all message-commands
grep_search(":[\\s]", false, "1000xbrain/**/*.md")

// 2. Check for format issues
grep_search("[A-Z].*:", false, "1000xbrain/**/*.md")
grep_search(":[^ ]", false, "1000xbrain/**/*.md")
grep_search(":\\s*\\[", false, "1000xbrain/**/*.md")

// 3. Check for reference issues
grep_search("@knowledge/rules/[a-z0-9-]+\\.md[^c]", false, "1000xbrain/**/*.md")
grep_search("@(?!knowledge/rules/)[^\\s]+\\.mdc", false, "1000xbrain/**/*.md")

// 4. Check for unwrapped message-commands
grep_search("[a-z-]+:\\s+@[^`]", false, "1000xbrain/**/*.md")

// 5. Document findings
edit_file("1000xbrain/workflows/rules-workflow/scan-results.md", 
          "Document message-command scanning results",
          "# Message-Command Scanning Results\n\n...")
```

This scanning process ensures consistent, properly formatted message-commands throughout the 1000xbrain cognitive architecture, reducing the risk of parsing errors and enhancing system reliability. 