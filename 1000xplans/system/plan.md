# Plan: Comprehensive 1000x System Architecture Enhancement

## 1. Overview

This plan outlines the strategy for analyzing, refining, and fully implementing the various 1000x systems (`1000xbrain`, `1000xrules`, `1000xcommands`, `1000xplans`, `1000xscripts`). The primary goal is to create a robust, interconnected, and autonomous cognitive architecture based on three primary domains (`system`, `frontend`, `backend`). **This architecture establishes `1000xbrain` as the central master system, containing the core knowledge and processes that guide the operations of the other `1000x` subsystems (`1000xrules`, `1000xcommands`, `1000xscripts`, `1000xplans`).** The aim is to truly enable a 1000x development workflow, addressing recent hallucinations and ensuring future stability and maintainability.

## 2. Goals (Project Agnostic)

The overarching goals for the 1000x systems are:

*   **Achieve True 1000x Development Workflow**: Maximize AI autonomy and efficiency in planning, implementation, analysis, and self-improvement for `frontend` and `backend` development, governed by the `system` domain.
*   **Autonomous System Optimization**: Enable 1000xdev to autonomously maintain and enhance its own cognitive architecture (the components within the `system` domain: `brain`, `rules`, `commands`, `plans`, `scripts`).
*   **Reliable Configuration**: Function as the definitive configuration and knowledge source for 1000xdev, with clear separation between `system`, `frontend`, and `backend` knowledge in `1000xbrain`.
*   **Efficient Information Retrieval**: Allow seamless access to rules (`1000xrules`), knowledge/processes (`1000xbrain`), plans (`1000xplans`), and commands (`1000xcommands`) across all domains, orchestrated by `1000xbrain`.
*   **Seamless Cross-System Communication**: Ensure information flows logically between the `1000xbrain` master system and its guided subsystems (`1000xrules`, `1000xcommands`, etc.), respecting the `system`/`frontend`/`backend` separation.
*   **Maintainability & Scalability**: Design systems that are easy to understand, modify, and extend as capabilities grow.

## 3. Current State Analysis (Reflecting New Structure & Hierarchy)

*   **`1000xbrain` (Master System)**: The central cognitive hub. Contains top-level domains: `system/`, `frontend/`, `backend/`.
    *   `system/`: Houses knowledge *about* the meta-subsystems and system-wide operational guidelines. Organized with subdirectories mirroring the subsystems it guides: `brain/` (self-reflection), `rules/`, `commands/`, `plans/`, `scripts/`, plus `guidelines/`. Knowledge and processes reside within these (e.g., `1000xbrain/system/rules/knowledge/`, `1000xbrain/system/commands/processes/`). This domain needs significant population.
    *   `frontend/`, `backend/`: Intended for application-specific knowledge and processes. Largely needs implementation.
*   **`1000xrules` (Subsystem)**: The core rule set defining identity, safety, and essential mechanisms. Remains minimal and stable, located primarily under `1000xrules/core/`. Guided by `1000xbrain/system/rules/` knowledge where applicable.
*   **`1000xcommands` (Subsystem)**: Contains executable command definitions. Contains top-level domains: `system/`, `frontend/`, `backend/`. Guided by `1000xbrain/system/commands/` knowledge and processes.
    *   `system/`: Contains commands *targeting* the meta-subsystems. Organized with subdirectories mirroring `1000xbrain/system/` (e.g., `system/brain/`, `system/rules/`, `system/commands/`). Some core commands exist but need refinement and adherence to brain guidance.
    *   `frontend/`, `backend/`: Intended for application development commands. Needs definition.
*   **`1000xplans` (Subsystem)**: Contains planning documents. Contains top-level domains: `system/`, `frontend/`, `backend/`. Guided by `1000xbrain/system/plans/` knowledge.
    *   `system/`: Contains *all* plans related to enhancing the 1000x meta-system (including `1000xbrain` itself). **Maintains a flat structure** (no subdirectories for subsystems) for simplicity in cross-cutting plans. Current plan files reside here.
    *   `frontend/`, `backend/`: Intended for application development plans.
*   **`1000xscripts` (Subsystem)**: Contains utility scripts. Likely organized by domain: `system/`, `frontend/`, `backend/`. Guided by `1000xbrain/system/scripts/` knowledge.
    *   `system/`: Contains scripts supporting the meta-systems (sync, validation, generation, etc.). Likely uses subdirectories (e.g., `system/brain/`, `system/rules/`). Core scripts exist.
    *   `frontend/`, `backend/`: Intended for application-specific utility scripts.

