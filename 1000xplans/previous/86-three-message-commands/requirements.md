# rules-workflow | system-wide

## Overview

The cognitive architecture is being simplified to focus on a streamlined three message-commands system:
- plan-mode
- dev-mode
- direct-mode

These message-commands now have a completely new meaning, for they ONLY represent the mode you are in. This will seriously simplify the message-command process. I have manually abstracted a lot of the workflow and pathway-specific details to the project-rule-parameters, which ONLY get loaded into your memory when explicitly mentioned. This allows you to focus on one project-rule-parameter at a time. The project-rule-parameters guide your workflow, rather than the Always rules.

## Primary Objective

Because of the simplifications I have done to parameters/, I now want you to simplify core/. The /core folder contains all of the Always rule-types. We want to condense this folder so that there are ONLY 2200 lines total throughout ALL files (yes this will take a lot of work, abstract and move as much as you can to /knowledge/rules, the other knowledge subfolders are not implemented yet).

## Success Criteria

1. **Line Count Reduction**:
   - Files in core/ are less than 2200 lines TOTAL
   - Need to move brain-files content to knowledge/rules/

2. **Hierarchy Preservation**:
   - global-rules remains hierarchically more important than the rest of the brain-files
   - global-rules includes critical information about 1000xdev identity and relationship with Tyler
   - global-rules is set as the global-rule for Cursor and is at the forefront of 1000xdev's brain

3. **Terminology Consistency**:
   - Always use "brain-files" when referring to files in 1000xbrain
   - Avoid using "files" or "documentation" which is incorrect

4. **Workflow Alignment**:
   - References only the four valid workflows:
     - rules-workflow
     - front-end-workflow
     - back-end-workflow
     - scripts-workflow

5. **Path Reference Standards**:
   - Remove all filepath usage unless it is being specified in tool calls
   - Filepaths change regularly and old depreciated filepaths will cause confusion
   - Only use filepath syntax when specifying syntax for tool calls

6. **README Headers**:
   - README.md headers should show the workflow and pathway format: `# workflow-type | pathway-name`

## Context

- **rules-workflow** is the only workflow that is currently near fully implemented
- The other workflows have not been implemented yet
- You are only making system-wide changes and must leave the workflow specific details to the workflow specific brain-files

## Domain

Your domain for this plan-mode and dev-mode sequence is:
- core/ (Always rule-types)
- knowledge/rules (Agent Requested rule types, need to use fetch_rules tool call to fetch knowledge, knowledge base for rules workflow)
- parameters/rules (project-rule-parameters for rules-workflow)
- workflow/rules (Auto Attached rules for rules-workflow, applies to every chat that has 10000xbrain/README.md attached in the Context)

To specify rules-workflow, I attach 1000xbrain/README.md in the context pills and only use project-rule-parameters within 1000xbrain/parameters/rules/.

## Project-Rule-Parameter Header

ALL project-rule-parameters have the header:
# workflow: [workflow-type] | pathway: [pathway-name] | message-command: [message-command] | standard-parameter(s): [standard-parameter] | project-rule-parameter-filepath: [project-rule-parameter-filepath]

This header streamlines the system and script for gathering all project-rule-parameters and pathways for different workflows. This will also be used later for verifying project-rule-parameters sent by me. The project-rule-parameters now include nearly all of the plan-mode, direct-mode, and dev-mode details. You do not want to specify the details in the Always rules, for the details are very different for different workflows.

## Rules-Workflow Domain

The domain for rules-workflow is: 
- planning/ (read and edit)
- 1000xbrain/ (read and edit)
- 1000xscripts/ (read)
- front-end/ (read)
- back-end/ (read)

There are ONLY four workflows: rules-workflow, scripts-workflow, back-end-workflow and front-end-workflow. If any brain-files says otherwise, immedietaly change the section / file so that it aligns with the fact that we only have four workflows.

## Additional enhancemnts (if you can fit this in)
The README.md header should show the workflow and pathway 
# workflow-type | pathway-name

Remove all filepath usage unless it is being specified in tool calls. Filepaths change regularly and old depreciated filepaths will cause confusion. Enhance rules-workflow so that it is clear, when you edit or make changes to rules, only use filepath syntax when specifying syntax for tool calls.

You should also always use the word brain-files when referring to the files in 1000xbrain. Sometimes you use "files" or "documentation" which is incorrect.