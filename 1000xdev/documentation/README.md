# 1000xdev Documentation Hub

> **Note:** All documentation files are subject to change. There should be no cross-referencing between documentation files. Documentation must be concise, directly relevant to the current cycle's tasks, and context not related to the cycle at hand may be removed.

This documentation hub provides all standards, architecture, onboarding, and integration guides for the GigaSwap application codebase. The structure is designed for maximum clarity and maintainability, with front-end and back-end documentation kept in fully separate subfolders.

## Structure Overview (2025-06)

- **front-end/**: All front-end architecture, standards, dependencies, testing/logging, and extension points. Self-contained for front-end contributors.
- **back-end/**: All back-end architecture, standards, dependencies, testing/logging, and extension points. Self-contained for back-end contributors.
- **steam/**: Steam Web API integration, models, routes, services, and tests.
- **gigaswap/**: Marketplace, integration, and external API documentation.
- **identity-and-rules/**: 1000xdev identity, user rules, and cursor rules manipulation docs.

## Table of Contents

- front-end/
  - overview.md
  - context.md
  - dependencies.md
  - standards.md
  - testing-logging.md
  - extension-points.md
  - README.md
- back-end/
  - overview.md
  - context.md
  - dependencies.md
  - standards.md
  - testing-logging.md
  - extension-points.md
  - README.md
- steam/
  - steam.md
  - steam-api-client.md
  - steam-models.md
  - steam-routes.md
  - steam-services.md
  - steam-tests.md
- gigaswap/
  - standards.md
  - integration.md
  - external-apis.md
  - marketplace.md
  - steam.md
  - README.md
- identity-and-rules/
  - 1000xdev-identity.md
  - dual-mode-interface.md
  - user-rules-manipulation.md
  - cursor-rules-manipulation.md
  - cursor-rules-strategy.md

- TODO.md (root)

Each folder is self-contained and does not cross-link to other folders. All documentation is written to be standalone and safe to move or restructure as needed.

## 🌐 Purpose & Scope
- This documentation hub is updated and improved every development cycle.
- It contains onboarding guides, workflow standards, technical references, and best practices for all domains (front-end, back-end, and integrations).
- The structure and content of this folder will change as the system evolves and new requirements emerge.

> **Important Note for 1000xdev:** You are expected and encouraged to revise, enhance, and expand this documentation as you develop and gain deeper understanding of the codebase. The current documentation serves as a starting point, and you should continuously refine it to reflect the evolving architecture and best practices you discover.

## 🚦 How to Use This Hub
- **Always start here** for the latest onboarding and workflow entry points.
- **Check subfolders** for the most current guides, technical references, and standards for your domain.
- **Expect change:** Documentation is actively maintained and improved every cycle, especially during Step 5 (Update Supporting Materials) of the workflow.
- If you find missing, outdated, or unclear documentation, update it as part of the current cycle or log it for the next one.

## 🛠️ Continuous Improvement
- This documentation is a living resource—expect regular updates, restructuring, and new content as the project grows.
- All major changes are tracked in the cycle-status file for each development cycle.
- **1000xdev's Role:** As you work with the codebase, you should:
  - Update documentation to reflect new insights about code structure and patterns
  - Revise technical guidance based on implementation experience
  - Enhance workflow documentation to improve development efficiency
  - Create new documentation for emerging patterns and technologies
  - Propose and implement improvements to the documentation structure itself

## 🔄 Workflow Enhancement
You are encouraged to make changes to enhance the workflow as a whole. This includes:
- Refining existing processes and standards
- Creating new templates and guides
- Proposing and implementing new 00OS commands
- Streamlining repetitive tasks
- Documenting new patterns and best practices you discover

Remember that documentation is a crucial part of development, not an afterthought. Quality documentation accelerates onboarding, improves consistency, and reduces technical debt.

## 🆕 Iterative Development Commands (Added 2025-01-08)

Four new 00OS commands were added this cycle to automate iterative development tasks across both domains:

| Command | Domain | Purpose |
|---------|--------|---------|
| `> dev-iterate-back-end` | back-end | Reads back-end logs, analyses TODO.md, makes iterative code edits until all back-end tasks are complete |
| `> dev-iterate-front-end` | front-end | Reads front-end logs, analyses TODO.md, makes iterative code edits until all front-end tasks are complete |
| `> dev-iterate-full-stack` | full-stack | Coordinates changes across back-end and front-end, ensuring API contracts and UI integration stay in sync |
| `> dev-analyze-logs` | back-end / front-end (flagged) | One-off command: analyze logs once, optionally edit files once (`--edit`) |

### Key Features:
- **Automated log analysis**: Commands automatically read and parse error logs from both applications
- **TODO.md integration**: Tasks are pulled from TODO.md and processed iteratively
- **Domain boundaries**: Each command respects domain boundaries (back-end only edits back-end files, etc.)
- **Error handling**: Robust error detection and recovery mechanisms
- **Flag system**: `dev-analyze-logs` uses `--front-end` or `--back-end` flags with optional `--edit` flag

### Usage Examples:
```bash
> dev-iterate-back-end       # Iteratively fix back-end issues until TODO.md tasks complete
> dev-iterate-front-end      # Iteratively fix front-end issues until TODO.md tasks complete
> dev-iterate-full-stack     # Handle both domains with coordination
> dev-analyze-logs --back-end          # Analyze back-end logs once (no edits)
> dev-analyze-logs --front-end --edit  # Analyze front-end logs and make one edit cycle
```

All PowerShell commands inside these processes now start with:

```
cd C:\Users\ethde\Desktop\GigaSwap;
```

ensuring the correct working directory regardless of where the agent starts.

Refer to `00OS/processes/1000xdev/` for full implementation details.

---

**For the latest onboarding, workflow, and technical information, always begin with this README and explore the relevant subfolders.**

