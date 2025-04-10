## rules-workflow | rules-workflow-enhancement


I want to migrate all helper rules to one of the following folders
dev-mode/
direct-mode/
plan-mode/

This is so that while I am in plan-mode, I have an arsenal of project-rule-parameters that I can use to create the best possible planning folder. Same applies for dev-mode and direct-mode. This also makes it easier for alignment so that the proejct-rule-parameters in plan-mode/ align with the overarching goals of plan-mode.


This also makes it easier to understand what you should expect for the project-rule-parameters in plan-mode/. Since you are only working in the planning folder, you should expect the file 1000xbrain/README.md and the planning folder to be loaded into the Context, which is your only context for the plan-mode project-rule-parameters. Having the 1000xbrain/README.md file in the context auto attaches the cursor rules for rules-workflow.

If the helper message-command is associated with a specific pathway, the pathway should be specified clearer in a header so that when we create/update scripts, we can easily pull all project-rule-parameters and group them by the pathway they are in.

Example of pathway:
All project-rule-parameters for pathway `system-wide`
plan-mode-system-wide.mdc
template-advanced.mdc
direct-mode-system-wide.mdc
dev-mode-system-wide.mdc
continue-implementation-system-wide.mdc
scan-message-commands.mdc
scan-symbol-usage.mdc

Example of solution:
Each project-rule-parameter file should have a standardized header in this format:
```
# Workflow: [workflow-type] | Pathway: [pathway-name]
```

Where both [workflow-type] and [pathway-name] MUST be in lower-case kebab-case format (words separated by hyphens, all lowercase).

For example:
```
# Workflow: rules-workflow | Pathway: system-wide
```

For native/global project-rule-parameters that don't belong to a specific pathway:
```
# Workflow: rules-workflow | Pathway: native
```

IMPORTANT: EVERY project-rule-parameter in rules-workflow MUST have this standardized header, with no exceptions. This is critical for automated processing and organization.

A `pathway` is like a workflow within a workflow

This standardized header format will:
1. Make it clear which workflow and pathway a file belongs to
2. Allow easy parsing by automation scripts
3. Create a self-documenting system that's intuitive even with no prior knowledge
4. Enable automatic grouping by either workflow type or pathway
5. Simplify documentation generation

There are also some native project-rule-parameters like:
enhance-planning.mdc
enhance-requirements.mdc
