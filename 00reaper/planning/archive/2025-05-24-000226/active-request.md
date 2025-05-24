# Active Request

<!--
This file is drafted and updated by 00reaper based on backlog.md and final-goal.md. The user reviews and provides feedback; 00reaper iterates until approved. Only one request is ever present.
--->

## Requirements: Enhancing 1000xdev Workflow and Cycle Hygiene

1. Update and align the 1000xdev workflow with the established 6-step cyclical process:
   1. **AI-Driven Collaborative Planning in planning/**
      - 1000xdev reviews `backlog.md` and `final-goal.md` and drafts a proposed `active-request.md` for the next cycle.
      - The user reviews, provides feedback, and 1000xdev iterates until approved.
      - Only 1000xdev edits `active-request.md`; the user never drafts requirements directly.
      - All iterations and feedback are tracked in the planning files and action log.
      - Approval is given by the user sending `> dev-implement` to start the next step.
   2. **Read Relevant Context:**
      - Review all relevant documentation and standards needed to support the requirements.
      - Define a clear, streamlined process for loading relevant documentation based on task type (front-end, back-end, or full-stack).
      - Implement a "just enough context" approach that minimizes reading while maximizing productivity.
   3. **Update cycle-status File:**
      - Draft the implementation plan, track progress, and log enhancements in `cycle-status.md`.
   4. **Make Changes and Test:**
      - Implement the plan by making all necessary code, test, and documentation changes.
      - Run all relevant tests and address any failures before proceeding.
   5. **Update Supporting Materials:**
      - Update documentation in the `documentation/` folder as needed.
      - Ensure documentation is modular, focused, and directly actionable.
      - Standardize documentation formats for consistency across domains.
      - Implement documentation templates for each domain (front-end, back-end, full-stack).
   6. **Reset, Archive, & Prepare for Next Cycle:**
      - Archive the completed `cycle-status.md` file to `archive/` with timestamp.
      - Reset `active-request.md` and `cycle-status.md` using templates.
      - Run `> dev-cycle-reset` to automate the archive and reset process.
      - Run `> dev-sync` to update all relevant rules.
      - Prepare for the next cycle.

2. Enhance the `dev-init` process with flags similar to `reaper-init`:
   - Implement `--front-end` flag: Initialize only frontend-specific documentation
   - Implement `--back-end` flag: Initialize only backend-specific documentation
   - Implement `--steam` flag: Initialize Steam API integration specific documentation and research

3. Create and document clear Step 6 process for both 00reaper and 1000xdev:
   - Create `reaper-cycle-reset` and `dev-cycle-reset` commands that automate the archive and reset process
   - Update documentation to clearly explain the archive and reset process
   - Ensure all templates are properly maintained and updated

4. Review and align master workflow files for 1000xdev:
   - Ensure `1000xdev-brain.md`, `README.md`, `user-rules-1000xdev.md`, and `.cursor/rules/1000xdev-master.mdc` exist and are aligned
   - Reference the 6-step cyclical workflow process in all master files
   - Enforce the same solo developer context and self-reinforcement protocol as 00reaper

5. Perform hygiene and maintenance:
   - Update all workflow templates in `planning/templates/` for both agents
   - Review and prioritize items in the self-improvement backlog
   - Ensure clear operational boundaries between 00reaper and 1000xdev
   - Remove empty context folder and emphasize direct documentation reference for efficiency

6. Implement streamlined communication protocol for 1000xdev:
   - Revise master workflow files to define a more direct action-oriented communication style
   - Default to making immediate changes to workflow files or codebase rather than providing explanations
   - Remove any requirement for user approval of explanations before changes are made
   - Emphasize that the user trusts 1000xdev to make changes immediately
   - Document this streamlined protocol in all master workflow files to enable true 1000x development speed

7. Enhance and optimize 1000xdev documentation structure:
   - Consolidate and update front-end architecture documentation:
     - Update `directory-structure-front-end-api.md` to reflect current src/ structure
     - Ensure the documentation covers core components, hooks, contexts, and app structure
     - Add reference sections for common patterns and practices
   - Enhance back-end architecture documentation:
     - Update Steam API documentation to ensure complete coverage of models, routes, services, and tests
     - Create documentation templates for new API endpoints and integrations
     - Improve test documentation with comprehensive examples
   - Streamline full-stack workflow documentation:
     - Merge `workflow.md` and `workflow-2.md` into a single, comprehensive resource
     - Update `tool-call-processes.md` with optimized, standardized tool call patterns
     - Document specific processes for common development workflows
   - Implement consistent documentation standards across all domains:
     - Create and document minimum documentation requirements for each domain
     - Define clear cross-referencing between related documentation files
     - Ensure all documentation follows a consistent, scannable format

## Context References
- **Key Files:**
  - `00reaper/planning/backlog.md` (REQ-001 and REQ-002)
  - `00reaper/planning/final-goal.md` (Cycle Hygiene & Reset section)
  - `00reaper/README.md` (6-Step Cyclical Workflow Process)
  - `00reaper/user-rules-00reaper.md` (Reference for 1000xdev equivalent)
  - `1000xdev/documentation/` (Documentation structure to enhance)
  - `1000xdev/documentation/front-end-architecture/` (Front-end documentation)
  - `1000xdev/documentation/back-end-architecture/` (Back-end documentation)
  - `1000xdev/documentation/full-stack-workflow/` (Workflow documentation) 