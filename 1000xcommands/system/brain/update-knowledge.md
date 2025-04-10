# Command: Update Knowledge File

# Gather context first (Example: Read the target file before editing)
tool_code
print(default_api.read_file(target_file="1000xbrain/system/rules/knowledge/new-rule-concepts.md", should_read_entire_file=True))

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/system/brain/processes/update-knowledge-process.md
# Knowledge: 1000xbrain/system/guidelines/file-structure/markdown-standards.md
# Knowledge: 1000xbrain/system/guidelines/tool-usage/edit-file-best-practices.md
# Parameter: knowledge_path=system/rules/knowledge/new-rule-concepts # TODO: Parameterize this
# Parameter: update_instructions=Add a subsection about core principles. # TODO: Parameterize this
# Parameter: code_edit_content=\"// ... existing code ...\\n\\n### Core Principles\\n\\n- Principle 1\\n- Principle 2\\n\" # TODO: Parameterize this
# --- END DYNAMIC EXECUTION --- 

# Note: This command currently uses placeholder parameters.
# Actual invocation would require providing knowledge_path, instructions, and edit content. 