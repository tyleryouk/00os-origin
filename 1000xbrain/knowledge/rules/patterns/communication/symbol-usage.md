# Symbol Usage Patterns

## Importance of Symbol Compliance

The @ symbol has special significance in the Cursor environment:

1. Cursor automatically treats text following the @ symbol as a reference
2. Improper usage can lead to unintended reference detection
3. Consistent standards ensure clarity and proper functionality
4. Cross-referencing is critical for navigating the cognitive architecture
5. Proper extension usage (.md vs .mdc) is essential for clear communication

## Comprehensive Symbol Catalog

### Primary Communication Symbols

| Symbol | Name | Purpose | Usage Context | Example |
|--------|------|---------|---------------|---------|
| **@** | At Symbol | File references & project rules | Parameters & cross-references | `verify-planning: @parameters/rules/helpers/verification/verify-planning.mdc` |
| **📋** | Clipboard | Plan mode indicator | Response mode designation | `📋 1000xdev [rules-workflow]` |
| **💻** | Computer | Dev mode indicator | Response mode designation | `💻 1000xdev [front-end-workflow]` |
| **⚡** | Lightning | Direct mode indicator | Response mode designation | `⚡ 1000xdev [front-end-workflow]` |
| **:**  | Colon | Parameter separator | Message-command syntax | `dev-mode: typescript` |
| **[ ]** | Square Brackets | Workflow type container | Mode indicators | `[rules-workflow]` |
| **\`\`** | Backticks | Code wrapping | File path references | `` `@file.md` `` |
| **-** | Hyphen | Kebab-case separator | Message-commands & parameters | `verify-planning` |
| **.md** | Markdown Extension | Brain-file designation | File editing contexts | `Edit core-essentials.md` |
| **.mdc** | Cursor Rule Extension | Rule reference designation | Message-command parameters | `@parameters/rules/helpers/verification/verify-planning.mdc` |

### Secondary Communication Symbols

| Symbol | Name | Purpose | Usage Context | Example |
|--------|------|---------|---------------|---------|
| **#** | Hash/Pound | Markdown heading | Documentation structure | `# Heading` |
| **\|** | Pipe | Table column separator | Documentation tables | `\| Column 1 \| Column 2 \|` |
| **✅** | Check Mark | Approval/Completion | Status indicators | `✅ Implementation complete` |
| **❌** | Cross Mark | Prohibition/Failure | Status indicators | `❌ Not authorized` |
| **🚫** | Prohibition | Strict prohibition | Authority matrix | `🚫 FORBIDDEN` |
| **⚠️** | Warning | Critical attention | Important notices | `⚠️ Critical requirement` |
| **/**  | Forward Slash | Path separator | File paths | `knowledge/rules/rules/file.md` |
| **\\** | Backslash | Escape character | Code examples | `console.log(\"escaped\")` |

## Brain-File vs. Cursor-Rule Reference Decision Tree

Use this decision tree to determine the correct extension:

```
What are you doing?
├── Showing a message-command with project-rule-parameter → Use .mdc
│   Example: `verify-planning: @parameters/rules/helpers/verification/verify-planning.mdc`
│
├── Discussing a file to edit → Use .md
│   Example: "Edit parameters/rules/helpers/verification/verify-planning.md to enhance verification"
│
├── Referencing documentation → Use .md
│   Example: "See file-standards.md for details"
│
└── Describing file structure → Use .md
    Example: "The file is located at 1000xbrain/core/core-essentials.md"
```

## Extension Usage Contexts

| Context | Correct Extension | Example | Notes |
|---|----|---|----|
| Message-command parameters | **.mdc** | `verify-planning: @parameters/rules/helpers/verification/verify-planning.mdc` | Always use .mdc for project-rule-parameters |
| Code editing discussions | **.md** | `Edit the file core/identity/global-rules.md` | Use .md when discussing files to edit |
| Documentation cross-references | **.md** | `See file-standards.md for details` | Use .md for documentation references |
| Path descriptions | **.md** | `The file is located at 1000xbrain/core/core-essentials.md` | Use .md when describing file locations |

## Prohibited @ Symbol Usage

1. **Direct Usage in Regular Text**:
   - Never use @ followed by a path in regular text
   - INCORRECT EXAMPLE:
     ```markdown
     To verify planning, use @parameters/rules/helpers/verification/verify-planning.mdc
     ```
   - CORRECT EXAMPLE:
     ```markdown
     To verify planning, use `verify-planning: @parameters/rules/helpers/verification/verify-planning.mdc`
     ```

2. **In File Names or Headers**:
   - Never include @ in file names or section headers
   - INCORRECT EXAMPLE:
     ```markdown
     # @parameters/rules/example.md Contents
     ```
   - CORRECT EXAMPLE:
     ```markdown
     # Parameters Rules Example Contents
     ```

3. **Unwrapped in Examples or Documentation**:
   - Never leave @ symbol references unwrapped when giving examples
   - INCORRECT EXAMPLE:
     ```markdown
     Use the format: message-command: @parameters/rules/command.mdc
     ```
   - CORRECT EXAMPLE:
     ```markdown
     Use the format: `message-command: @parameters/rules/command.mdc`
     ```

4. **Multiple Unwrapped @ Symbols**:
   - Multiple @ symbols in close proximity can cause parsing issues
   - INCORRECT EXAMPLE:
     ```markdown
     The files @parameters/rules/helpers/verification/verify-planning.mdc and @parameters/rules/helpers/implementation/update-rules.mdc are related.
     ```
   - CORRECT EXAMPLE:
     ```markdown
     The files `@parameters/rules/helpers/verification/verify-planning.mdc` and `@parameters/rules/helpers/implementation/update-rules.mdc` are related.
     ```

## Decision Frameworks for Symbol Selection

Use these decision trees to select appropriate symbols:

### @ Symbol Decision Tree
```
Are you referencing a file?
├── Yes → Is it in the first 20 lines of a file?
│   ├── Yes → Direct usage allowed (@file.md)
│   └── No → Must be wrapped in backticks (`@file.md`)
└── No → Are you showing a message-command example?
    ├── Yes → Must be wrapped in backticks, use .mdc extension
    └── No → Don't use @ symbol
```

### Extension Decision Tree
```
What type of file are you referencing?
├── Brain file for editing → Use .md extension (e.g., global-rules.md)
└── Project rule parameter → Use .mdc extension (e.g., @global-rules.mdc)

What context are you in?
├── Message-command parameters → ALWAYS use .mdc extension
├── File editing discussions → ALWAYS use .md extension
├── Code search discussions → ALWAYS use .md extension
└── Documentation references → ALWAYS use .md extension
```

### Mode Indicator Symbol Decision Tree
```
Which mode are you operating in?
├── Planning Mode → Use 📋 emoji
├── Developer Mode → Use 💻 emoji
└── Direct Mode → Use ⚡ emoji

What workflow are you working on?
├── Rules → [rules-workflow]
├── Front-End → [front-end-workflow]
├── Back-End → [back-end-workflow]
└── Scripts → [scripts-workflow]

Full mode indicator:
Planning + Rules = 📋 1000xdev [rules-workflow]
Developer + Front-End = 💻 1000xdev [front-end-workflow]
Direct + Back-End = ⚡ 1000xdev [back-end-workflow]
etc.
```

## Mode Indicator Troubleshooting

| Issue | Example | Correction |
|-------|---------|------------|
| Missing emoji | `1000xdev [rules-workflow]` | Add appropriate emoji: `📋 1000xdev [rules-workflow]` |
| Wrong emoji | `💻 1000xdev [rules-workflow]` in plan-mode | Use correct emoji: `📋 1000xdev [rules-workflow]` |
| Wrong emoji | `📋 1000xdev [front-end-workflow]` in direct-mode | Use correct emoji: `⚡ 1000xdev [front-end-workflow]` |
| Missing brackets | `📋 1000xdev rules-workflow` | Add brackets: `📋 1000xdev [rules-workflow]` |
| Incomplete indicator | `📋 [rules-workflow]` | Include all parts: `📋 1000xdev [rules-workflow]` |
| Not at beginning | `Starting work... 📋 1000xdev [rules-workflow]` | Move to beginning: `📋 1000xdev [rules-workflow] Starting work...` |

## Effective Symbol Combinations

Certain symbols are frequently used together in specific patterns:

### Documentation Symbol Combinations

| Combination | Purpose | Example |
|-------------|---------|---------|
| **# + [ ]** | Section with emphasized terms | `# Mode [Planning]` |
| **\| + -** | Table with list items | `\| Category \| - Item 1<br>- Item 2 \|` |
| **@ + \`\`` | Referenced file with backticks | `` `@file.md` `` |
| **> + -** | Blockquote with list | `> Important:<br>- Point 1<br>- Point 2` |
| **```+ @** | Code block with reference | ```````typescript<br>// @ts-ignore`````` |
| **\`\` + .md** | Brain-file reference | `` `global-rules.md` `` |
| **\`\` + .mdc** | Cursor-rule reference | `` `@global-rules.mdc` `` |

### Message-Command Symbol Combinations

| Combination | Purpose | Example |
|-------------|---------|---------|
| **- + :** | Command with parameter separator | `dev-mode: typescript` |
| **: + @** | Parameter with project rule | `verify-planning: @parameters/rules/helpers/verification/verify-planning.mdc` |
| **: + " + "** | Parameter with quoted value | `verify-file: "path with spaces.md"` |
| **@ + .mdc** | Project rule with extension | `@parameters/rules/helpers/verification/verify-planning.mdc` |
| **/ + @** | Path with reference | `path/to/file.md @parameters/rules/helpers/verification/verify-planning.mdc` |

