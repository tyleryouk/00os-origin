# Major Changes Workflow

This directory contains command files for the sequential Major Changes workflow, designed to handle explicit change requests from Tyler Youk.

## Purpose

The Major Changes workflow provides a structured approach for implementing significant changes explicitly requested by Tyler. This workflow complements the Autonomous workflow by focusing on user-directed changes rather than AI-initiated optimizations.

## Command Sequence

1. `1.md` (initiate-explicit-cycle) - Starts a new cycle for explicitly requested changes
2. `2.md` (assess-change-request) - Analyzes and scopes the explicit change request
3. `3.md` (plan-implementation) - Creates a detailed implementation plan
4. `4.md` (implement-changes) - Executes the planned changes
5. `5.md` (verify-changes) - Verifies the changes meet requirements
6. `6.md` (refine-changes) - Optional refinement step for addressing issues
7. `7.md` (complete-change-cycle) - Finalizes the change cycle

## Usage

Commands should be executed in sequence using the standard invocation format:
`run command:system/major-changes/[number]`

## State Management

The workflow maintains state between commands in:
`1000xbrain/system/major-changes/operational_feedback/` 