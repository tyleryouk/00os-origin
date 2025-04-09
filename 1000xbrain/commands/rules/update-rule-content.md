# Update Rule Content

list_dir("1000xrules/core")

read_file("1000xrules/core/identity/core-identity.md", should_read_entire_file=true)

read_file("1000xbrain/rules/processes/rules-development.md", should_read_entire_file=true)

codebase_search("content standards", ["1000xbrain/rules"])

read_file("1000xrules/core/identity/enhancement-capabilities.md", should_read_entire_file=true)

edit_file("1000xrules/core/identity/core-identity.md", "Update core identity content", "# Enhanced content goes here")

read_file("1000xrules/core/identity/core-identity.md", should_read_entire_file=true) 