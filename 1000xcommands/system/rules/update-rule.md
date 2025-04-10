# Command: Update Core Rule

# Gather context first (Example: Read the target rule before editing)
tool_code
print(default_api.read_file(target_file="1000xrules/core/communication/new-example-rule.md", should_read_entire_file=True))

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/system/rules/processes/update-rule-process.md
# Knowledge: 1000xbrain/system/guidelines/file-structure/markdown-standards.md
# Knowledge: 1000xbrain/system/guidelines/tool-usage/edit-file-best-practices.md
# Parameter: rule_path=core/communication/new-example-rule # TODO: Parameterize this
# Parameter: update_instructions=Add detail to the overview. # TODO: Parameterize this
# Parameter: code_edit_content=\"// ... existing code ...\\n## Overview\\n\\nExample content with added detail.\\n// ... existing code ...\" # TODO: Parameterize this
# --- END DYNAMIC EXECUTION --- 

# Note: This command currently uses placeholder parameters.
# Actual invocation would require providing rule_path, instructions, and edit content. 