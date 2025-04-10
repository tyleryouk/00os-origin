# Benchmark Command Processing

# First, read the command processing optimization rules to understand benchmark requirements
read_file(target_file="1000xrules/core/communication/command-processing-optimization.md", should_read_entire_file=true, explanation="Read command processing optimization requirements")
read_file(target_file="1000xplans/rules/validation-plan.md", should_read_entire_file=true, explanation="Read validation plan for benchmark guidance")

# Read any existing benchmark results
read_file(target_file="1000xplans/rules/test-results-template.md", should_read_entire_file=true, explanation="Read test results template")

# List available commands for testing
list_dir(relative_workspace_path="1000xcommands/brain", explanation="List brain domain commands for benchmark testing")
list_dir(relative_workspace_path="1000xcommands/rules", explanation="List rules domain commands for benchmark testing")

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/rules/processes/command-benchmarking.md
# Knowledge: 1000xbrain/rules/knowledge/performance-benchmarking.md

# The AI will:
# 1. Select appropriate commands to benchmark from the available commands
# 2. Measure execution time and processing behavior for each command
# 3. Document findings in the test results template
# 4. Analyze results against the success criteria in the validation plan
# 5. Provide recommendations for further optimization if needed
# 6. Record all findings in a final benchmark report 