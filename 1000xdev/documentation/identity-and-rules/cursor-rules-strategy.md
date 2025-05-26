# Cursor Rules Strategy for GigaSwap

## Rationale for Minimal, Master Rules

### Drawbacks of Too Many or Overly Granular Rules
- **Confusion:** Multiple overlapping or redundant rules can dilute context and lead to conflicting guidance for the agent.
- **Maintenance Burden:** Each rule requires ongoing updates as workflows, folder structures, or best practices evolve. The more rules, the higher the risk of outdated or orphaned guidance.
- **Context Dilution:** Cursor's context window is limited. Too many rules can crowd out the most important operational and workflow information, reducing agent performance and clarity.

### Benefits of a Single Master Rule per AI Identity
- **Clarity:** One rule per major AI identity (e.g., 00reaper, 1000xdev) ensures the agent always has the most relevant, up-to-date context for its current operational mode.
- **Simplicity:** Fewer files mean less to manage, less risk of inconsistency, and easier onboarding for new workflows or collaborators.
- **Actionability:** A master rule can be tightly focused on identity, operational boundaries, workflow summary, and any solo developer context, making it easy for the agent to follow.

## Recommended Structure for Each Master Rule
- **Identity & Scope:** Clearly state the AI identity (00reaper or 1000xdev), its operational boundaries, and what it is/ is not allowed to do.
- **Workflow Summary:** Summarize the cyclical workflow process (6-step or as appropriate), referencing the key files and folders for that identity.
- **Solo Developer Context:** Explicitly state that the user is a solo developer, and all instructions, templates, and checklists should reflect this (no references to teams or collaborators).
- **User Rules Reference:** Point to the relevant user-rules file (e.g., `user-rules-1000xdev.md` or `user-rules-00reaper.md`) for detailed operational directives.
- **Operational Boundaries:** List which folders/files the identity can and cannot modify, and how to handle planning vs. execution files.

## Manual Attachment & Rule Switching
- **Manual Attachment:** The user (Tyler) should manually attach the appropriate master rule file in `.cursor/rules/` when working with 00reaper or 1000xdev, just as user-rules files are switched.
- **No Permanent Rules:** No rule is permanent. Rules should be periodically reviewed, updated, or replaced as workflows and project needs evolve.
- **Minimalism:** Only attach the master rule for the current operational context. Avoid stacking multiple rules unless absolutely necessary for a specific, temporary purpose.

## Rationale for Minimal, Actionable Rules
- **Supports Clarity:** The agent always operates with a single, clear set of instructions, reducing ambiguity and the risk of conflicting guidance.
- **Improves Performance:** Cursor's context window is used efficiently, focusing on the most actionable and relevant information.
- **Easier Maintenance:** With only one or two master rules to update, keeping guidance current is simple and reliable.

## Summary
- Use a single, master Cursor rule for each major AI identity (00reaper, 1000xdev).
- Attach the rule manually when working in that context, mirroring the user-rules pattern.
- Keep each rule focused, actionable, and minimal—covering identity, workflow, boundaries, and solo developer context.
- Periodically review and update rules as workflows evolve. No rule is permanent.
- This approach maximizes clarity, maintainability, and agent effectiveness in the GigaSwap project. 