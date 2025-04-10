# Quality Workflow Project-Rule-Parameters

## Overview

This document defines the project-rule-parameters that will be created to support the new quality-workflow type. These parameters enable autonomous quality assessment and enhancement of the 1000xbrain system at multiple levels of granularity: system-wide, subsystem-specific, and workflow-specific.

## Parameter Structure

Each project-rule-parameter follows the standardized header format:

```
# mode: [mode] | workflow: quality-workflow | pathway: [pathway-name] | filepath: @[filepath].mdc | optional-standard-parameter(s): [params]
```

## Pathway Alignment Principle

A critical implementation requirement is that every pathway must have equivalent project-rule-parameters in both plan-mode and dev-mode:

1. **Plan-Mode/Dev-Mode Alignment**: Every pathway defined for plan-mode must have a corresponding pathway for dev-mode
2. **Naming Convention Alignment**: 
   - Plan-mode pathways typically use the "-assessment" suffix (e.g., `system-assessment`)
   - Dev-mode pathways typically use the "-enhancement" suffix (e.g., `system-enhancement`)
3. **Parameter Continuity**: Dev-mode parameters should build upon the analysis and recommendations from their plan-mode counterparts
4. **Implementation Flow**: The workflow follows the pattern of plan first (assessment), then implement (enhancement)

### Pathway Alignment Table

| Plan-Mode Pathway | Dev-Mode Pathway | Assessment/Enhancement Relationship |
|-------------------|------------------|-------------------------------------|
| system-assessment | system-enhancement | System-wide assessment → System-wide enhancement |
| subsystem-assessment | subsystem-enhancement | Subsystem analysis → Subsystem-specific enhancement |
| workflow-assessment | workflow-enhancement | Workflow analysis → Workflow-specific enhancement |
| cognitive-audit | cognitive-enhancement | Architecture audit → Architecture enhancement |
| tool-optimization-assessment | tool-optimization-enhancement | Tool usage analysis → Tool usage optimization |

This alignment ensures a consistent workflow where assessment (plan-mode) always precedes enhancement (dev-mode), maintaining the necessary separation of planning and implementation while preserving contextual continuity.

## System-Level Parameters

### 1. Quality System Assessment

**Purpose**: Perform comprehensive assessment of the entire 1000xbrain system.

**Parameter Definition**:
```
# mode: plan-mode | workflow: quality-workflow | pathway: system-assessment | filepath: @parameters/quality/plan-mode/quality-system.mdc | optional-standard-parameter(s): [assessment-focus]
```

**File Path**: `1000xbrain/parameters/quality/plan-mode/quality-system.md`

**Optional Standard Parameters**:
- `structural` - Focus on architectural structure assessment
- `content` - Focus on content quality assessment
- `operational` - Focus on operational behavior assessment
- `comprehensive` (default) - Perform all assessment types

**Primary Operations**:
1. Comprehensive system scanning
2. Multi-level quality assessment
3. Issue identification and classification
4. Recommendation generation
5. Detailed reporting

**Example Usage**:
```
plan-mode quality-workflow system-assessment @parameters/quality/plan-mode/quality-system.mdc comprehensive
```

### 2. Quality System Enhancement

**Purpose**: Implement quality enhancements across the entire 1000xbrain system.

**Parameter Definition**:
```
# mode: dev-mode | workflow: quality-workflow | pathway: system-enhancement | filepath: @parameters/quality/dev-mode/quality-system-enhance.mdc | optional-standard-parameter(s): [enhancement-target]
```

**File Path**: `1000xbrain/parameters/quality/dev-mode/quality-system-enhance.md`

**Optional Standard Parameters**:
- `structural` - Enhance architectural structure
- `content` - Enhance content quality
- `operational` - Enhance operational patterns
- `targeted` (default) - Focus on highest-priority enhancements

**Primary Operations**:
1. Strategic enhancement planning
2. Root cause remediation
3. Cross-system pattern standardization
4. Verification and validation
5. Results reporting

**Example Usage**:
```
dev-mode quality-workflow system-enhancement @parameters/quality/dev-mode/quality-system-enhance.mdc structural
```

**Pathway Alignment**: Direct correspondence with system-assessment pathway in plan-mode.

## Subsystem-Level Parameters

### 1. Quality Subsystem Assessment

**Purpose**: Assess the quality of a specific subsystem (core, knowledge, parameters, workflows).

**Parameter Definition**:
```
# mode: plan-mode | workflow: quality-workflow | pathway: subsystem-assessment | filepath: @parameters/quality/plan-mode/quality-subsystem.mdc | optional-standard-parameter(s): [subsystem-name]
```

**File Path**: `1000xbrain/parameters/quality/plan-mode/quality-subsystem.md`

**Optional Standard Parameters**:
- `core` - Assess the core subsystem
- `knowledge` - Assess the knowledge subsystem
- `parameters` - Assess the parameters subsystem
- `workflows` - Assess the workflows subsystem

