# System Change Philosophy

## Overview

This document outlines the core philosophy guiding modifications across the interconnected 1000x systems (`1000xbrain`, `1000xcommands`, `1000xplans`, `1000xrules`). The goal is to ensure changes are implemented consistently, efficiently, and safely, maintaining system integrity while enabling evolution.

## Core Principles

1.  **Holistic View**: Changes in one system component must consider potential impacts across all related systems.
2.  **Incremental Implementation**: Prefer smaller, verifiable changes over large, monolithic updates.
3.  **Consistency**: Adhere to established patterns, naming conventions, and architectural principles defined within `1000xrules` and `1000xbrain`.
4.  **Automation**: Leverage `1000xcommands` and automated processes (`system-change-workflow.md`) wherever possible to reduce manual effort and ensure repeatability.
5.  **Verification**: All changes require verification to confirm they meet requirements and do not introduce regressions.
6.  **Documentation**: Rationale and impact of significant changes should be documented appropriately (e.g., commit messages, planning artifacts).
7.  **Core Rule Precedence**: All changes must remain compliant with the core rules defined in `1000xrules/core/`. 