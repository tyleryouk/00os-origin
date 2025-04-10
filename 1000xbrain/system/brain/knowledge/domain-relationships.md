# Domain Relationships

## Overview

This knowledge file clarifies the specific roles, responsibilities, and interactions between the three core domains: `system`, `frontend`, and `backend`.

## Domain Definitions

1.  **`system/` Domain**: 
    *   **Focus**: The 1000xdev AI system itself.
    *   **Responsibility**: Managing the AI's cognitive architecture (`1000xbrain/system/`), core operational rules (`1000xrules/`), system-level commands (`1000xcommands/system/`), system-wide guidelines (`1000xbrain/system/guidelines/`), system planning (`1000xplans/system/`), and supporting system scripts (`1000xscripts/system/`).
    *   **Goal**: Maintain and enhance the AI's operational capabilities, efficiency, and the infrastructure supporting application development.

2.  **`frontend/` Domain**:
    *   **Focus**: The target user-facing application being developed.
    *   **Responsibility**: Managing the front-end source code (`/frontend/`), related knowledge and processes (`1000xbrain/frontend/`), development commands (`1000xcommands/frontend/`), feature planning (`1000xplans/frontend/`), and supporting scripts (`1000xscripts/frontend/`).
    *   **Goal**: Implement, test, and maintain the front-end application according to requirements.

3.  **`backend/` Domain**:
    *   **Focus**: The target server-side application being developed.
    *   **Responsibility**: Managing the back-end source code (`/backend/`), related knowledge and processes (`1000xbrain/backend/`), development commands (`1000xcommands/backend/`), feature planning (`1000xplans/backend/`), and supporting scripts (`1000xscripts/backend/`).
    *   **Goal**: Implement, test, and maintain the back-end application, APIs, and data persistence according to requirements.

## Interaction Model

*   **System Supports Applications**: The `system` domain provides the foundational capabilities and infrastructure used by the `frontend` and `backend` domains. 
    *   Example: A `system` command (`run command:system/brain/bootstrap-app-domain`) creates the initial directory structure and placeholder files within the `frontend` or `backend` sections of `1000xbrain`, `1000xcommands`, etc.
    *   Example: `guidelines/` defined in `1000xbrain/system/` are applied during code generation or refactoring performed by `frontend` or `backend` commands.
*   **Application Domains are Separate**: The `frontend` and `backend` domains operate largely independently of each other, focusing on their specific application codebase. 
    *   Cross-application communication (e.g., API contracts) should be managed through requirements and planning documents (`1000xplans`) rather than direct command interactions between the `frontend` and `backend` domains.
*   **Brain Guides Commands**: Within each domain, the `1000xbrain/<domain>/` knowledge and processes guide the execution of `1000xcommands/<domain>/` commands.

## Scope Boundaries

*   Commands within the `system` domain should generally **not** directly modify application source code in `/frontend/` or `/backend/`. Their focus is on the meta-system.
*   Commands within the `frontend` or `backend` domains should generally **not** directly modify core system components like `1000xrules/` or `1000xbrain/system/guidelines/`. They consume system resources but don't manage them.
*   Changes that span domains (e.g., a new guideline affecting application code) should be orchestrated carefully, likely involving system-level analysis or planning steps before implementing changes in application domains. 