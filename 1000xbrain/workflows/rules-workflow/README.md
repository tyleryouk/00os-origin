# Rules Workflow Subsystem

## Workflow & Pathway
**Workflow**: rules-workflow
**Pathway**: Multiple pathways available:
- Subsystem enhancement
- System-wide enhancement
- Performance optimization
- Error recovery
- Front-end enhancement

For detailed architecture understanding, use:
```typescript
fetch_rules(["knowledge/guides/architecture"], 
           "Understanding rules workflow subsystem architecture")
```

## Overview

The rules workflow subsystem is responsible for managing the development and enhancement of Project Rules. It provides standardized processes, validation mechanisms, and implementation guidance.

For detailed workflow patterns, use:
```typescript
fetch_rules(["knowledge/patterns/impl/implementation-patterns"], 
           "Understanding rules workflow implementation patterns")
```

## Core Subsystem Files

| File | Purpose |
|------|---------|
| `rules-workflow.md` | Core workflow process and standards |
| `scanning-process.md` | Guidance for syntax compliance scanning |
| `scenario-selection.md` | Process for selecting implementation scenarios |
| `sync-cursor-rules.md` | Process documenting automatic synchronization between 1000xbrain and Cursor Rules |
| `rules-workflow-cheatsheet.md` | Quick reference for key workflow steps |
| `validation-script.md` | Script for validating project-rule-parameters |

For file standards and organization, use:
```typescript
fetch_rules(["knowledge/reference/guides/file-standards"], 
           "Understanding file organization and standards")
```

## ⚠️ CRITICAL README.md VERIFICATION REQUIREMENT ⚠️

Before making ANY changes to files in the 1000xbrain cognitive architecture, you MUST ALWAYS check the README.md file in the directory first:

1. **Directory-Specific Requirements**: Each directory has unique structure and formatting requirements detailed in its README.md
2. **Knowledge File Headers**: All files in the knowledge directory MUST begin with a USE WHEN header
3. **Format Standards**: Follow the exact format standards specified in each directory's README.md
4. **Contribution Guidelines**: Adhere to directory-specific contribution rules outlined in README.md files

### Knowledge Directory README.md Requirements

For the knowledge directory specifically:

1. **USE WHEN Headers**: All files MUST begin with a USE WHEN header that follows this format:
   ```
   # USE WHEN [action verb in -ing form] [specific task/context], [action verb in -ing form] [related domain], or [action verb in -ing form] [related technology]
   ```
   
2. **Common Format Issues to Avoid**:
   - Missing USE WHEN header entirely
   - Using action verbs that are not in -ing form
   - Having content before the USE WHEN header
   - Having only one context instead of multiple contexts

### README.md Checking Procedure

1. **First Step**: Before editing any file, run:
   ```bash
   cat [directory]/README.md
   ```
   
2. **For Knowledge Files**: After checking README.md, verify the first line has a USE WHEN header:
   ```bash
   head -n 1 [file_path]
   ```
   
3. **When Creating New Files**: Always check README.md in the target directory first to understand requirements

### Automated Validation

For comprehensive README.md verification, use the validation script:
```bash
cd 1000xscripts
./Validate-ProjectRuleParameters.ps1
```

This script checks:
- README.md existence in all directories
- USE WHEN headers in knowledge files
- README.md access patterns before file modifications

