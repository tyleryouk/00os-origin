# Command: Update Script File

# Gather context first (Example: Read the target script before editing)
tool_code
print(default_api.read_file(target_file="1000xscripts/system/new-utility.ps1", should_read_entire_file=True))

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/system/scripts/processes/update-script-process.md
# Knowledge: 1000xbrain/system/guidelines/tool-usage/edit-file-best-practices.md
# Parameter: script_path=system/new-utility.ps1 # TODO: Parameterize this
# Parameter: update_instructions=Add a parameter to the script. # TODO: Parameterize this
# Parameter: code_edit_content=\"param($NewParam)\\n\\nWrite-Host \"Hello from new script! Param: $NewParam\"\" # TODO: Parameterize this
# --- END DYNAMIC EXECUTION ---

# Note: Needs parameterization.