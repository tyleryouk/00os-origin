# Command: Update Process File

# Gather context first (Example: Read the target file before editing)
tool_code
print(default_api.read_file(target_file="1000xbrain/system/rules/processes/new-rule-verification.md", should_read_entire_file=True))

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/system/brain/processes/update-process-process.md
# Knowledge: 1000xbrain/system/guidelines/file-structure/markdown-standards.md
# Knowledge: 1000xbrain/system/guidelines/tool-usage/edit-file-best-practices.md
# Parameter: process_path=system/rules/processes/new-rule-verification # TODO: Parameterize this
# Parameter: update_instructions=Add error handling details to step 2. # TODO: Parameterize this
# Parameter: code_edit_content=\"// ... existing code ...\\n2. Step 2\\n   * Add error handling notes.\\n// ... existing code ...\" # TODO: Parameterize this
# --- END DYNAMIC EXECUTION --- 

# Note: This command currently uses placeholder parameters.
# Actual invocation would require providing process_path, instructions, and edit content. 