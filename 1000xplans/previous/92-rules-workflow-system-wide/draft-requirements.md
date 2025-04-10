rules workflow | system-wide

**This is a rough draft, enhanced version is in enhanced-requirements.md**
**Make changes to enhanced-requirements.md, this file is for the inital rough draft**

This is a full cleanse and re-implementation of 1000xbrain. You will complete ALL of the four steps below throughout this planning process. I will keep sending `plan-mode: rules-workflow system-wide @parameters/rules/plan-mode/system-wide.mdc`
1. Create a plan to create a new rules-workflow pathway called system-wide-optimization that will be reusable and will ensure that the 1000xbrain brain-files align with the requirements below. You will also intelligently analyze for ways to optimize files through de-cluttering and enhancing the overall strucure and cross-communication between brain-files.
**the context-files and implementation-files to create a new rules-workflow pathway should be in this planning folder**
Do not make any changes to this requirements.md file.
**NOTE: you are in rules-workflow | system-wide for this planning folder 92-rules-workflow-system-wide**
project-rule-parameters to create:
`1000xbrain/parameters/rules/plan-mode/system-wide-optimization.md`
header: # workflow: rules-workflow | pathway: system-wide-optimization | message-command: plan-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/plan-mode/system-wide-optimization.mdc
`1000xbrain/parameters/rules/dev-mode/system-wide-optimization.md`
header: # workflow: rules-workflow | pathway: system-wide-optimization | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/dev-mode/system-wide-optimization.mdc
(no direct-mode project-rule-parameter for system-wide-optimization)
2. Create a new folder called 93-rules-workflow-system-wide-optimization which will use the new project-rule-parameters within the new rules-workflow pathway. This folder will be part 1 of the full system-wide optimization using the rules-workflow pathway system-wide-optimization. Complete the entire planning folder.
3. Create a new folder called 94-rules-workflow-system-wide-optimization which will use the new project-rule-parameters within the new rules-workflow pathway. This folder will be part 2 of the full system-wide optimization using the rules-workflow pathway system-wide-optimization. Complete the entire planning folder.
4. Create a new folder calls 95-rules-workflow-system-wide-optimization. Create a requirements.md for further enhancements you could make. Only create a requirements.md file.

**note that you are changing the format of message-commands are changing, so you will need to account for this in the planning folders 93 to 95**


# SYSTEM WIDE ENHANCEMENTS

