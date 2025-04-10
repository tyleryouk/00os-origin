# Research Summary: Cursor Rules Best Practices

## Key Findings from Documentation and Community Discussions:

1.  **Rule Types & Location**: 
    *   **Project Rules**: Preferred method. Stored in `.cursor/rules/` (or `.cursorrules` file in root, though `.cursor/rules` allows for better organization and is needed for MCP). These provide granular, path-specific control and are version-controllable.
    *   **Global Rules**: Set in Cursor Settings (`General` > `Rules for AI`). Apply to all projects. Useful for universal preferences (e.g., output language, response length).
    *   **Syncing**: Our setup uses `1000xrules` (editable `.md`) synchronized to `.cursor/rules` (`.mdc`), which is consistent with the need for `.cursor/rules` structure.

2.  **Structure & Formatting**: 
    *   **Markdown**: Rules are written in Markdown (`.mdc` files).
    *   **Clarity & Specificity**: Rules should be clear, specific, and use natural language. Vague instructions are less effective (e.g., "Use 2 spaces for indentation" > "Use proper indentation").
    *   **Organization**: Breaking down rules into smaller, focused files within `.cursor/rules` (or our `1000xrules`) is recommended over one large file. This aligns with the `.cursor/rules` directory approach.
    *   **Semantic Descriptions/Globs**: Project rules can use descriptions and glob patterns (`*.tsx`, `**/components/*`) to specify when they should apply.
    *   **Referencing (@)**: Rules can reference other files (`@file`) to include their content as context.
    *   **JSON Structure (Optional)**: Some users experiment with JSON-like structures within markdown for organization (seen in forum examples), but plain markdown with clear headers is standard.

3.  **Perspective (Person)**:
    *   **No Definitive Standard**: Documentation and examples show **both** first-person (user instructing AI) and third-person (describing AI behavior) perspectives.
    *   **Common Practice**: Many examples use **third-person** to define the AI's role, expertise, or required behavior (e.g., "You are an expert in TypeScript...", "Analyze the problem thoroughly...").
    *   **Recommendation for 1000xdev**: Given the goal of defining the `1000xdev` persona as a distinct entity (Jarvis), using the **third-person perspective** seems most appropriate and aligned with community examples. We will instruct `1000xdev` on how *it* should behave, its expertise, and its relationship with Tyler Youk.

4.  **Content Best Practices**: 
    *   **Start Simple**: Begin with basic, high-priority rules.
    *   **Prioritize**: List the most critical rules first.
    *   **Consistency**: Ensure rules don't contradict each other.
    *   **Context**: Include project-specific context (tech stack, architecture, key libraries, naming conventions).
    *   **Examples**: Use brief code snippets to illustrate preferred practices.
    *   **Balance**: Be specific but allow some flexibility for the AI.
    *   **Iteration**: Refine rules based on AI performance.
    *   **Minimalism**: Keep rules concise. Overly long or complex rules can be less effective.
    *   **Persona Definition**: Explicitly defining the AI's role/persona is a common pattern (e.g., "You are an expert...").

5.  **Efficiency & 1000x Development**: 
    *   **Clear Instructions**: Treat the AI like a junior developer needing clear context and guidance (Medium article). Explicit rules, structured tasks, and clear architecture understanding are key.
    *   **Context is Crucial**: Provide sufficient context (@ files, documentation references) to avoid hallucinations and ensure the AI understands the project.
    *   **Planning**: Planning before coding (using AI for planning help) improves results (dev.to article).
    *   **Separate Concerns**: Using different rule files for different aspects (e.g., style, structure, persona) can improve clarity and maintainability.

## Conclusion for Our Implementation:

-   **Structure**: Continue using the `1000xrules` (`.md`) -> `.cursor/rules` (`.mdc`) sync model.
-   **Organization**: Organize rules within `1000xrules/core/` using subdirectories (identity, communication) and potentially further breakdown for clarity.
-   **Perspective**: Write core identity and behavior rules in the **third person**, defining how `1000xdev` should act and interact with Tyler Youk.
-   **Content**: Focus on defining the `1000xdev` persona (Jarvis), the communication protocol (`1000xcommands` vs. regular chat), role separation, and core operational principles. Keep rules clear, specific, and provide context where needed.
-   **1000xcommands**: Treat these `.mdc` files purely as tool invocation sequences, keeping them minimal (header + tool calls). Abstract detailed logic/guidelines into `1000xbrain` knowledge files referenced by the commands. 