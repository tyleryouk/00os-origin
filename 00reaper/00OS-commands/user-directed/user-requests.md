# 00OS User Requests and Implementation Tracking

## Request Details
### REQ-000: [New] Revise > reaper-init
For the command and process for `reaper-init`, you should assume that you have no context to begin with. This 00OS command will be utilized to initialize you, 00reaper, with all the context needed to properly make changes to 00OS. We are currently working in the workflow folder 00reaper\00OS-commands, and I want > reaper-init to read files within this folder to fully understand context.

Before updating reaper-init, I want to make enhancements to 00reaper/00OS-commands. I want to enhance this workflow folder so to be more concise and clear as far as the goals for the requests and workflow cycles.  There is really good context in 00reaper\00OS-commands\documentation and 00reaper\00OS-commands\research-cursor. I would like you to make some list_dir and read_file tool calls to the workflow folder 00reaper\00OS-commands to better understand this request. This request will need some formalization as well to ensure a solid cycle to enhance the workflow files (consolidate/optimize workflow files), along with revising reaper-init.



### REQ-001: Update Step 5 so that you only make changes to the documentation in 00reaper\00OS-commands\documentation, the context will be handled seperately.
You tend to create context better with direct invokation of the reaper-overwrite process. Additionally, not all context files need to be updated for every cycle. The overwriting and updating of 00reaper\00OS-commands\context-00OS-current-state will be handled outside of the cycle. Update README.md and user-rules-00OS-commands (if needed) to specify that step 5 of the cyclical process should only make updates/enhancements to 00reaper\00OS-commands\documentation if needed. 

**further context on steps**
Step 2 should read context and documentation, step 5 should only update documentation.

### REQ-002: Update Step 6 to fully clear out the three core workflow files
Right now, cycle-status.md does not get cleared out. Additionally, I do not want to keep any logs of past cycles. Focus on either current or future cycles. 





### REQ-009: Workflow Simplification - File Update Pattern Standardization
#### Requirements
1. **Clear File Update Boundaries**:
   - Step 1: Update ONLY active-request.md
   - Step 2: No file updates (research/knowledge gathering only)
   - Step 3: Update ONLY implementation-plan.md
   - Steps 4-6: Update ONLY cycle-status.md

2. **Workflow Document Specialization**:
   - active-request.md: Requirements document (WHAT needs to be done)
   - implementation-plan.md: Blueprint document (HOW it will be done)
   - cycle-status.md: Progress tracking document (WHERE we are in the process)

3. **Benefits**:
   - Eliminated confusion about which file to update when
   - Reduced cognitive load during development
   - Clearer purpose for each workflow document
   - Simplified training for new contributors

### REQ-010: Workflow Simplification - Automated Workflow Transitions
#### Requirements
1. **Command Shortcuts for Stage Advancement**:
   - Create simple commands to mark completion of current stage
   - Automatically update cycle-status.md with timestamp
   - Pre-populate templates for next stage details

2. **Quick-Copy Templates**:
   - Add standardized templates for each stage update in cycle-status.md
   - Include placeholders for common stage-specific information
   - Enforce consistent formatting across stages

3. **Automated Status Dating**:
   - Automatically add timestamps to status updates
   - Track time spent in each stage
   - Provide metrics on workflow efficiency

4. **Implementation Approach**:
   - Add new 00reaper processes for stage advancement
   - Create standardized templates for each stage
   - Implement simple command syntax like `> reaper-advance-stage`

5. **Benefits**:
   - Reduced manual overhead in workflow transitions
   - Consistent documentation across cycles
   - Better metrics on development process
   - Simplified training for contributors


