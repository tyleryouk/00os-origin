# Verify All Commands

# Read knowledge files for verification process and command structure 
read_file(target_file="1000xbrain/commands/knowledge/command-structure.md", should_read_entire_file=True, explanation="Read command structure guidelines.")
read_file(target_file="1000xbrain/commands/knowledge/testing-procedures.md", should_read_entire_file=True, explanation="Read command testing procedures.")
read_file(target_file="1000xbrain/commands/knowledge/best-practices.md", should_read_entire_file=True, explanation="Read command best practices.")
read_file(target_file="1000xbrain/brain/processes/command-verification-and-correction.md", should_read_entire_file=True, explanation="Read command verification process.")

# List all brain-domain commands to verify
list_dir(relative_workspace_path="1000xcommands/brain", explanation="List all brain domain commands that need to be verified.")

# Read the planning notes for command verification requirements
read_file(target_file="1000xplans/brain/notes.md", should_read_entire_file=True, explanation="Read the brain planning notes for verification requirements.")
read_file(target_file="1000xplans/brain/implementation-progress.md", should_read_entire_file=True, explanation="Read implementation progress to track verification status.")

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/brain/processes/command-verification-and-correction.md
# Knowledge: 1000xbrain/commands/knowledge/testing-procedures.md, 1000xbrain/commands/knowledge/best-practices.md

# The AI will:
# 1. Iterate through each brain-domain command file in 1000xcommands/brain/
# 2. Read each command file and parse the tool calls
# 3. Execute each tool call, observing and resolving any errors
# 4. Document potential enhancements in 1000xplans/brain/notes.md
# 5. Update implementation progress in 1000xplans/brain/implementation-progress.md
# 6. Perform any necessary fixes for problematic commands using edit_file 