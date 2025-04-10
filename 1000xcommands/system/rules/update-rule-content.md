# Update Rule Content

list_dir("1000xrules/core")

read_file("1000xrules/core/identity/core-identity.md", should_read_entire_file=true)

read_file("1000xbrain/rules/processes/rules-development.md", should_read_entire_file=true)

codebase_search("content standards", ["1000xbrain/rules"])

read_file("1000xrules/core/identity/enhancement-capabilities.md", should_read_entire_file=true)

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/rules/processes/rules-development.md
# Knowledge: 1000xrules/core/identity/core-identity.md, 1000xrules/core/identity/enhancement-capabilities.md 
# Note: The AI executing this command MUST now follow the steps outlined in the specified Process file.
# Use the gathered context (including loaded Knowledge files, search results)
# to determine and execute the necessary edit_file call(s) to update the target rule content.
# Verification (e.g., re-reading the file) should also be performed as part of the dynamic execution.

# (Explicit edit_file and read_file for implementation/verification removed)
# edit_file("1000xrules/core/identity/core-identity.md", "Update core identity content", "# Enhanced content goes here")
# read_file("1000xrules/core/identity/core-identity.md", should_read_entire_file=true) 