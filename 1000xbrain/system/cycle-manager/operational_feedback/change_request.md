# Change Request Details

**Requestor**: Tyler Youk
**Status**: Analysis Completed
**Directive**: Fix
**Target Cycle**: system/cycle-manager
**Enhancement Name**: list-cycles script integration, fix target cycles
**Priority**: High

## Request Description

The target cycles template in the user_request.md file is not accurate. The current template shows incorrect values (frontend/main and backend/main), and needs to be updated to reflect only actual available cycles. Additionally, the requirement-analysis-process.md needs to be updated to integrate with the list-cycles.ps1 script to maintain an accurate internal list of available cycles.

## Requirements

1. Update requirement-analysis-process.md to run list-cycles.ps1 at the beginning of execution
2. Store the list of available cycles for internal reference and validation
3. Use the stored list to validate Target Cycle values in user requests
4. Update the DIRECTIVE REFERENCE section to accurately list available cycles

## Scope

- Update process files in system/cycle-manager to integrate with list-cycles.ps1
- Create and maintain an internal cycle list
- Implement validation against the internal cycle list

## Success Criteria

1. The requirement-analysis-process.md file includes a step to run list-cycles.ps1
2. The system maintains an up-to-date internal list of available cycles
3. Target Cycle validation is performed against the internal list
4. The USER REQUEST SECTION template accurately reflects available cycles

## Special Considerations

The current system only has system domain cycles (system/autonomous, system/cycle-manager, system/major-changes). 
There are no frontend or backend cycles currently available, which will be reflected in the updated list. 