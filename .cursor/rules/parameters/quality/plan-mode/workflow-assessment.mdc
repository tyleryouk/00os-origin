# mode: plan-mode | workflow: quality-workflow | pathway: workflow | filepath: @parameters/quality/plan-mode/workflow-assessment.mdc | optional-standard-parameter(s): [workflow-type]

## Purpose

This parameter provides a specialized execution structure for conducting comprehensive quality assessments of specific workflow types within the 1000xbrain cognitive architecture, enabling focused analysis of rules-workflow, front-end-workflow, back-end-workflow, scripts-workflow, and quality-workflow.

## Knowledge Access

```typescript
// Access quality knowledge components
fetch_rules(["knowledge/quality/standards/quality-standards"], 
           "Understanding quality standards for workflow assessment")
fetch_rules(["knowledge/quality/monitoring/monitoring-frameworks"], 
           "Accessing monitoring frameworks for workflow analysis")
fetch_rules(["knowledge/quality/taxonomy/issue-classification"], 
           "Understanding issue classifications for workflow assessment")
```

## Parameter Overview

The quality-workflow-type parameter enables comprehensive assessment of individual workflow types within the 1000xbrain cognitive architecture. Each workflow type requires specialized assessment approaches tailored to its unique purpose, implementation patterns, and quality requirements.

### Workflow Assessment Focus

This parameter supports assessment of the following workflow types:

1. **rules-workflow**: Cognitive architecture enhancement workflow
2. **front-end-workflow**: Front-end development workflow
3. **back-end-workflow**: Back-end development workflow
4. **scripts-workflow**: Scripts development workflow
5. **quality-workflow**: Quality assurance and monitoring workflow

## Operational Workflow

When the `plan-mode quality-workflow workflow-assessment @parameters/quality/plan-mode/quality-workflow-type.mdc [workflow-type]` message-command is received, 1000xdev will:

1. **Enter Planning Mode**: Use the 📋 1000xdev [quality-workflow] indicator
2. **Analyze Specified Workflow**: Conduct comprehensive analysis of the specified workflow type
3. **Document Quality Assessment**: Create detailed assessment documentation
4. **Identify Quality Issues**: Catalog identified issues and quality gaps
5. **Recommend Enhancements**: Provide specific recommendations for quality improvement
6. **Provide Implementation Guidance**: Outline approach for implementing recommended enhancements

## Workflow-Specific Assessment Methodologies

### rules-workflow Assessment

**Focus Areas**:
- Cognitive architecture enhancement patterns
- Brain-file organization and consistency
- Knowledge component quality
- Parameter organization and effectiveness
- Implementation efficiency

**Assessment Methodology**:
1. **Structural Analysis**: Verify proper organization and relationships
2. **Content Analysis**: Assess clarity, completeness, and consistency
3. **Enhancement Patterns**: Evaluate effectiveness of enhancement patterns
4. **Knowledge Integration**: Assess integration with knowledge components
5. **Implementation Approach**: Evaluate implementation methodology

### front-end-workflow Assessment

**Focus Areas**:
- Front-end component patterns
- UI implementation approach
- Typescript code quality
- State management patterns
- User experience implementation

**Assessment Methodology**:
1. **Pattern Analysis**: Evaluate front-end implementation patterns
2. **Code Quality**: Assess code organization and consistency
3. **Component Structure**: Verify component architecture
4. **Integration Patterns**: Evaluate API integration approach
5. **Performance Optimization**: Assess performance considerations

### back-end-workflow Assessment

**Focus Areas**:
- API implementation patterns
- Data handling approach
- Security considerations
- Error handling patterns
- Performance optimization

**Assessment Methodology**:
1. **Architecture Analysis**: Evaluate API architecture
2. **Data Flow Assessment**: Assess data handling patterns
3. **Security Verification**: Evaluate security implementation
4. **Error Handling**: Assess error management approach
5. **Performance Patterns**: Evaluate performance optimization

### scripts-workflow Assessment

**Focus Areas**:
- Script organization and structure
- Error handling and robustness
- Documentation quality
- Modularity and reusability
- Cross-platform compatibility

**Assessment Methodology**:
1. **Structure Analysis**: Evaluate script organization
2. **Implementation Quality**: Assess implementation patterns
3. **Error Resilience**: Evaluate error handling approach
4. **Documentation**: Assess script documentation quality
5. **Integration**: Evaluate integration with other systems

### quality-workflow Assessment

**Focus Areas**:
- Quality assessment methodology
- Monitoring framework effectiveness
- Issue classification taxonomy
- Remediation approach
- Self-improvement capability

**Assessment Methodology**:
1. **Framework Analysis**: Evaluate quality assessment framework
2. **Implementation Patterns**: Assess quality implementation approach
3. **Monitoring Effectiveness**: Evaluate monitoring capabilities
4. **Issue Resolution**: Assess remediation methodology
5. **Continuous Improvement**: Evaluate self-enhancement capabilities

