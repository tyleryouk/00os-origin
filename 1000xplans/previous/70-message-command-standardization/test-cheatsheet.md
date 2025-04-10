# Message Command System Enhanced Test Cheatsheet

## Core Message-Commands

### create-template

#### Parameter Patterns

**Pattern 1: Basic Template Creation**
- **Required Parameters:**
  1. `workflow-type` (standard)
- **Example:** `create-template: rules-workflow @template-basic.mdc`

**Pattern 2: Advanced Template Creation**
- **Required Parameters:**
  1. `workflow-type` (standard)
  2. `folder-type` (standard)
  3. `project-rule-parameter` (standard)
- **Example:** `create-template: rules-workflow @past-chat-folder @planning-folder @template-past-chat-hallucination.mdc`

#### Project-Rule-Parameter Call Patterns

Each project-rule-parameter has exactly ONE valid call pattern:

| Parameter | Valid Call Pattern |
|-----------|-------------------|
| `@template-basic.mdc` | `create-template: rules-workflow @template-basic.mdc` |
| `@template-advanced.mdc` | `create-template: rules-workflow @template-advanced.mdc` |
| `@template-past-chat-hallucination.mdc` | `create-template: rules-workflow @past-chat-folder @planning-folder @template-past-chat-hallucination.mdc` |
| `@template-standard-hallucination.mdc` | `create-template: rules-workflow @standard-hallucination-folder @template-standard-hallucination.mdc` |

#### Compatible Project-Rule-Parameters

| Parameter | Description | Loyal To |
|-----------|-------------|---------|
| `@template-basic.mdc` | Basic template creation | `create-template` |
| `@template-advanced.mdc` | Advanced features template | `create-template` |
| `@template-past-chat-hallucination.mdc` | Chat-based template | `create-template` |
| `@template-standard-hallucination.mdc` | Standard hallucination template | `create-template` |

### dev-mode

#### Parameter Patterns

**Pattern 1: Standard Development Mode**
- **Required Parameters:**
  1. `workflow-type` (standard)
- **Example:** `dev-mode: rules-workflow @dev-mode-system-wide.mdc`

#### Project-Rule-Parameter Call Patterns

Each project-rule-parameter has exactly ONE valid call pattern:

| Parameter | Valid Call Pattern |
|-----------|-------------------|
| `@dev-mode-system-wide.mdc` | `dev-mode: rules-workflow @dev-mode-system-wide.mdc` |
| `@dev-mode-subsystem.mdc` | `dev-mode: rules-workflow @dev-mode-subsystem.mdc` |
| `@dev-mode-performance.mdc` | `dev-mode: rules-workflow @dev-mode-performance.mdc` |
| `@dev-mode-error-recovery.mdc` | `dev-mode: rules-workflow @dev-mode-error-recovery.mdc` |

#### Compatible Project-Rule-Parameters

| Parameter | Description | Loyal To |
|-----------|-------------|---------|
| `@dev-mode-system-wide.mdc` | System-wide implementation | `dev-mode` |
| `@dev-mode-subsystem.mdc` | Subsystem-focused implementation | `dev-mode` |
| `@dev-mode-performance.mdc` | Performance optimization | `dev-mode` |
| `@dev-mode-error-recovery.mdc` | Error recovery implementation | `dev-mode` |

### continue-implementation

#### Parameter Patterns

**Pattern 1: Basic Continuation**
- **Required Parameters:** None
- **Example:** `continue-implementation: @continue-implementation-system-wide.mdc`

**Pattern 2: Recovery Point Continuation**
- **Required Parameters:**
  1. `recovery-point` (standard)
- **Example:** `continue-implementation: recovery-point @continue-implementation-system-wide.mdc`

#### Project-Rule-Parameter Call Patterns

Each project-rule-parameter has exactly ONE valid call pattern:

| Parameter | Valid Call Pattern |
|-----------|-------------------|
| `@continue-implementation-system-wide.mdc` | `continue-implementation: @continue-implementation-system-wide.mdc` |
| `@continue-implementation-subsystem.mdc` | `continue-implementation: @continue-implementation-subsystem.mdc` |
| `@continue-implementation-performance.mdc` | `continue-implementation: @continue-implementation-performance.mdc` |
| `@continue-implementation-error-recovery.mdc` | `continue-implementation: recovery-point @continue-implementation-error-recovery.mdc` |

#### Compatible Project-Rule-Parameters

| Parameter | Description | Loyal To |
|-----------|-------------|---------|
| `@continue-implementation-system-wide.mdc` | Continue system-wide implementation | `continue-implementation` |
| `@continue-implementation-subsystem.mdc` | Continue subsystem implementation | `continue-implementation` |
| `@continue-implementation-performance.mdc` | Continue performance optimization | `continue-implementation` |
| `@continue-implementation-error-recovery.mdc` | Continue error recovery | `continue-implementation` |

## Helper Message-Commands

### analyze-related-rules

#### Parameter Patterns

**Pattern 1: Basic Analysis**
- **Required Parameters:**
  1. `workflow-type` (standard)
- **Example:** `analyze-related-rules: rules-workflow @analyze-system-wide.mdc`

#### Project-Rule-Parameter Call Patterns

Each project-rule-parameter has exactly ONE valid call pattern:

| Parameter | Valid Call Pattern |
|-----------|-------------------|
| `@analyze-system-wide.mdc` | `analyze-related-rules: rules-workflow @analyze-system-wide.mdc` |

#### Compatible Project-Rule-Parameters

| Parameter | Description | Loyal To |
|-----------|-------------|---------|
| `@analyze-system-wide.mdc` | System-wide rule analysis | `analyze-related-rules` |

