# 00OS Dual-Mode Interface

## Overview

The 00OS system provides a dual-mode interface for user-AI interaction within the prompt box. This enables both structured command execution and flexible natural language conversation, maximizing productivity and clarity.

---

## The Two Modes

### 1. Command Mode
- **How to use:** Prefix your message with `>` (e.g., `> help`, `> file list /00os/processes`)
- **What happens:**
  - The AI interprets your input as a 00OS command.
  - The command is parsed, the corresponding process rule is fetched, and the defined tool calls are executed.
  - The result is returned in a standardized, terminal-like format.
- **Purpose:**
  - Enables automation, repeatability, and precision for all supported 00OS processes.
  - Ideal for file operations, system queries, workflow automation, and any structured task.

**Example:**
```
> file list /00os/processes
```

### 2. Conversational Mode
- **How to use:** Just type your message without the `>` prefix.
- **What happens:**
  - The AI interprets your input as a natural language message.
  - You can ask questions, discuss requirements, plan workflows, or request explanations.
  - The AI responds conversationally, without invoking command processing.
- **Purpose:**
  - Enables flexible, context-rich discussion and planning.
  - Ideal for brainstorming, clarifying requirements, or reviewing results.

**Example:**
```
How do I create a new command for 1000xdev?
```

---

## Rationale
- **Productivity:** Users can seamlessly switch between automation (commands) and discussion (conversation) without changing interfaces.
- **Clarity:** The `>` prefix provides an unambiguous signal for command execution, reducing errors and confusion.
- **Extensibility:** This model supports future AI identities and workflows, as all agents can interpret both modes.

---

## Best Practices
- Use **Command Mode** for any action you want the AI to execute as a process.
- Use **Conversational Mode** for discussion, planning, or when you need explanations or help.
- If unsure, start with conversation—00reaper will guide you to the right command if needed.

---

## Summary Table
| Mode              | How to Use         | Purpose                        |
|-------------------|-------------------|--------------------------------|
| Command Mode      | `> command ...`   | Automation, structured tasks   |
| Conversational    | No prefix         | Discussion, planning, Q&A      |

---

**The dual-mode interface is fundamental to 00OS, enabling both robust automation and flexible collaboration in a single, unified environment.** 