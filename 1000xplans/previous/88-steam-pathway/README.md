# rules-workflow | system-wide

## Project Overview

This system-wide enhancement project aims to integrate the Steam Web API into the GigaSwap marketplace, focusing on CS2 skin trading capabilities. The implementation will create new pathways across multiple workflows (rules, front-end, and back-end) to provide a comprehensive cognitive architecture for handling Steam-related functionalities.

## Key Objectives

1. Create a structured pathway system for Steam Web API integration
2. Develop comprehensive knowledge components for Steam data handling
3. Implement parameter files across all relevant workflows
4. Establish auto-attached brain-files for specialized behavior
5. Maintain consistency with existing cognitive architecture patterns

## Implementation Scope

This enhancement spans multiple domains within the 1000xbrain cognitive architecture:

- **Rules workflow**: Creating pathways in parameters/rules/ and knowledge/rules/ for enhancing both front-end and back-end Steam integrations
- **Front-end workflow**: Establishing a complete Steam Web API pathway in parameters/front-end/ and knowledge/front-end/
- **Back-end workflow**: Developing an initial Steam Web API pathway in parameters/back-end/ and knowledge/back-end/
- **Knowledge components**: Building specialized knowledge bases for Steam data handling across all domains

## Pathway Structure

The project implements the following pathway structure:

```
1000xbrain/
├── knowledge/
│   ├── front-end/steam-web-api/     # Front-end implementation knowledge
│   ├── back-end/steam-web-api/      # Back-end implementation knowledge
│   └── rules/                       # Rules workflow knowledge
│       ├── front-end-steam-web-api/ # Rules for front-end integration
│       └── back-end-steam-web-api/  # Rules for back-end integration
│
├── parameters/
│   ├── front-end/                   # Front-end parameters
│   │   ├── plan-mode/steam-web-api.md
│   │   ├── dev-mode/steam-web-api.md
│   │   └── direct-mode/steam-web-api.md
│   ├── back-end/                    # Back-end parameters
│   │   ├── plan-mode/steam-web-api.md
│   │   ├── dev-mode/steam-web-api.md
│   │   └── direct-mode/steam-web-api.md
│   └── rules/                       # Rules workflow parameters
│       ├── plan-mode/
│       │   ├── front-end-steam-web-api.md
│       │   └── back-end-steam-web-api.md
│       ├── dev-mode/
│       │   ├── front-end-steam-web-api.md
│       │   └── back-end-steam-web-api.md
│       └── direct-mode/
│           ├── front-end-steam-web-api.md
│           └── back-end-steam-web-api.md
│
└── workflows/
    ├── front-end/steam-web-api.md   # Front-end auto-attached workflow
    └── back-end/steam-web-api.md    # Back-end auto-attached workflow
```

## Primary Files

The following planning documents provide essential context:

- **requirements.md**: Core requirements and objectives for the system-wide enhancement
- **context-steam-web-api.md**: Detailed information about the SteamWebAPI.com service
- **context-1000xbrain-structure.md**: Current state of the cognitive architecture
- **research-api-for-cs2-skin-trading.md**: Comprehensive API research and recommendations
- **implementation-system-wide-enhancement.md**: Implementation approach and sequencing
- **implementation-progress.md**: Current status of the implementation
- **next-steps-using-steam-pathway.md**: Getting started guide for using the pathways 