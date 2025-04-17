# 00OS Configuration Files Summary

This document summarizes the content of the configuration files found in `00os/config/` as of [Current Date - Please Update Manually].

## 1. `00os/config/settings.md`

This file contains the primary system configuration for 00OS, defined in JSON format. It governs the core behavior of the OS across multiple facets:

*   **System**: Basic OS identification (`name`, `version`).
*   **Parser**: Rules for command interpretation (`commandPrefix` - currently empty, `caseSensitive`, `maxCommandLength`, `allowPiping`, `allowChaining`).
*   **Execution**: Process runtime parameters (`defaultTimeout`, `maxConcurrentProcesses`, `logLevel`, `debugMode`).
*   **Identity**: Identity management (`default` identity is `00reaper`, `autoSwitch` enabled, `identityIndicators`).
*   **Paths**: Standardized locations for `processes`, `logs`, `config`, and `temp` directories.
*   **Display**: Controls terminal output appearance (`showCommandPrefix`, `showExecutionTime`, `formatOutput`, `colorOutput`, `colors`).
*   **Security**: Permission system settings (`enforcePermissions`, `logPermissionDenials`, `restrictedPaths` like `/.cursor/rules` and `/00os/core`).
*   **Advanced**: Toggles for `enableExperimentalFeatures`, `developmentMode`, `allowJavaScriptEval`, and resource limits (`maxProcessMemory`).
*   **Compatibility**: Settings for handling legacy commands (`supportLegacyCommands`, `legacyCommandPrefix`, `emulate1000xdev`).

The file also explains how processes can interact with these settings using `tools.getSystemSetting()` and `tools.updateSystemSetting()` (requires appropriate permissions).

## 2. `00os/config/terminal.md`

This file specifically configures the terminal interface itself:

*   **`prefix`**: Defines the character(s) used to signify a command (currently set to `>`).
*   **`theme`**: Specifies the visual style for terminal output (details not provided in the file).
*   **`history`**: Sets the maximum number of commands to retain in history (details not provided).
*   **`autoComplete`**: Enables or disables command auto-completion (details not provided).

This summary provides an overview of the configurable aspects of the 00OS system.
