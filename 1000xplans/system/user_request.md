# USER REQUEST File
# This file is exclusively for storing USER REQUEST content to be read and processed by 1000xdev.
# Notes and personal content should be kept in notes.md.

## USER REQUEST SECTION

# --- TEMPLATE START ---
# Instructions:
# 1. Replace bracketed placeholders with your request details.
# 2. All directive fields are required - they help automate processing.
# 3. Run `1000xscripts/system/list-cycles.ps1` in terminal to see all available cycles.

# Directive: Enhancement
# Target Cycle: N\A (system-wide change)
# Enhancement Name: Project Agnostic Goal for 1000xsystems, so that you and I can work on any project
# Priority: High

# Enhancement Details
The goal of the 1000xsystems is to be fully project agnostic, so that if I take the 1000xsystems and move them to another folder, they will work as intended. The structure of the project folders including the 1000xsystems will always be:

project-folder/
- .cursor
- 1000xbrain
- 1000xcommands
- 1000xplans
- 1000xrules
- 1000xscripts
- (project-directory-folders)
- (root-project-files)

In this particular proejct, the structure is:
GigaSwap/
- .cursor
- 1000xbrain
- 1000xcommands
- 1000xplans
- 1000xrules
- 1000xscripts
- back-end
- front-end
- logs-main
- .gitignore

Example, I want to copy this system into a new project that I am working on. If I copy your brain and it's subsystems to the new project folder, the directory structure will look like:
- .cursor
- 1000xbrain
- 1000xcommands
- 1000xplans
- 1000xrules
- 1000xscripts
- p3_handout
- p3_strict_instructions

To make the 1000xsystems project agnostic, here are suggestions of changes to make through all of the 1000xsystems. Review the suggestions, then make at least 50 tool calls to the 1000xsystems to thoroughly analyze the current state of the 1000xsystems. 50 tool calls is a minimum, even though I would prefer that you conduct more to get a holistic view of the 1000xsystems.

Possible changes to 1000xsystems:
- Ensure all filepaths are relative (I am pretty sure all filepaths are already relative, however, you will need to grep search through the 1000xsystems to check). If there are places where filepaths are not relative and include \GigaSwap\, then there needs to be some system to set the root path (e.g for this project, the root path will be C:\Users\ethde\Desktop\GigaSwap).

- There are many instances where the domains: front-end, back-end, and system are specified. This is good for this project, but I would rather centralize the documentation of domains so that if I switch this system to another project I can update the domains. 

- **IMPORTANT NOTE** I just started creating 1000xsystems with you. Originally, it was just 1000xbrain. As we have worked together over the past year, these configurations have gotten much better. I now want to be able to migrate these configurations so that you and I can work on any project together. Because a lot of the 1000xsystem configurations are new, the cycles for front-end and back-end have not been created yet. Additionally, nothing has been created for the brain-domains 1000xbrain\front-end\ and 1000xbrain\back-end\ . This information should give you the confidence to make any necessary changes to make all 1000xsystem (1000xbrain, 1000xcommands, 1000xplans, 1000xscripts, 1000xrules) without the worry of affecting the front-end and back-end directories, for there aren't any configurations/cycles/knowledge/commands/processes/scripts for front-end nor back-end yet. 

- Please intelligently review every 1000xsystem: 1000xbrain, 1000xcommands, 1000xplans, 1000xscripts, and 1000xrules.

- Note that if it is the easiest to just keep all documentation of the front-end and back-end domains in 1000xsystems as is, let me know and I can just move the 1000xsystems over to the new project folder, then ask you to manually change all of the domain documentation from `front-end` and `back-end` to the new project. 

# Focus Areas (Optional)
1000xbrain\
1000xcommands\
1000xplans\
1000xrules\
1000xscripts

# --- DIRECTIVE REFERENCE ---
# Enhancement: Add new functionality or improve existing features
# Fix: Correct problems or issues in existing functionality
# Refactor: Restructure code without changing functionality
# Analysis: Evaluate component(s) without making changes
# --- TEMPLATE END ---

## END USER REQUEST SECTION 