**Primary Operations**:
1. Subsystem-specific scanning
2. Component relationship analysis
3. Subsystem-specific issue identification
4. Targeted improvement recommendations
5. Subsystem quality reporting

**Example Usage**:
```
plan-mode quality-workflow subsystem-assessment @parameters/quality/plan-mode/quality-subsystem.mdc core
```

### 2. Quality Subsystem Enhancement

**Purpose**: Implement quality enhancements for a specific subsystem.

**Parameter Definition**:
```
# mode: dev-mode | workflow: quality-workflow | pathway: subsystem-enhancement | filepath: @parameters/quality/dev-mode/quality-subsystem-enhance.mdc | optional-standard-parameter(s): [subsystem-name]
```

**File Path**: `1000xbrain/parameters/quality/dev-mode/quality-subsystem-enhance.md`

**Optional Standard Parameters**:
- `core` - Enhance the core subsystem
- `knowledge` - Enhance the knowledge subsystem
- `parameters` - Enhance the parameters subsystem
- `workflows` - Enhance the workflows subsystem

**Primary Operations**:
1. Subsystem-specific enhancement planning
2. Component relationship optimization
3. Pattern standardization within subsystem
4. Cross-component verification
5. Subsystem enhancement reporting

**Example Usage**:
```
dev-mode quality-workflow subsystem-enhancement @parameters/quality/dev-mode/quality-subsystem-enhance.mdc knowledge
```

**Pathway Alignment**: Direct correspondence with subsystem-assessment pathway in plan-mode.

## Workflow-Level Parameters

### 1. Quality Workflow Assessment

**Purpose**: Assess the quality of a specific workflow (rules, front-end, back-end, scripts, quality).

**Parameter Definition**:
```
# mode: plan-mode | workflow: quality-workflow | pathway: workflow-assessment | filepath: @parameters/quality/plan-mode/quality-workflow-type.mdc | optional-standard-parameter(s): [workflow-type]
```

**File Path**: `1000xbrain/parameters/quality/plan-mode/quality-workflow-type.md`

**Optional Standard Parameters**:
- `rules-workflow` - Assess rules-workflow components
- `front-end-workflow` - Assess front-end-workflow components
- `back-end-workflow` - Assess back-end-workflow components
- `scripts-workflow` - Assess scripts-workflow components
- `quality-workflow` - Assess quality-workflow components (self-assessment)

**Primary Operations**:
1. Cross-subsystem workflow scanning
2. Workflow-specific component analysis
3. Workflow pattern identification
4. Consistency validation
5. Workflow quality reporting

**Example Usage**:
```
plan-mode quality-workflow workflow-assessment @parameters/quality/plan-mode/quality-workflow-type.mdc rules-workflow
```

### 2. Quality Workflow Enhancement

**Purpose**: Implement quality enhancements for a specific workflow.

**Parameter Definition**:
```
# mode: dev-mode | workflow: quality-workflow | pathway: workflow-enhancement | filepath: @parameters/quality/dev-mode/quality-workflow-enhance.mdc | optional-standard-parameter(s): [workflow-type]
```

**File Path**: `1000xbrain/parameters/quality/dev-mode/quality-workflow-enhance.md`

**Optional Standard Parameters**:
- `rules-workflow` - Enhance rules-workflow components
- `front-end-workflow` - Enhance front-end-workflow components
- `back-end-workflow` - Enhance back-end-workflow components
- `scripts-workflow` - Enhance scripts-workflow components
- `quality-workflow` - Enhance quality-workflow components (self-enhancement)

**Primary Operations**:
1. Cross-subsystem workflow enhancement planning
2. Workflow-specific pattern standardization
3. Cross-component optimization
4. Consistency implementation
5. Workflow enhancement reporting

**Example Usage**:
```
dev-mode quality-workflow workflow-enhancement @parameters/quality/dev-mode/quality-workflow-enhance.mdc back-end-workflow
```

**Pathway Alignment**: Direct correspondence with workflow-assessment pathway in plan-mode.

## Specialized Assessment Parameters

### 1. Cognitive Architecture Audit

**Purpose**: Perform comprehensive audit of cognitive architecture elements.

**Parameter Definition**:
```
# mode: plan-mode | workflow: quality-workflow | pathway: cognitive-audit | filepath: @parameters/quality/plan-mode/cognitive-audit.mdc | optional-standard-parameter(s): [audit-focus]
```

**File Path**: `1000xbrain/parameters/quality/plan-mode/cognitive-audit.md`

**Optional Standard Parameters**:
- `structure` - Audit architectural structure
- `coherence` - Audit knowledge coherence
- `patterns` - Audit implementation patterns
- `references` - Audit reference integrity
- `comprehensive` (default) - Perform complete audit