For detailed README.md verification procedures, see:
- [scanning-process.md](scanning-process.md#readme-md-verification-process)
- [validation-script.md](validation-script.md#readme-md-and-knowledge-file-validation)

### README.md Verification Implementation Summary

The README.md verification requirement has been implemented across multiple system files:

| Updated File | Enhancement | Purpose |
|---|---|---|
| [rules-workflow.md](rules-workflow.md#readme-md-verification-requirements) | Added dedicated README.md verification section | Core requirement documentation |
| [scanning-process.md](scanning-process.md#readme-md-verification-process) | Added README.md scanning process | Technical implementation details |
| [validation-script.md](validation-script.md#readme-md-and-knowledge-file-validation) | Added validation script enhancements | Automated verification tools |
| [scanning-automation.md](scanning-automation.md) | Added automated README.md checking | Continuous verification system |
| [message-commands-reference.md](message-commands-reference.md#verify-readme-files) | DEPRECATED - Replaced by self-documenting header system | Header-based command tracking |
| [rules-workflow-cheatsheet.md](rules-workflow-cheatsheet.md#readme-md-verification-requirements) | Added README.md verification section | Quick reference for requirements |

This comprehensive implementation ensures that:

1. All files in knowledge directories have proper USE WHEN headers
2. README.md files are always checked before making any file changes
3. The verification process is automated through validation scripts
4. Clear guidance is provided on proper header formats
5. Standardized tool call patterns are available for verification

## ⚠️ Important: Automated Cheatsheet Generation

The `rules-workflow-cheatsheet.md` file is **automatically generated** by the `Update-WorkflowCheatsheets.ps1` script located in the 1000xscripts/report-scripts directory. 

**Do not edit the cheatsheet manually** as your changes will be overwritten the next time the script runs. Instead:

1. To update the cheatsheet content, run the script:
   ```
   & '1000xscripts/report-scripts/Update-WorkflowCheatsheets.ps1'
   ```

2. If persistent changes are needed, modify the script itself:
   ```
   edit_file("1000xscripts/report-scripts/Update-WorkflowCheatsheets.ps1", "...")
   ```

3. The script automatically scans parameter files in the 1000xbrain/parameters/rules directory and generates the appropriate cheatsheet entries.

This automation ensures that the cheatsheet always reflects the current state of available message-commands and their associated project-rule-parameters.

## Related Files

For detailed file relationships, use:
```typescript
fetch_rules(["knowledge/reference/architecture/brain-files-cursor-rules"], 
           "Understanding file relationships and synchronization")
```

- **Knowledge/Rules Directory**: Contains the Cursor Rule files referenced by project-rule-parameters
- **Workflows/Rules-Workflow Directory**: Contains the core workflow documentation
- **1000xbrain Directory**: Contains the editable source files that are automatically synchronized to Cursor Rules

## Message-Command Structure

For detailed message-command patterns, use:
```typescript
fetch_rules(["knowledge/patterns/tool/command-patterns"], 
           "Understanding message-command structure and patterns")
```

Message-commands in the rules workflow follow these standards:

1. **Syntax**: `message-command: standard-parameter @parameters/rules/project-rule-parameter.mdc`
2. **Case**: Always lowercase kebab-case
3. **Parameters**: Separated by space after colon
4. **Project-Rule-Parameters**: Always prefixed with @ and use .mdc extension

## Mode Transition

After planning is complete, transition directly to Developer Mode with:

```
dev-mode: rules-workflow @optional-project-rule-parameter.mdc
```

For mode transition patterns, use:
```typescript
fetch_rules(["knowledge/patterns/impl/basic-patterns"], 
           "Understanding mode transition patterns")
```

## Validation Requirements

For validation patterns and requirements, use:
```typescript
fetch_rules(["knowledge/patterns/tool/basic-patterns"], 
           "Understanding validation requirements and patterns")
```

When processing message-commands, always validate:

1. **Syntax Correctness**: Message-command follows required format (lowercase, kebab-case, colon)
2. **Parameter Validity**: Standard-parameters are recognized and valid
3. **Project-Rule Existence**: Project-rule-parameters refer to existing files
4. **Extension Correctness**: Project-rule-parameters use .mdc extension
5. **Format Consistency**: No brackets or incorrect formatting

## File Extension Requirements

For file extension standards, use:
```typescript
fetch_rules(["knowledge/reference/guides/file-standards"], 
           "Understanding file extension requirements")
```

- **Markdown Files**: Use .md extension for standard documentation
- **Cursor Rules**: Use .mdc extension for all files referenced as project-rule-parameters
- **Scripts**: Use appropriate extension for the script type (.ps1, .bat, etc.)

## Validation Script

For validation script patterns, use:
```typescript
fetch_rules(["knowledge/patterns/tool/tool-combinations"], 
           "Understanding validation script implementation")
```

The rules workflow includes a PowerShell script for validating project-rule-parameters:

- **Location**: Defined in `validation-script.md` and implemented in 1000xscripts
- **Purpose**: Scans for and validates all project-rule-parameters across the 1000xbrain
- **Validation Checks**:
  - Correct extension usage (.mdc instead of .md)
  - Existence of referenced files
  - Consistent naming patterns
- **Usage**: Useful for verifying correct parameter references throughout the cognitive architecture

## Workflow Types

For workflow type patterns, use:
```typescript
fetch_rules(["knowledge/patterns/impl/implementation-patterns"], 
           "Understanding workflow type implementations")
```

The rules workflow supports multiple specialized workflows:

1. **Default Approach**: Standard rule enhancements
2. **Subsystem Enhancement**: Focused improvements to specific subsystems
3. **Error Recovery**: Enhancing error handling mechanisms
4. **Performance Optimization**: Optimizing system performance
5. **System-Wide Enhancement**: Comprehensive multi-component improvements

## Implementation Scenarios

For implementation scenario patterns, use:
```typescript
fetch_rules(["knowledge/patterns/impl/architecture-patterns"], 
           "Understanding implementation scenario patterns")
```

The rules workflow adapts to different scenarios:

1. **Targeted Rule Modifications**: Specific changes to defined files
2. **Conversation Analysis**: Improvements based on conversation analysis
3. **System-Wide Enhancement**: Broad improvements to the architecture
4. **Subsystem Enhancement**: Focus on specific cognitive components

## Automatic Synchronization

For synchronization patterns, use:
```typescript
fetch_rules(["knowledge/reference/architecture/brain-files-cursor-rules"], 
           "Understanding automatic synchronization processes")
```

The 1000xbrain cognitive architecture features seamless integration with Cursor Project Rules:

- Edits to .md files in the 1000xbrain directory are automatically synchronized to corresponding .mdc Cursor Project Rules
- This creates a direct cognitive link between editable brain-files and operational Project Rules
- When content in 1000xbrain is modified, cognitive capabilities are directly enhanced
- README.md files in 1000xbrain are excluded from synchronization as they serve only as navigation aids

## Implementation Complete Criteria

For implementation completion standards, use:
```typescript
fetch_rules(["knowledge/patterns/impl/implementation-patterns"], 
           "Understanding implementation completion criteria")
```

Implementation is complete when:

1. All planned changes are implemented in 1000xbrain files
2. All project-rule-parameters pass validation checks
3. All file structure requirements are followed
4. All references use appropriate extensions (.md for source files, .mdc for project-rule-parameters)
5. Verification confirms integrity



