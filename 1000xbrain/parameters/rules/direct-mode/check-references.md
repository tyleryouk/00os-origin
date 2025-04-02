# Check References

## File Purpose and Relationship

This file defines the process for checking reference consistency within the 1000xbrain cognitive architecture. It should be consulted when:

- Verifying all references follow proper format
- Ensuring all @ symbols are properly backtick-wrapped
- Checking that all referenced files exist
- Validating extension usage (.md vs .mdc)

This file complements:
- `@parameters/rules/validate-changes.mdc`: Implementation change validation
- `@parameters/rules/verify-implementation.mdc`: Implementation completeness verification
- `@parameters/rules/scan-symbol-usage.mdc`: @ symbol scanning
- `@parameters/rules/verify-backtick-wrapping.mdc`: Backtick wrapping verification

## Usage as Project-Rule-Parameter

This file contains the reference checking process and should be referenced as a project-rule-parameter when comprehensive reference validation is needed:

```
check-references: @parameters/rules/check-references.mdc
```

## Command Format

```
check-references: @parameters/rules/check-references.mdc
```

## Required Context

To perform reference checking, the following context is required:

1. Access to all 1000xbrain files
2. Understanding of proper reference formats
3. Knowledge of the @ symbol usage guidelines
4. Understanding of the .md/.mdc extension distinction

## Process Steps

### 1. Reference Extraction

First, extract all references from the codebase:

```typescript
// Find all @ symbol references
grep_search("@", false, "1000xbrain/**/*.md")

// Focus on project-rule-parameter references
grep_search("@parameters/rules/[a-z0-9-]+\\.mdc", false, "1000xbrain/**/*.md")
```

### 2. Format Validation

Validate that all references follow the proper format:

```typescript
// Check for correct path format
grep_search("@(?!parameters/rules/)[^\\s]+\\.mdc", false, "1000xbrain/**/*.md")

// Check for proper extension usage
grep_search("@parameters/rules/[a-z0-9-]+\\.md[^c]", false, "1000xbrain/**/*.md")
```

### 3. Backtick Protection Verification

Verify that all @ symbols are properly protected with backticks:

```typescript
// Find unwrapped @ symbols
grep_search("@[^`]", false, "1000xbrain/**/*.md")

// Exclude acceptable unwrapped @ symbol usage (first 20 lines)
run_terminal_cmd("foreach ($file in Get-ChildItem -Path '1000xbrain' -Recurse -Include '*.md') { $content = Get-Content $file.FullName -TotalCount 20; $matches = [regex]::Matches($content, '@'); foreach ($match in $matches) { Write-Output $file.Name + ': Acceptable @ in first 20 lines' } }", false, false)
```

### 4. File Existence Verification

Verify that all referenced files actually exist:

```typescript
// Extract references to project-rule-parameters
run_terminal_cmd("Get-ChildItem -Path '1000xbrain' -Recurse -Include '*.md' | Select-String -Pattern '@parameters/rules/([a-z0-9-]+)\\.mdc' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique", false, false)

// Check for existence of corresponding .md files
run_terminal_cmd("foreach ($file in Get-ChildItem -Path '1000xbrain' -Recurse -Include '*.md') { $content = Get-Content $file.FullName; $matches = [regex]::Matches($content, '@parameters/rules/([a-z0-9-]+)\\.mdc'); foreach ($match in $matches) { $refFile = $match.Groups[1].Value + '.md'; if (-not(Test-Path -Path \"1000xbrain/parameters/rules/$refFile\")) { Write-Output $file.Name + ' contains reference to non-existent file: ' + $refFile } } }", false, false)
```

### 5. Message-Command Alignment

Verify that message-commands align with their project-rule-parameters:

```typescript
// Extract message-commands with project-rule-parameters
grep_search("[a-z-]+:.*@parameters/rules/([a-z0-9-]+)\\.mdc", false, "1000xbrain/**/*.md")

