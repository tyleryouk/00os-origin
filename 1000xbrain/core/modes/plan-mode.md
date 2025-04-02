# Planning Mode

> **IMPORTANT**: This file has been split into smaller, focused components for better maintainability.

## File Organization

The Planning Mode system is now organized into the following components:

1. **core.md**: Core definitions and purpose
   - Planning Mode's fundamental purpose
   - Core responsibilities and benefits
   - Essential mode characteristics
   - Basic operational parameters

2. **documentation.md**: Documentation standards and protocols
   - Planning folder structure and organization
   - Essential and optional documentation files
   - Documentation templates and formats
   - File creation and modification protocols

3. **knowledge.md**: Knowledge access patterns and usage
   - Knowledge access patterns using fetch_rules
   - Planning-specific knowledge components
   - Best practices for knowledge access
   - Context-specific knowledge usage

4. **verification.md**: Verification requirements and checklists
   - Essential verification requirements
   - Planning completion checklists
   - Documentation verification standards
   - Knowledge access verification

5. **completion.md**: Completion signals and mode transitions
   - Planning completion verification
   - Completion signal format
   - Mode transition protocols
   - Final verification requirements

## Usage as Project-Rule-Parameter

Each component can be referenced as a project-rule-parameter in message-commands:

```
plan-mode: rules-workflow @core/modes/plan-mode/core.mdc
plan-mode: rules-workflow @core/modes/plan-mode/documentation.mdc
plan-mode: rules-workflow @core/modes/plan-mode/knowledge.mdc
plan-mode: rules-workflow @core/modes/plan-mode/verification.mdc
plan-mode: rules-workflow @core/modes/plan-mode/completion.mdc
```

## File Relationships

This file organization complements:
- **dev-mode.md**: Developer Mode operations
- **mode-transitions.md**: Mode transition protocols
- **global-rules.md**: Core identity and mode concepts
- **message-commands.md**: Message command formats and usage

For essential Planning Mode components, see core-essentials.md (Always Rule).


