# System Enhancement Notes: Major Changes Workflow

## USER REQUEST SECTION

# --- TEMPLATE START ---
# Instructions:
# 1. Replace bracketed placeholders `[...]` with your request details.
# 2. Use the `# Directive:` line to specify the type of action (e.g., Enhancement, Fix, Refactor).
# 3. Use the `# Target Cycle:` line to specify the cycle to modify (e.g., system/autonomous, system/cycle-manager).
#    - Available cycles: system/autonomous, system/cycle-manager, system/major-changes
#    - Run `1000xscripts/system/list-cycles.ps1` in terminal for a complete list of available cycles.
# 4. Keep details concise and clear.

# Directive: [Enhancement/Fix/Refactor/Analysis]
# Target Cycle: [domain/cycle-name]
# Enhancement Name: [Brief Name of Change]
# Priority: [High/Medium/Low]

# Enhancement Details
# [Provide a clear description of the change or enhancement needed.]
# [Use bullet points for specific requirements if applicable.]

# Focus Areas (Optional)
# [Optionally list specific areas or files to focus on.]

# --- TEMPLATE END ---

# --- CURRENT REQUEST START ---
# Directive: Enhancement
# Target Cycle: system/cycle-manager
# Enhancement Name: Directive System Implementation
# Priority: High

# Enhancement Details
Implement the directive system for simplified cycle analysis and management:

1. Enhance `1000xbrain/system/cycle-manager/processes/cycle-analysis-process.md` to include specific checks for analyzing cycle-manager itself
2. Modify `1000xbrain/system/cycle-manager/processes/requirement-analysis-process.md` to support the directive format
3. Create `1000xscripts/system/list-cycles.ps1` to dynamically list available cycles
4. Update the USER REQUEST SECTION template to be more efficient and include references to available directives and all cycles throughout the domains front-end, back-end, and system. There are currently only 3 cycles: autonomous, cycle-manager, major-changes. It may be easier to name the cycles by the filepath of the 1000xcommand folder, examples:
1000xcommands\system\autonomous
1000xcommands\system\cycle-manager
1000xcommands\system\major-changes

# Focus Areas
- Steps 1 and 2 of the cycle guidelines to optimize the USER REQUEST SECTION format
- Implementation of the directive parsing system
- Creation of the list-cycles script
- Documentation of available directives

## END USER REQUEST SECTION
# --- CURRENT REQUEST END ---

## Tyler Youk notes 

*file size, high priority*
All file sizes for all cycles should be less than 250 lines. 1000xcommands are always within 250 lines, however there are times when the planning folder files in 1000xplans and the knowledge/process/operational-enhancement files are over 250 lines. You will mainly need to address the standards for creating files in 1000xbrain throughout the cycle (specifically operational-enhancements, which is dynamically updated throughout the cycle process)

# --- CURRENT REQUEST START ---
# Directive: Enhancement
# Target Cycle: cycle-manager
# Enhancement Name: Directive System Implementation
# Priority: High

# Enhancement Details
Implement the directive system for simplified cycle analysis and management as described in the proposed solution (lines 308-323 of notes.md), including:

1. Enhance `1000xbrain/system/cycle-manager/processes/cycle-analysis-process.md` to include specific checks for analyzing cycle-manager itself
2. Modify `1000xbrain/system/cycle-manager/processes/requirement-analysis-process.md` to support the directive format
3. Create `1000xscripts/system/list-cycles.ps1` to dynamically list available cycles
4. Update the USER REQUEST SECTION template to be more efficient and include references to available directives and all cycles throughout the domains front-end, back-end, and system. There are currently only 3 cycles: autonomous, cycle-manager, major-changes. It may be easier to name the cycles by the filepath of the 1000xcommand folder, examples:
1000xcommands\system\autonomous
1000xcommands\system\cycle-manager
1000xcommands\system\major-changes

# Focus Areas
- Steps 1 and 2 of the cycle guidelines to optimize the USER REQUEST SECTION format
- Implementation of the directive parsing system
- Creation of the list-cycles script
- Documentation of available directives

#### Old legacy USER REQUEST SECTION STRUCTURE

#### Directive system for simplified cycle analysis
Implement the directive system for simplified cycle analysis and management as described in the proposed solution (lines 308-323 of notes.md), including:

1. Enhance `1000xbrain/system/cycle-manager/processes/cycle-analysis-process.md` to include specific checks for analyzing cycle-manager itself
2. Modify `1000xbrain/system/cycle-manager/processes/requirement-analysis-process.md` to support the directive format
3. Create `1000xscripts/system/list-cycles.ps1` to dynamically list available cycles
4. Update the USER REQUEST SECTION template to be more efficient and include references to available directives and all cycles throughout the domains front-end, back-end, and system.

#### Focus Areas
- Steps 1 and 2 of the cycle guidelines to optimize the USER REQUEST SECTION format
- Implementation of the directive parsing system
- Creation of the list-cycles script
- Documentation of available directives

*operational_feedback folder enhancement*
At some point, you are going to need to delete the documentation of old cycles in 1000xbrain\system\autonomous\operational_feedback and other operational_feedback folders. Note that this repository gets pushed to github frequently, so there is really no need to keep documentation of old cycles. Less is more. You should be comfortable overwriting old documentation in 1000xbrain\system\autonomous\operational_feedback . The usage of operational_feedback folder for all cycles should be standardized.

*pushing to git autonomously*
I am also confident in your abilities now and would like to give you access to push to github. Create a script which will push the root directory to github. Note that this is a mono-repository, and the front-end and back-end applications have their own git configurations and do not get pushed when we push the root directory (front-end and back-end will only get pushed if we manually configure the root directory git to include these two inner repositories). I do not want to change the current settings to push the front-end and back-end directories.

The terminal command sequence for pushing to git is as follows:

1. Ensure you are in GigaSwap root directory
```powershell
cd C:\Users\ethde\Desktop\GigaSwap
```

2. Ensure you are in correct branch (checkout to correct branch, you should always be in 1000xdev branch)
```powershell
git branch
```

correct output
```terminal
PS C:\Users\ethde\Desktop\GigaSwap> git branch
* 1000xdev
  main
PS C:\Users\ethde\Desktop\GigaSwap> 
```

3. Read current git status
```powershell
git status
```

4. git add
```powershell
git add .
```