### Mode Indicator Symbol Combinations

| Combination | Purpose | Example |
|-------------|---------|---------|
| **📋 + [ ]** | Plan mode with workflow | `📋 1000xdev [rules-workflow]` |
| **💻 + [ ]** | Dev mode with workflow | `💻 1000xdev [front-end-workflow]` |
| **⚡ + [ ]** | Direct mode with workflow | `⚡ 1000xdev [back-end-workflow]` |
| **[ + -]** | Workflow with kebab-case | `[front-end-workflow]` |
| **📋 + #** | Plan mode with header | `📋 1000xdev [rules-workflow]<br># Planning Update` |
| **💻 + -** | Dev mode with list | `💻 1000xdev [front-end-workflow]<br>- Implemented feature` |
| **⚡ + -** | Direct mode with list | `⚡ 1000xdev [back-end-workflow]<br>- Implemented feature` |

## Symbol Combination Conflicts to Avoid

| Combination | Conflict | Resolution |
|-------------|----------|------------|
| **@ + #** | @ reference with heading | Move reference to beginning of file |
| **@ + @** | Multiple adjacent references | Separate with text or use lists |
| **[ ] + [ ]** | Nested brackets | Use different delimiters for inner grouping |
| **\` + @** | Backtick directly before @ | Add space: \` @file.md` |
| **# + @** | Heading with @ reference | Never use @ in headers |
| **.mdc + edit** | Referencing mdc file for editing | Use .md extension for editing contexts |
| **.md + message-command** | Using .md in message-command | Always use .mdc in message-commands |

