# System Enhancement Notes: Major Changes Workflow

## Tyler Youk
At some point, you are going to need to delete the documentation of old cycles in 1000xbrain\system\autonomous\operational_feedback and other operational_feedback folders. Note that this repository gets pushed to github frequently, so there is really no need to keep documentation of old cycles. Less is more. You should be comfortable overwriting old documentation in 1000xbrain\system\autonomous\operational_feedback .

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

## end

## USER REQUEST SECTION

I really like the 7 step sequential 1000xcommands in both 1000xcommands\system\autonomous\ and 1000xcommands\system\major-changes\ . I want to standardize this 7 step sequential 1000xcommand process in the guidelines of 1000xbrain\system\guidelines\ so that every folder within 1000xcommands\back-end\ 1000xcommands\front-end\ 1000xcommands\system\ includes the same 7 step sequential 1000xcommands tailored towards the cycle. Essentially, every 1000xcommand should be within a cycle. There should be no one-off 1000xcommands anymore. 

To do ensure alignment among every cycle within the 1000xcommands\domain\ folders (where domain is back-end, front-end and system), I want you to create a new cycle called manage-cycles with the filepath 1000xcommands\system\manage-cycles\ . Just like autonomous and major-changes, manage-cycles should have 7 sequential 1000xcommands with the names 1, 2, 3, 4, 5, 6 and 7 respectively.

manage-cycles is responsible for creating cycles, enhancing cycles, and optimizing cycles (reducing clutter). I want manage-cycles to be so great that we can use manage-cycles to not only create cycles within 1000xcommands\system\ , but ALSO within 1000xcommands\front-end\ and 1000xcommands\back-end\ . 1000xcommands in manage-cycles should make explicit tool calls an dynamic tool calls to 1000xbrain\system\guidelines\ and 1000xbrain\system\manage-cycles (new folder). This is so that every cycle is standardized, so that if we find ways to enhance the cycles, all we need to do is make changes to manage-cycle 1000xcommands and relevant 1000xbrain files and then we can systematically make changes to every cycle. This will reduce the number of outdated files and cycles within the 1000xsystem. This is because we will continously find ways to enhance the cycles, and I want to centralized the knowledge and processes for managing and creating cycles so that when the cycle process is updated, we can easily update every cycle. Again, manage-cycles will be responsible for creating cycles, enhancing cycles, and optimizing cycles for all domains. manage-cycles\1 should create a user request section just like this. I think this user request section would be good for all cycles that aren't fully autonomous. This is what I mean by we will be making changes to the cycle guidelines frequently, there are many enhancements we could make to this 7 step sequential process.

**Before we start**
If you feel like there is a better name than manage-cycles, please respond to me with the better name. Chat to me directly first before making any changes.

# Change Request
Create new cycle called (choose name of cycle) within 1000xcommands\system\ 

# Requirements
New cycle should make explicit and dynamic tool calls to 1000xbrain\system\(new-name) (new folder) and 1000xbrain\system\guidelines\ . If you see ways to further enhance the centralization of cycle guidelines, then let me know.

# Priority
High

# Additional Notes
Overwrite the 1000xdev notes below, they are outdated. I will also likely send you chat messages to enhance the plan and research before we start making changes.

## END USER REQUEST SECTION

## 1000XDEV NOTES

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

### References

- Existing autonomous workflow structure in `1000xcommands/system/autonomous/`
- Process files in `1000xbrain/system/autonomous/processes/`
- Knowledge files in `1000xbrain/system/autonomous/knowledge/` 

### Operational Enhancements

- Notes.md now has a standardized format with dedicated sections for:
  - Tyler's permanent notes (Tyler Youk section)
  - User request section for major changes workflow
  - 1000xdev implementation notes

- Major-changes workflow now reads directly from the USER REQUEST SECTION in notes.md
- This provides a clear interface for Tyler to specify change requests
- The section is cleared after processing to prepare for the next request 