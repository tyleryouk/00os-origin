# Command: new-1000xplan (Commands Domain)

# Purpose: Automates analysis of the commands domain and updates planning files.
# This command gathers context about the current state of command-related files
# and prepares for a new planning cycle focused on the commands domain.

# 1. Analyze 1000xbrain support files for commands
default_api.read_file(target_file="1000xbrain/commands/commands-structure.md", should_read_entire_file=True)
default_api.read_file(target_file="1000xbrain/commands/knowledge/command-planning-knowledge.md", should_read_entire_file=True)
default_api.read_file(target_file="1000xbrain/commands/knowledge/command-patterns.md", should_read_entire_file=True) # Read patterns if it exists
default_api.read_file(target_file="1000xbrain/commands/processes/command-planning-process.md", should_read_entire_file=True)
default_api.read_file(target_file="1000xbrain/commands/processes/command-development-process.md", should_read_entire_file=True)
default_api.read_file(target_file="1000xbrain/commands/processes/execution-process.md", should_read_entire_file=True) # Read execution process if it exists

# 2. Analyze existing commands
default_api.list_dir(relative_workspace_path="1000xcommands/brain/")
default_api.list_dir(relative_workspace_path="1000xcommands/commands/")
default_api.list_dir(relative_workspace_path="1000xcommands/rules/")
default_api.list_dir(relative_workspace_path="1000xcommands/plans/")
default_api.list_dir(relative_workspace_path="1000xcommands/front-end/")
default_api.list_dir(relative_workspace_path="1000xcommands/back-end/")
default_api.list_dir(relative_workspace_path="1000xcommands/scripts/")

# 3. Read current planning state for the commands domain
default_api.read_file(target_file="1000xplans/commands/requirements.md", should_read_entire_file=True)
default_api.read_file(target_file="1000xplans/commands/implementation-plan.md", should_read_entire_file=True)
default_api.read_file(target_file="1000xplans/commands/implementation-progress.md", should_read_entire_file=True)
default_api.read_file(target_file="1000xplans/commands/README.md", should_read_entire_file=True)

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/commands/processes/command-planning-process.md
# Knowledge: 1000xbrain/commands/knowledge/command-planning-knowledge.md 
# Note: The AI executing this command must now update the planning files 
# (requirements.md, implementation-plan.md, implementation-progress.md, README.md) 
# based on the analysis of the context gathered in the explicit steps above 
# and following the specified Process file.

# 4. Placeholder edit calls: Update planning files based on analysis
# Note: The AI executing this command needs to intelligently determine the content
# for these edits based on the results of the read/list calls above.
default_api.edit_file(
    target_file="1000xplans/commands/requirements.md", 
    instructions="Update requirements based on analysis of current command state.",
    code_edit="# Requirements Update\n\n[AI inserts analysis and updated requirements here]"
)
default_api.edit_file(
    target_file="1000xplans/commands/implementation-plan.md", 
    instructions="Update implementation plan based on analysis.",
    code_edit="# Implementation Plan Update\n\n[AI inserts updated plan steps based on analysis]"
)
default_api.edit_file(
    target_file="1000xplans/commands/implementation-progress.md", 
    instructions="Reset or update progress for new planning cycle based on analysis.",
    code_edit="# Implementation Progress Update\n\nStatus: Planning (New Cycle)\n\n[AI updates log based on analysis]"
)
default_api.edit_file(
    target_file="1000xplans/commands/README.md", 
    instructions="Update README to reflect the start of a new planning cycle based on analysis.",
    code_edit="# README Update\n\n[AI updates README summary based on analysis]"
) 