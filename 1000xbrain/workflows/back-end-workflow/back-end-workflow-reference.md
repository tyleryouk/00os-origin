# Back-End Workflow Reference Guide

## Purpose and Usage

This reference guide maps message-commands to their corresponding project-rule-parameters for the back-end workflow. Use this guide to:

1. Find the correct project-rule-parameter for a specific message-command
2. Understand the purpose of each specialized workflow tool
3. Access detailed implementation guidance through project-rule-parameters

## Message-Command to Project-Rule-Parameter Mapping

| Message-Command | Project-Rule-Parameter | Purpose |
|-----------------|------------------------|---------|
| `run-tests` | @workflows/back-end-workflow/test-based-process.mdc | Run tests to verify implementation |
| `analyze-test-results` | @workflows/back-end-workflow/test-analysis-guide.mdc | Analyze test failures and fix issues |
| `create-test` | @workflows/back-end-workflow/test-creation-guide.mdc | Create new test cases following best practices |
| `api-implementation` | @workflows/back-end-workflow/api-patterns.mdc | Implement API endpoints with best practices |
| `db-implementation` | @workflows/back-end-workflow/db-patterns.mdc | Implement database operations with best practices |

## Usage Examples

### Testing Workflow

```
run-tests: user-authentication @workflows/back-end-workflow/test-based-process.mdc
```

This message-command runs tests related to user authentication using the guidance in test-based-process.mdc.

### Test Analysis Workflow

```
analyze-test-results: order-creation @workflows/back-end-workflow/test-analysis-guide.mdc
```

This message-command analyzes test failures related to order creation using the guidance in test-analysis-guide.mdc.

### Test Creation Workflow

```
create-test: wallet-integration @workflows/back-end-workflow/test-creation-guide.mdc
```

This message-command provides guidance for creating wallet integration tests using the patterns in test-creation-guide.mdc.

## Combined Tools and Project-Rule-Parameters

Certain complex workflows benefit from combining tools from different sources:

### Back-End with Database Tools

```
db-implementation: transaction-history @workflows/back-end-workflow/db-patterns.mdc @parameters/tool/sql-patterns.mdc
```

This combines database implementation patterns with SQL-specific patterns.

### Back-End with API Testing Tools

```
api-implementation: user-authentication @workflows/back-end-workflow/api-patterns.mdc @parameters/tool/api-testing-patterns.mdc
```

This combines API implementation patterns with API testing techniques.

## File Structure Requirements

All 1000xbrain files referenced as project-rule-parameters MUST follow these structure requirements:

1. **No Frontmatter**: Files should NEVER contain frontmatter (the --- enclosed metadata sections)
2. **Direct Content**: All markdown content should begin directly with headers or text
3. **Standard Markdown**: Use only standard markdown formatting
4. **Header First**: Typically start with a level 1 header (# Title) followed by content 