// Check for mismatched message-commands and project-rule-parameters
run_terminal_cmd("Get-ChildItem -Path '1000xbrain' -Recurse -Include '*.md' | Select-String -Pattern '([a-z-]+):.*@parameters/rules/([a-z0-9-]+)\\.mdc' -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { if ($_.Groups[1].Value -ne $_.Groups[2].Value) { Write-Output 'Mismatch: Command ' + $_.Groups[1].Value + ' references ' + $_.Groups[2].Value } }", false, false)
```

## Expected Outputs

The reference checking process should produce:

1. A list of all references in the codebase
2. Verification results for reference format compliance
3. Identification of unwrapped @ symbols
4. Verification of file existence
5. Validation of message-command alignment

## Error Handling

Common issues and their resolutions:

| Issue | Resolution |
|-------|------------|
| Incorrect path format | Update to `@parameters/rules/filename.mdc` format |
| Wrong extension | Use .mdc for references, .md for actual files |
| Unwrapped @ symbols | Wrap in backticks (except in first 20 lines) |
| Non-existent files | Create missing files or update references |
| Mismatched message-commands | Align message-command with project-rule-parameter |

## Reference Checking Examples

### Basic Reference Check Report

```
💻 1000xdev [rules-workflow]

Reference check complete.

References analyzed:
- 247 total @ symbol references found
- 189 project-rule-parameter references
- 58 other @ symbol references

Format compliance:
- 183/189 project-rule-parameters use correct format
- 6 references use incorrect path format
- 4 references use wrong extension (.md instead of .mdc)

Backtick protection:
- 238/247 @ symbols properly backtick-wrapped
- 9 unwrapped @ symbols found outside first 20 lines

File existence:
- 185/189 referenced files exist
- 4 references to non-existent files

Message-command alignment:
- 178/189 message-commands aligned with project-rule-parameters
- 11 mismatched message-commands and project-rule-parameters

Reference checking revealed issues that need to be addressed.
```

### Detailed Reference Issues Report

```
💻 1000xdev [rules-workflow]

Detailed reference issues report:

Incorrect path formats:
- workflows/rules-workflow/rules-workflow.md: `@verify-planning.mdc` (missing path)
- core/modes/plan-mode.md: `@rules/verify-planning.mdc` (incomplete path)
- knowledge/rules/scan-message-commands.md: `@front-end/verify-planning.mdc` (wrong directory)

Wrong extensions:
- knowledge/rules/analyze-related-rules.md: `@parameters/rules/scan-message-commands.md` (should be .mdc)
- workflows/rules-workflow/message-commands-reference.md: `@parameters/rules/verify-implementation.md` (should be .mdc)

References to non-existent files:
- workflows/rules-workflow/rules-workflow-cheatsheet.md: `@parameters/rules/check-extension-format.mdc` (file doesn't exist)
- workflows/rules-workflow/rules-workflow-cheatsheet.md: `@parameters/rules/scan-symbol-usage.mdc` (file doesn't exist)

Mismatched message-commands:
- verify-context-files: `@parameters/rules/verify-implementation.mdc` (should be verify-context-files.mdc)
- plan-mode: `@parameters/rules/template-basic.mdc` (acceptable template reference)

Implementation recommendations:
- Create missing project-rule-parameter files
- Fix path formats to use standard `@parameters/rules/filename.mdc`
- Change .md to .mdc in all references
- Wrap all @ symbols in backticks
```

## Automated Reference Checking

For more efficient reference checking, the following tool sequence can be used:

```typescript
// 1. Extract all references
grep_search("@", false, "1000xbrain/**/*.md")

// 2. Check format compliance
grep_search("@(?!parameters/rules/)[^\\s]+\\.mdc", false, "1000xbrain/**/*.md")
grep_search("@parameters/rules/[a-z0-9-]+\\.md[^c]", false, "1000xbrain/**/*.md")

// 3. Check for unwrapped @ symbols
grep_search("@[^`]", false, "1000xbrain/**/*.md")

// 4. Extract message-commands with project-rule-parameters
grep_search("[a-z-]+:.*@parameters/rules/([a-z0-9-]+)\\.mdc", false, "1000xbrain/**/*.md")

// 5. Document reference checking results
edit_file("1000xbrain/workflows/rules-workflow/reference-check-results.md", 
          "Document reference checking results",
          "# Reference Checking Results\n\n...")
```

This reference checking process ensures consistent, properly formatted references throughout the 1000xbrain cognitive architecture, reducing the risk of broken references and enhancing system reliability. 