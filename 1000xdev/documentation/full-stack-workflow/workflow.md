# 1000xdev Workflow Documentation

> **Note:** All operational rules, standards, and specializations for 1000xdev are defined in [user-rules-1000xdev.md](../user-rules-1000xdev.md). For guidance on updating and maintaining user rules, see [documentation/user-rules-manipulation.md](./user-rules-manipulation.md).

## Overview
The 1000xdev workflow is now organized in a flat, modular structure for clarity, maintainability, and rapid onboarding. All documentation, context, user rules, and research are located in dedicated subfolders: 

---

# Workflow Phase Templates & Checklists

## Request Phase Checklist
- [ ] Review all collaborative planning materials in `user-directed/`
- [ ] Select and clarify requirements for the new cycle
- [ ] Copy requirements into `active-request.md`
- [ ] Confirm scope and context with collaborators if needed

## Context Loading Phase Checklist
- [ ] Identify all relevant documentation, standards, and context files
- [ ] Review technical references in `documentation/`, `context/`, and previous cycles
- [ ] Summarize key findings and dependencies

## Planning Phase Checklist
- [ ] Draft a concrete implementation plan in `cycle.md`
- [ ] Break down work into actionable steps
- [ ] Assign responsibilities (if applicable)
- [ ] Identify blockers, risks, and required resources
- [ ] Review plan with collaborators if needed

## Make Changes and Test Phase Checklist
- [ ] Implement code, test, and documentation changes in `back-end/` and/or `front-end/`
- [ ] Write or update tests in `back-end/tests/` and `front-end/src/__tests__/`
- [ ] Run all relevant tests (unit, integration, E2E)
- [ ] Address any test failures before proceeding
- [ ] Commit changes with clear, descriptive messages referencing the cycle/request
- [ ] If changes span both back-end and front-end, ensure both are updated and tested together
- [ ] Document significant design or architectural decisions

## Update Supporting Materials Phase Checklist
- [ ] Update documentation, templates, or standards in `documentation/` as needed
- [ ] Ensure all supporting materials reflect the latest changes and best practices

## Reset, Archive, & Prepare Phase Checklist
- [ ] Archive the completed `cycle.md` file (move to `archive/` with timestamp or cycle ID)
- [ ] Reset `active-request.md` and `cycle.md` using templates in `documentation/`
- [ ] Ensure all files are up to date and the workflow is ready for the next cycle 