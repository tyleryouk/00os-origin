# Caching Workflow for Back-End

## Overview

This workflow provides specialized behavior for back-end caching components, focusing on performance optimization, data freshness, and distributed caching strategies. It extends the base back-end workflow with caching-specific implementation guidelines.

## Workflow Activation

This workflow is automatically attached whenever working with any file in the `back-end/` directory. It extends the base back-end workflow with specialized caching patterns and performance optimization guidance.

## Behavior Specialization

This workflow specializes behavior for caching development by:

1. **Cache Strategy Patterns**:
   - Multi-level cache design
   - Cache invalidation strategies
   - Time-to-live (TTL) management
   - Cache-aside implementation

2. **Redis Caching Patterns**:
   - Redis data structure selection
   - Pipelining optimization
   - Lua scripting for atomic operations
   - Redis Cluster configuration

3. **In-Memory Caching Patterns**:
   - LRU/LFU implementation
   - Memory pressure management
   - Thread-safe caching
   - Background refresh patterns

4. **Distributed Caching Patterns**:
   - Consistent hashing
   - Cache synchronization
   - Cache stampede prevention
   - Cache replication

## Caching Best Practices

1. **Cache Selection**:
   - Choose appropriate cache for data type
   - Configure optimal expiration times
   - Size caches appropriately
   - Implement monitoring and metrics

2. **Invalidation Strategies**:
   - Time-based invalidation
   - Event-based invalidation
   - Version-based invalidation
   - Pattern-based invalidation

3. **Performance Optimization**:
   - Batch cache operations
   - Use async cache operations
   - Pre-compute expensive operations
   - Implement cache warming

4. **Resilience Patterns**:
   - Cache fallback strategies
   - Circuit breaking patterns
   - Cache reconnection handling
   - Degraded operation modes

## Related Parameters

This workflow integrates with the following parameter files:

- **Plan Mode**: `parameters/back-end/plan-mode/caching.md`
- **Dev Mode**: `parameters/back-end/dev-mode/caching.md`
- **Direct Mode**: `parameters/back-end/direct-mode/caching.md`

## Knowledge Integration

This workflow references the following knowledge components:

- **Redis Patterns**: `knowledge/back-end/caching/redis.md`
- **In-Memory Caching**: `knowledge/back-end/caching/in-memory.md`
- **Distributed Caching**: `knowledge/back-end/caching/distributed.md`
- **Cache Strategies**: `knowledge/back-end/caching/strategies.md`

## Integration with API Layers

1. **API Response Caching**:
   - FastAPI response caching
   - Cache-Control header management
   - ETag implementation
   - Conditional GET handling

2. **Database Query Caching**:
   - Query result caching
   - Stored procedure result caching
   - ORM-level cache integration
   - Cache key generation strategies

3. **External API Caching**:
   - Steam API response caching (integrates with `workflows/back-end/steam-web-api.md`)
   - Adaptive TTL based on data volatility
   - Stale-while-revalidate pattern
   - Background refresh for critical data

## Quality Requirements

Caching components must meet these quality gates:

1. **Performance**: Cache operations complete in <10ms
2. **Hit Rate**: Minimum 80% cache hit rate for primary caches
3. **Memory Usage**: Cache size within defined limits
4. **Resilience**: System remains functional during cache failures

## Implementation Guidelines

1. **Cache Key Design**:
   - Implement consistent key naming strategy
   - Include version in cache keys
   - Use namespaces for organization
   - Balance key specificity with reuse

2. **TTL Strategy**:
   - Align TTL with data volatility
   - Implement sliding expiration where appropriate
   - Use different TTLs for different data types
   - Consider business hours in TTL strategy

3. **Monitoring Setup**:
   - Track cache hit/miss rates
   - Monitor memory usage
   - Set up latency alerts
   - Implement cache analytics

4. **Testing Approach**:
   - Test cache behavior under load
   - Verify invalidation strategies
   - Test failure scenarios
   - Benchmark performance 