## Context-Aware Symbol Usage

Different communication contexts require different symbol usage patterns:

### Planning Mode Documentation Context

| Symbol | Usage Pattern | Example |
|--------|--------------|---------|
| **#** | Used for section headers | `# Requirements`, `## Implementation Plan` |
| **-** | Used for list items | `- First item`, `- Second item` |
| **\|** | Used for table formatting | `\| Header \| Header \|` |
| **\`\`** | Used for inline code or references | `` `verify-planning` `` |
| **@** | Used only at file beginning or in backticks | `@related-file.md` or `` `@parameters/rules/helpers/verification/verify-planning.mdc` `` |
| **.md** | Used for brain-files | `Edit core/identity/global-rules.md` |
| **.mdc** | Used in message-command examples | `` `@parameters/rules/helpers/verification/verify-planning.mdc` `` |

### Developer Mode Implementation Context

| Symbol | Usage Pattern | Example |
|--------|--------------|---------|
| **/**  | Used for file paths | `src/components/Feature.tsx` |
| **:**  | Used for property definitions | `status: 'complete'` |
| **{}** | Used for code blocks and object literals | `{ property: value }` |
| **()** | Used for function calls | `functionName()` |
| **@** | Used in code comments or backtick-wrapped | `// @ts-ignore` or `` `@parameters/rules/helpers/verification/verify-planning.mdc` `` |
| **.md** | Used for brain-files | `Checking core/identity/global-rules.md` |
| **.mdc** | Used in message-command examples | `` `@parameters/rules/helpers/verification/verify-planning.mdc` `` | 