## **core rules that you must know at all times**
You are mainly making changes to 1000xbrain/core/**, for this entire subsystem needs to be enhanced.
1000xbrain has four subsystems, which all work together in harmony. The four subsystem, seperated by subfolder, are `core`, `parameters`, `knowledge` and `workflows`.

### **workflows**
`workflow-type` is the name of the workflow. Each workflow is optimized to make file changes to one folder in the root of the directory and the planning folder. Each workflow-type has a specific domain within the repository, and you are only allowed to edit and read files within the specific domain. The workflow-type and pathway will be specified by the project-rule-parameter AND will also be known by the context in the Context Pills. 

#### **Example of workflow-types within GigaSwap. Do not actually include the workflow-types in the core-brain-files. You want to optimize core-brain-files so that it can handle the addition/deletion/changes of workflows.**
**front-end-workflow**
Domains: front-end/** && planning/**
Context-Pills: front-end/README.md && planning folder in format {n}-workflow-type-pathway-name

**back-end-workflow**
Domains: back-end/** && planning/**
Context-Pills: back-end/README.md && planning folder within planning/** in format {n}-workflow-type-pathway-name

**rules-workflow**
Domains: 1000xbrain/** && planning/**
Context-Pills: 1000xbrain/README.md && planning folder within planning/** in format {n}-workflow-type-pathway-name

**scripts-workflow**
Domains: back-scripts/** && planning/**
Context-Pills: 1000xscripts/README.md && planning folder in format {n}-workflow-type-pathway-name

The root folder README.md of each workflow-type domain is loaded into the Context-Pills to Auto Attach the workflow-files.

*planning/ is a root directory folder that contains planning-folders in the syntax {n}-planning-folders. planning/ also has a cs.md file for me (my domain) and a notes.md file (my domain). There is also a previous/ folder of past planning folders which get deleted every once in a while by me. You do not need to include this information in the core-brain-files unless you feel like it is necessary for your understanding of the planning/ folder. The planning/ folder and the planning-folders are my domain, and I will typically only write the requirements then expect you to complete the rest of the planning folder based on the requirements and project-rule-parameters*

### **common-words**
common-words are lower-case kebab-case words that hold specific meaning and are used for our 1000xdevelopment communication protocol. common-words are outlined for better communication throughout different workflows.
| common-word | meaning | extra notes |
|-------------|---------|-------------|
| brain-file | markdown file within 1000xbrain/ | contains no frontmatter and acts as the editable mirror of the cursor rules that guide your thought process |
| cursor-rule | .mdc cursor rule within .cursor/rules/ | contains frontmatter containing the rule type which is automatically processed during the syncing process |
| core-brain-files | brain-files within 1000xbrain/core/ | Always rule type |
| knowledge-base-files | brain-files within 1000xbrain/knowledge/ | Agent Requested rule type, accessible through explicit fetch_rules tool call instructions in project-rule-parameters |
| knowledge-base | Refers to the subsystem 1000xbrain/knowledge | - |
| project-rule-parameters | brain-files within 1000xbrain/core/ | Manual rule type, explicitly outlines instructions for you to use the fetch_rules tool call to retrieve knowledge-base-files. Also explicitly outlines every other tool call. The structure for 1000xbrain is designed for the instructions within the project-rule-parameter to be at the forefront of your brain, guiding your dev-mode, plan-mode, or direct-mode processes |
| workflow-files | brain-files within 1000xbrain/workflows/ | Auto Attached rule type, auto attached when the README.md of the root folder is attached to the Context Pills. Context Pills will always have the planning folder along with the workflow-domain root README.md |
| workflow-type | name of workflow | - |\
| workflow | autonomous workflow with strict guidelines in 1000xbrain/workflows/ and 1000xbrain/parameters/, utilizing knowledge for 1000xbrain/knowledge/ | - |
| subysystem | Distinct subsystems within 1000xbrain: `core` `knowledge` `parameters` `workflows` | - |
| context-files | Context files within the planning folder |
| implementation-files | implementation files within the planning folder |
| pathway-name | name of pathway within workflow-type |

Please add more common-words that you see frequently used throughout 1000xbrain.

### **message-commands**
Has the format:
mode: workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)

You must parse the message-command every time you retrieve the message-command. You will know the message from me is a message-command because it will ALWAYS start with `dev-mode: ` `plan-mode: `direct-mode: `.
Here is how you will parse the message-command (MANDATORY).  **You must have an error check in place in-case I misspell. You will not interpret anything. View these message-commands as terminal commands, where syntax must be 100% accurate. Rather than the terminal throwing an error, you will respond in the chat with an error-message if the message-command is not 100% accurate.**

1. Ensure `mode` is one of the three modes.
2. Use fetch_rules to read the project-rule-parameter.mdc IN FULL.
3. Ensure the mode, workflow-type and pathway-name accurate align with the HEADER of the project-rule-parameter.mdc. EVERY project-rule-parameter will have the following at the top of the file (first line):


### **modes**
modes:
1. **plan-mode**: Planning Mode (📋)
   - Focus on documentation and planning
   - Indicated by 📋 emoji in responses
   - message-command syntax: 
plan-mode: workflow-type pathway-name 

**mandatory mode-indicator for every response to plan-mode message-command**
📋 1000xdev [workflow-type | pathway-name] 

2. **dev-mode**: Developer Mode (💻)
   - Focus on code implementation and testing
   - Indicated by 💻 emoji in responses
   - Example: `dev-mode: front-end-workflow`
**mandatory mode-indicator for every response to plan-mode message-command**
📋 1000xdev [workflow-type | pathway-name] 

3. **direct-mode**: Direct Mode (⚡)
   - Focus on immediate implementation with research
   - Indicated by ⚡ emoji in responses
   - Example: `direct-mode: back-end-workflow`

**mandatory mode-indicator for every response to direct-mode message-command**
📋 1000xdev [workflow-type | pathway-name] 


For every message-commands, the following should be your context as you autonomously make changes to the planning folder or the workflow-type domain folder.Every message from me will have the following loaded into the Context Pills:
1. planning-folder titled {n}-workflow-type-pathway-name
2. root README.md file of the workflow-type domain folder

Your domain for plan-mode, dev-mode, and direct-mode will be the planning folder attached to the Context Pills and the workflow-type domain.

### **planning folder for plan-mode and dev-mode**
To retain true 1000x development principles (as accurately described in core/ right now), you must ensure that the planning folder process for plan-mode and dev-mode is known in one of the core-brain-files.
### Process for plan-mode and dev-mode
1. I will start the plan-mode process 


### workflow-type guidelines that must be known within core-brain-files
## core
**All markdown files within core are called core-brain-files.**
Directory structure:
core/
|___communication/ (1000xdev communication principles)
|___identity/ (engrains your identity as 1000xdev)
|___modes/ (high-level overview of the modes)

A lot of great information has been abstracted to the knowledge-base-files. Understanding the meaning behind the three other subsystems will help you utilize the knowledge-base-files while retaining a consise, optimize core directory. You should fully understand that large files within core/ slow down your development process and fog your brain with information. You need to adhere to optimization principles so that you can retain clear focus when working with the details of project-rule-parameters.

## knowledge
**All markdown files within knowledge are called knowledge-base-files**
Directory structure:
knowledge/
|___back-end
    |___(workflow-pathway-1)/
    |___(workflow-pathway-2)/
    |___(workflow-pathway-3)/
|___front-end
|___rules
|___scripts

knowledge-base-files are sorted by `workflow-type/pathway-name/knowledge-base-files`

### parameters
**All markdown files within parameters are called project-rule-parameters**
Directory structure:
parameters/
|___back-end
    |___dev-mode
        |___(project-rule-parameter-1)
        |___(project-rule-parameter-2)
        |___(project-rule-parameter-3)
    |___direct-mode
    |___plan-mode
|___front-end
|___rules
|___scripts

project-rule-parameters are sorted by `workflow-type/mode/project-rule-parameters`

### workflow rules that each workflow must follow
Each workflow is named by workflow-type. The four workflows for GigaSwap are:
back-end-workflow
front-end-workflow
rules-workflow
scripts-workflow
Each workflow must ONLY edit the files within its domain.
#### back-end-workflow domain
back-end/**
planning/**
#### front-end-workflow domain
front-end/**
planning/**
#### rules-workflow domain
1000xbrain/**
planning/**
#### scripts-workflow domain
1000xscripts/**
planning/**

Note that each subsystem always has access to read and edit files to planning/**.
Tyler Youk's sole domain is planning/** and will only edit the requirements.md files. This is to retain true 1000x AI Augmented Development.
**At the start of the first plan-mode project-rule-parameter, Tyler Youk will have the planning folder and the root README.md file of the workflow-type domain folder in the Context Pills. The planning folder will only have the requirements.md, either empty or containing requirements by Tyler Youk. This should be clear in core/ so that when you make enhancements to subsystems you know the overarching guidelines for plan-mode. The way you start off plan-mode will dictate how well the implementation goes in dev-mode, so it is very important that you always understand the plan-mode process that is global for all workflows to achieve full 1000x development.**


**Current Issues**
1. The common-word terminology is not known within your brain. The structure of 1000xbrain is not known as well. There are many disrepencies if you read the README.md files.
2. knowledge-base-files are best accessed through explicit calls within the project-rule-parameters, and right now, there are a lot of fetch_rules tool calls within core/ and workflows/ which never get used. You need to enhance the system so that upon the message-command with the project-rule-parameter, you immediately make fetch_rules tool calls to the necessary rules before starting anything. This allows you to only keep the rules necessary for the pathway process, rather than keeping all of the rules at the forefront of your brain for every process. You need to significantly limit the number of fetch_rules tool calls within core/ and workflows/ and increase the number of fetch_rules tool calls within parameters/.
3. README.md files do not get synced, you need to change these README.md files to index.md files. There only needs to be one README.md file in the root, so that rules-workflow Auto Attached rules get automatically attached when I load 1000xbrain/README.md in the Context Pills.
4. There are a LOT of knowledge-base-files with great information that are never being used. You need to enhance the project-rule-parameters to better utilize these great knowledge-base-files.
5. The structure of the Context Pills throughout iterations is not known throughout workflows. There should be some structure so that the workflows align with eachother so that when enhancing one workflow, you can easily reference the structure (there is some knowledge-base-file that outlines the workflow structure, but there are so many knowledge-base-files for the rules-workflow that I can not identify it myself).
6. You need to significantly reduce the number of knowledge-base-files within rules-workflow (knowledge/rules/) and align the knowledge-base-files with the structure of sorting the knowledge-base-files by pathway.
7. There needs to be more understanding of the reasoning behind utilizing pathways. You need to abstract and consolidate information to pathways, then keep a list of pathways that we have. There is a script in 1000xscripts that generates the cheatsheet in the planning folder planning/cs.md. For strict domain adherance purposes (in rules-workflow, you are only allowed to make edits to files in 1000xbrain), it may be the best to have one script in 1000xbrain for generating a list of all of the project-rule-parameters sorted by pathway for your reference.

**Success Criteria**
1. core-brain-files are a total of less than 2000 lines. (VERY IMPORTANT, you do not want to keep large files in core/ because it engrains too much information). Try to aim for near 1000 lines within the core-brain-files in core/.
2. Auto Attached rules in subsystems accurately describe the **AUTONOMOUS** workflow cycle:
run terminal commands -> make changes -> run terminal commands -> make changes
3. Auto Attached rules in subsystems accurately describe the planning folder and what will be loaded into the Context Pills for each message and conversation thread.
Planning Folder should have at minimum:
implementation-progress.md
README.md
some type of cheatsheet for terminal commands
implementation-file(s)
context-file(s)
requirements.md
4. Retain 1000x development principles.
5. Retain your identity as 1000xdev and the goal to achieve true 1000x AI augmented development through streamlined communication of message-commands and engrained autonomous workflows.
6. Retain my identity, Tyler Youk, and my role along with my domains to guide you through true 1000x AI augmented development.
7. Write the rules as if you are writing from my point of view, writing to yourself. When you write `you`, you are referring to yourself, 1000xdev. When you write `I` you are referring to me, Tyler Youk.

**IMPORTANT**
Split these requirements and implementation into multiple planning folders:
92-rules-workflow-system-wide
93-rules-workflow-system-wide
94-rules-workflow-system-wide