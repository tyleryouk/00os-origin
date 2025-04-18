# 00OS Configuration Files Summary

This document summarizes the content of the configuration files found in `00os/config/` as of June 12, 2024.

## Configuration Changes
- The `terminal.md` file has been removed to eliminate confusion about command prefix configurability
- Command prefix ('>') is now treated as a fixed system property, not a configurable setting
- All configuration is now centralized in `settings.md`

## 1. `00os/config/settings.md`

This file contains the primary system configuration for 00OS, defined in JSON format. It governs the core behavior of the OS across multiple facets:

*   **System**: Basic OS identification (`name`, `version`).
*   **Parser**: Rules for command interpretation (`commandPrefix` - currently empty, `caseSensitive`, `maxCommandLength`, `allowPiping`, `allowChaining`).
   - Note: While `commandPrefix` exists in the settings structure, the actual command detection prefix ('>' character) is hardcoded in the command handler for reliability
*   **Execution**: Process runtime parameters (`defaultTimeout`, `maxConcurrentProcesses`, `logLevel`, `debugMode`).
*   **Identity**: Identity management (`default` identity is `00reaper`, `autoSwitch` enabled, `identityIndicators`).
*   **Paths**: Standardized locations for `processes`, `logs`, `config`, and `temp` directories.
*   **Display**: Controls terminal output appearance (`showCommandPrefix`, `showExecutionTime`, `formatOutput`, `colorOutput`, `colors`).
*   **Security**: Permission system settings (`enforcePermissions`, `logPermissionDenials`, `restrictedPaths` like `/.cursor/rules` and `/00os/core`).
*   **Advanced**: Toggles for `enableExperimentalFeatures`, `developmentMode`, `allowJavaScriptEval`, and resource limits (`maxProcessMemory`).
*   **Compatibility**: Settings for handling legacy commands (`supportLegacyCommands`, `legacyCommandPrefix`, `emulate1000xdev`).

The file also explains how processes can interact with these settings using `tools.getSystemSetting()` and `tools.updateSystemSetting()` (requires appropriate permissions).

## Configuration Philosophy

The 00OS configuration system has been simplified to reduce potential confusion:

1. **Command Detection**: The '>' prefix for commands is now considered a fundamental system property, not a configurable setting
2. **Centralized Configuration**: All configurable settings are maintained in a single file (`settings.md`)
3. **Clear Documentation**: Each setting is clearly documented with its purpose and impact
4. **Access Control**: Changes to critical settings require appropriate permissions

This approach ensures consistency in command detection and processing, which is essential for the reliable operation of the 00OS command system.
