# workflow: rules-workflow | pathway: front-end-steam-web-api | message-command: plan-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/plan-mode/front-end-steam-web-api.md

## Parameter Purpose

This parameter provides specialized guidance for planning and documenting enhancements to the Steam Web API integration in front-end components while in Planning Mode. It focuses on documentation standards, planning strategies, and knowledge organization for the GigaSwap marketplace's front-end Steam integration.

## Usage Context

Use this parameter when planning or documenting rules related to front-end Steam Web API integration, including:

- Authentication flow documentation
- Inventory display patterns
- Market data visualization
- Trading interface components
- Error handling strategies
- Cross-system patterns

## Implementation Guidelines

### Documentation Structure

Create comprehensive documentation for Steam Web API integration following this structure:

1. **Knowledge Organization**:
   - Organize knowledge files in logical categories
   - Use clear file naming conventions
   - Implement consistent header structure
   - Create cross-reference system

```typescript
// Create knowledge directory structure
run_terminal_cmd("mkdir -p 1000xbrain/knowledge/rules/front-end-steam-web-api", false)

// Verify directory structure
list_dir("1000xbrain/knowledge/rules/front-end-steam-web-api")
```

2. **Documentation Template**:
   - Implement standardized document template
   - Include proper headers with USE WHEN statements
   - Add clear sections for different topics
   - Ensure consistent formatting

```typescript
// Create template for authentication patterns
edit_file("1000xbrain/knowledge/rules/front-end-steam-web-api/authentication-patterns.md",
          "Create authentication patterns documentation template",
          "# USE WHEN implementing authentication patterns for Steam API integration\n\n## Overview\n\nThis file documents best practices and patterns for implementing Steam authentication in front-end components.\n\n## Key Patterns\n\n1. **Pattern One**:\n   - Description point one\n   - Description point two\n   - Description point three\n\n2. **Pattern Two**:\n   - Description point one\n   - Description point two\n   - Description point three\n\n## Implementation Guidelines\n\n### Implementation Example\n\n```tsx\n// Example code\n```\n\n## Error Handling\n\n// Error handling guidelines\n\n## Cross-References\n\n// Cross-references to related knowledge components")
```

### Planning Guidelines

1. **Knowledge Component Planning**:
   - Identify required knowledge components
   - Draft structure for each component
   - Plan cross-reference system
   - Define access patterns

```typescript
// Plan knowledge component structure
edit_file("planning/steam-integration/knowledge-components.md",
          "Plan knowledge component structure",
          "# Knowledge Component Structure\n\n## Front-End Steam Web API Integration\n\n### Core Knowledge Components\n\n1. **Authentication Patterns**\n   - Purpose: Document patterns for Steam authentication\n   - Location: knowledge/rules/front-end-steam-web-api/authentication-patterns.md\n   - Content: Authentication flow, token management, session handling\n\n2. **Inventory Patterns**\n   - Purpose: Document patterns for inventory display\n   - Location: knowledge/rules/front-end-steam-web-api/inventory-patterns.md\n   - Content: Data fetching, refresh strategies, filtering and sorting\n\n3. **Market Data Patterns**\n   - Purpose: Document patterns for market data visualization\n   - Location: knowledge/rules/front-end-steam-web-api/market-patterns.md\n   - Content: Price history, real-time updates, data aggregation\n\n4. **Trading Patterns**\n   - Purpose: Document patterns for trading interface\n   - Location: knowledge/rules/front-end-steam-web-api/trading-patterns.md\n   - Content: Trade offer creation, status tracking, history display\n\n5. **Best Practices**\n   - Purpose: Document overall best practices\n   - Location: knowledge/rules/front-end-steam-web-api/best-practices.md\n   - Content: Overall best practices, cross-cutting concerns\n\n### Cross-Reference Structure\n\nEach knowledge component should reference related components as follows:\n\n- Authentication should reference inventory and trading\n- Inventory should reference authentication and market data\n- Market data should reference inventory and trading\n- Trading should reference authentication and inventory\n- Best practices should reference all other components")
```

2. **Terminology Standardization**:
   - Define standard terminology
   - Document term usage
   - Create consistent naming patterns
   - Establish abbreviation standards

```typescript
// Create terminology standard document
edit_file("planning/steam-integration/terminology.md",
          "Create terminology standards document",
          "# Terminology Standards\n\n## Steam Web API Integration\n\n### Core Terms\n\n| Term | Definition | Usage Context |\n|------|------------|---------------|\n| Steam OpenID | Authentication protocol used by Steam | Authentication flow discussions |\n| Steam Inventory | Collection of items in a user's Steam account | Inventory display discussions |\n| Market Data | Price and volume information from Steam Market | Market visualization discussions |\n| Trade Offer | A proposed exchange of items between users | Trading interface discussions |\n\n### Naming Patterns\n\n1. **Component Names**:\n   - `SteamLoginButton` - Component for initiating login\n   - `SteamInventoryGrid` - Component for displaying inventory\n   - `SteamMarketChart` - Component for market data visualization\n   - `SteamTradeOffer` - Component for creating trade offers\n\n2. **Function Names**:\n   - `useSteamAuth()` - Hook for authentication\n   - `useSteamInventory()` - Hook for inventory data\n   - `useSteamMarket()` - Hook for market data\n   - `useSteamTrade()` - Hook for trading functionality\n\n3. **File Names**:\n   - `authentication-patterns.md` - For authentication patterns\n   - `inventory-patterns.md` - For inventory patterns\n   - `market-patterns.md` - For market data patterns\n   - `trading-patterns.md` - For trading patterns")