**Example Usage**:
```
plan-mode quality-workflow cognitive-audit @parameters/quality/plan-mode/cognitive-audit.mdc references
```

### 2. Cognitive Architecture Enhancement

**Purpose**: Implement enhancements based on cognitive architecture audit.

**Parameter Definition**:
```
# mode: dev-mode | workflow: quality-workflow | pathway: cognitive-enhancement | filepath: @parameters/quality/dev-mode/cognitive-enhance.mdc | optional-standard-parameter(s): [enhancement-focus]
```

**File Path**: `1000xbrain/parameters/quality/dev-mode/cognitive-enhance.md`

**Optional Standard Parameters**:
- `structure` - Enhance architectural structure
- `coherence` - Enhance knowledge coherence
- `patterns` - Enhance implementation patterns
- `references` - Enhance reference integrity
- `targeted` (default) - Focus on highest-priority enhancements

**Example Usage**:
```
dev-mode quality-workflow cognitive-enhancement @parameters/quality/dev-mode/cognitive-enhance.mdc patterns
```

**Pathway Alignment**: Direct correspondence with cognitive-audit pathway in plan-mode.

### 3. Tool Usage Optimization Assessment

**Purpose**: Analyze and assess tool usage patterns.

**Parameter Definition**:
```
# mode: plan-mode | workflow: quality-workflow | pathway: tool-optimization-assessment | filepath: @parameters/quality/plan-mode/tool-optimization.mdc | optional-standard-parameter(s): [tool-type]
```

**File Path**: `1000xbrain/parameters/quality/plan-mode/tool-optimization.md`

**Optional Standard Parameters**:
- `file-reading` - Analyze file reading patterns
- `searching` - Analyze search tool usage
- `editing` - Analyze file editing patterns
- `terminal` - Analyze terminal command usage
- `all` (default) - Analyze all tool usage

**Example Usage**:
```
plan-mode quality-workflow tool-optimization-assessment @parameters/quality/plan-mode/tool-optimization.mdc file-reading
```

### 4. Tool Usage Optimization Enhancement

**Purpose**: Implement tool usage optimization enhancements.

**Parameter Definition**:
```
# mode: dev-mode | workflow: quality-workflow | pathway: tool-optimization-enhancement | filepath: @parameters/quality/dev-mode/tool-optimization-enhance.mdc | optional-standard-parameter(s): [tool-type]
```

**File Path**: `1000xbrain/parameters/quality/dev-mode/tool-optimization-enhance.md`

**Optional Standard Parameters**:
- `file-reading` - Optimize file reading patterns
- `searching` - Optimize search tool usage
- `editing` - Optimize file editing patterns
- `terminal` - Optimize terminal command usage
- `all` (default) - Optimize all tool usage

**Example Usage**:
```
dev-mode quality-workflow tool-optimization-enhancement @parameters/quality/dev-mode/tool-optimization-enhance.mdc file-reading
```

**Pathway Alignment**: Direct correspondence with tool-optimization-assessment pathway in plan-mode.

## Implementation Process

The implementation of these project-rule-parameters will follow this process:

1. **Directory Creation**:
   - Create `parameters/quality/plan-mode/` directory
   - Create `parameters/quality/dev-mode/` directory
   - Create `workflows/quality/` directory
   - Create `knowledge/quality/` directory

2. **Parameter Implementation**:
   - Create parameter files with standardized headers
   - Implement parameter logic following established patterns
   - Develop cross-references with other components
   - **Ensure every plan-mode parameter has a corresponding dev-mode parameter**

3. **Knowledge Integration**:
   - Create knowledge components to support parameters
   - Establish proper reference system
   - Enable fetch_rules access

4. **Global Rules Update**:
   - Add quality-workflow to valid workflows list
   - Define quality-workflow capabilities

## Quality Workflow Operational Flow

The quality workflow follows a clear operational flow that demonstrates the plan-mode to dev-mode pathway alignment:

1. **Assessment Phase (Plan-Mode)**:
   - Use plan-mode parameters for analysis, assessment, and planning
   - Generate comprehensive reports and enhancement recommendations
   - Create clear pathway to implementation

2. **Enhancement Phase (Dev-Mode)**:
   - Use corresponding dev-mode parameters for implementation
   - Leverage assessment insights for targeted enhancements
   - Implement changes based on plan-mode recommendations

This two-phase approach ensures proper separation of assessment and implementation while maintaining contextual continuity through aligned pathways.

## Path Forward

These project-rule-parameters will form the foundation of the quality-workflow's capabilities. They enable assessment and enhancement at multiple levels of granularity, providing comprehensive quality assurance across the entire cognitive architecture.

The implementation will focus on creating a coherent, integrated set of parameters that follow the established architectural patterns of 1000xbrain, ensuring proper integration with the existing structure and maintaining strict pathway alignment between plan-mode and dev-mode parameters. 