# Notes: Hybrid Command Execution Plan

**Goal:** Refine the 1000xcommands system to clearly support both:
1.  **Explicit Tool Calls:** Defined directly in the command `.md` file (for context loading, simple fixed actions).
2.  **Dynamic Tool Calls:** Triggered by the command, where the AI determines the necessary tool call sequence based on loaded `1000xbrain` process and knowledge files.

**Problem:** Previous refactoring may have overly emphasized dynamic calls, removing potentially useful explicit steps. Need a clear model for how both coexist and how the AI transitions between them during command execution.
