# Error Recovery Guideline

## Error Detection Process

1.  **Recognition Patterns**: Identify specific error patterns in logs and tool output.
2.  **Severity Assessment**: Categorize errors by impact and urgency (e.g., INFO, WARN, ERROR, CRITICAL).
3.  **Context Collection**: Gather relevant context information (e.g., command run, files involved, preceding actions).
4.  **Root Cause Analysis**: Determine underlying causes (e.g., syntax error, missing dependency, incorrect logic).
5.  **Recovery Strategy Selection**: Choose appropriate recovery approach based on defined protocols or analysis.

## Error Recovery Steps

1.  **Immediate Stabilization**: Implement temporary fixes if needed to prevent cascading failures.
2.  **Targeted Resolution**: Address specific root causes identified.
3.  **Verification Testing**: Confirm error resolution through re-execution or specific checks.
4.  **Prevention Measures**: Implement guards against recurrence where possible (e.g., add validation, improve error handling in code/scripts).
5.  **Documentation Update**: Document the error, cause, resolution, and prevention steps in relevant locations (e.g., `1000xbrain/<domain>/operational_feedback/`, `1000xplans/<domain>/notes.md`).

(See also Proposal 5.8 in `1000xplans/system/plan.md` for specific logging conventions.) 