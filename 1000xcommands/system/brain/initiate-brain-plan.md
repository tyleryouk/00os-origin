# Initiate Brain Plan: Setup Standard Directory

# Overview: Creates the standard planning file structure in 1000xplans/brain/

# Step 1: Read the process definition containing templates
read_file(
    target_file="1000xbrain/brain/processes/new-planning-cycle-initiation.md", 
    should_read_entire_file=True,
    explanation="Read the standard process definition containing planning file templates."
)

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/brain/processes/new-planning-cycle-initiation.md
# Note: The AI executing this command MUST parse the templates from the specified Process file 
# and use them to create/reset the standard planning files (plan.md, implementation-progress.md, notes.md, requirements.md) 
# in '1000xplans/brain/' via dynamic edit_file calls.

# Remove previous static edit_file calls for plan.md, implementation-progress.md, notes.md etc.

# Step 3: Create README.md (Explicit step, can remain or be moved into process)
edit_file(
    target_file="1000xplans/brain/README.md", 
    instructions="Create the README file for the brain plan.",
    code_edit="# Brain Domain Plan: [Plan Title/Objective]\\n\\n## Overview\\n\\n[Provide a concise summary of the plan's goals, scope, and context.]\\n"
)