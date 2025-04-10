# Knowledge: Pattern Recognition Principles

## Core Concepts

* **Pattern**: A consistent structure, format, or approach that appears multiple times across the codebase
* **Redundancy**: Duplicated code, logic, or documentation that serves essentially the same purpose
* **Similarity**: The degree to which different code segments or files resemble each other
* **Standard vs. Non-Standard**: Deviation from established patterns within the codebase

## Pattern Types to Identify

### Documentation Patterns

* **Placeholder Content**: Text like "TODO", "TBD", or minimal implementation markers
* **Template Markers**: Unchanged template content, boilerplate text, or example code
* **Documentation Structures**: Headers, sections, and formats that should be consistent
* **Reference Formats**: Citations, links, and cross-references to other components

### Code Patterns

* **Tool Call Patterns**: Similar sequences of tool calls that might be abstracted
* **Logic Structures**: Common decision trees, loops, or processing sequences
* **Error Handling**: Standard approaches to error detection and recovery
* **Setup/Teardown**: Initialization and cleanup code with similar structures

### File Organization Patterns

* **Naming Conventions**: Files that don't follow the established naming patterns
* **Directory Structure**: Files in unexpected locations based on component type
* **Related File Groups**: Sets of files that typically appear together but are incomplete

## Similarity Metrics

### Lexical Similarity

* **Text Matching**: Percentage of identical text between files
* **Fuzzy Matching**: Accounting for minor variations in otherwise similar text
* **N-gram Analysis**: Detecting similar phrases or sequences

### Structural Similarity

* **Component Organization**: Similar organization of sections/blocks
* **Function Signatures**: Similar parameters, returns, and documentation
* **Import/Reference Patterns**: Similar dependencies or reference structures

### Functional Similarity

* **Purpose Overlap**: Different components serving the same functional role
* **API Surface**: Similar interfaces despite different implementations
* **Use Cases**: Components addressing the same user needs

## Application Guidelines

* Always consider context when identifying patterns - what makes sense in one component type may not in another
* Focus on actionable patterns that represent opportunities for simplification
* Prioritize patterns that impact maintainability and cognitive complexity
* Consider both the cost of inconsistency and the cost of enforcing consistency 