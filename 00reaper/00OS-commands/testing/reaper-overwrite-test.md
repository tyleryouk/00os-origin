# reaper-overwrite Test Cases

## Test Case: Basic Functionality
- **Command**: `> reaper-overwrite processes/00reaper 00reaper/00OS-commands/context-00OS-current-state/00reaper-processes.md`
- **Expected Behavior**: 
  - Command should execute without errors
  - The target file should be overwritten with concise context information
  - Each process should have a section with Purpose, Location, Status, and (if applicable) Key Tools
- **Verification Method**: Manual inspection of output file
- **Status**: ✅ Verified (REQ-001 implementation)

## Test Case: Missing Source Directory
- **Command**: `> reaper-overwrite non-existent-dir 00reaper/00OS-commands/context-00OS-current-state/test.md`
- **Expected Behavior**: 
  - Command should return an error
  - Error should indicate that the source directory does not exist
- **Verification Method**: Review error message
- **Status**: ✅ Verified through code review

## Test Case: Empty Source Directory
- **Command**: `> reaper-overwrite empty-dir 00reaper/00OS-commands/context-00OS-current-state/test.md`
- **Expected Behavior**: 
  - Command should execute but generate a warning
  - Warning should indicate that no files were found to process
- **Verification Method**: Review warning message
- **Status**: ✅ Verified through code review

## Test Case: Invalid Target File
- **Command**: `> reaper-overwrite processes/00reaper invalid/path/target.md`
- **Expected Behavior**: 
  - Command should attempt to read files but fail when writing
  - Error should indicate issues with writing to the target file
- **Verification Method**: Review error message
- **Status**: ✅ Verified through code review

## Test Case: Different File Formats
- **Command**: `> reaper-overwrite mixed-formats 00reaper/00OS-commands/context-00OS-current-state/test.md`
- **Expected Behavior**: 
  - Command should handle files with and without frontmatter
  - Files with different heading structures should be processed correctly
  - Files with missing metadata should show default values ("No description available", "Status unknown")
- **Verification Method**: Review resulting context file
- **Status**: ✅ Verified through code inspection

## Test Case: Large Files
- **Command**: `> reaper-overwrite large-files 00reaper/00OS-commands/context-00OS-current-state/test.md`
- **Expected Behavior**: 
  - Command should handle files longer than the read_file 250-line limit
  - Context should be generated correctly even for large files
- **Verification Method**: Review resulting context file
- **Status**: ✅ Verified through code inspection

## Regression Test: Previous Failure Case
- **Issue**: Previous implementation failed when trying to consolidate full content of all files
- **Fix Applied**: Changed to only extract metadata and generate concise summaries
- **Verification Method**: Execute the same command that previously failed
- **Status**: ✅ Fixed (Implementation avoids size limitations by creating concise summaries) 