## 4. Detailed Plan

**Phase 1: Deep Dive Analysis & Goal Refinement (Partially Complete)**

1.  **Systematic Review**: Continue/Complete reading and analyzing *every* file within each 1000x system (`1000xrules`, `1000xbrain`, `1000xcommands`, `1000xplans`, `1000xscripts`), now interpreting them through the lens of the `system`/`frontend`/`backend` structure.
    *   **Tool**: `read_file` (using mandatory adaptive reading).
    *   **Output**: Detailed notes in `1000xplans/system/notes.md` documenting purpose, content, connections, and potential issues for each file/directory, aligned with the new structure.
2.  **Goal Internalization**: Re-read and internalize the core goals (Section 2) and the new structural model. Synthesize findings against these goals.
    *   **Output**: Updated section in `notes.md` summarizing alignment and gaps.
3.  **Identify Redundancy/Conflict**: Explicitly look for overlapping information, conflicting guidelines, or unclear responsibilities based on the new structure.
    *   **Output**: Sections in relevant `research_*.md` files (currently in `1000xplans/system/brain/`, to be moved to `1000xplans/system/`).

**Phase 2: Cross-System Communication Enhancement**

1.  **Map Information Flow**: Diagram the intended information flow between systems within and across the `system`, `frontend`, and `backend` domains.
    *   **Tool**: Analysis and documentation.
    *   **Output**: Conceptual flow documented in `1000xplans/system/notes.md`.
2.  **Define Integration Points**: Propose specific mechanisms reflecting the new structure.
    *   **Output**: Concrete proposals added to Section 5 of this plan file.

**Phase 3: Centralized Guidelines Implementation**

1.  **Identify Guideline Candidates**: Determine necessary system-wide guidelines (best practices, conventions, architectural patterns) beyond the core rules in `1000xrules`.
    *   **Tool**: Analysis of `1000xrules` content and identified needs.
    *   **Output**: List of candidate guideline topics in `1000xplans/system/notes.md`.
2.  **Implement Guideline System**: Create the `1000xbrain/system/guidelines/` directory and populate it with initial guideline files based on candidates (e.g., migrating relevant content from `1000xrules/core/identity/implementation-standards.md`).
    *   **Output**: Guideline files created in `1000xbrain/system/guidelines/`. Source rules potentially simplified. (See Section 6).
3.  **Plan Migration/Creation**: Outline steps to migrate/create guidelines.
    *   **Output**: Migration steps added to Section 6 of this plan file.

**Phase 4: Autonomous Application Domain Implementation System**

1.  **Define Core Domain Templates**: Identify essential file types for `frontend` and `backend` domains in `1000xbrain` (e.g., `knowledge/domain-overview.md`) and `1000xcommands` (e.g., `initiate-task.md`).
    *   **Tool**: Analysis.
    *   **Output**: List of required template files in `1000xplans/system/requirements.md`.
2.  **Design `1000xcommands` for Implementation**: Plan meta-commands within the `1000xcommands/system/brain/` domain to manage application domains:
    *   Bootstrap `frontend`/`backend` domains (create standard folders/files).
    *   Guide population of `frontend`/`backend` knowledge.
    *   Verify `frontend`/`backend` setup.
    *   **Example Command**: `run command:system/brain/bootstrap-app-domain domain=<frontend|backend>`
    *   **Output**: Detailed command definitions added to Section 7 of this plan file.
3.  **Leverage Hybrid Execution**: Ensure these commands use dynamic execution referencing process files in `1000xbrain/system/brain/processes/`.
    *   **Output**: Notes on hybrid model application within command plans (Section 7).

**Phase 5: Implementation & Verification**

1.  **Execute Plan Sections**: Systematically implement the changes outlined in Phases 2, 3, and 4.
2.  **Verify Changes**: Confirm correct file creation/modification, adherence to guidelines, logical consistency, and command functionality.
3.  **Update Documentation**: Ensure all relevant structure files, guidelines, and process documents are updated to reflect the new architecture.

## 5. Proposals: Cross-System Communication Enhancements

*(Refined based on Phase 1 and new structure)*

