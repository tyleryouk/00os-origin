# Database Workflow for Back-End

## Overview

This workflow provides specialized behavior for back-end database components, focusing on SQLAlchemy, PostgreSQL, and database optimization patterns. It extends the base back-end workflow with database-specific implementation guidelines.

## Workflow Activation

This workflow is automatically attached whenever working with any file in the `back-end/` directory. It extends the base back-end workflow with specialized database patterns and guidance for database-related components.

## Behavior Specialization

This workflow specializes behavior for database development by:

1. **Model Design Patterns**:
   - SQLAlchemy model organization
   - Relationship configuration
   - Data integrity constraints
   - Performance-optimized schema design

2. **Query Optimization Patterns**:
   - Efficient query construction
   - Eager/lazy loading strategies
   - N+1 query prevention
   - Connection pooling configuration

3. **Migration Patterns**:
   - Alembic migration strategies
   - Zero-downtime migration patterns
   - Data migration techniques
   - Schema versioning

4. **Repository Patterns**:
   - Data access layer organization
   - Transaction management
   - Bulk operation optimization
   - Query reusability patterns

## Database Best Practices

1. **Schema Design**:
   - Normalize to appropriate level (3NF minimum)
   - Use appropriate data types
   - Apply proper constraints
   - Include indexes for common queries

2. **Query Performance**:
   - Use query profiling tools
   - Optimize JOIN operations
   - Apply appropriate caching
   - Use pagination for large result sets

3. **Transaction Management**:
   - Implement proper isolation levels
   - Use context managers for transactions
   - Handle deadlocks appropriately
   - Implement retry mechanisms

4. **Security Practices**:
   - Prevent SQL injection
   - Implement proper access controls
   - Encrypt sensitive data
   - Audit database operations

## Related Parameters

This workflow integrates with the following parameter files:

- **Plan Mode**: `parameters/back-end/plan-mode/database.md`
- **Dev Mode**: `parameters/back-end/dev-mode/database.md`
- **Direct Mode**: `parameters/back-end/direct-mode/database.md`

## Knowledge Integration

This workflow references the following knowledge components:

- **Schema Design**: `knowledge/back-end/database/schema-design.md`
- **Performance**: `knowledge/back-end/database/performance.md`
- **Migrations**: `knowledge/back-end/database/migrations.md`
- **Security**: `knowledge/back-end/database/security.md`

## Quality Requirements

Database components must meet these quality gates:

1. **Query Efficiency**: All queries must complete in <100ms
2. **Schema Validation**: Pass all schema validation tests
3. **Migration Safety**: Zero-downtime deployment capable
4. **Security**: Pass SQL injection security tests

## Implementation Guidelines

1. **Model Structure**:
   - Create Base model class
   - Implement standard timestamps
   - Use proper relationship cascades
   - Define clear __repr__ methods

2. **Migration Strategy**:
   - Keep migrations atomic
   - Include up/down migration paths
   - Separate schema/data migrations
   - Version control all migrations

3. **Repository Implementation**:
   - Create base repository class
   - Implement standard CRUD operations
   - Use query caching appropriately
   - Separate query building from execution

4. **Testing Strategy**:
   - Use test database fixtures
   - Implement transaction-based tests
   - Test edge cases explicitly
   - Verify migration paths 