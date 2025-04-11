# System Enhancement Notes: Major Changes Workflow

## USER REQUEST SECTION

# --- TEMPLATE START ---
# Instructions:
# 1. Replace bracketed placeholders with your request details.
# 2. All directive fields are required - they help automate processing.
# 3. Run `1000xscripts/system/list-cycles.ps1` in terminal to see all available cycles.

# Directive: Enhancement
# Target Cycle: system/cycle-manager
# Enhancement Name: Enhance 1000xplans
# Priority: High

# Enhancement Details
*1000xplan enhancements*
I noticed you never use 1000xplans\system\implementation-progress.md 1000xplans\plan.md and 1000xplans\system\requirements.md. Given that you only use notes within 1000xplans\system\ , see if there is a way to enhance 1000xsystem as a whole. I noticed when searching for enhancements, it is easier for you to use operational-feedback rather than 1000xplans. We can make 1000xplans more of my domains, where you read what I have to say in 1000xplans\system\notes.md . The other file in 1000xplans\system\ that I will keep is commands-index.md. Maybe, we can make 1000xplans more of my domain only? You almost never write to notes either, you only write to notes.md to update the USER REQUEST SECTION. Let me know what you think in terms of the utilization of 1000xplans. 

# Focus Areas (Optional)
1000xplans usage within each cycle.

# --- DIRECTIVE REFERENCE ---
# Enhancement: Add new functionality or improve existing features
# Fix: Correct problems or issues in existing functionality
# Refactor: Restructure code without changing functionality
# Analysis: Evaluate component(s) without making changes
# --- TEMPLATE END ---

## END USER REQUEST SECTION

## Tyler Youk notes 

*Remove all usages of date, low priority*
You keep adding incorrect dates. Remove any instruction in 1000xbrain and 1000xrules stating to use dates. Stop using dates. The dates are known thorugh git version control. Stop using dates for the templates or any other type of documentation. 

*Another one*
Create clear distinction between autonomous and user-directed within USER REQUEST SECTION, so that I can clearly state to run an autonomous cycle if I have no request

*file size, high priority*
All file sizes for all cycles should be less than 250 lines. 1000xcommands are always within 250 lines, however there are times when the planning folder files in 1000xplans and the knowledge/process/operational-enhancement files are over 250 lines. You will mainly need to address the standards for creating files in 1000xbrain throughout the cycle (specifically operational-enhancements, which is dynamically updated throughout the cycle process)

*Creation of front-end cycle, steam-api*
Create an autonomous cycle within front-end to autonomously integrate the Steam API.
All 1000xsystem based errors (tool calls etc), should be reported to the cycle-manager. This will seperate concerns so that during the front-end cycle you can focus on front-end implementation, and all cycle related issues or even enhancements requests will be abstracted to the cycle-manager for a system based cycle iteration (not a front-end cycle based iteration). All reports for cycle issues or enhancements should go to 1000xbrain\system\cycle-manager\operational-feedback\front-end-cycles\ (create new folder). Note that ALL front-end related knowledge and processes should be abstracted to the 1000xbrain\front-end\ domain (seperate part of your brain is designated for front-end). We still want to keep this 1000xsystem project agnostic, so that if I decide to create a new project it will be easy to do so.

*Creation of back-end cycle, steam-api*
Create an autonomous cycle within front-end to autonomously integrate the Steam API.
All 1000xsystem based errors (tool calls etc), should be reported to the cycle-manager. This will seperate concerns so that the back-end cycle can focus on back-end implementation, and will abstract the tool call and cycle errors or even optimization requests to cycle-manager. All reports should go to 1000xbrain\system\cycle-manager\operational-feedback\back-end-cycles\ (create new folder). Note that ALL back-end related knowledge and processes should be abstracted to the 1000xbrain\back-end\ domain (seperate part of your brain is designated for front-end). We still want to keep this 1000xsystem project agnostic, so that if I decide to create a new project it will be easy to do so.

*Better documentation and guidelines for 1000xcommands*
In one implementation, you created 1000xcommands wrong. cycle-manager is very important because it managers the 7 step sequential 1000xcommand cycle of ALL cycles, including its own cycle. You can not mess up 1000xcommands when working in the cycle cycle-manager.

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

## 1000XDEV NOTES