```

3. **Implementation Planning**:
   - Create detailed implementation roadmap
   - Define milestones and dependencies
   - Establish verification checkpoints
   - Document success criteria

```typescript
// Create implementation roadmap
edit_file("planning/steam-integration/implementation-roadmap.md",
          "Create implementation roadmap",
          "# Implementation Roadmap\n\n## Front-End Steam Web API Integration\n\n### Phase 1: Knowledge Foundation\n\n1. **Create Best Practices Document**\n   - Milestone: Complete best practices documentation\n   - Dependencies: None\n   - Timeline: 1 day\n\n2. **Create Authentication Patterns**\n   - Milestone: Complete authentication patterns documentation\n   - Dependencies: Best practices document\n   - Timeline: 1 day\n\n3. **Create Inventory Patterns**\n   - Milestone: Complete inventory patterns documentation\n   - Dependencies: Authentication patterns\n   - Timeline: 1 day\n\n### Phase 2: Specialized Patterns\n\n4. **Create Market Data Patterns**\n   - Milestone: Complete market data patterns documentation\n   - Dependencies: Inventory patterns\n   - Timeline: 1 day\n\n5. **Create Trading Patterns**\n   - Milestone: Complete trading patterns documentation\n   - Dependencies: Authentication and inventory patterns\n   - Timeline: 1 day\n\n### Phase 3: Cross-System Integration\n\n6. **Create Cross-System Patterns**\n   - Milestone: Document patterns that span front-end and back-end\n   - Dependencies: All previous patterns\n   - Timeline: 1 day\n\n7. **Implement Verification System**\n   - Milestone: Create verification methods for pattern implementation\n   - Dependencies: All pattern documentation\n   - Timeline: 1 day\n\n### Success Criteria\n\n- All knowledge components properly documented\n- Cross-reference system implemented\n- Terminology standardized across all components\n- Implementation roadmap complete with clear milestones")
```

### Knowledge Access Pattern

Document appropriate fetch_rules patterns for accessing Steam Web API integration knowledge:

```typescript
// Create knowledge access guide
edit_file("planning/steam-integration/knowledge-access.md",
          "Create knowledge access guide",
          "# Knowledge Access Guide\n\n## Accessing Front-End Steam Web API Knowledge\n\n### Basic Access Pattern\n\n```typescript\nfetch_rules([\"knowledge/rules/front-end-steam-web-api/best-practices\"], \n           \"Understanding best practices for Steam API integration\")\n```\n\n### Specific Pattern Access\n\n```typescript\nfetch_rules([\"knowledge/rules/front-end-steam-web-api/authentication-patterns\"], \n           \"Understanding Steam authentication patterns\")\n\nfetch_rules([\"knowledge/rules/front-end-steam-web-api/inventory-patterns\"], \n           \"Understanding Steam inventory integration patterns\")\n\nfetch_rules([\"knowledge/rules/front-end-steam-web-api/market-patterns\"], \n           \"Understanding Steam market data visualization patterns\")\n\nfetch_rules([\"knowledge/rules/front-end-steam-web-api/trading-patterns\"], \n           \"Understanding Steam trading implementation patterns\")\n```\n\n### Multiple Component Access\n\n```typescript\nfetch_rules([\n  \"knowledge/rules/front-end-steam-web-api/authentication-patterns\",\n  \"knowledge/rules/front-end-steam-web-api/inventory-patterns\"\n], \"Understanding authentication and inventory integration patterns\")\n```\n\n### Cross-System Knowledge Access\n\n```typescript\nfetch_rules([\n  \"knowledge/rules/front-end-steam-web-api/authentication-patterns\",\n  \"knowledge/rules/back-end-steam-web-api/authentication-patterns\"\n], \"Understanding full-stack authentication patterns\")\n```")
```

## Documentation Verification Guidelines

Before completing planning documentation, verify:

1. **Content Completeness**:
   - All required knowledge components planned
   - Implementation roadmap complete
   - Terminology standards defined
   - Knowledge access patterns documented

2. **Structure Consistency**:
   - Consistent document structure
   - Proper header format
   - Clear section organization
   - Complete cross-references

3. **Feasibility Assessment**:
   - Implementation timeline realistic
   - Dependencies correctly identified
   - Success criteria well-defined
   - Verification methods established

## Cross-References

- **Front-End Authentication Knowledge**: `knowledge/front-end/steam-web-api/authentication.md`
- **Front-End Implementation Best Practices**: `knowledge/rules/front-end-steam-web-api/best-practices.md`
- **Back-End Planning Parameter**: `parameters/rules/plan-mode/back-end-steam-web-api.md`
- **System-Wide Planning Guide**: `knowledge/rules/guides/planning-patterns.md` 