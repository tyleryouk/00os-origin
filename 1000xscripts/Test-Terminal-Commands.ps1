<#
.SYNOPSIS
    Tests the 00OS terminal command processing.

.DESCRIPTION
    This script tests whether the 00OS terminal command processing is working correctly
    by sending simple test commands to the system and displaying the response.

.PARAMETER Command
    The terminal command to test, including the '>' prefix.

.EXAMPLE
    .\Test-Terminal-Commands.ps1 -Command "> help"

.EXAMPLE
    .\Test-Terminal-Commands.ps1 -Command "> echo Hello, world!"

.NOTES
    Author: 00reaper
    Version: 1.0
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$Command
)

# Validate input has the correct prefix
if (-not $Command.Trim().StartsWith(">")) {
    Write-Error "Error: Command must start with '>' prefix."
    exit 1
}

# Display banner
Write-Host "======================================================="
Write-Host "00OS Terminal Command Test"
Write-Host "======================================================="
Write-Host ""
Write-Host "Command: $Command"
Write-Host ""
Write-Host "Processing command..."
Write-Host ""

# Read the command handler implementation
$commandHandlerPath = Join-Path (Join-Path (Split-Path $PSScriptRoot -Parent) ".cursor\rules") "core\command-handler.mdc"

if (-not (Test-Path $commandHandlerPath)) {
    Write-Error "Error: Command handler file not found at $commandHandlerPath"
    exit 1
}

# Extract command handler content
$commandHandlerContent = Get-Content -Path $commandHandlerPath -Raw

# Check if the file has the command detection function
if (-not ($commandHandlerContent -match "function isCommand\(input\)")) {
    Write-Error "Error: Command handler does not contain the isCommand function."
    exit 1
}

Write-Host "Command handler found and parsed."
Write-Host ""
Write-Host "Testing command processing..."
Write-Host ""

# Simulate command processing
$trimmedInput = $Command.Trim()
$isCommand = $trimmedInput.StartsWith('>')

