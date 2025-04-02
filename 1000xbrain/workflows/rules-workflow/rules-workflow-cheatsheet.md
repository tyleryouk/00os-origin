# RULES-Workflow Cheatsheet

## PLAN-MODE project-rule-parameters

| project-rule-parameter | message-command | standard-parameters |
|------------------------|-----------------|---------------------|
| `@parameters/rules/plan-mode/continue-planning.mdc` | continue-planning | none |
| `@parameters/rules/plan-mode/plan-mode-error-recovery.mdc` | plan-mode | workflow-type |
| `@parameters/rules/plan-mode/plan-mode-front-end-workflow-enhancement.mdc` | plan-mode | workflow-type |
| `@parameters/rules/plan-mode/plan-mode-performance.mdc` | plan-mode | workflow-type |
| `@parameters/rules/plan-mode/plan-mode-rules-workflow-enhancement.mdc` | plan-mode | workflow-type |
| `@parameters/rules/plan-mode/plan-mode-subsystem.mdc` | plan-mode | workflow-type |
| `@parameters/rules/plan-mode/plan-mode-system-wide.mdc` | plan-mode | workflow-type |
| `@parameters/rules/plan-mode/template-advanced.mdc` | create-template | workflow-type |
| `@parameters/rules/plan-mode/template-basic.mdc` | create-template | workflow-type |
| `@parameters/rules/plan-mode/template-past-chat-hallucination.mdc` | create-template | workflow-type, folder-type, project-rule-parameter |
| `@parameters/rules/plan-mode/template-standard-hallucination.mdc` | create-template | workflow-type |

## DEV-MODE project-rule-parameters

| project-rule-parameter | message-command | standard-parameters |
|------------------------|-----------------|---------------------|
| `@parameters/rules/dev-mode/dev-mode-error-recovery.mdc` | dev-mode | workflow-type |
| `@parameters/rules/dev-mode/dev-mode-front-end-workflow-enhancement.mdc` | dev-mode | workflow-type |
| `@parameters/rules/dev-mode/dev-mode-performance.mdc` | dev-mode | workflow-type |
| `@parameters/rules/dev-mode/dev-mode-rules-workflow-enhancement.mdc` | parameter | none |
| `@parameters/rules/dev-mode/dev-mode-subsystem.mdc` | dev-mode | workflow-type |
| `@parameters/rules/dev-mode/dev-mode-system-wide.mdc` | dev-mode | rules-workflow |

## DIRECT-MODE project-rule-parameters

| project-rule-parameter | message-command | standard-parameters |
|------------------------|-----------------|---------------------|
| `@parameters/rules/direct-mode/direct-mode-front-end-workflow-enhancement.mdc` | direct-mode | workflow-type |
| `@parameters/rules/direct-mode/direct-mode-rules-workflow-enhancement.mdc` | parameter | none |
| `@parameters/rules/direct-mode/direct-mode-subsystem.mdc` | direct-mode | workflow-type |
| `@parameters/rules/direct-mode/direct-mode-system-wide.mdc` | direct-mode | workflow-type |

## CONTINUATION project-rule-parameters

| project-rule-parameter | message-command | standard-parameters |
|------------------------|-----------------|---------------------|
| `@parameters/rules/continuation/continue-implementation.mdc` | continue-implementation | none |
| `@parameters/rules/continuation/continue-implementation-error-recovery.mdc` | continue-implementation | none |
| `@parameters/rules/continuation/continue-implementation-front-end-workflow-enhancement.mdc` | continue-implementation | none |
| `@parameters/rules/continuation/continue-implementation-performance.mdc` | continue-implementation | none |
| `@parameters/rules/continuation/continue-implementation-rules-workflow-enhancement.mdc` | continue-implementation | none |
| `@parameters/rules/continuation/continue-implementation-subsystem.mdc` | continue-implementation | none |
| `@parameters/rules/continuation/continue-implementation-system-wide.mdc` | continue-implementation | none |

## HELPERS project-rule-parameters


### ANALYSIS Commands

| project-rule-parameter | message-command |
|------------------------|-----------------|
| `@parameters/rules/helpers/analysis/analyze-related-rules.mdc` | analyze-related-rules |
| `@parameters/rules/helpers/analysis/audit-project-rules.mdc` | audit-project-rules |
| `@parameters/rules/helpers/analysis/scan-message-commands.mdc` | scan-message-commands |
| `@parameters/rules/helpers/analysis/scan-symbol-usage.mdc` | scan-symbol-usage |

### FINALIZATION Commands

| project-rule-parameter | message-command |
|------------------------|-----------------|
| `@parameters/rules/helpers/finalization/enhance-planning.mdc` | enhance-planning |
| `@parameters/rules/helpers/finalization/enhance-requirements.mdc` | enhance-requirements |
| `@parameters/rules/helpers/finalization/finalize-implementation.mdc` | finalize-implementation |

### IMPLEMENTATION Commands

| project-rule-parameter | message-command |
|------------------------|-----------------|
| `@parameters/rules/helpers/implementation/context-first-implementation.mdc` | context-first-implementation |
| `@parameters/rules/helpers/implementation/direct-implementation.mdc` | direct-implementation |

### PARAMETER-MANAGEMENT Commands

| project-rule-parameter | message-command |
|------------------------|-----------------|
| `@parameters/rules/helpers/parameter-management/create-rules-parameter.mdc` | create-rules-parameter |
| `@parameters/rules/helpers/parameter-management/cross-workflow-parameter-manager.mdc` | cross-workflow-parameter-manager |
| `@parameters/rules/helpers/parameter-management/parameter-manager.mdc` | parameter-manager |
| `@parameters/rules/helpers/parameter-management/parameter-manager-unified.mdc` | parameter-manager-unified |
| `@parameters/rules/helpers/parameter-management/remove-rules-parameter.mdc` | remove-rules-parameter |
| `@parameters/rules/helpers/parameter-management/update-rules-parameter.mdc` | update-rules-parameter |

### RECOVERY Commands

| project-rule-parameter | message-command |
|------------------------|-----------------|
| `@parameters/rules/helpers/recovery/direct-implementation-continuation.mdc` | direct-implementation-continuation |

### VALIDATION Commands

| project-rule-parameter | message-command |
|------------------------|-----------------|
| `@parameters/rules/helpers/validation/check-extension-format.mdc` | check-extension-format |
| `@parameters/rules/helpers/validation/check-references.mdc` | check-references |
| `@parameters/rules/helpers/validation/validate-changes.mdc` | validate-changes |
| `@parameters/rules/helpers/validation/validate-path-format.mdc` | validate-path-format |

### VERIFICATION Commands

| project-rule-parameter | message-command |
|------------------------|-----------------|
| `@parameters/rules/helpers/verification/verify-backtick-wrapping.mdc` | verify-backtick-wrapping |
| `@parameters/rules/helpers/verification/verify-context-files.mdc` | verify-context-files |
| `@parameters/rules/helpers/verification/verify-implementation.mdc` | verify-implementation |
| `@parameters/rules/helpers/verification/verify-readme-headers.mdc` | verify-readme-headers |

