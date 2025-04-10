# Command: dev-start (Commands Domain)

# Purpose: Initializes the development phase for the commands domain.
# Reads ALL planning artifacts and relevant context files to prepare for implementation.

default_api.list_dir(relative_workspace_path="1000xplans/commands/")
default_api.read_file(target_file="1000xplans/commands/README.md", should_read_entire_file=True)
default_api.read_file(target_file="1000xplans/commands/requirements.md", should_read_entire_file=True)
default_api.read_file(target_file="1000xplans/commands/implementation-plan.md", should_read_entire_file=True)
default_api.read_file(target_file="1000xplans/commands/implementation-progress.md", should_read_entire_file=True)
default_api.read_file(target_file="1000xbrain/commands/commands-structure.md", should_read_entire_file=True)
default_api.read_file(target_file="1000xbrain/commands/processes/command-development-process.md", should_read_entire_file=True)
default_api.read_file(target_file="1000xbrain/commands/knowledge/command-planning-knowledge.md", should_read_entire_file=True)

# Note: This command primarily loads context. The actual development (editing files
# based on the plan) is performed by the AI after this command runs. 