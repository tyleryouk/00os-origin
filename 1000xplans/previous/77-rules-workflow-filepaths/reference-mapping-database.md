# Reference Mapping Database for Filepath Updates

This file contains a comprehensive mapping of all filepath references that need to be updated throughout the codebase. The mapping is organized by file and includes both old and new filepaths as well as the context for each reference.

## File Categories

The following files need to be checked and updated for filepath references:

1. **Core Identity Files**:
   - `1000xbrain/core/identity/global-rules.md`

2. **Core Communication Files**:
   - `1000xbrain/core/communication/message-commands.md`
   - `1000xbrain/core/communication/message-command-list.md`
   - `1000xbrain/core/communication/syntax-standards.md`
   - `1000xbrain/core/communication/symbol-guidelines.md`

3. **Mode System Files**:
   - `1000xbrain/core/modes/mode-transitions.md`
   - `1000xbrain/core/modes/transitions/mode-transitions-handlers.md`

4. **Workflow Files**:
   - `1000xbrain/workflows/rules-workflow.md`
   - `1000xbrain/workflows/README.md`
   - `1000xbrain/workflows/rules-workflow/message-commands-reference.md`
   - `1000xbrain/workflows/rules-workflow/README.md`
   - `1000xbrain/workflows/rules-workflow/rules-workflow-cheatsheet.md`

## Reference Mapping Tables

### Core Identity Files

#### 1000xbrain/core/identity/global-rules.md

| Old Filepath | New Filepath | Context | Line |
|--------------|--------------|---------|------|
| `@parameters/rules/plan-mode.mdc` | `@parameters/rules/plan-mode/plan-mode.mdc` | Example in syntax distinctions | TBD |
| `@parameters/rules/dev-mode.mdc` | `@parameters/rules/dev-mode/dev-mode.mdc` | Example in syntax distinctions | TBD |
| `@parameters/rules/direct-mode.mdc` | `@parameters/rules/direct-mode/direct-mode.mdc` | Example in syntax distinctions | TBD |
| `@template-basic.mdc` | `@parameters/rules/plan-mode/template-basic.mdc` | Example in two-command workflow | TBD |
| `@log-based-implementation.mdc` | `@parameters/rules/dev-mode/log-based-implementation.mdc` | Example in two-command workflow | TBD |
| `@direct-implementation.mdc` | `@parameters/rules/direct-mode/direct-implementation.mdc` | Example in two-command workflow | TBD |
| `@template-advanced.mdc` | `@parameters/rules/plan-mode/template-advanced.mdc` | Example in two-command workflow | TBD |
| `@error-recovery.mdc` | `@parameters/rules/helpers/recovery/error-recovery.mdc` | Example in two-command workflow | TBD |
| `@subsystem-enhancement.mdc` | `@parameters/rules/plan-mode/subsystem-enhancement.mdc` | Example in two-command workflow | TBD |

### Core Communication Files

#### 1000xbrain/core/communication/message-commands.md

| Old Filepath | New Filepath | Context | Line |
|--------------|--------------|---------|------|
| `@core/communication/message-commands.mdc` | `@parameters/rules/plan-mode/plan-mode.mdc` | Example in usage as project-rule-parameter | TBD |
| `@template-basic.mdc` | `@parameters/rules/plan-mode/template-basic.mdc` | Example in essential message-commands | TBD |
| `@log-based-implementation.mdc` | `@parameters/rules/dev-mode/log-based-implementation.mdc` | Example in essential message-commands | TBD |
| `@direct-implementation.mdc` | `@parameters/rules/direct-mode/direct-implementation.mdc` | Example in essential message-commands | TBD |
| `@template-advanced.mdc` | `@parameters/rules/plan-mode/template-advanced.mdc` | Example in essential message-commands | TBD |
| `@error-recovery.mdc` | `@parameters/rules/helpers/recovery/error-recovery.mdc` | Example in essential message-commands | TBD |
| `@verify-planning.mdc` | `@parameters/rules/helpers/verification/verify-planning.mdc` | Example in parameter system | TBD |

#### 1000xbrain/core/communication/message-command-list.md

| Old Filepath | New Filepath | Context | Line |
|--------------|--------------|---------|------|
| `@template-basic.mdc` | `@parameters/rules/plan-mode/template-basic.mdc` | Example in plan-mode section | TBD |
| `@template-advanced.mdc` | `@parameters/rules/plan-mode/template-advanced.mdc` | Example in plan-mode section | TBD |
| `@log-based-implementation.mdc` | `@parameters/rules/dev-mode/log-based-implementation.mdc` | Example in dev-mode section | TBD |
| `@system-wide-implementation.mdc` | `@parameters/rules/dev-mode/system-wide-implementation.mdc` | Example in dev-mode section | TBD |
| `@direct-implementation.mdc` | `@parameters/rules/direct-mode/direct-implementation.mdc` | Example in direct-mode section | TBD |
| `@error-recovery.mdc` | `@parameters/rules/helpers/recovery/error-recovery.mdc` | Example in continue-implementation section | TBD |
| `@feature-completion.mdc` | `@parameters/rules/helpers/implementation/feature-completion.mdc` | Example in continue-implementation section | TBD |

