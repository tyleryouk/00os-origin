# 1000xdev Documentation Hub

This documentation hub provides all standards, architecture, onboarding, and integration guides for the GigaSwap application codebase. The structure is designed for maximum clarity and maintainability, with front-end and back-end documentation kept in fully separate subfolders.

## Structure Overview (2025-05)

- **front-end/**: All front-end architecture, standards, dependencies, testing/logging, and extension points. Self-contained for front-end contributors.
- **back-end/**: All back-end architecture, standards, dependencies, testing/logging, and extension points. Self-contained for back-end contributors.
- **full-stack/**: Shared standards and integration docs that apply to both domains (e.g., API design, authentication, error handling).
- **integration/**: Documentation for cross-cutting integrations (Steam, marketplace, external APIs). Each doc is self-contained.
- **onboarding/**: Getting started guides and workflow checklists for new contributors.

## Migration Notice

The previous folders (`front-end-architecture/`, `back-end-architecture/`, `full-stack-workflow/`) are being migrated to this new structure. Legacy docs will be archived for reference.

## Table of Contents

- front-end/
  - overview.md, context.md, dependencies.md, standards.md, testing-logging.md, extension-points.md, README.md
- back-end/
  - overview.md, context.md, dependencies.md, standards.md, testing-logging.md, extension-points.md, README.md
- full-stack/
  - standards.md, integration.md, README.md
- integration/
  - steam.md, marketplace.md, external-apis.md
- onboarding/
  - getting-started.md, workflow-checklists.md

Each folder is self-contained and does not cross-link to other folders. All documentation is written to be standalone and safe to move or restructure as needed.

## 🌐 Purpose & Scope
- This documentation hub is updated and improved every development cycle.
- It contains onboarding guides, workflow standards, technical references, and best practices for all domains (front-end, back-end, and full-stack).
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

---

**For the latest onboarding, workflow, and technical information, always begin with this README and explore the relevant subfolders.**

