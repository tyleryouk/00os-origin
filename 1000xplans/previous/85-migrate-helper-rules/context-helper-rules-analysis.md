# Context Analysis: Helper Rules Migration

## Current Helper Rules Structure

The current helper rules are organized in a directory structure under `1000xbrain/parameters/rules/helpers/` with the following subdirectories:

- `analysis/`: Tools for analyzing codebase and requirements
- `implementation/`: Tools for implementing specific patterns
- `recovery/`: Tools for recovering from errors or issues
- `validation/`: Tools for validating implementations
- `verification/`: Tools for verifying implementations
- `finalization/`: Tools for finalizing implementations
- `parameter-management/`: Tools for managing parameters

## Target Structure

Based on the requirements, all helper rules should be migrated to one of the following mode-specific directories:

- `1000xbrain/parameters/rules/plan-mode/`: For helpers used during planning phase
- `1000xbrain/parameters/rules/dev-mode/`: For helpers used during development phase
- `1000xbrain/parameters/rules/direct-mode/`: For helpers used during direct implementation

## Current Mode-Specific Directories Structure

### Plan Mode

The `plan-mode/` directory already contains several templates and specialized planning modes, including:
- Basic and advanced templates
- System-wide planning
- Performance planning
- Error recovery planning
- Workflow enhancement planning (rules-workflow, front-end-workflow)
- Subsystem planning
- Hallucination templates

### Dev Mode

The `dev-mode/` directory contains implementation-focused files, including:
- General implementation strategies
- Continuation strategies
- Error recovery
- Performance optimization
- System-wide implementation
- Subsystem implementation
- Workflow enhancement implementation (rules-workflow, front-end-workflow)

### Direct Mode

The `direct-mode/` directory contains files for immediate implementation, including:
- System-wide direct implementation
- Subsystem direct implementation
- Workflow enhancement direct implementation (rules-workflow, front-end-workflow)

## Sample Helper Rules Content

Examining a few helper rules shows their purpose and functionality:

1. `implementation/context-first-implementation.md`: Focuses on gathering context before implementation
2. `implementation/direct-implementation.md`: Focuses on immediate implementation
3. `recovery/direct-implementation-continuation.md`: Focuses on continuing interrupted direct implementations

## Migration Considerations

When migrating helper rules, we need to consider:

1. **Mode Alignment**: Ensuring each helper is placed in the appropriate mode directory based on its primary function
2. **Naming Consistency**: Adopting consistent naming patterns within each mode directory
3. **Content Updates**: Updating content to reflect mode-specific contexts and requirements
4. **Dependency Management**: Handling any cross-references between files
5. **Documentation**: Updating README files to reflect the new organization

## Context-Specific Considerations

According to the requirements, when using project-rule-parameters in `plan-mode/`, the context is expected to include:
- The `1000xbrain/README.md` file
- The current planning folder

This scoped context helps ensure that plan-mode project-rule-parameters focus specifically on creating comprehensive planning folders, without being distracted by implementation details.

## Current Helper Rules Usage

The helper rules are currently used as specialized project-rule-parameters that provide focused functionality for specific tasks. They are referenced using the @-symbol notation in message commands, such as:

```
continue-implementation: @parameters/rules/helpers/recovery/direct-implementation-continuation.mdc
```

After migration, they would be referenced using a path that reflects their mode-specific location:

```
continue-implementation: @parameters/rules/dev-mode/direct-implementation-continuation.mdc
``` 