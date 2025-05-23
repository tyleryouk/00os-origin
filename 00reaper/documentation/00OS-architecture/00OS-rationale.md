# 00OS & Cursor Rules: Canonical Rationale & Design Philosophy

> For all AI identity definitions and relationships, see [ai-identities/](ai-identities/).

> **This file is the canonical, static rationale for the 00OS system and Cursor rule manipulation. It is only updated for major architectural or philosophical changes. For evolving or cycle-specific context, see `00reaper/context/`.**

---

## Introduction

00OS was created to bring deterministic, auditable, and automatable command execution to Cursor's AI environment, while preserving the power of natural language. This document explains the "why" behind the system's architecture, rule manipulation, and design choices.

---

## Design Philosophy
- **Explicitness over ambiguity:** Every command and process is defined, auditable, and repeatable.
- **Layered guidance:** User rules, project rules, and default rules combine for both global consistency and local flexibility.
- **Separation of concerns:** Development and production rules are kept distinct for safety and clarity.
- **Auditability and onboarding:** All major decisions and rationale are documented for future reference.

---

## Why Cursor Rule Manipulation?
- **Problem:** Pure chat-based AI is powerful but ambiguous, hard to automate, and prone to drift.
- **Solution:** By manipulating Cursor rules, we intercept and structure AI behavior, enabling a terminal-like interface, deterministic command processing, and robust error handling.
- **Always-active rules:** Core components (command handler, parser, registry, executor) are always loaded for reliability.
- **On-demand rules:** Command/process files are loaded as needed, keeping the system modular and efficient.

---

## Historical Problems Solved
- **Ambiguity:** Natural language alone led to unpredictable results; explicit commands solve this.
- **Drift:** Ad hoc rules and context led to inconsistent behavior; a rule-driven system enforces alignment.
- **Lack of auditability:** Previous approaches made it hard to see why the AI did what it did; now, every process is defined and reviewable.
- **Onboarding pain:** New users (or future you) can now understand both the "what" and the "why."

---

## Major Design Decisions
- **Terminal-like interface:** Enables automation, scripting, and repeatability.
- **3-step pattern:** Detect command → fetch process rule → execute tool calls. Ensures reliability and maintainability.
- **Tool call minimalism:** Only the necessary tool calls are made, with clear error handling and standardized responses.
- **Separation of dev/prod rules:** Markdown for development, `.mdc` for production, synced via a controlled process.
- **Dual-mode interface:** Supports both conversational and command-driven workflows.

---

## Future-Proofing
- **Modular rule system:** Easy to add, update, or retire commands and processes.
- **Adaptable to Cursor changes:** Architecture is designed to evolve as Cursor's capabilities grow.
- **Clear update protocol:** Only update this file for major changes; use context for evolving details.

---

## Common Misconceptions & Anti-Patterns
- **"Commands can be run via terminal tool calls."** No—commands must be processed via the rule system, not by executing 00OS commands in the shell.
- **"Rules should be updated ad hoc."** No—use the cyclical workflow and update protocol to avoid drift.
- **"Documentation should be dynamic."** No—keep rationale static; use context for anything that changes frequently.

---

## References & Further Reading
- **Research archive:** See `planning/archive/research-cursor` for deep-dive research and historical docs.
- **Master workflow files:** The single source of truth for operational rules and enforcement.
- **Cursor official docs:**
  - [Cursor Rules](https://docs.cursor.com/context/rules)
  - [Cursor 101: Customizing AI Behavior](https://cursor101.com/article/cursor-rules-customizing-ai-behavior)

---

> **Disclaimer:** This file is static and only updated for major architectural changes. For evolving or cycle-specific context, see `00reaper/context/`. 