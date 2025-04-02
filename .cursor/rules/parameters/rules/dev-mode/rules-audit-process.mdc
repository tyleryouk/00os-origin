# workflow: rules-workflow | pathway: audit | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-path: parameters/rules/dev-mode/rules-audit-process.mdc

## File Purpose and Relationship

This file defines the operation of the `dev-mode: rules-workflow @parameters/rules/dev-mode/rules-audit-process.mdc` message-command, which initializes developer mode with a focus on implementing rules audit processes. It should be consulted to understand:

- How to implement rules audit processes
- How to create audit validation scripts
- How to generate audit reports
- How to resolve audit findings

## Usage as Project-Rule-Parameter

This file contains specialized knowledge access for rules audit implementation. It should be referenced as a project-rule-parameter when implementing rules audit processes:

```
dev-mode: rules-workflow @parameters/rules/dev-mode/rules-audit-process.mdc
```

## Knowledge Access

When implementing rules audit processes, use the `fetch_rules` tool to access specialized knowledge:

```typescript
// Access audit procedures
fetch_rules(["knowledge/rules/guides/audit-procedures"], 
           "Understanding comprehensive audit procedures for implementation")

// Access validation criteria
fetch_rules(["knowledge/rules/reference/audit-validation-criteria"], 
           "Understanding validation criteria for implementation")

// Access implementation patterns
fetch_rules(["knowledge/rules/patterns/impl/audit-implementation"], 
           "Implementing detailed audit processes and scripts")

// Access reporting templates
fetch_rules(["knowledge/rules/patterns/doc/audit-reporting"], 
           "Implementing audit report generation")
```

## Implementation Guidance

When implementing a rules audit process, follow these key principles:

1. **Modular Implementation**:
   - Create separate components for each audit phase
   - Implement inventory collection functions
   - Create validation rule functions
   - Build report generation modules

2. **Validation Rules Implementation**:
   - Implement header validation logic
   - Create section verification functions
   - Build format checking functions
   - Implement reference validation

3. **Report Generation**:
   - Create structured report templates
   - Implement issue categorization
   - Build action item generation
   - Create visualization functions

4. **Integration Points**:
   - Connect inventory, validation, and reporting components
   - Implement logging throughout the process
   - Create command-line interface
   - Build automation hooks

## Tool Call Sequences

```typescript
// Initialize audit implementation
list_dir("parameters/rules")

// Check for existing validation scripts
grep_search("validate_header|verify_sections", false, "scripts/**/*.py")

// Create/edit validation script
edit_file("scripts/audit/validate_headers.py",
          "Implement header validation script",
          "import os\nimport re\n\ndef extract_headers(directory):\n    \"\"\"Extract headers from all project-rule-parameter files.\"\"\"\n    headers = {}\n    \n    for root, _, files in os.walk(directory):\n        for file in files:\n            if file.endswith('.md'):\n                filepath = os.path.join(root, file)\n                with open(filepath, 'r') as f:\n                    first_line = f.readline().strip()\n                    if first_line.startswith('# workflow:'):\n                        headers[filepath] = first_line\n    \n    return headers\n\ndef validate_headers(headers):\n    \"\"\"Validate all headers follow the expected format.\"\"\"\n    # Implementation code...\n    \ndef main():\n    # Implementation code...\n    \nif __name__ == \"__main__\":\n    main()")

// Create/edit section verification script
edit_file("scripts/audit/verify_sections.py",
          "Implement section verification script",
          "import os\n\ndef verify_sections(directory):\n    \"\"\"Verify that all project-rule-parameters have required sections.\"\"\"\n    required_sections = [\n        '## Purpose',\n        '## Command Format',\n        '## Required Context',\n        '## Process Steps',\n        '## Tool Calls',\n        '## Expected Outputs',\n        '## Error Handling'\n    ]\n    \n    issues = []\n    \n    for root, _, files in os.walk(directory):\n        for file in files:\n            if file.endswith('.md'):\n                filepath = os.path.join(root, file)\n                with open(filepath, 'r') as f:\n                    content = f.read()\n                    \n                    missing_sections = []\n                    for section in required_sections:\n                        if section not in content:\n                            missing_sections.append(section)\n                    \n                    if missing_sections:\n                        issues.append({\n                            'filepath': filepath,\n                            'missing_sections': missing_sections\n                        })\n    \n    return issues\n\ndef main():\n    # Implementation code...\n    \nif __name__ == \"__main__\":\n    main()")

// Create/edit report generation script
edit_file("scripts/audit/generate_report.py",
          "Implement report generation script",
          "import json\nfrom datetime import datetime\n\ndef generate_audit_report(issues):\n    \"\"\"Generate a formatted audit report from collected issues.\"\"\"\n    report = [\"# Rules Audit Report - \" + datetime.now().strftime(\"%B %Y\")]\n    \n    # Summary statistics\n    total_params = len(issues.get('all_files', []))\n    total_issues = sum(len(v) for k, v in issues.items() if k != 'all_files')\n    \n    report.append(\"\\n## Summary\")\n    report.append(f\"- {total_params} project-rule-parameters audited\")\n    report.append(f\"- {total_issues} issues identified\")\n    # Additional summary items...\n    \n    # Critical issues\n    # Implementation code...\n    \n    return \"\\n\".join(report)\n\ndef main():\n    # Implementation code...\n    \nif __name__ == \"__main__\":\n    main()")

// Create/edit main audit script
edit_file("scripts/audit/run_audit.py",
          "Implement main audit script",
          "#!/usr/bin/env python3\n\"\"\"\nComprehensive Project-Rule-Parameter Audit Script\n\nThis script performs a complete audit of all project-rule-parameters\nin the 1000xbrain cognitive architecture.\n\"\"\"\n\nimport os\nimport sys\nimport json\nfrom datetime import datetime\n\n# Import components\nfrom validate_headers import extract_headers, validate_headers\nfrom verify_sections import verify_sections\nfrom generate_report import generate_audit_report\n\ndef main():\n    # Setup phase\n    os.makedirs('audit-results', exist_ok=True)\n    \n    # Inventory phase\n    all_files = get_all_parameters()\n    headers = extract_headers(all_files)\n    refs = extract_references()\n    \n    # Validation phase\n    issues = {}\n    issues['all_files'] = all_files\n    issues['missing_headers'] = find_missing_headers(all_files, headers)\n    issues['inconsistent_headers'] = validate_headers(headers)\n    issues['path_issues'] = verify_paths(headers)\n    issues['missing_sections'] = verify_sections(all_files)\n    issues['reference_issues'] = validate_references(refs)\n    \n    # Reporting phase\n    report = generate_audit_report(issues)\n    action_items = generate_action_items(issues)\n    \n    # Save results\n    with open('audit-results/audit-report.md', 'w') as f:\n        f.write(report)\n    \n    with open('audit-results/action-items.md', 'w') as f:\n        f.write(action_items)\n    \n    with open('audit-results/issues.json', 'w') as f:\n        json.dump(issues, f, indent=2)\n    \n    print(f\"Audit completed: {len(all_files)} files scanned, {sum(len(v) for k, v in issues.items() if k != 'all_files')} issues found\")\n\nif __name__ == \"__main__\":\n    main()")
```

## Example Usage

```
dev-mode: rules-workflow @parameters/rules/dev-mode/rules-audit-process.mdc

prompt: I need to implement a comprehensive audit system for all project-rule-parameters to ensure they follow the new self-documenting header system 