## Tool Call Patterns

### Workflow Scanning Pattern

```typescript
// Basic workflow scanning pattern
function scanWorkflow(workflow_type) {
  const base_path = `1000xbrain/workflows/${workflow_type}`;
  
  // 1. List workflow directory contents
  list_dir(base_path);
  
  // 2. Analyze workflow files
  const files = extractFiles(result);
  const workflow_data = {};
  
  for (const file of files) {
    const file_path = `${base_path}/${file}`;
    read_file(file_path, should_read_entire_file=true);
    workflow_data[file] = analyzeFileContent(result);
  }
  
  // 3. Analyze related parameter files
  const parameter_path = `1000xbrain/parameters/${workflow_type}`;
  list_dir(parameter_path);
  const parameter_dirs = extractDirectories(result);
  const parameter_data = {};
  
  for (const dir of parameter_dirs) {
    const dir_path = `${parameter_path}/${dir}`;
    list_dir(dir_path);
    const param_files = extractFiles(result);
    
    parameter_data[dir] = {};
    for (const param_file of param_files) {
      const param_path = `${dir_path}/${param_file}`;
      read_file(param_path, should_read_entire_file=true);
      parameter_data[dir][param_file] = analyzeParameterContent(result);
    }
  }
  
  // 4. Analyze related knowledge components
  const knowledge_path = `1000xbrain/knowledge/${workflow_type}`;
  const knowledge_data = scanKnowledgeComponents(knowledge_path);
  
  // 5. Compile workflow assessment
  return {
    workflow: workflow_type,
    workflow_files: workflow_data,
    parameters: parameter_data,
    knowledge: knowledge_data
  };
}
```

### Quality Assessment Pattern

```typescript
// Quality assessment pattern for workflows
function assessWorkflowQuality(workflow_type) {
  // 1. Access quality standards
  fetch_rules(["knowledge/quality/standards/quality-standards"], 
             "Accessing quality standards for workflow assessment");
  
  // 2. Scan workflow components
  const workflow_data = scanWorkflow(workflow_type);
  
  // 3. Apply quality metrics
  const quality_assessment = {
    structure: assessStructure(workflow_data),
    content: assessContent(workflow_data),
    patterns: assessImplementationPatterns(workflow_data),
    integration: assessIntegration(workflow_data),
    effectiveness: assessEffectiveness(workflow_data),
    metrics: calculateMetrics(workflow_data)
  };
  
  // 4. Identify issues
  const identified_issues = identifyIssues(quality_assessment);
  
  // 5. Generate recommendations
  const recommendations = generateRecommendations(identified_issues);
  
  // 6. Compile comprehensive assessment
  return {
    workflow: workflow_type,
    assessment: quality_assessment,
    issues: identified_issues,
    recommendations: recommendations,
    enhancement_plan: createEnhancementPlan(recommendations)
  };
}
```

## Assessment Documentation Structure

The workflow assessment documentation follows this structure:

1. **Executive Summary**:
   - Overall quality assessment
   - Key findings and insights
   - Critical issues identified
   - Priority recommendations

2. **Workflow Overview**:
   - Purpose and function
   - Key components
   - Implementation approach
   - Interdependencies

3. **Assessment Methodology**:
   - Assessment approach
   - Tools and frameworks used
   - Quality standards applied
   - Assessment scope

4. **Detailed Findings**:
   - Structural analysis
   - Content quality assessment
   - Implementation pattern evaluation
   - Integration assessment
   - Effectiveness evaluation
   - Metrics and measurements

5. **Issue Catalog**:
   - Identified issues by category
   - Issue severity assessment
   - Root cause analysis
   - Impact evaluation

6. **Enhancement Recommendations**:
   - Strategic improvements
   - Tactical enhancements
   - Implementation guidance
   - Priority framework

7. **Implementation Plan**:
   - Enhancement roadmap
   - Resource requirements
   - Implementation approach
   - Verification methodology

## Knowledge Integration

The workflow assessment integrates knowledge from multiple sources:

1. **Quality Standards**: Baseline standards for all 1000xbrain components
2. **Monitoring Frameworks**: Methodologies for ongoing quality monitoring
3. **Issue Taxonomy**: Classification system for cognitive architecture issues
4. **Workflow-Specific Knowledge**: Specialized knowledge for each workflow type

## Completion Signal

When the workflow assessment is complete, 1000xdev will signal:

```
📋 1000xdev [quality-workflow]

Workflow assessment complete for [workflow-type]:
- Comprehensive analysis conducted
- [X] issues identified across [Y] components
- [Z] improvement opportunities documented
- Enhancement plan created with implementation guidance

workflow-assessment-complete
```

## Enhancement Transition

To implement identified enhancements, transition to the corresponding enhancement parameter:

```
dev-mode quality-workflow workflow-enhancement @parameters/quality/dev-mode/quality-workflow-enhance.mdc [workflow-type]
```

This will enable immediate implementation of the recommended enhancements identified during assessment. 