5. git commit (use latest-1000xdev if you can't think of commit messages, every commit message should be tagged with -1000xdev)
```powershell
git commit -m "latest-1000xdev"
```
6. push to 1000xdev (you should only push to 1000xdev)
```powershell
git commit -m "latest-1000xdev"
```

If you integrate pushing git commands, I would like for there to be a standardized process file in which the 1000xcommand will read first before making any changes. I would like the 1000xcommand to have strict explicit tool calls preferably to a script. I would like there to be strict guidelines in the process file to ensure that upon errors or unexpected terminal responses there is a strict process. There should also be a success criteria to ensure that you are in the correct branch and that the commit has successfully pushed. You should be able to read past commits as well (I have git connected with cursor). For me to send you git commits, I can reference @Git. Review @Web for Cursor Documentation on @Git integration in Cursor. 

You should only push to the branch 

*Adding script list.ps1 to execute at the end of every cycle*

*Enhancement to cycle-manager*
During the implementation process (4), there are often times when you will to take a break. Which of the following options would you recommend:
1. Modifying the guidelines of the 4th step of all cycles to expect repeated runs of `run command:system/{cycle-name}/4` until the implementation is complete
2. Create a continuation 1000xcommand (4-continue?) `run command:system/{cycle-name}/4`
3. Other suggestions for continuing implementation when you take breaks, or if the implementation is spread out over phases and you stop after the first phase? Try to keep any new suggestions simple.

#### streamlined way to identify cycles
There should be a streamlined way to identify cycles. I want to be able to write in the User Request Section: `Enhance the cycle {cycle-name} to do {x and y}`. The cycle-name can be distinct so that you clearly understand the cycle-name when reading my plain english. I can also use the filepath to the 1000xcommand folder if that makes it easier? 

#### New cycle to "oversee" cycle-manager directly?

**context**
cycle-manager should be the centralized manager for all cycles, that looks over and watches all cycles. 

When looking at ways to enhance the cycle of cycle-manager itself, would you recommend creating a third party perspective. Like an executive boss for cycle-mangaer? This could help with enhancing cycle-manager itself (help cycle-manager with finding enhancements for all other cycles, changing cycle-manager's thought process so that cycle-manager does not think the same way and look for the same types of enhancements). A third party perspective could also look at cycle-manager and see potential issues or bottlenecks in its management processes.

**Current state of cycle-manager**
Right now, cycle-manager should actively analyze and manager ALL cycles including it's own cycle to ensure ALL cycles follow specific guidelines. Right now, cycle-manager is responsible for creating the guidelines that govern all cycles, and ensuring that these guidelines are enforced for all cycles.

Respond with what you think would be the simplest solution: creating a third party cycle to oversee cycle-manger, or continue to enhance cycle-manager to efficiently manager ALL cycles including its own. Continue to enhance cycle-manager so that it can manage its own cycle along with the guidelines and structure of every other cycle, or create a new cycle which serves as a third party perspective.



## end

## 1000XDEV NOTES

### Assessment Summary (2024-05-28)

I have assessed the request to create a new cycle management system called "cycle-manager" (name confirmed after consultation). This system will standardize the 7-step sequential command pattern across all domains (system, front-end, back-end) and provide centralized knowledge/processes for cycle management.

**Key Findings:**
- The request describes creating a standardized cycle management system with 7 sequential commands
- The system should enable creating, enhancing, and optimizing cycles across all domains
- All cycles should follow a consistent 7-step approach with standardized USER REQUEST SECTION format
- Centralization of knowledge and processes is critical for maintaining consistency
- Priority is marked as "High"
- The implementation will use "cycle-manager" as the name (instead of "manage-cycles")
- A unified cycle model will be implemented where all cycles can operate autonomously by default but will process user input when available
- This unified model eliminates the need for separate autonomous and major-changes cycle types

**Next Steps:**
1. Create implementation plan for cycle-manager
2. Set up directory structure in 1000xcommands/system/cycle-manager/
3. Create corresponding knowledge/processes in 1000xbrain/system/cycle-manager/
4. Implement standardized templates and guidelines
5. Design the unified cycle approach with both autonomous and user-directed capabilities

The original request has been preserved in `1000xbrain/system/major-changes/operational_feedback/original_request.md` for reference throughout the implementation process.

### Overview

These notes document the design and implementation approach for the Major Changes workflow, a new sequential command structure designed to handle explicit change requests from Tyler Youk.

### Design Approach

#### Parallel Workflow Structure

The Major Changes workflow is designed to operate in parallel with the existing Autonomous workflow but focuses on handling changes that are explicitly requested by Tyler rather than being autonomously discovered and implemented.

Key structural similarities:
- Sequential 7-step approach
- Numbered command files (1.md through 7.md)
- Dynamic execution patterns
- Operational feedback tracking

Key differences:
- Focused on explicit change requests
- Includes a dedicated assessment phase
- Handles user-specified requirements
- May involve broader scope changes

#### Command Sequence Design

1. **Initiate Cycle (1.md)**
   - Starts a new change cycle
   - Prepares operational feedback structures
   - Similar to autonomous 1.md

2. **Assess Change (2.md)**
   - New command with no direct equivalent in autonomous workflow
   - Analyzes change request parameters
   - Determines scope and impact
   - Identifies affected components

3. **Plan Implementation (3.md)**
   - Creates implementation plan for the specific change
   - Similar to autonomous 3.md but focuses on explicit change

4. **Implement Changes (4.md)**
   - Executes the planned changes
   - Similar to autonomous 4.md

5. **Verify Changes (5.md)**
   - Verifies the implementation meets requirements
   - Similar to autonomous 5.md

6. **Refine Changes (6.md)**
   - Optional step for addressing issues
   - Similar to autonomous 6.md

7. **Complete Cycle (7.md)**
   - Finalizes the change cycle
   - Similar to autonomous 7.md

#### Process Reuse Strategy

To minimize duplication, the Major Changes workflow will reuse existing processes where appropriate:

- **Verification Process**: Can be reused with minimal modifications
- **Refinement Process**: Can be reused with minimal modifications
- **Implementation Process**: May need adaptation for explicit changes
- **Cycle Initiation/Completion**: Can be adapted from existing processes

The **Assessment Process** will be a new addition specific to the Major Changes workflow, with no direct equivalent in the autonomous workflow.

### Implementation Strategy

#### Phased Implementation

The implementation will proceed in phases:
1. Set up directory structure
2. Create command files
3. Link to existing processes
4. Create new assessment process
5. Document and test the workflow

#### Directory Structure

```
1000xcommands/
  └── system/
      ├── autonomous/       (existing)
      │   └── [1-7].md
      └── major-changes/    (new)
          └── [1-7].md

1000xbrain/
  └── system/
      ├── autonomous/       (existing)
      │   ├── knowledge/
      │   ├── processes/
      │   └── operational_feedback/
      └── major-changes/    (new)
          ├── knowledge/
          ├── processes/
          └── operational_feedback/
```

#### Required New Files

1. **Command Files**:
   - 7 sequential command files (1.md through 7.md)
   - README.md for documentation

2. **Process Files**:
   - change-assessment-process.md (new)
   - Other processes can be reused with references

3. **Knowledge Files**:
   - change-assessment-principles.md (new if needed)
   - Other knowledge files can be reused

4. **Operational Feedback Structure**:
   - Similar structure to autonomous workflow
   - Will include cycle tracking, state management, and results

### Integration Considerations

#### State Management

The major-changes workflow will use a similar state management approach to the autonomous workflow, tracking:
- Current cycle number
- Current phase
- Status of each phase
- Transition between phases

#### Command Index Integration

The new commands will be added to the system command index for discoverability.

#### Relationship with Autonomous Workflow

The two workflows will operate independently but will share:
- Common process and knowledge files where appropriate
- Similar operational patterns
- Complementary purposes within the system

### Usage Patterns

#### When to Use Major Changes Workflow

- For explicit feature requests from Tyler
- For significant architectural changes
- For changes spanning multiple components
- For changes requiring specific parameters or configuration

#### When to Use Autonomous Workflow

- For self-discovered optimizations
- For routine maintenance and improvements
- For addressing technical debt
- For incremental enhancements

### Future Enhancements

Potential future enhancements to consider:
- Unified state management system for both workflows
- Transition mechanism between workflows
- Enhanced change assessment capabilities
- Integration with external change tracking systems

### Implementation Notes

The implementation will be executed using the autonomous workflow:
1. Requirements and planning (completed)
2. Implementation will be performed using `run command:system/autonomous/4`
3. Verification will use `run command:system/autonomous/5`
4. Completion will use `run command:system/autonomous/7`

This creates an interesting pattern where the autonomous workflow is being used to implement its complementary major-changes workflow. 

### Cycle Manager Self-Analysis Refinement (YYYY-MM-DD)

**Context:** Discussion on improving how `cycle-manager` analyzes itself and how Tyler can trigger this analysis.

**Assessment:**
- The existing `cycle-analysis-process.md` is designed to analyze any cycle, including `cycle-manager` itself.
- Creating a separate, dedicated self-analysis process file for `cycle-manager` would add unnecessary complexity and redundancy.
- Triggering self-analysis via the standard `USER REQUEST SECTION` change request format can be verbose for routine checks.

**Proposed Solution:**
1.  **Enhance Existing Process:** Refine `1000xbrain/system/cycle-manager/processes/cycle-analysis-process.md` to include specific checks, focuses, or sub-routines that are activated when `cycle-manager` is the target cycle being analyzed. This ensures thorough self-examination without needing a separate process file.
2.  **Add Request Directive:** Modify `1000xbrain/system/cycle-manager/processes/requirement-analysis-process.md` to recognize a new, simplified format within the `USER REQUEST SECTION` specifically for triggering analysis. Example format:
    ```markdown
    ## USER REQUEST SECTION

    # Directive: Analyze Cycle
    # Target Cycle: cycle-manager
    # Analysis Focus: [Optional: e.g., Bottlenecks]
    # Directive Notes: [Optional: Add specific context or instructions here.]

    ## END USER REQUEST SECTION
    ```
    This allows Tyler to initiate `cycle-manager` self-analysis (or analysis of any cycle) directly without writing a full change request narrative.

**Rationale:** This approach leverages existing structures, maintains simplicity, and provides a streamlined user interaction for triggering cycle analysis. 