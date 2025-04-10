# Create 1000xcommand (Brain Domain Perspective)

# Reads knowledge files for command creation guidelines from the 'commands' brain area
read_file(target_file="1000xbrain/commands/knowledge/command-structure.md", should_read_entire_file=True, explanation="Read general command structure.")
read_file(target_file="1000xbrain/commands/knowledge/directory-organization.md", should_read_entire_file=True, explanation="Read command directory organization rules.")
read_file(target_file="1000xbrain/commands/knowledge/creation-process.md", should_read_entire_file=True, explanation="Read general command creation process.")
read_file(target_file="1000xbrain/commands/knowledge/testing-procedures.md", should_read_entire_file=True, explanation="Read general command testing procedures.")
read_file(target_file="1000xbrain/commands/knowledge/best-practices.md", should_read_entire_file=True, explanation="Read general command best practices.")

# Read the planning file containing the definition for the command to be created
read_file(target_file="1000xplans/brain/notes.md", should_read_entire_file=True, explanation="Read the brain planning notes file to find the command definition.")

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/commands/processes/creation-process.md 
# Knowledge: (All files read above)
# Note: The AI must parse the content read from 1000xplans/brain/notes.md,
# extracting the section between '## create-1000xcommand' and '## end',
# to determine the domain, name, and content for the new command.
# It then uses this definition and the loaded Knowledge files to execute 
# the appropriate edit_file call targeting the correct path under 1000xcommands/.

# (Conceptual placeholder removed)

# Creates the new command .md file (Path and content determined by 1000xdev based on requirements and knowledge files)
# Note: The edit_file call below is conceptual. The actual target_file (e.g., 1000xcommands/<domain>/...) and code_edit 
# would be determined dynamically by 1000xdev after parsing the definition from notes.md 
# and applying the rules from the knowledge files read above.
# edit_file(target_file="1000xcommands/<domain>/<new-command-name>.md", 
#           instructions="Create new command definition file based on requirements from notes.md.", 
#           code_edit="# New Command Name\ntool_call(...)\n...") 