### audit-project-rules

#### Parameter Patterns

**Pattern 1: Basic Audit**
- **Required Parameters:** None
- **Example:** `audit-project-rules: @audit-system-wide.mdc`

#### Project-Rule-Parameter Call Patterns

Each project-rule-parameter has exactly ONE valid call pattern:

| Parameter | Valid Call Pattern |
|-----------|-------------------|
| `@audit-system-wide.mdc` | `audit-project-rules: @audit-system-wide.mdc` |

#### Compatible Project-Rule-Parameters

| Parameter | Description | Loyal To |
|-----------|-------------|---------|
| `@audit-system-wide.mdc` | System-wide rule audit | `audit-project-rules` |

## Parameter Reference

### Standard Parameters

| Parameter | Used By |
|-----------|---------|
| `workflow-type` | `plan-mode`, `dev-mode`, `create-template`, `analyze-related-rules` |
| `folder-type` | `create-template` |
| `project-rule-parameter` | `create-template` |
| `recovery-point` | `continue-implementation` |

### Project-Rule-Parameter Loyalty and Call Patterns

Each project-rule-parameter (e.g., `@parameter.mdc`) has:
1. Exactly one message-command it can be used with (loyalty)
2. Exactly one specific combination of standard-parameters (call pattern)
3. Documentation of its exact usage pattern

| Parameter Pattern | Loyal To | Call Pattern Example |
|------------------|---------|----------------------|
| `@plan-mode-*.mdc` | `plan-mode` | `plan-mode: rules-workflow @plan-mode-system-wide.mdc` |
| `@dev-mode-*.mdc` | `dev-mode` | `dev-mode: rules-workflow @dev-mode-system-wide.mdc` |
| `@continue-planning-*.mdc` | `continue-planning` | `continue-planning: @continue-planning.mdc` |
| `@continue-implementation-*.mdc` | `continue-implementation` | `continue-implementation: @continue-implementation-system-wide.mdc` |
| `@template-*.mdc` | `create-template` | `create-template: rules-workflow @template-basic.mdc` |
| `@analyze-*.mdc` | `analyze-related-rules` | `analyze-related-rules: rules-workflow @analyze-system-wide.mdc` |
| `@audit-*.mdc` | `audit-project-rules` | `audit-project-rules: @audit-system-wide.mdc` |

## Call Pattern Validation

### Testing Call Pattern Validity

```powershell
# Test specific call pattern for a project-rule-parameter
Test-CallPattern -Command "dev-mode: rules-workflow @dev-mode-system-wide.mdc" -ProjectRuleParameter "@dev-mode-system-wide.mdc"
# Should return: Valid = True

# Test invalid call pattern
Test-CallPattern -Command "dev-mode: front-end-workflow @dev-mode-system-wide.mdc" -ProjectRuleParameter "@dev-mode-system-wide.mdc"
# Should return: Valid = False, Error = "Standard parameter mismatch at position 0: Expected 'rules-workflow', found 'front-end-workflow'"

# Test wrong message-command
Test-CallPattern -Command "continue-implementation: @dev-mode-system-wide.mdc" -ProjectRuleParameter "@dev-mode-system-wide.mdc"
# Should return: Valid = False, Error = "Message-command mismatch: Expected 'dev-mode', found 'continue-implementation'"
```

### Project-Rule-Parameter File Format

Each project-rule-parameter file must include these sections:

```markdown
## Project Rule Parameter

Loyal to: dev-mode: @parameters/rules/dev-mode-system-wide.mdc

## Call Pattern

Message-Command: dev-mode
Standard-Parameters: rules-workflow
Example: `dev-mode: rules-workflow @dev-mode-system-wide.mdc`
```

## Migration Notes

### Previously Shared Parameters

The following parameters were previously shared and now have dedicated alternatives with strict call patterns:

1. **Shared Parameter**: `@dev-mode-system-wide.mdc`
   - **Previously Used By**: `dev-mode`, `continue-implementation`
   - **Now Used Only By**: `dev-mode` with call pattern `dev-mode: rules-workflow @dev-mode-system-wide.mdc`
   - **Alternative for** `continue-implementation`: `@continue-implementation-system-wide.mdc` with call pattern `continue-implementation: @continue-implementation-system-wide.mdc`

2. **Shared Parameter**: `@dev-mode-subsystem.mdc`
   - **Previously Used By**: `dev-mode`, `continue-implementation`
   - **Now Used Only By**: `dev-mode` with call pattern `dev-mode: rules-workflow @dev-mode-subsystem.mdc`
   - **Alternative for** `continue-implementation`: `@continue-implementation-subsystem.mdc` with call pattern `continue-implementation: @continue-implementation-subsystem.mdc`

3. **Shared Parameter**: `@dev-mode-performance.mdc`
   - **Previously Used By**: `dev-mode`, `continue-implementation`
   - **Now Used Only By**: `dev-mode` with call pattern `dev-mode: rules-workflow @dev-mode-performance.mdc`
   - **Alternative for** `continue-implementation`: `@continue-implementation-performance.mdc` with call pattern `continue-implementation: @continue-implementation-performance.mdc`

4. **Shared Parameter**: `@dev-mode-error-recovery.mdc`
   - **Previously Used By**: `dev-mode`, `continue-implementation`
   - **Now Used Only By**: `dev-mode` with call pattern `dev-mode: rules-workflow @dev-mode-error-recovery.mdc`
   - **Alternative for** `continue-implementation`: `@continue-implementation-error-recovery.mdc` with call pattern `continue-implementation: recovery-point @continue-implementation-error-recovery.mdc` 