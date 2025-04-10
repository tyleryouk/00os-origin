# Context: Steam Web API Cognitive Architecture Mapping

This document maps the cognitive architecture components related to the Steam Web API pathway, showing their relationships and integration points.

## High-Level Architecture Map

```
┌───────────────────────────────────────────────────────────────────────────────────┐
│                                                                                   │
│                            STEAM WEB API PATHWAY                                  │
│                                                                                   │
├───────────────────────────┬───────────────────────────┬───────────────────────────┤
│                           │                           │                           │
│    KNOWLEDGE COMPONENTS   │    PARAMETER COMPONENTS   │    WORKFLOW COMPONENTS    │
│                           │                           │                           │
├───────────────┬───────────┼───────────────┬───────────┼───────────────┬───────────┤
│               │           │               │           │               │           │
│  FRONT-END    │  BACK-END │  FRONT-END    │  BACK-END │  FRONT-END    │  BACK-END │
│               │           │               │           │               │           │
└───────────────┴───────────┴───────────────┴───────────┴───────────────┴───────────┘
```

## Component Relationships

### Knowledge Components

The knowledge components form the foundation of understanding for Steam Web API integration:

1. **Front-End Knowledge**
   - `knowledge/front-end/steam-web-api/authentication`
   - `knowledge/front-end/steam-web-api/inventory`
   - `knowledge/front-end/steam-web-api/market-data`
   - `knowledge/front-end/steam-web-api/trading`

2. **Back-End Knowledge**
   - `knowledge/back-end/steam-web-api/authentication`
   - `knowledge/back-end/steam-web-api/data-caching`
   - `knowledge/back-end/steam-web-api/market-data`
   - `knowledge/back-end/steam-web-api/security`

3. **Rules Knowledge**
   - `knowledge/rules/back-end-steam-web-api/best-practices`
   - `knowledge/rules/front-end-steam-web-api/best-practices`

### Parameter Components

Parameter components provide implementation guidance through project-rule-parameters:

1. **Front-End Parameters**
   - `parameters/front-end/steam-web-api/authentication`
   - `parameters/front-end/steam-web-api/inventory`
   - `parameters/front-end/steam-web-api/market-data`
   - `parameters/front-end/steam-web-api/trading`

2. **Back-End Parameters**
   - `parameters/back-end/steam-web-api/authentication`
   - `parameters/back-end/steam-web-api/data-caching`
   - `parameters/back-end/steam-web-api/market-data`
   - `parameters/back-end/steam-web-api/security`

3. **Rules Parameters**
   - `parameters/rules/back-end-steam-web-api/best-practices`
   - `parameters/rules/front-end-steam-web-api/best-practices`

### Workflow Components

Workflow components activate when working with specific file types:

1. **Front-End Workflows**
   - `workflows/front-end/steam-web-api/authentication-workflow`
   - `workflows/front-end/steam-web-api/inventory-workflow`
   - `workflows/front-end/steam-web-api/market-data-workflow`
   - `workflows/front-end/steam-web-api/trading-workflow`

2. **Back-End Workflows**
   - `workflows/back-end/steam-web-api/authentication-workflow`
   - `workflows/back-end/steam-web-api/data-caching-workflow`
   - `workflows/back-end/steam-web-api/market-data-workflow`
   - `workflows/back-end/steam-web-api/security-workflow`

## Integration Points

### Front-End to Back-End Integration

The Steam Web API integration requires coordinated development across front-end and back-end components:

```
┌───────────────────────────┐             ┌───────────────────────────┐
│                           │             │                           │
│   FRONT-END COMPONENTS    │◄────────────►    BACK-END COMPONENTS    │
│                           │             │                           │
└───────────┬───────────────┘             └───────────────┬───────────┘
            │                                             │
            ▼                                             ▼
┌───────────────────────────┐             ┌───────────────────────────┐
│                           │             │                           │
│     STEAM AUTH FLOW       │◄────────────►    STEAM AUTH PROXY       │
│                           │             │                           │
└───────────────────────────┘             └───────────────────────────┘
            │                                             │
            ▼                                             ▼
┌───────────────────────────┐             ┌───────────────────────────┐
│                           │             │                           │
│   INVENTORY COMPONENTS    │◄────────────►   INVENTORY DATA PROXY    │
│                           │             │                           │
└───────────────────────────┘             └───────────────────────────┘
            │                                             │
            ▼                                             ▼
┌───────────────────────────┐             ┌───────────────────────────┐
│                           │             │                           │
│   MARKET DATA DISPLAY     │◄────────────►   MARKET DATA SERVICE     │
│                           │             │                           │
└───────────────────────────┘             └───────────────────────────┘
            │                                             │
            ▼                                             ▼
┌───────────────────────────┐             ┌───────────────────────────┐
│                           │             │                           │
│    TRADING INTERFACE      │◄────────────►     TRADING SERVICE       │
│                           │             │                           │
└───────────────────────────┘             └───────────────────────────┘
```

### Knowledge to Parameter Integration

Knowledge components are accessed by parameter components through fetch_rules:

```
┌─────────────────────────────┐        ┌─────────────────────────────┐
│                             │        │                             │
│     PARAMETER COMPONENT     │        │     KNOWLEDGE COMPONENT     │
│                             │        │                             │
│  parameters/front-end/...   │───────▶│  knowledge/front-end/...    │
│                             │fetch   │                             │
└─────────────────────────────┘rules   └─────────────────────────────┘
```

### Data Flow Architecture

The Steam Web API integration follows this data flow pattern:

```
┌───────────────┐      ┌───────────────┐      ┌───────────────┐      ┌───────────────┐
│               │      │               │      │               │      │               │
│  Steam Web    │──────►  GigaSwap     │──────►  GigaSwap     │──────►  GigaSwap     │
│  API          │      │  Back-End     │      │  Front-End    │      │  User         │
│               │      │  Proxy        │      │  Components   │      │  Interface    │
│               │      │               │      │               │      │               │
└───────────────┘      └───────────────┘      └───────────────┘      └───────────────┘
```

## Communication Paths

The fetch_rules tool enables communication between parameter components and knowledge components:

1. **Front-End Communication Path**
   - `parameters/front-end/steam-web-api/authentication` → `knowledge/front-end/steam-web-api/authentication`
   - `parameters/front-end/steam-web-api/inventory` → `knowledge/front-end/steam-web-api/inventory`
   - `parameters/front-end/steam-web-api/market-data` → `knowledge/front-end/steam-web-api/market-data`
   - `parameters/front-end/steam-web-api/trading` → `knowledge/front-end/steam-web-api/trading`

2. **Back-End Communication Path**
   - `parameters/back-end/steam-web-api/authentication` → `knowledge/back-end/steam-web-api/authentication`
   - `parameters/back-end/steam-web-api/data-caching` → `knowledge/back-end/steam-web-api/data-caching`
   - `parameters/back-end/steam-web-api/market-data` → `knowledge/back-end/steam-web-api/market-data`
   - `parameters/back-end/steam-web-api/security` → `knowledge/back-end/steam-web-api/security`

3. **Rules Communication Path**
   - `parameters/rules/back-end-steam-web-api/best-practices` → `knowledge/rules/back-end-steam-web-api/best-practices`
   - `parameters/rules/front-end-steam-web-api/best-practices` → `knowledge/rules/front-end-steam-web-api/best-practices` 