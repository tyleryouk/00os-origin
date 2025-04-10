# Knowledge: Complexity Metrics

## Core Metrics

### Structural Complexity

* **Nesting Depth**: The maximum level of indentation or logical nesting in a file
* **Branching Complexity**: Number of conditional branches or decision points
* **Component Count**: Number of distinct logical components or sections
* **Dependency Count**: Number of external references or dependencies
* **Length Metrics**: Raw size in lines, paragraphs, or sections

### Conceptual Complexity

* **Concept Density**: Number of unique concepts introduced per section/file
* **Abstraction Level**: Degree of abstraction vs. concrete implementation
* **Cognitive Load**: Estimated mental effort to understand the component
* **Domain Specificity**: Reliance on domain-specific knowledge
* **Learning Curve**: Estimated time for a new developer to understand

### Implementation Complexity

* **Verbosity Ratio**: Amount of code/text relative to functionality provided
* **Documentation Ratio**: Documentation to implementation ratio
* **Parameter Complexity**: Number and complexity of parameters/options
* **Coupling Degree**: Tightness of integration with other components
* **Variability**: Number of different paths or configurations possible

### Maintenance Burden

* **Change Frequency**: Historical frequency of modifications needed
* **Change Impact**: Typical scope of changes (isolated vs. ripple effects)
* **Test/Verification Effort**: Difficulty of verifying correctness
* **Update Synchronicity**: Need to update multiple files in coordination

## Complexity Scoring System

### Baseline Scoring (1-5 scale)

1. **Trivial**: Simple, self-contained, easily understood
2. **Simple**: Straightforward but with some minimal structure
3. **Moderate**: Average complexity, understandable with some effort
4. **Complex**: Requires significant effort to understand fully
5. **Very Complex**: Requires extensive effort and expertise

### Complexity Factors (Multipliers)

* **Size Factor**: Based on relative size compared to similar components
* **Interconnection Factor**: Based on number of connections to other components
* **Specialty Factor**: Based on required specialized knowledge
* **Clarity Factor**: Based on documentation and readability

### Priority Calculation

Priority = Base Complexity Score × (Maintenance Frequency + Impact Factor) / Clarity Factor

## Application Guidelines

* Adapt metrics to the specific component type (code vs. documentation vs. configuration)
* Consider both absolute complexity and relative complexity compared to similar components
* Focus on identifying complexity hotspots rather than optimizing for minimal complexity everywhere
* Balance complexity reduction against maintaining necessary functionality
* Prioritize reducing complexity in frequently accessed or modified components

## Complexity Thresholds by Component Type

### Documentation Files

* **Low Complexity**: < 100 lines, < 3 sections, clear structure
* **Medium Complexity**: 100-300 lines, 3-7 sections, standard formatting
* **High Complexity**: > 300 lines, > 7 sections, intricate cross-references

### Command Files

* **Low Complexity**: < 5 tool calls, linear execution
* **Medium Complexity**: 5-15 tool calls, some conditional logic
* **High Complexity**: > 15 tool calls, complex dynamic execution

### Process Files

* **Low Complexity**: < 5 steps, straightforward workflow
* **Medium Complexity**: 5-10 steps, some branching paths
* **High Complexity**: > 10 steps, multiple interdependent conditions

### Script Files

* **Low Complexity**: < 50 lines, simple operations
* **Medium Complexity**: 50-200 lines, modular functions
* **High Complexity**: > 200 lines, advanced error handling and processing 