# Enhance Cognitive Architecture (Comprehensive)

# --- Phase 1: Initial Research ---

# Research 1000xbrain structure and knowledge
list_dir(relative_workspace_path="1000xbrain", explanation="List top-level 1000xbrain contents.")
list_dir(relative_workspace_path="1000xbrain/brain", explanation="List core brain contents.")
list_dir(relative_workspace_path="1000xbrain/brain/knowledge", explanation="List brain knowledge contents.")
list_dir(relative_workspace_path="1000xbrain/brain/processes", explanation="List brain process contents.")
read_file(target_file="1000xbrain/brain/1000xbrain-structure.md", should_read_entire_file=True, explanation="Read the main 1000xbrain structure file.")
read_file(target_file="1000xbrain/brain/knowledge/system-structure/system-architecture.md", should_read_entire_file=True, explanation="Read the system architecture knowledge file.")
read_file(target_file="1000xbrain/brain/knowledge/system-wide/cognitive-enhancement.md", should_read_entire_file=True, explanation="Read the cognitive enhancement guidelines.")
read_file(target_file="1000xbrain/brain/processes/planning-workflow.md", should_read_entire_file=True, explanation="Read the planning workflow definition to understand standard structure.")
read_file(target_file="1000xbrain/brain/processes/new-planning-cycle-initiation.md", should_read_entire_file=True, explanation="Read the planning cycle initiation process to get standard templates.")

# Research potential integration points in other systems
codebase_search(query="cognitive architecture integration points", target_directories=["1000xrules", "1000xscripts"], explanation="Search for integration points in rules and scripts.")
read_file(target_file="1000xbrain/brain/processes/new-planning-cycle-initiation.md", should_read_entire_file=True, explanation="Read the planning cycle initiation process to get standard templates.") # Read template source

# --- Phase 2: Planning Setup ---

# Note: Directory clearing is removed. Relies on the process defined in 'new-planning-cycle-initiation.md'.
# The AI executing this command MUST parse the templates from 'new-planning-cycle-initiation.md' (read above) 
# and use them to create/reset the standard planning files below via dynamic edit_file calls.

# Conceptual Placeholder: Create/Reset standard planning files dynamically
# edit_file(target_file="1000xplans/brain/plan.md", instructions="Create/Reset standard plan file using template from process file.", code_edit="[Parsed template from new-planning-cycle-initiation.md]")
# edit_file(target_file="1000xplans/brain/implementation-progress.md", instructions="Create/Reset standard progress file using template from process file.", code_edit="[Parsed template from new-planning-cycle-initiation.md]")
# edit_file(target_file="1000xplans/brain/notes.md", instructions="Create/Reset standard notes file using template from process file.", code_edit="[Parsed template from new-planning-cycle-initiation.md]")

# Create requirements file specific to this command's purpose (can remain static or be dynamic)
edit_file(
    target_file="1000xplans/brain/requirements.md", 
    instructions="Create/Update specific requirements file for cognitive architecture enhancement.", 
    code_edit="# Requirements\\n\\n- Enhance the cognitive architecture of 1000xbrain as a whole.\\n- Follow the process outlined in `1000xbrain/brain/processes/system-change-workflow.md`.\\n- Refine requirements based on dynamic research phase."
)

# --- Phase 3: Load Process Guidance ---

# Read the process file that will guide subsequent steps (referenced in requirements.md)
read_file(target_file="1000xbrain/brain/processes/system-change-workflow.md", should_read_entire_file=True, explanation="Read the process file defining how to conduct the enhancement.")

# Search for related patterns (Context Gathering)
codebase_search(query="cognitive patterns", target_directories=["1000xbrain/brain/knowledge"], explanation="Search for cognitive patterns within the brain knowledge base.")

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/brain/processes/system-change-workflow.md
# Note: The AI executing this command MUST now follow the steps outlined in the specified Process file.
# Use the gathered context, requirements, knowledge patterns, and the defined workflow 
# to determine and execute the necessary sequence of tool calls (read_file, edit_file, codebase_search, etc.) 
# to achieve the cognitive architecture enhancement.

# (Explicit tool calls for implementation previously listed here are removed)

# The following lines referencing cognitive-architecture/* have been removed:
# read_file("1000xbrain/brain/knowledge/cognitive-architecture/enhancement-patterns.md", should_read_entire_file=true)
# edit_file("1000xbrain/brain/knowledge/cognitive-architecture/core-concepts.md", "Enhance cognitive architecture concepts", "# Enhanced content goes here")
# read_file("1000xbrain/brain/knowledge/cognitive-architecture/core-concepts.md", should_read_entire_file=true) 
# read_file("1000xbrain/brain/knowledge/cognitive-architecture/core-concepts.md", should_read_entire_file=true) 