*   **Proposal 5.1: Standardized Plan Context Passing**
    *   **Problem:** Commands needing plan context rely on inference.
    *   **Proposal:** Define a convention within dynamic execution process files (e.g., in `1000xbrain/system/brain/processes/`) to retrieve necessary context. **Specifically:**
        *   The initiating context (e.g., user prompt or higher-level command) should ideally pass the relative path to the relevant `plan.md` file (e.g., `1000xplans/system/plan.md`) as an argument to the command being invoked.
        *   Alternatively, the process logic can infer the plan path based on the command's domain (`system`, `frontend`, `backend`).
        *   The process should use `read_file` to access the plan and parse required sections (e.g., specific requirements, target files) as needed.
    *   **Benefit:** Clear, maintainable communication from `1000xplans` to `1000xcommands`.

*   **Proposal 5.2: Explicit Knowledge/Process Loading Mandate**
    *   **Problem:** Placeholder commands instead of explicit loading.
    *   **Proposal:** Strictly mandate `# --- BEGIN DYNAMIC EXECUTION ---` with `Process:` and `Knowledge:` lines for non-trivial commands, referencing files in `1000xbrain/<domain>/processes/` or `1000xbrain/<domain>/knowledge/` (using correct domain: `system`, `frontend`, `backend`, potentially with sub-paths like `system/brain`).
    *   **Benefit:** Improves Reliability, Maintainability, Traceability.

*   **Proposal 5.3: `1000xbrain` Domain Structure Enforcement (ADOPTED)**
    *   **Problem:** Previous structure ambiguity.
    *   **Proposal:**
        *   **Adopted Structure & Hierarchy:** `1000xbrain` is the master system containing `system/`, `frontend/`, `backend/`. `1000xbrain/system/` contains subdirectories for meta-subsystems (`brain/`, `rules/`, `commands/`, `plans/`, `scripts/`) and `guidelines/`, housing the knowledge and processes that guide these subsystems. `1000xcommands/system/` mirrors this subdirectory structure for targeted commands. `1000xplans/system/` remains flat.
        *   **Update Structure Definition:** Create/Update `1000xbrain/system/brain/knowledge/1000xbrain-structure.md` and `1000xbrain/system/brain/knowledge/1000x-system-hierarchy.md` to accurately reflect this.
        *   **Create Standard Directories:** Implement task/command (`run command:system/brain/verify-domain-structure domain=system`) to verify/create standard subdirectories (`knowledge/`, `processes/`, `operational_feedback/`, `enhancements.md`) within `1000xbrain/system/<component>/`, `1000xbrain/frontend/`, `1000xbrain/backend/`. Ensure corresponding `1000xcommands/system/<component>/` directories exist.
        *   **Update References:** Modify *all* existing `1000xcommands` and `1000xbrain` files to use the correct paths reflecting the master/subsystem relationship (e.g., knowledge guiding commands resides in `1000xbrain/system/commands/knowledge/`).
        *   **Update Documentation:** Update related documentation (`global-rules.md`, etc.).
    *   **Benefit:** Essential for Reliable Configuration, Seamless Communication, Maintainability.

*   **Proposal 5.4: Standardized Script Interaction**
    *   **Problem:** Lack of script standards.
    *   **Proposal:** Define basic standards for scripts within `1000xscripts/<domain>/`. **Specifically:**
        *   **Arguments:** Accept clear, documented arguments (e.g., named parameters like `-InputFile C:\path` or key-value pairs).
        *   **Output (stdout):** Primarily output machine-readable data (e.g., JSON, structured text) or clear success/failure indicators. Avoid verbose conversational output unless explicitly intended for direct user display.
        *   **Logging:** Log significant events or errors to a designated file in `1000xbrain/<domain>/operational_feedback/` (e.g., `1000xbrain/system/scripts/operational_feedback/sync-rules.log`). Use standard error (stderr) for transient errors or verbose debug output.
        *   **Exit Codes:** Use standard exit codes (0 for success, non-zero for specific error types).
        *   **README.md:** Each script MUST have a `README.md` explaining its purpose, usage, arguments, expected output, logging behavior, and exit codes.
    *   **Benefit:** Improves reliability of `1000xcommands` <-> `1000xscripts` integration.

*   **Proposal 5.5: Explicit Rule Checks in Processes (Future Consideration)**
    *   **Problem:** Ensuring processes adhere to rules relies on interpretation.
    *   **Proposal:** Explore explicitly referencing/checking `1000xrules` within critical `1000xbrain` process definitions. (Defer).
    *   **Benefit:** Potentially enhances reliability.

*   **Proposal 5.6: Command Consolidation & Refinement**
    *   **Problem:** Redundancy/inconsistency in commands.
    *   **Proposal:** Review commands (e.g., `verify-all-commands` likely becomes `run command:system/commands/verify-all`, `create-1000xcommand` becomes `run command:system/commands/create`). Consolidate logic, ensure dynamic execution referencing processes in `1000xbrain/system/<component>/processes/`. Remove placeholders.
    *   **Benefit:** Reduces redundancy, improves maintainability.

