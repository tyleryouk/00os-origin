# Enhancement Requirements: System-Wide README.md Updates

## Overview

This document outlines the requirements for updating all README.md files in the 1000xbrain directory to accurately reflect the reorganized directory structure and rule type system. The system is now organized with a direct one-to-one mapping between directories and rule types, requiring comprehensive documentation updates.

## New Knowledge Organization System

The 1000xbrain directory has been reorganized into a clean structure with a direct mapping between directories and rule types:

- `/core` - Always rule types (automatically included in every conversation)
- `/knowledge` - Agent Request rule types (accessible through fetch_rules tool call)
- `/parameters` - Manual rule types (accessible as project-rule-parameters for message-commands)
- `/workflows` - Auto Attached rule types (automatically attached based on the workflow-type)

## Business Requirements

1. **Comprehensive Directory Structure Documentation**
   - Update all README.md files to accurately reflect the new directory structure
   - Clearly document the one-to-one mapping between directories and rule types
   - Provide consistent documentation of access methods for each rule type

2. **Standardized Access Method Documentation**
   - Document Always rules as automatically included in every conversation
   - Document Auto-Attached rules as activated by file matching
   - Document Manual rules as accessed through project-rule-parameters
   - Document Agent Requested rules as accessed through the fetch_rules tool

3. **Consistent Terminology**
   - Use consistent terminology for rule types across all documentation
   - Maintain clear distinction between different access methods
   - Use standardized terms for directories and their purposes

4. **Clear Cross-References**
   - Provide clear cross-references between directories and rule types
   - Document relationships between different knowledge components
   - Ensure consistent navigation guidance across all README.md files

5. **fetch_rules Tool Documentation**
   - Document fetch_rules as the primary access method for Agent Requested rules
   - Provide comprehensive examples of fetch_rules usage
   - Explain the relationship between fetch_rules and automatic inclusion

## Technical Requirements

1. **Root README.md Updates**
   - Create a comprehensive overview of the new structure
   - Document all four rule types and their access methods
   - Provide a directory-rule type mapping table
   - Include examples of accessing each rule type

2. **Core README.md Updates**
   - Document core directory as containing Always rules
   - Explain automatic inclusion mechanism
   - Document relationship to other rule types
   - Include fetch_rules examples for accessing specialized knowledge

3. **Knowledge README.md Updates**
   - Document knowledge directory as containing Agent Requested rules
   - Provide comprehensive fetch_rules documentation
   - Explain automatic inclusion vs. direct access
   - Include examples for different knowledge domains

4. **Workflows README.md Updates**
   - Document workflows directory as containing Auto-Attached rules
   - Explain file-matching activation mechanism
   - Document relationship to other rule types
   - Include fetch_rules examples for accessing specialized knowledge

5. **Parameters README.md Updates**
   - Document parameters directory as containing Manual rules
   - Explain project-rule-parameter syntax and usage
   - Document relationship to other rule types
   - Include fetch_rules examples for accessing specialized knowledge

6. **Subdirectory README.md Updates**
   - Update all subdirectory README.md files for consistency
   - Maintain consistent rule type terminology
   - Provide context-specific examples
   - Ensure cross-references align with new structure

## Implementation Requirements

1. **Standardized Documentation Structure**
   - Each README.md should include a directory purpose section
   - Each README.md should explain the appropriate access method
   - Each README.md should document relationships to other rule types
   - Each README.md should include appropriate examples

2. **Visual Consistency**
   - Use consistent formatting across all README.md files
   - Maintain consistent table structures
   - Use standardized code block formats for examples
   - Implement consistent visual hierarchy

3. **Examples Appropriateness**
   - Provide context-appropriate examples for each directory
   - Include basic and advanced usage examples
   - Ensure examples follow correct syntax
   - Document relationship between examples and usage scenarios

4. **Verification Standards**
   - Define verification criteria for each README.md file
   - Establish consistency checks across documentation
   - Create validation approach for terminology usage
   - Implement cross-reference verification

## Access Method Documentation Standards

### Always Rules (Core Directory)
```markdown
## Always Rules Access

Files in the core directory are **Always Rules** that:

- Are automatically included in every conversation
- Provide fundamental cognitive capabilities
- Form the baseline of 1000xdev's operation
- Require no explicit access method
```

### Auto-Attached Rules (Workflows Directory)
```markdown
## Auto-Attached Rules Access

Files in the workflows directory are **Auto-Attached Rules** that:

- Are automatically included when matching files are referenced
- Activate based on workflow type (file extensions/paths)
- Provide domain-specific workflow guidance
- Require no explicit access method
```

### Manual Rules (Parameters Directory)
```markdown
## Manual Rules Access

Files in the parameters directory are **Manual Rules** that:

- Are accessed as project-rule-parameters in message-commands
- Must be explicitly referenced with the @ symbol
- Provide task-specific implementation details
- Follow this syntax: `message-command: @parameters/path/to/file.mdc`
```

### Agent Requested Rules (Knowledge Directory)
```markdown
## Agent Requested Rules Access

Files in the knowledge directory are **Agent Requested Rules** that:

- Are accessed using the fetch_rules tool
- Can be automatically included when relevant to current task
- Provide specialized domain knowledge
- Follow this syntax: `fetch_rules(["knowledge/path/to/file"])`
```

## Success Criteria

The implementation will be considered successful when:

1. All README.md files accurately reflect the new directory structure
2. Documentation uses consistent terminology across all files
3. Each rule type has clear, consistent access method documentation
4. Cross-references between directories are accurate and helpful
5. fetch_rules tool is properly documented in all relevant contexts
6. Examples are appropriate, accurate, and consistent

## Implementation Phases

The implementation will proceed in four phases:

1. **Basic Structure Update**: Update all README.md files with basic structure and terminology
2. **Directory-Specific Customization**: Customize each README.md with specific content
3. **Comprehensive Examples**: Add detailed examples for each access method
4. **Testing and Validation**: Verify consistency and accuracy across all documentation

## Timeline and Priority

- **High Priority**: Root README.md, Knowledge README.md
- **Medium Priority**: Core README.md, Workflows README.md, Parameters README.md
- **Lower Priority**: Subdirectory README.md files

The complete implementation should be completed in one development cycle to ensure consistency across all documentation. 