#### 1000xbrain/core/communication/syntax-standards.md

| Old Filepath | New Filepath | Context | Line |
|--------------|--------------|---------|------|
| `@template-basic.mdc` | `@parameters/rules/plan-mode/template-basic.mdc` | Example in syntax standards | TBD |
| `@verify-planning.mdc` | `@parameters/rules/helpers/verification/verify-planning.mdc` | Example in syntax standards | TBD |
| `@log-based-implementation.mdc` | `@parameters/rules/dev-mode/log-based-implementation.mdc` | Example in syntax standards | TBD |

#### 1000xbrain/core/communication/symbol-guidelines.md

| Old Filepath | New Filepath | Context | Line |
|--------------|--------------|---------|------|
| `@core/communication/symbol-guidelines.mdc` | `@parameters/rules/helpers/verification/verify-symbol-guidelines.mdc` | Example in usage as project-rule-parameter | TBD |
| `@parameters/rules/verify-planning.mdc` | `@parameters/rules/helpers/verification/verify-planning.mdc` | Examples of proper file references | TBD |
| `@parameters/rules/update-rules.mdc` | `@parameters/rules/helpers/implementation/update-rules.mdc` | Examples of proper file references | TBD |

### Mode System Files

#### 1000xbrain/core/modes/mode-transitions.md

| Old Filepath | New Filepath | Context | Line |
|--------------|--------------|---------|------|
| `@core/modes/transitions/mode-transitions-core.mdc` | `@parameters/rules/helpers/implementation/mode-transitions-core.mdc` | Example in usage as project-rule-parameter | TBD |
| `@core/modes/transitions/mode-transitions-handlers.mdc` | `@parameters/rules/helpers/implementation/mode-transitions-handlers.mdc` | Example in usage as project-rule-parameter | TBD |
| `@core/modes/transitions/mode-transitions-context.mdc` | `@parameters/rules/helpers/implementation/mode-transitions-context.mdc` | Example in usage as project-rule-parameter | TBD |

#### 1000xbrain/core/modes/transitions/mode-transitions-handlers.md

| Old Filepath | New Filepath | Context | Line |
|--------------|--------------|---------|------|
| `@parameters/rules/continue-planning.mdc` | `@parameters/rules/plan-mode/continue-planning.mdc` | Example in continue-planning section | TBD |
| `@parameters/rules/continue-implementation.mdc` | `@parameters/rules/dev-mode/continue-implementation.mdc` | Example in continue-implementation section | TBD |
| `@parameters/rules/direct-implementation.mdc` | `@parameters/rules/direct-mode/direct-implementation.mdc` | Example in direct implementation section | TBD |

### Workflow Files

#### 1000xbrain/workflows/rules-workflow.md

| Old Filepath | New Filepath | Context | Line |
|--------------|--------------|---------|------|
| `@parameters/rules/plan-mode.mdc` | `@parameters/rules/plan-mode/plan-mode.mdc` | Example in workflow overview | TBD |
| `@parameters/rules/dev-mode.mdc` | `@parameters/rules/dev-mode/dev-mode.mdc` | Example in workflow overview | TBD |
| `@parameters/rules/template-basic.mdc` | `@parameters/rules/plan-mode/template-basic.mdc` | Example in workflow overview | TBD |
| `@parameters/rules/continue-planning.mdc` | `@parameters/rules/plan-mode/continue-planning.mdc` | Example in workflow overview | TBD |
| `@parameters/rules/continue-implementation.mdc` | `@parameters/rules/dev-mode/continue-implementation.mdc` | Example in workflow overview | TBD |

#### 1000xbrain/workflows/rules-workflow/message-commands-reference.md

| Old Filepath | New Filepath | Context | Line |
|--------------|--------------|---------|------|
| `@parameters/rules/plan-mode.mdc` | `@parameters/rules/plan-mode/plan-mode.mdc` | Example in message-commands reference | TBD |
| `@parameters/rules/dev-mode.mdc` | `@parameters/rules/dev-mode/dev-mode.mdc` | Example in message-commands reference | TBD |
| `@parameters/rules/continue-planning.mdc` | `@parameters/rules/plan-mode/continue-planning.mdc` | Example in message-commands reference | TBD |
| `@parameters/rules/continue-implementation.mdc` | `@parameters/rules/dev-mode/continue-implementation.mdc` | Example in message-commands reference | TBD |
| `@parameters/rules/verify-planning.mdc` | `@parameters/rules/helpers/verification/verify-planning.mdc` | Example in message-commands reference | TBD |

