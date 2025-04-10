# Command: Update Command File

# Gather context first (Example: Read the target command before editing)
tool_code
print(default_api.read_file(target_file="1000xcommands/system/rules/create-rule.md", should_read_entire_file=True))

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/system/commands/processes/update-command-process.md
# Knowledge: 1000xbrain/system/commands/knowledge/command-structure.md
# Knowledge: 1000xbrain/system/guidelines/tool-usage/edit-file-best-practices.md
# Parameter: command_path=system/rules/create-rule # TODO: Parameterize this
# Parameter: update_instructions=Add a new knowledge file reference. # TODO: Parameterize this
# Parameter: code_edit_content=\"// ... existing code ...\\n# Knowledge: 1000xbrain/system/rules/knowledge/rules-architecture.md # Added Knowledge\\n// ... existing code ...\" # TODO: Parameterize this
# --- END DYNAMIC EXECUTION --- 

# Note: This command currently uses placeholder parameters.
# Actual invocation would require providing command_path, instructions, and edit content. 