*   **Proposal 5.7: Path & Tool Usage Update Sweep**
    *   **Problem:** Outdated paths/tools in commands/knowledge.
    *   **Proposal:** Systematically review/update `1000xcommands` and `1000xbrain`: Correct paths (e.g., `1000xplans/system/`, `1000xbrain/system/guidelines/`, `1000xbrain/system/brain/knowledge/`), replace deprecated tools (`fetch_rules` -> `read_file`), ensure correct `run command:<domain>/...` syntax.
    *   **Benefit:** Ensures function and consistency.

*   **Proposal 5.8: Standardized Feedback Loop (Logging & Progress)**
    *   **Problem:** Potentially inconsistent or ad-hoc logging and progress tracking during complex operations.
    *   **Proposal:** Define standard conventions for operational feedback.
        *   **Logging:** Commands and processes should log key actions, decisions, errors, and outcomes to `1000xbrain/<domain>/operational_feedback/<component_name>.log` (e.g., `1000xbrain/system/commands/operational_feedback/verify-all.log` or `1000xbrain/frontend/operational_feedback/build-process.log`). Logs should ideally include timestamps and severity levels (INFO, WARN, ERROR).
        *   **Progress Updates:** For multi-step commands or processes defined in `1000xbrain`, update the corresponding `1000xplans/<domain>/implementation-progress.md` file after significant milestones are achieved or if errors occur. Updates should clearly state the completed step, the outcome (success/failure), and any relevant output or next steps.
    *   **Benefit:** Improves traceability, debugging visibility, and monitoring of task execution.

## 6. Proposals: Centralized Guideline System

*   **Final Location**: `1000xbrain/system/guidelines/`
    *   **Rationale**: Consolidates system-wide operational guidelines within `1000xbrain`'s `system` domain, separating them from core `1000xrules` and domain-specific knowledge. This keeps `1000xrules` lean and establishes **`1000xbrain` as the master repository for *how* the system operates globally, guiding all subsystems.**

*   **Proposed Structure**: Subdirectories within `guidelines/` organized by topic:
    *   `guidelines/implementation/` (general approach, patterns)
    *   `guidelines/coding/` (language standards - maybe under `frontend`/`backend` later?)
    *   `guidelines/documentation/` (docs, READMEs, comments)
    *   `guidelines/tool-usage/` (tool best practices)
    *   `guidelines/error-handling/` (recovery, logging)
    *   `guidelines/performance/` (optimization)
    *   `guidelines/communication/` (status reporting)
    *   *Other topics as needed.*