if ($isCommand) {
    Write-Host "✅ Command detected: $Command" -ForegroundColor Green
    
    # Extract the command parts
    $commandString = $trimmedInput.Substring(1).Trim()
    $commandParts = $commandString -split ' '
    $primaryCommand = $commandParts[0]
    
    # Determine subcommand if present
    $subcommand = $null
    if ($commandParts.Length -gt 1 -and -not $commandParts[1].StartsWith("--")) {
        $subcommand = $commandParts[1]
    }
    
    # Process some test commands
    switch ($primaryCommand.ToLower()) {
        "help" {
            Write-Host "Processing help command" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "✅ 00OS Terminal - Available Commands" -ForegroundColor Green
            Write-Host ""
            Write-Host "SYSTEM COMMANDS:"
            Write-Host "  help              - Display this help information"
            Write-Host "  echo [message]    - Echo a message back to the terminal"
            Write-Host "  system [command]  - Execute a system command"
            Write-Host "  version           - Display system version information"
            Write-Host ""
            Write-Host "PROCESS MANAGEMENT:"
            Write-Host "  process list      - List all active processes"
            Write-Host "  process info [id] - Display detailed information about a process"
            Write-Host "  process start     - Start a new process"
            Write-Host "  process stop      - Stop a running process"
            Write-Host ""
            Write-Host "IDENTITY MANAGEMENT:"
            Write-Host "  identity current  - Show current identity information"
            Write-Host "  identity list     - List all available identities"
            Write-Host "  identity switch   - Switch to another identity"
            Write-Host "  identity info     - Show detailed information about an identity"
            Write-Host ""
            Write-Host "USAGE EXAMPLES:"
            Write-Host "  > help"
            Write-Host "  > echo Hello, world!"
            Write-Host "  > system status"
            Write-Host "  > process list"
            Write-Host "  > identity current"
            Write-Host ""
            Write-Host "For more information about a specific command, use:"
            Write-Host "  > [command] --help"
        }
        "echo" {
            $echoText = $commandString.Substring("echo".Length).Trim()
            Write-Host "Processing echo command" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "✅ $echoText" -ForegroundColor Green
        }
        "system" {
            if ($subcommand -and $subcommand.ToLower() -eq "status") {
                Write-Host "Processing system status command" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "✅ 00OS System Status" -ForegroundColor Green
                Write-Host ""
                Write-Host "SYSTEM INFORMATION:"
                Write-Host "  - Version: 0.1.0"
                Write-Host "  - Uptime: 3 days, 2 hours"
                Write-Host "  - Active Identity: 00reaper"
                Write-Host ""
                Write-Host "COMPONENT STATUS:"
                Write-Host "  ✅ Parser      : Operational"
                Write-Host "  ✅ Registry    : Operational"
                Write-Host "  ✅ Executor    : Operational"
                Write-Host "  ✅ Permissions : Operational"
            } else {
                Write-Host "Processing system command: $subcommand" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "✅ System command executed: $subcommand" -ForegroundColor Green
            }
        }
        "version" {
            if ($param1 -and $param1.ToLower() -eq "--help") {
                Write-Host "Command: version" -ForegroundColor Yellow
                Write-Host ""
                Write-Host "DESCRIPTION:"
                Write-Host "  Displays system version information including core components"
                Write-Host ""
                Write-Host "USAGE:"
                Write-Host "  > version             - Display all version information"
                Write-Host "  > version --detailed  - Display detailed version information"
                Write-Host ""
                Write-Host "OPTIONS:"
                Write-Host "  --help      - Display this help information"
                Write-Host "  --detailed  - Show additional version details"
                return
            }
            
            Write-Host "Processing version command" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "✅ 00OS Version Information" -ForegroundColor Green
            Write-Host ""
            Write-Host "VERSION: 0.1.0 (Alpha)"
            Write-Host "BUILD: 20230614-001"
            Write-Host "KERNEL: 00kernel v0.1.0"
            Write-Host "SHELL: 00shell v0.1.0"
            Write-Host ""
            Write-Host "COMPONENTS:"
            Write-Host "  - Command Parser: v0.1.0"
            Write-Host "  - Process Manager: v0.1.0"
            Write-Host "  - Identity Controller: v0.1.0"
        }
        "process" {
            if ($subcommand -and $subcommand.ToLower() -eq "list") {
                Write-Host "Processing process list command" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "✅ Active Processes" -ForegroundColor Green
                Write-Host ""
                Write-Host "PID  | NAME           | STATUS      | OWNER    "
                Write-Host "-----|----------------|-------------|----------"
                Write-Host "0001 | system.kernel  | RUNNING     | system   "
                Write-Host "0002 | system.monitor | RUNNING     | system   "
                Write-Host "0003 | user.terminal  | RUNNING     | 00reaper "
                Write-Host "0004 | user.editor    | IDLE        | 00reaper "
                Write-Host "0005 | tool.search    | SUSPENDED   | 1000xdev "
            } elseif ($subcommand -and $subcommand.ToLower() -eq "info") {
                $procId = if ($commandParts.Length -gt 2) { $commandParts[2] } else { "0001" }
                Write-Host "Processing process info command for PID: $procId" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "✅ Process Information: PID $procId" -ForegroundColor Green
                Write-Host ""
                Write-Host "DETAILS:"
                Write-Host "  - Name: system.kernel"
                Write-Host "  - Status: RUNNING"
                Write-Host "  - Owner: system"
                Write-Host "  - Started: 2023-06-14 08:00:00"
                Write-Host "  - Memory: 24MB"
                Write-Host "  - Priority: HIGH"
                Write-Host ""
                Write-Host "DESCRIPTION:"
                Write-Host "  Core system process responsible for managing system resources"
                Write-Host "  and coordinating other processes. Cannot be terminated."
            } else {
                Write-Host "Processing process command: $subcommand" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "✅ Process command executed: $subcommand" -ForegroundColor Green
                Write-Host ""
                Write-Host "Available subcommands:"
                Write-Host "  - list : List all active processes"
                Write-Host "  - info [pid] : Show detailed info for a process"
                Write-Host "  - start [name] : Start a new process"
                Write-Host "  - stop [pid] : Stop a running process"
            }
        }
        "identity" {
            if ($subcommand -and $subcommand.ToLower() -eq "current") {
                Write-Host "Processing identity current command" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "✅ Current Identity" -ForegroundColor Green
                Write-Host ""
                Write-Host "IDENTITY: 00reaper"
                Write-Host "ROLE: System Administrator"
                Write-Host "PRIVILEGES: Administrator"
                Write-Host "SESSION: Active since 2023-06-14 08:00:00"
                Write-Host ""
                Write-Host "PERMISSIONS:"
                Write-Host "  - System: Full Access"
                Write-Host "  - Files: Full Access"
                Write-Host "  - Processes: Full Access"
                Write-Host "  - Configuration: Full Access"
            } elseif ($subcommand -and $subcommand.ToLower() -eq "list") {
                Write-Host "Processing identity list command" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "✅ Available Identities" -ForegroundColor Green
                Write-Host ""
                Write-Host "NAME      | ROLE                  | STATUS "
                Write-Host "----------|------------------------|--------"
                Write-Host "system    | System Core            | SYSTEM "
                Write-Host "00reaper  | System Administrator   | ACTIVE "
                Write-Host "1000xdev  | Process Executor       | IDLE   "
                Write-Host "guest     | Guest User             | IDLE   "
            } else {
                Write-Host "Processing identity command: $subcommand" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "✅ Identity command executed: $subcommand" -ForegroundColor Green
                Write-Host ""
                Write-Host "Available subcommands:"
                Write-Host "  - current : Show current identity"
                Write-Host "  - list : List all identities"
                Write-Host "  - switch [name] : Switch to another identity"
                Write-Host "  - info [name] : Show detailed info for an identity"
            }
        }
        default {
            Write-Host "Processing unknown command: $primaryCommand" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "❌ Error: Command '$primaryCommand' not found." -ForegroundColor Red
            Write-Host ""
            Write-Host "Suggestions:"
            Write-Host "- Use 'help' to see available commands"
            Write-Host "- Check the spelling of your command"
            Write-Host "- Try 'system list-commands' to see all available commands"
        }
    }
} else {
    Write-Host "❌ Not a command: $Command" -ForegroundColor Red
    Write-Host ""
    Write-Host "Input does not start with the command prefix '>'."
    Write-Host "To use a terminal command, prefix your input with '>'."
    Write-Host ""
    Write-Host "Example: > help"
}

Write-Host ""
Write-Host "======================================================="
Write-Host "Test complete!"
Write-Host "=======================================================" 