#### 1000xbrain/workflows/rules-workflow/rules-workflow-cheatsheet.md

| Old Filepath | New Filepath | Context | Line |
|--------------|--------------|---------|------|
| `@parameters/rules/plan-mode.mdc` | `@parameters/rules/plan-mode/plan-mode.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/dev-mode.mdc` | `@parameters/rules/dev-mode/dev-mode.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/direct-mode.mdc` | `@parameters/rules/direct-mode/direct-mode.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/template-basic.mdc` | `@parameters/rules/plan-mode/template-basic.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/template-advanced.mdc` | `@parameters/rules/plan-mode/template-advanced.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/continue-planning.mdc` | `@parameters/rules/plan-mode/continue-planning.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/continue-implementation.mdc` | `@parameters/rules/dev-mode/continue-implementation.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/verify-planning.mdc` | `@parameters/rules/helpers/verification/verify-planning.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/verify-implementation.mdc` | `@parameters/rules/helpers/verification/verify-implementation.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/analyze-related-rules.mdc` | `@parameters/rules/helpers/analysis/analyze-related-rules.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/scan-message-commands.mdc` | `@parameters/rules/helpers/analysis/scan-message-commands.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/context-first-implementation.mdc` | `@parameters/rules/helpers/implementation/context-first-implementation.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/direct-implementation.mdc` | `@parameters/rules/direct-mode/direct-implementation.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/direct-implementation-continuation.mdc` | `@parameters/rules/helpers/recovery/direct-implementation-continuation.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/validate-changes.mdc` | `@parameters/rules/helpers/validation/validate-changes.mdc` | Table in cheatsheet | TBD |
| `@parameters/rules/finalize-implementation.mdc` | `@parameters/rules/helpers/finalization/finalize-implementation.mdc` | Table in cheatsheet | TBD |

## Missing Files to Create

### Front-End Enhancement Files

| File to Create | Base Template | Purpose |
|----------------|---------------|---------|
| `1000xbrain/parameters/rules/plan-mode/continue-planning-front-end-enhancement.md` | `continue-planning.md` | Continue planning for front-end enhancement |
| `1000xbrain/parameters/rules/dev-mode/dev-mode-front-end-enhancement.md` | `dev-mode.md` | Initialize dev-mode for front-end enhancement |
| `1000xbrain/parameters/rules/dev-mode/continue-implementation-front-end-enhancement.md` | `continue-implementation.md` | Continue implementation for front-end enhancement |

### Direct-Mode Files

| File to Create | Base Template | Purpose |
|----------------|---------------|---------|
| `1000xbrain/parameters/rules/direct-mode/direct-mode-front-end-enhancement.md` | `direct-mode.md` | Initialize direct-mode for front-end enhancement |
| `1000xbrain/parameters/rules/direct-mode/direct-mode-subsystem.md` | `direct-mode.md` | Initialize direct-mode for subsystem modifications |
| `1000xbrain/parameters/rules/direct-mode/direct-mode-system-wide.md` | `direct-mode.md` | Initialize direct-mode for system-wide changes |

## Reference Update Patterns

### For Text References

**Pattern**: Update filepath while preserving backtick wrapping
```markdown
Example: `` `@parameters/rules/template-basic.mdc` `` → `` `@parameters/rules/plan-mode/template-basic.mdc` ``
```

### For Code Block References

**Pattern**: Update filepath without adding additional backticks
```markdown
Example:
```
plan-mode: rules-workflow @parameters/rules/template-basic.mdc
```
→
```
plan-mode: rules-workflow @parameters/rules/plan-mode/template-basic.mdc
```
```

### For Table References

**Pattern**: Update filepath while preserving table formatting
```markdown
Example:
| `@parameters/rules/template-basic.mdc` | Template for basic planning |
→
| `@parameters/rules/plan-mode/template-basic.mdc` | Template for basic planning |
```

### For Multiple References in a Single Line

**Pattern**: Update each reference individually, preserving existing formatting
```markdown
Example:
Use either `@parameters/rules/template-basic.mdc` or `@parameters/rules/template-advanced.mdc` for planning.
→
Use either `@parameters/rules/plan-mode/template-basic.mdc` or `@parameters/rules/plan-mode/template-advanced.mdc` for planning.
``` 