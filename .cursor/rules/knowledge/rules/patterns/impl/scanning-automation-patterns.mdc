# USE WHEN implementing scanning automation, developing validation tools, or optimizing scanning processes

# Scanning Automation Patterns

## Overview
This document provides implementation patterns for automating the scanning of project-rule-parameter references in the 1000xbrain cognitive architecture.

## Key Patterns

### Pattern 1: Script Development

The implementation will use shell scripts with the following components:

```bash
#!/bin/bash

# Set the root directory for scanning
ROOT_DIR="1000xbrain"

# Function to scan for unwrapped @ symbols
function scan_unwrapped_symbols() {
  echo "Scanning for unwrapped @ symbols..."
  grep -r "@" --include="*.md" "$ROOT_DIR/" | grep -v "\`@" | grep -v "@\`" | grep -v "```"
}

# Function to scan for incorrect extensions
function scan_incorrect_extensions() {
  echo "Scanning for incorrect extensions..."
  grep -r "@" --include="*.md" "$ROOT_DIR/" | grep -E "\.md[^c]"
}

# Function to scan for @ symbols in headers
function scan_headers() {
  echo "Scanning for @ symbols in headers..."
  grep -r "^#.*@" --include="*.md" "$ROOT_DIR/"
}

# Function to validate message-command format
function validate_message_commands() {
  echo "Validating message-command format..."
  grep -r ":" --include="*.md" "$ROOT_DIR/" | grep -E "plan-mode|dev-mode" | grep -v "plan-mode: " | grep -v "dev-mode: "
}

# Function to validate project-rule-parameter paths
function validate_project_rule_paths() {
  echo "Validating project-rule-parameter paths..."
  grep -r "@[^/].*\.mdc" --include="*.md" "$ROOT_DIR/" | grep -v "@parameters/rules/"
}

# Function to verify README.md files in directories
function verify_readme_files() {
  echo "Verifying README.md files in directories..."
  find "$ROOT_DIR" -type d -not -path "*/\.*" | while read -r dir; do
    if [ ! -f "$dir/README.md" ]; then
      echo "WARNING: Missing README.md in directory: $dir"
    fi
  done
}

# Function to validate USE WHEN headers in knowledge files
function validate_use_when_headers() {
  echo "Validating USE WHEN headers in knowledge files..."
  find "$ROOT_DIR/knowledge" -type f -name "*.md" -not -name "README.md" | while read -r file; do
    first_line=$(head -n 1 "$file")
    if [[ ! "$first_line" =~ ^#\ USE\ WHEN ]]; then
      echo "ERROR: Missing required USE WHEN header in knowledge file: $file"
    fi
  done
}

# Function to check README.md access before file modifications
function check_readme_access_before_modification() {
  echo "Checking README.md access before file modifications..."
  find "$ROOT_DIR" -type f -name "*.md" -not -name "README.md" -mtime -7 | while read -r file; do
    dir=$(dirname "$file")
    readme_file="$dir/README.md"
    if [ -f "$readme_file" ]; then
      file_mtime=$(stat -c %Y "$file")
      readme_atime=$(stat -c %X "$readme_file")
      
      # Check if README.md was accessed before file modification (with 1 hour buffer)
      if [ $readme_atime -lt $((file_mtime - 3600)) ]; then
        echo "WARNING: File may have been modified without checking README.md first: $file"
      fi
    fi
  done
}

# Run all scans
scan_unwrapped_symbols
scan_incorrect_extensions
scan_headers
validate_message_commands
validate_project_rule_paths
verify_readme_files
validate_use_when_headers
check_readme_access_before_modification

echo "Scanning complete."
```

### Pattern 2: Integration with Project Workflows

The automation script will be integrated with these workflows:

1. **Pre-Commit Hook**: Run scans before changes are committed
2. **Scheduled Validation**: Automated daily scans
3. **Pull Request Checks**: Validation before merging changes
4. **Manual Execution**: On-demand scanning during development

### Pattern 3: Implementation Phases

#### Phase 1: Basic Scanning

Implement core scanning functionality:

1. **Unwrapped @ Symbol Detection**: Identify @ symbols not wrapped in backticks
2. **Incorrect Extension Detection**: Find .md instead of .mdc extensions
3. **Header Validation**: Check for @ symbols in headers
4. **Message-Command Format Validation**: Verify command syntax

#### Phase 2: Reporting System

Develop comprehensive reporting:

1. **Summary Reports**: High-level issue overview
2. **Detailed Reports**: Line-by-line issue identification
3. **HTML Reports**: Visual representation of issues
4. **Trend Analysis**: Track issues over time

#### Phase 3: Automatic Fix Generation

Create fix automation:

1. **Fix Script Generation**: Create scripts to automatically fix issues
2. **Interactive Fixing**: Allow manual review before applying fixes
3. **Batch Processing**: Apply fixes to multiple files
4. **Fix Verification**: Verify fixes don't introduce new issues

#### Phase 4: README.md and Knowledge File Validation

Implement README.md and knowledge file validation:

1. **README.md Verification**: Check for README.md files in all directories
2. **USE WHEN Header Validation**: Verify knowledge files have proper headers
3. **Access Pattern Verification**: Check README.md access before file modification
4. **Automatic Header Addition**: Generate USE WHEN headers for files missing them

### Pattern 4: Production Implementation

The scanning system will be implemented as:

1. **Docker Container**: Self-contained environment for consistent execution
2. **GitHub Action**: Integration with GitHub workflows
3. **Web Service**: API for programmatic scanning access
4. **Command Line Tool**: For manual execution during development

## Implementation Strategy

Implementation should follow these key steps:

1. Create the base scanning script with core functionality
2. Integrate with existing workflow systems
3. Develop reporting capabilities
4. Add automatic fix generation
5. Implement extended validation
6. Package for production use

## Related Patterns
- Error Resolution Patterns: `knowledge/rules/guides/scanning-error-resolution`
- Scanning Output Reference: `knowledge/rules/reference/scanning-output-reference`
- Integration Point Patterns: `knowledge/rules/patterns/impl/scanning-implementation`

## Conclusion
Scanning automation patterns provide a systematic approach to maintaining reference integrity in the cognitive architecture. Following these patterns ensures consistent formatting, correct extension usage, and proper symbol wrapping throughout the codebase. 