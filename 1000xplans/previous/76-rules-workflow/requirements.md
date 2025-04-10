rules-workflow | subsystem enhancements for rules-workflow 
1000xbrain/workflows/rules-workflow
1000xbrain/parameters/rules


**Enhance the rules-workflow project-rule-parameter system:**

### Idea 1: Create new project-rule-parameters for rules-workflow
Create a project-rule-parameter for rules-workflow to specifically enhance front-end-workflow. This should include tool calls to relevant files within front-end/**. This rules-workflow pathway should open up your domain to read files in front-end/ while still only making changes to files in 1000xbrain.

### Idea 2: Sort planning folder project-rule-parameters into three categories:
plan-mode (core + helpers)
dev-mode (core + helpers)
no-planning-folder (new mode)

1000xbrain/parameters/rules should have three subfolders for plan-mode, dev-mode, and no-planning-folder

**Context**
Core plan-mode project-rule-parameters should start with `plan-mode-{feature}`
Core dev-mode project-rule-parameters should start with `dev-mode-{feature}`
Classify continue-planning and it's project rule parameters as a helper plan-mode project-rule-parameter
Classify continue-implementation and it's project rule parameters as a helper dev-mode project-rule-parameter
Enhance the message-command system

### Idea 3: Create new mode for no-planning-folder
Convert no-planning-folder (in message-command-references) to a new mode, so you now have three modes. You should intelligently decide on the mode name (e.g. `direct-mode` `no-plan-mode` `quick-mode`). This mode will have no planning folder and will come in the syntax:
no-planning-folder: workflow-type @optional-project-rule-parameter.mdc 
prompt:

This is a new type of message-command where `prompt` will be explicitly written after the optional project-rule-parameter. You must read the prompt as a regular message and conduct research. In this mode, you should iterate on the process: research -> make changes -> research -> make changes




### Idea 4: Header to indicate workflow and pathway in first header of README.md
At the top of every README.md in rules-workflow, there should be some type of header like:
## project-rule-parameters for this planning folder
continue-implementation: rules-workflow @parameters/rules/continue-implementation-performance.mdc 
dev-mode: rules-workflow @parameters/rules/dev-mode-performance.mdc 
dev-mode: rules-workflow @parameters/rules/plan-mode-performance.mdc 

It can also look like this (snippet of cheatsheet):
## | project-rule-parameter | message-command | standard-parameters |
| project-rule-parameter | message-command | standard-parameters |
|------------------------|-----------------|---------------------|
| `@parameters/rules/plan-mode-error-recovery.mdc` | plan-mode | workflow-type |
| `@parameters/rules/plan-mode-performance.mdc` | plan-mode | workflow-type |
| `@parameters/rules/plan-mode-subsystem.mdc` | plan-mode | workflow-type |
| `@parameters/rules/plan-mode-system-wide.mdc` | plan-mode | workflow-type |
| `@parameters/rules/dev-mode-error-recovery.mdc` | dev-mode | workflow-type |
| `@parameters/rules/dev-mode-performance.mdc` | dev-mode | workflow-type |
| `@parameters/rules/dev-mode-subsystem.mdc` | dev-mode | workflow-type |
| `@parameters/rules/dev-mode-system-wide.mdc` | dev-mode | rules-workflow |
| `@parameters/rules/continue-planning.mdc` | continue-planning | none |
| `@parameters/rules/continue-implementation.mdc` | continue-implementation | none |
| `@parameters/rules/continue-implementation-error-recovery.mdc` | continue-implementation | none |
| `@parameters/rules/continue-implementation-performance.mdc` | continue-implementation | none |
| `@parameters/rules/continue-implementation-subsystem.mdc` | continue-implementation | none |
| `@parameters/rules/continue-implementation-system-wide.mdc` | continue-implementation | none |
| `@parameters/rules/template-advanced.mdc` | create-template | workflow-type |
| `@parameters/rules/template-basic.mdc` | create-template | workflow-type |
| `@parameters/rules/template-past-chat-hallucination.mdc` | create-template | workflow-type, folder-type, project-rule-parameter |
| `@parameters/rules/template-standard-hallucination.mdc` | create-template | workflow-type |

Or
## workflow and pathway
rules workflow | subsystem

This header section in the README.md of all rules-workflow planning folders is so that it is clear to everyone that you are in rules-workflow and what type of pathway we are in if we have chosen a pathway like system-wide or subsystem. This will also help you for continue-implementation etc. I would prefer that you don't use any of the examples above and create your own header and content for your readibility, so it's easy to understand what project-rule-parameters to expect with plan-mode, dev-mode, continue-implementation, and continue-planning.

### Question for 1000xdev
I have not really used these helper message-commands yet. Are these supposed to be one-off message-commands (I notice that they do not have rules-workflow as a standard parameter). Are they supposed to be used outside of rules-workflow or within rules-workflow, because they are grouped within the other rules-workflow project-rule-parameters. 

If these helper message-commands and project-rule-parameters can only be used at certain stages of plan-mode and dev-mode, this needs to be stated. If they are strictly one-offs, I need to know when I can use them (empty planning folder, after implementation, no planning folder, etc)

I want to optimize the usage of some of these helper message-commands, but need you to intelligently analyze the current state of 1000xbrain and how to best utilize these rules-workflow helper message-commands. The more strict, the better.

# RULES-Workflow Cheatsheet

## Core Message-Commands

| project-rule-parameter | message-command | standard-parameters |
|------------------------|-----------------|---------------------|
| `@parameters/rules/plan-mode-error-recovery.mdc` | plan-mode | workflow-type |
| `@parameters/rules/plan-mode-performance.mdc` | plan-mode | workflow-type |
| `@parameters/rules/plan-mode-subsystem.mdc` | plan-mode | workflow-type |
| `@parameters/rules/plan-mode-system-wide.mdc` | plan-mode | workflow-type |
| `@parameters/rules/dev-mode-error-recovery.mdc` | dev-mode | workflow-type |
| `@parameters/rules/dev-mode-performance.mdc` | dev-mode | workflow-type |
| `@parameters/rules/dev-mode-subsystem.mdc` | dev-mode | workflow-type |
| `@parameters/rules/dev-mode-system-wide.mdc` | dev-mode | rules-workflow |
| `@parameters/rules/continue-planning.mdc` | continue-planning | none |
| `@parameters/rules/continue-implementation.mdc` | continue-implementation | none |
| `@parameters/rules/continue-implementation-error-recovery.mdc` | continue-implementation | none |
| `@parameters/rules/continue-implementation-performance.mdc` | continue-implementation | none |
| `@parameters/rules/continue-implementation-subsystem.mdc` | continue-implementation | none |
| `@parameters/rules/continue-implementation-system-wide.mdc` | continue-implementation | none |
| `@parameters/rules/template-advanced.mdc` | create-template | workflow-type |
| `@parameters/rules/template-basic.mdc` | create-template | workflow-type |
| `@parameters/rules/template-past-chat-hallucination.mdc` | create-template | workflow-type, folder-type, project-rule-parameter |
| `@parameters/rules/template-standard-hallucination.mdc` | create-template | workflow-type |

## Helper Message-Commands

| project-rule-parameter | message-command |
|------------------------|-----------------|
| `@parameters/rules/analyze-related-rules.mdc` | analyze-related-rules |
| `@parameters/rules/audit-project-rules.mdc` | audit-project-rules |
| `@parameters/rules/check-extension-format.mdc` | check-extension-format |
| `@parameters/rules/check-references.mdc` | check-references |
| `@parameters/rules/context-first-implementation.mdc` | context-first-implementation |
| `@parameters/rules/direct-implementation.mdc` | direct-implementation |
| `@parameters/rules/direct-implementation-continuation.mdc` | direct-implementation-continuation |
| `@parameters/rules/finalize-implementation.mdc` | finalize-implementation |
| `@parameters/rules/scan-message-commands.mdc` | scan-message-commands |
| `@parameters/rules/scan-symbol-usage.mdc` | scan-symbol-usage |
| `@parameters/rules/validate-changes.mdc` | validate-changes |
| `@parameters/rules/validate-path-format.mdc` | validate-path-format |
| `@parameters/rules/verify-backtick-wrapping.mdc` | verify-backtick-wrapping |
| `@parameters/rules/verify-context-files.mdc` | verify-context-files |
| `@parameters/rules/verify-implementation.mdc` | verify-implementation |


### **Important Notes**
THESE ARE ALL IDEAS. TAKE THE BEST IDEAS AND OPTIMIZE. YOU DO NOT NEED TO DO EVERYTHING VERBATIM. 

REMEMBER, WE WANT THE CHANGES TO BE SIMPLE SO THAT EVERY TIME YOUR MEMORY IS RESET IT IS VERY EASY TO JUMP BACK IN AND START PLANNING OR IMPLEMENTING FOR THE WORKFLOW-TYPE RULES-WORKFLOW