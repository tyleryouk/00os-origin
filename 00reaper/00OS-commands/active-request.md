# REQ-000: Enhance Workflow Folder and Revise reaper-init Command

## Part 1: Workflow Folder Enhancement
### Requirements
1. **Documentation Organization**
   - Review and consolidate documentation in `00reaper/00OS-commands/documentation/`
   - Ensure all process templates and standards are up-to-date
   - Move any implementation-specific details to appropriate documentation files

2. **Core Workflow File Optimization**
   - Ensure all four root files stay under 250 lines:
     - README.md: Core workflow overview and quick start
     - active-request.md: Current request requirements
     - implementation-plan.md: Concrete implementation steps
     - cycle-status.md: Progress tracking
   - Abstract detailed documentation to appropriate subdirectories

3. **Workflow Process Clarification**
   - Update step definitions for better clarity:
     - Step 1: ONLY update active-request.md
     - Step 2: Read context/documentation (no file updates)
     - Step 3: ONLY update implementation-plan.md
     - Step 4: Make changes to 00OS
     - Step 5: ONLY update documentation if needed
     - Step 6: Clear ALL core workflow files completely

4. **File Purpose Specialization**
   - active-request.md: WHAT needs to be done (requirements)
   - implementation-plan.md: HOW it will be done (blueprint)
   - cycle-status.md: WHERE we are in the process (tracking)

## Part 2: reaper-init Command Revision
### Requirements
1. **Context Loading**
   - Start with zero context assumption
   - Read and process all files in workflow folder:
     - Documentation and standards
     - Research materials
     - Current context state
     - Templates and guides

2. **Process Enhancement**
   - Implement strict tool call sequence:
     - list_dir for directory structure understanding
     - read_file for content processing
     - No terminal commands or self-execution
   - Follow standardized error handling and response formatting

3. **Initialization Flow**
   - Clear understanding of workflow folder structure
   - Load all necessary documentation and standards
   - Process current context state
   - Prepare for immediate task execution

## Completion Criteria
- [ ] Workflow folder structure optimized and documented
- [ ] Core workflow files consolidated to under 250 lines each
- [ ] Step definitions updated and clarified
- [ ] File update boundaries established and documented
- [ ] reaper-init command revised with proper tool call sequence
- [ ] All changes follow 00OS command standards and patterns

## Success Metrics
1. All core workflow files under 250 lines
2. Clear separation of concerns in workflow files
3. Simplified but comprehensive workflow process
4. reaper-init successfully initializes with zero context
5. Documentation properly organized and accessible





