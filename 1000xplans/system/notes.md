# System Enhancement Notes: Major Changes Workflow

## Tyler Youk
I noticed that the 1000xcommands in system/major-changes and system/autonomous do not make tool calls to read files within guidelines. There should be at least some tool calls to guidelines, so that for every cycle you understand 1000xsystem guidelines. Especially if you are making major changes to a subsystem, you should know the context of the structure and guidelines of the subsystem. I noticed this, because I saw you were creating README.md files throughout the major-changes folders, which is not present in any other knowledge or processes folder.

First thing you need to do is update the 1000xcommands in autonomous and major-changes to run explicit tool calls to read relevant files within 1000xbrain\system\guidelines. 

What I am assuming you are doing, is that you are using the guidelines to create processes and knowledge-base-files? I feel like it would just the be the easiest to utilize the guidelines during the cycle of the 1000xcommand workflow cycle so that certain guidelines are standards for every cycle, rather than using the guidelines to create process and knowledge-base-files. This allows us to change guidelines while maintianing alingment with all process-files, knowledge-base-files, and 1000xcommands.


At some point, you are going to need to delete the documentation of old cycles in 1000xbrain\system\autonomous\operational_feedback . Note that this repository gets pushed to github frequently, so there is really no need to keep documentation of old cycles. Less is more. You should be comfortable overwriting old documentation in 1000xbrain\system\autonomous\operational_feedback .

I am also confident in your abilities now and would like to give you access to push to github. Create a script which will push the root directory to github. Note that this is a mono-repository, and the front-end and back-end applications have their own git configurations and do not get pushed when we push the root directory (front-end and back-end will only get pushed if we manually configure the root directory git to include these two inner repositories). I do not want to change the current settings to push the front-end and back-end directories.

The terminal command sequence for pushing to git is as follows:

1. Ensure you are in GigaSwap root directory
```powershell
cd C:\Users\ethde\Desktop\GigaSwap
```

2. Read current git status
```powershell
git status
```

3. git add
```powershell
git add .
```

2. git commit (use latest-1000xdev if you can't think of commit messages, every commit message should be tagged with 1000xdev)
```powershell
git commit -m "latest-1000xdev"
```

If you integrate pushing git commands, I would like for there to be a standardized process file in which the 1000xcommand will read first before making any changes. I would like the 1000xcommand to have strict explicit tool calls preferably to a script. I would like there to be strict guidelines in the process file to ensure that upon errors there is a strict process, and there is also a success criteria section too. You should be able to read past commits as well (I have git connected with cursor). For me to send you git commits, I can reference @Git. Review @Web for Cursor Documentation on @Git integration in Cursor. 

## end


## Overview

These notes document the design and implementation approach for the Major Changes workflow, a new sequential command structure designed to handle explicit change requests from Tyler Youk.

## Design Approach

### Parallel Workflow Structure

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

### Command Sequence Design

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

### Process Reuse Strategy

To minimize duplication, the Major Changes workflow will reuse existing processes where appropriate:

- **Verification Process**: Can be reused with minimal modifications
- **Refinement Process**: Can be reused with minimal modifications
- **Implementation Process**: May need adaptation for explicit changes
- **Cycle Initiation/Completion**: Can be adapted from existing processes

The **Assessment Process** will be a new addition specific to the Major Changes workflow, with no direct equivalent in the autonomous workflow.

## Implementation Strategy

### Phased Implementation

The implementation will proceed in phases:
1. Set up directory structure
2. Create command files
3. Link to existing processes
4. Create new assessment process
5. Document and test the workflow

### Directory Structure

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

### Required New Files

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

## Integration Considerations

### State Management

The major-changes workflow will use a similar state management approach to the autonomous workflow, tracking:
- Current cycle number
- Current phase
- Status of each phase
- Transition between phases

### Command Index Integration

The new commands will be added to the system command index for discoverability.

### Relationship with Autonomous Workflow

The two workflows will operate independently but will share:
- Common process and knowledge files where appropriate
- Similar operational patterns
- Complementary purposes within the system

## Usage Patterns

### When to Use Major Changes Workflow

- For explicit feature requests from Tyler
- For significant architectural changes
- For changes spanning multiple components
- For changes requiring specific parameters or configuration

### When to Use Autonomous Workflow

- For self-discovered optimizations
- For routine maintenance and improvements
- For addressing technical debt
- For incremental enhancements

## Future Enhancements

Potential future enhancements to consider:
- Unified state management system for both workflows
- Transition mechanism between workflows
- Enhanced change assessment capabilities
- Integration with external change tracking systems

## Implementation Notes

The implementation will be executed using the autonomous workflow:
1. Requirements and planning (completed)
2. Implementation will be performed using `run command:system/autonomous/4`
3. Verification will use `run command:system/autonomous/5`
4. Completion will use `run command:system/autonomous/7`

This creates an interesting pattern where the autonomous workflow is being used to implement its complementary major-changes workflow.

## References

- Existing autonomous workflow structure in `1000xcommands/system/autonomous/`
- Process files in `1000xbrain/system/autonomous/processes/`
- Knowledge files in `1000xbrain/system/autonomous/knowledge/` 