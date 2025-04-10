rules-workflow | system-wide

Before creating the rest of the planning-folder-files, **analyze the files within the domain of back-end-workflow**

Your domain to edit:
1000xbrain/knowledge/back-end/
1000xbrain/workflows/back-end/
1000xbrain/parameters/back-end/

*note*
You just started creating this workflow and it is very much incomplete. You need to start on the back-end due to time constrainst so you need to start creating brain-files for this workflow.

Retain the principles of 1000xdevelopment as seen in 1000xbrain/core/identity/global-rules.md. The whole point of these brain-files is to augment development, so that you autonomously create files, make changes to files, delete files, and run tests to verify API development.

Each planning process will start with the following files and folders loaded into the Context Pills:
back-end/README.md planning-folder/

The planning folder and back-end/README.md files will be the ONLY two files in the Conetxt Pills throughout ALL of planning and ALL of development.

The planning folder will start with only one file: a requirements.md file. At the top of this requirements.md file, I will write the workflow (back-end-workflow) and the pathway (i.e. steam-web-api). The format will be:
# [workflow-type] | [pathway-name]

The rest of the requirements.md file will be my explanation of what I want done.

You will read the requirements.md file, make appropriate tool calls to back-end/** , then do the following in order:
1. Update requirements.md file
2. Create context-files or context-file
3. Create implementation-files or implementation-file
4. Create a test-cheatsheet.md file
5. Create a README.md file

For an example of a good planning brain-file, review 1000xbrain/parameters/rules/plan-mode/system-wide.md. For an example of a good development brain-file, review 1000xbrain/parameters/rules/dev-mode/system-wide.md.

For the project-rule-parameters `enhance-planning` and `continue-implementation`, you will start with a read_file tool call for README.md 

You need to be smart about these changes to the folders within the domain. Note that the brain-files within these folders have the following cursor rule-types:
1000xbrain/knowledge/back-end/ -> Agent Requested Rule Type, must use fetch_rules to utilize knowledge-base brain-files, must have # USE WHEN header at the top of the brain-file for syncing purposes.
1000xbrain/workflows/back-end/ -> Auto Attached Rule Type, Auto Attached whenever I load the back-end/README.md file into the Context Pills (I can send a screenshot of the Auot Attached Rules actually being in the Context)
1000xbrain/parameters/back-end/ -> Manual Rule Type, must be explicitly referenced to use


The flow of communication between brain-files should be as follows:
### workflow-files in 1000xbrain/workflows/back-end/
Will be at the forefront of your brain for EVERY chat. Keep details minimal, for we want to abstract as much as possible to the project-rule-parameters and knowledge-base so that you can focus on the actual implementation and planning tasks at hand. The workflow-files should be a total of less than 500 lines. Try to abstract as much of the details to knowledge-base-files and project-rule-parameters. The goal of these workflow-files for back-end-workflow is to engrain the 1000xdevelopment mindset, that you are extremely smart and have all of the tools to truly achieve 1000xdevelopment. You, 1000xdev, are allowed to make any changes and do not need my input. You can focus on tool calls rather than communication with me, because everything will be laid out in the explicit tool call definitions in the project-rule-parameters. You should also have some type of basic overview of back-end/** and GigaSwap marketplace (trading platform for CS2 skins) within the workflow-files.

### knowledge-base-files in 1000xbrain/knowledge/back-end/
Will be utilized by project-rule-parameters only. 

### project-rule-parameters in 1000xbrain/parameters/back-end/
Will utilize knowledge-base-files by explicitly requiring the use of the fetch_rules tool. project-rule-parameters should have explicit tool calls to use. project-rule-parameters will only be loaded into memory when explicitly called.

This structure allows you to focus on the tool calls and iterative process in the project-rule-parameters, making tool calls to knowledge-base-files during the process, and keeping the autonomous mindset from the workflow-files retained in your brain.
