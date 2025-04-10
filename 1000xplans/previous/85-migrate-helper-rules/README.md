# Helper Rules Migration Plan

This planning folder contains documentation for migrating all helper rules from the `1000xbrain/parameters/rules/helpers/` directory to the appropriate mode-specific directories (`plan-mode/`, `dev-mode/`, and `direct-mode/`).

## Purpose

The migration aims to:
1. Organize helper rules based on their mode-specific functionality
2. Make it easier to find and use appropriate project-rule-parameters in each mode
3. Ensure that the context for each mode has access to the relevant helpers
4. Align helper rule usage with the overall mode system
5. Implement standardized pathway headers for better organization and discoverability

## Planning Documents

This folder contains the following planning documents:

| File | Description |
|------|-------------|
| [requirements.md](requirements.md) | Initial requirements for the migration |
| [context-helper-rules-analysis.md](context-helper-rules-analysis.md) | Analysis of the current helper rules structure |
| [context-mode-specific-patterns.md](context-mode-specific-patterns.md) | Analysis of mode-specific patterns and pathway organization |
| [helpers-inventory-and-mapping.md](helpers-inventory-and-mapping.md) | Complete inventory and migration mapping with pathway assignments |
| [implementation-migration-plan.md](implementation-migration-plan.md) | Implementation plan for the migration |
| [test-cheatsheet.md](test-cheatsheet.md) | Testing scenarios to verify successful migration |

## Implementation Overview

The migration will follow a phased approach:

1. **Analysis Phase**: Complete inventory and categorization of all helper rules
2. **Migration Phase**: Move and update each helper rule to its appropriate mode directory
3. **Verification Phase**: Verify all migrations were successful and update references
4. **Documentation Phase**: Update README files to reflect the new organization

## Standardized Pathway Header System

A key improvement in this migration is the implementation of standardized pathway headers for all project-rule-parameter files. Each file will have a header in this format:

```
# Workflow: [workflow-type] | Pathway: [pathway-name]
```

For example:
```
# Workflow: rules-workflow | Pathway: system-wide
```

For native project-rule-parameters that don't belong to a specific pathway:
```
# Workflow: rules-workflow | Pathway: native
```

This header system provides several benefits:
1. Makes it clear which workflow and pathway a file belongs to
2. Allows easy parsing by automation scripts
3. Creates a self-documenting system that's intuitive even with no prior knowledge
4. Enables automatic grouping by either workflow type or pathway
5. Simplifies documentation generation

## Migration Mapping Summary

Helper rules will be migrated based on their primary function:

- **Plan Mode**: Analysis helpers, verification planning helpers, parameter management helpers
  - Pathways: analysis, verification, parameter-management
- **Dev Mode**: Implementation helpers (except direct implementation), recovery helpers (except direct implementation continuation), validation helpers, finalization helpers
  - Pathways: implementation, recovery, validation, finalization
- **Direct Mode**: Direct implementation helpers, direct implementation continuation helpers
  - Pathways: implementation, recovery

## Next Steps

1. Complete the detailed inventory of all helper rules
2. Implement the migration according to the implementation plan
3. Verify the migration using the test cheatsheet
4. Update all related documentation and references 