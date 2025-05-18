---
name: version
description: Display system version information
category: system
author: 00reaper
version: 2.0
permissions: [basic]
outputs:
  - name: version
    type: string
    description: Version information
---

# Process: version

USE WHEN you want to execute version

## Execution

This process returns the current 00OS version and build information.

- The version information is hardcoded for simplicity and reliability.

## Examples

> version
✅ 00OS v0.1.0 (Alpha) — Build 20240601-001 