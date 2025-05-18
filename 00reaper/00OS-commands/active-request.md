<!-- No active request. Ready for new REQ. -->

# REQ-SIMP-004: Cycle 4 - Expand Command Simplification

## Requirements
1. Convert the following system commands to the simplified, direct tool-call format:
   - help
   - version
2. Convert the following 00reaper commands:
   - reaper-sync
   - reaper-init
   - reaper-read-files
   - reaper-analyze-tasks

## Completion Criteria
- [ ] All listed commands follow the 3-step pattern and use direct tool call sequences
- [ ] Implementations are minimal, with no unnecessary validation or error handling
- [ ] Documentation and examples are updated as needed
- [ ] All commands execute successfully and pass basic tests

## Context References
- 00OS-commands/user-directed/00OS-simplification-roadmap.md
- 00OS-commands/documentation/command-template-core.md
- 00OS-commands/documentation/command-standards-core.md

## Related Requests
This is Cycle 4 of the 00OS Command Simplification Initiative.





