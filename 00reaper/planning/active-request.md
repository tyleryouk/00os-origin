# Active Request

<!--
This file is drafted and updated by 00reaper based on backlog.md and final-goal.md. The user reviews and provides feedback; 00reaper iterates until approved. Only one request is ever present.
-->

## Requirements: Transform 1000xdev Documentation into a Modular Onboarding & Reference Hub

1. Redesign the `1000xdev/documentation/` folder to serve as a comprehensive, modular onboarding and reference hub for all 1000xdev, front-end, and back-end development.
2. Add or update onboarding guides for both front-end and back-end, including:
   - Clear getting started steps for new developers
   - Directory/codebase overviews with diagrams or tables
   - How to run, test, and contribute to each domain
3. Improve cross-linking between documentation and actual code/context files:
   - Reference key files and folders in `front-end/` and `back-end/` (e.g., `src/`, `app/`, `context/`, `models/`, `tests/`)
   - Link to context files like `back-end/context/api.json` and `db_schema.json`
   - Reference and explain the purpose of root-level README.md files
4. Ensure all documentation is actionable, discoverable, and up-to-date:
   - Remove or update any legacy or empty files/folders
   - Add a top-level index or map for the documentation folder
   - Use consistent naming and structure for all docs
5. Make the documentation directly support both onboarding and daily developer productivity:
   - Add quick-reference sections for common tasks (e.g., running tests, starting dev servers, debugging)
   - Highlight best practices, standards, and where to find more help
6. **After updating `1000xdev/documentation/`, update the context file `00reaper/context/1000xdev.md` and the documentation in `00reaper/documentation/ai-identities/` to reflect the new structure and onboarding improvements.**

## Context References
- **Key Files:**
  - cycle-status.md
  - 00reaper-brain.md
  - 1000xdev-brain.md
  - 00reaper/planning/templates/
  - 00reaper/documentation/
  - 00reaper/planning/backlog.md
  - 00reaper/planning/final-goal.md
  - 1000xdev/documentation/
  - 00OS/processes/1000xdev/dev-init.md
  - front-end/README.md
  - back-end/README.md
  - back-end/context/api.json
  - back-end/context/db_schema.json
- **Related Requests:**
  - REQ-003: Enhance 1000xdev's documentation folder and dev-init process 