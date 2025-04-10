# Command: list-commands (Commands Domain)

# Purpose: Lists available command definition files, optionally filtering by domain.
# This command provides context for understanding available commands.

# List all command files across all domains
default_api.list_dir(relative_workspace_path="1000xcommands/")
default_api.list_dir(relative_workspace_path="1000xcommands/brain/")
default_api.list_dir(relative_workspace_path="1000xcommands/commands/")
default_api.list_dir(relative_workspace_path="1000xcommands/rules/")
default_api.list_dir(relative_workspace_path="1000xcommands/plans/")
default_api.list_dir(relative_workspace_path="1000xcommands/front-end/")
default_api.list_dir(relative_workspace_path="1000xcommands/back-end/")
default_api.list_dir(relative_workspace_path="1000xcommands/scripts/")

# Note: Filtering logic (e.g., showing only a specific domain) would typically be 
# handled by the AI interpreting the results of these list calls, rather than 
# embedding complex filtering logic within the command itself. 