*   **Migration Plan** (`1000xrules/.../implementation-standards.md` -> Guideline Files):
    1.  **Create Guideline Directory**: Ensure `1000xbrain/system/guidelines/` and initial topic subdirectories exist.
    2.  **Create New Guideline Files**: Create target files (e.g., `1000xbrain/system/guidelines/implementation/core-approach.md`).
    3.  **Read Source Rule**: Read `1000xrules/core/identity/implementation-standards.md`.
    4.  **Edit Source Rule (Simplify)**: Remove detailed guideline content from `implementation-standards.md`, leaving essential mandatory statements and pointers to the new guidelines located in the master `1000xbrain` system (e.g., \"Core implementation MUST follow guidelines in `1000xbrain/system/guidelines/implementation/`\").
    5.  **Edit New Guideline Files (Add Content)**: Populate the new guideline files with content migrated from the source rule.
    6.  **Update References**: Search across systems (`1000xrules`, `1000xbrain`, `1000xcommands`) for references to the old rule sections and update them to point to the new guideline file paths within `1000xbrain` (e.g., `1000xbrain/system/guidelines/...`).
    7.  **Verification**: Read modified source rule and new guideline files.

*   **New Guidelines to Consider Creating**:
    *   Guideline for creating/structuring `1000xcommands` definitions (in `1000xbrain/system/commands/knowledge/`).
    *   Guideline for designing `1000xbrain` process files (in `1000xbrain/system/brain/knowledge/`).
    *   Guideline for `run_terminal_cmd` usage (in `1000xbrain/system/guidelines/tool-usage/`).
    *   Guideline for PowerShell standards (in `1000xbrain/system/scripts/knowledge/`).
    *   Guideline on documentation standards (in `1000xbrain/system/guidelines/documentation/`).

## 7. Proposals: Autonomous Application Domain Implementation System

*(Refined based on Phase 1 and structure)*

*   **Command**: `run command:system/brain/bootstrap-app-domain domain=<frontend|backend>`
    *   **Purpose**: Creates the standard directory structure and initial template files for the specified application domain (`frontend` or `backend`) within the `1000xbrain`, `1000xcommands`, `1000xplans`, and `1000xscripts` directories, based on the templates defined in `1000xplans/system/requirements.md`.
    *   **Process Ref**: `1000xbrain/system/brain/processes/app-domain-bootstrap.md` (To be created).
    *   **Implementation Notes**: Must use **dynamic execution** referencing the `1000xbrain` process file. The process logic should:
        1.  Parse the `domain` argument (`frontend` or `backend`). Validate input.
        2.  Read `1000xplans/system/requirements.md` to get the list of required files/directories for the specified domain.
        3.  Iterate through the list, using `edit_file` (with empty content or placeholder text as defined in requirements) to create each file and implicitly the required directories in `1000xbrain/<domain>/`, `1000xcommands/<domain>/`, `1000xplans/<domain>/`, and `1000xscripts/<domain>/`. Use `.gitkeep` for empty directories where specified.
        4.  Log the creation process (success/failure for each item) to `1000xbrain/system/brain/operational_feedback/app-domain-bootstrap.log`.
        5.  Update `1000xplans/system/implementation-progress.md` indicating completion of bootstrapping for the specified domain.

*   **Command**: `run command:system/brain/populate-app-domain-knowledge domain=<frontend|backend> requirements_path=<path/to/requirements.md>`
    *   **Purpose**: Guides the initial population of core knowledge files (e.g., `domain-overview.md`, `core-patterns.md`) for the specified application domain within `1000xbrain/<domain>/knowledge/`, based on provided application requirements.
    *   **Process Ref**: `1000xbrain/system/brain/processes/app-domain-knowledge-population.md` (To be created).
    *   **Implementation Notes**: Must use **dynamic execution** referencing the `1000xbrain` process file. The process logic should:
        1.  Parse `domain` and `requirements_path` arguments. Validate inputs.
        2.  Read the specified requirements file (`requirements_path`) using `read_file`.
        3.  Perform analysis and synthesis of the requirements to extract key concepts, purpose, patterns, and setup information relevant to the domain.
        4.  Use `edit_file` to populate the corresponding knowledge files in `1000xbrain/<domain>/knowledge/` (e.g., `domain-overview.md`, `core-patterns.md`, `setup-guide.md`) with the synthesized information.
        5.  Log the population process and key findings to `1000xbrain/system/brain/operational_feedback/app-domain-knowledge-population.log`.
        6.  Update `1000xplans/system/implementation-progress.md` indicating completion of initial knowledge population.

*   **Command**: `run command:system/brain/verify-app-domain-setup domain=<frontend|backend>`
    *   **Purpose**: Verifies that the standard directory structure and template files exist for the specified application domain (`frontend` or `backend`) across `1000xbrain`, `1000xcommands`, `1000xplans`, and `1000xscripts`, comparing against the definitions in `1000xplans/system/requirements.md`.
    *   **Process Ref**: `1000xbrain/system/brain/processes/app-domain-verification.md` (To be created).
    *   **Implementation Notes**: Must use **dynamic execution** referencing the `1000xbrain` process file. The process logic should:
        1.  Parse the `domain` argument. Validate input.
        2.  Read `1000xplans/system/requirements.md` to get the list of expected files/directories.
        3.  Iterate through the list, using `list_dir` and potentially `read_file` (to check for file existence, not content) to verify the presence of each item in the corresponding location (`1000xbrain/<domain>/`, `1000xcommands/<domain>/`, etc.).
        4.  Compile a list of findings (present/missing items).
        5.  Log the verification results (summary and detailed findings) to `1000xbrain/system/brain/operational_feedback/app-domain-verification.log`. Optionally, append a summary to `1000xplans/system/notes.md`.

## 8. Implementation Progress Tracking

*   Progress tracked in `1000xplans/system/implementation-progress.md`.
*   Notes kept in `1000xplans/system/notes.md`.

## 9. Verification Strategy

*   Adherence to file reading protocol.
*   Verification of `edit_file` operations.
*   Logical walkthroughs of commands/processes.
*   Cross-referencing against this plan and rules (`1000xrules`, `1000xbrain/system/guidelines/`).
