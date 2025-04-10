# Process: Application Domain Knowledge Population

## Purpose

This process outlines the steps for guiding the initial population of core knowledge files for a specified application domain (`frontend` or `backend`) within `1000xbrain/<domain>/knowledge/`, based on provided application requirements.

## Trigger

Invoked via `run command:system/brain/populate-app-domain-knowledge domain=<frontend|backend> requirements_path=<path/to/requirements.md>`.

## Inputs

*   `domain`: The target application domain (`frontend` or `backend`).
*   `requirements_path`: The relative path to the file containing the application requirements.

## Steps

1.  **Parse & Validate Inputs**: Extract `domain` and `requirements_path` arguments. Verify domain is valid and requirements path exists.
2.  **Read Requirements**: Read the content of the file specified by `requirements_path` using `read_file`.
3.  **Analyze & Synthesize**: Process the requirements content to identify:
    *   Overall purpose and goals of the application domain.
    *   Key technical concepts, components, or libraries.
    *   Common architectural patterns or workflows.
    *   Essential setup or configuration details.
4.  **Populate Knowledge Files**: Use `edit_file` to add the synthesized information to the corresponding placeholder files within `1000xbrain/<domain>/knowledge/`:
    *   `domain-overview.md`: Add purpose, goals, key concepts.
    *   `core-patterns.md`: Add identified patterns/workflows.
    *   `setup-guide.md`: Add setup/configuration details.
5.  **Log Results**: Record the population process, key findings, and success/failure status in `1000xbrain/system/brain/operational_feedback/app-domain-knowledge-population.log`.
6.  **Update Progress**: Update `1000xplans/system/implementation-progress.md` to mark initial knowledge population for the specified `domain` as complete.

## Outputs

*   Populated knowledge files (`domain-overview.md`, `core-patterns.md`, `setup-guide.md`) in `1000xbrain/<domain>/knowledge/`.
*   Log file updated.
*   Progress tracker updated. 