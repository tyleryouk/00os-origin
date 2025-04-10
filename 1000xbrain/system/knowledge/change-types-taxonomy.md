# Change Types Taxonomy

## Overview

This knowledge file defines a comprehensive taxonomy of change types that can be addressed within the system, particularly through the major-changes workflow. The taxonomy provides a framework for understanding, categorizing, and handling different types of changes, enabling specialized knowledge development for each category.

## Primary Change Categories

### 1. Structural Changes

Changes that modify the organization, architecture, or fundamental structure of the system.

#### Subcategories:
* **Directory Reorganization**: Changing how files are organized within directories
* **Component Separation/Merging**: Splitting or combining system components
* **Interface Modification**: Changing how components interact with each other
* **Pattern Implementation**: Introducing new design patterns across the system

#### Typical Characteristics:
* Impact multiple files or directories
* Require careful coordination of changes
* May require updates to references and imports
* Often involve moving functionality between components

### 2. Functional Changes

Changes that modify what the system does or how it behaves.

#### Subcategories:
* **Feature Addition**: Adding entirely new capabilities to the system
* **Feature Enhancement**: Improving or extending existing functionality
* **Feature Removal**: Removing functionality that is no longer needed
* **Behavior Modification**: Changing how the system responds to inputs or conditions

#### Typical Characteristics:
* Focus on capabilities rather than implementation details
* May require new files, components, or integrations
* Often involve updating documentation to reflect new capabilities
* May require testing to ensure changes meet requirements

### 3. Performance Optimizations

Changes specifically focused on improving efficiency, speed, or resource usage.

#### Subcategories:
* **Algorithm Optimization**: Improving how computations are performed
* **Resource Management**: Enhancing how system resources are allocated and used
* **Caching Implementation**: Adding or improving caching mechanisms
* **Parallel Processing**: Implementing or improving concurrent execution

#### Typical Characteristics:
* Often involve complex tradeoffs between metrics
* Require careful measurement before and after changes
* May impact other non-functional requirements
* Focus on implementation details rather than external behavior

### 4. Integration Changes

Changes related to how the system interacts with external components or systems.

#### Subcategories:
* **API Implementation**: Adding or modifying interfaces for external systems
* **Dependency Management**: Changing libraries, frameworks, or tools used
* **Protocol Adaptation**: Updating how the system communicates with other systems
* **Data Format Changes**: Modifying data structures used for interchange

#### Typical Characteristics:
* Often cross system boundaries
* May require coordination with external systems
* Focus on compatibility and interoperability
* May involve versioning considerations

### 5. Refactoring Operations

Changes that improve code quality without changing external behavior.

#### Subcategories:
* **Code Cleaning**: Improving readability and maintainability
* **Technical Debt Reduction**: Addressing known implementation issues
* **Pattern Application**: Introducing consistent patterns within code
* **Naming Standardization**: Improving clarity through naming conventions

#### Typical Characteristics:
* Should not change external system behavior
* Focus on internal quality and maintainability
* Often involve widespread but small changes
* Require careful verification to ensure equivalence

### 6. System-Wide Changes

Changes that affect the entire system rather than specific components.

#### Subcategories:
* **Policy Implementation**: Introducing new system-wide rules or guidelines
* **Standardization**: Applying consistent standards across all components
* **Infrastructure Changes**: Modifying the underlying system infrastructure
* **Cross-Cutting Concerns**: Implementing aspects that touch many parts of the system

#### Typical Characteristics:
* Impact most or all system components
* Require coordination across many areas
* Often involve policy or guideline documentation
* May require automated transformation tools

## Change Complexity Levels

Each change can be classified by its complexity level, which helps determine the appropriate approach:

### Level 1: Simple Changes
* Limited scope (1-3 files)
* Clear requirements
* Minimal risk
* No architectural impact
* **Example**: Updating documentation, fixing a localized bug

### Level 2: Moderate Changes
* Medium scope (4-10 files)
* Well-defined requirements
* Limited risk
* Minimal architectural impact
* **Example**: Adding a small feature, enhancing existing functionality

### Level 3: Complex Changes
* Broad scope (10+ files)
* Potentially evolving requirements
* Moderate risk
* Some architectural implications
* **Example**: Adding a major feature, implementing a new subsystem

### Level 4: System-Critical Changes
* System-wide scope
* Complex requirements
* High risk
* Significant architectural impact
* **Example**: Changing fundamental architecture, implementing cross-cutting concerns

## Specialized Knowledge Application

This taxonomy serves as the foundation for developing specialized knowledge files for each change type:
* Each primary category should have a dedicated knowledge file with specialized handling procedures
* Complex subcategories may warrant their own knowledge files
* Knowledge files should document patterns, best practices, verification approaches, and common pitfalls

## Integration with Workflows

The major-changes workflow should leverage this taxonomy by:
1. **Assessment Phase**: Categorizing the requested change using this taxonomy
2. **Planning Phase**: Applying specialized knowledge based on the categorization
3. **Implementation Phase**: Following patterns appropriate for the change type
4. **Verification Phase**: Using type-specific verification approaches

## Cross-Reference Capabilities

Changes may involve multiple categories, requiring:
* Prioritization of primary change type 
* Recognition of secondary characteristics
* Application of knowledge from all relevant categories
* Specialized handling for hybrid change types 