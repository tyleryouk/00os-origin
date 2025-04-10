# Performance Optimization Guideline

## Resource Consumption Analysis Process

1.  **Identify Performance Bottlenecks**: Locate areas that impede performance (e.g., slow commands, complex loops, large file reads).
2.  **Measure Baseline Performance**: Establish performance benchmarks if possible (e.g., timing command execution).
3.  **Apply Targeted Optimizations**: Implement specific improvements (e.g., refine algorithm, optimize queries, use more efficient tools).
4.  **Verify Performance Gains**: Measure improvements against baseline.
5.  **Document Optimization Patterns**: Record successful strategies in the relevant `1000xbrain/<domain>/knowledge/` directory.

## Optimization Priorities

1.  **Critical Path Optimization**: Focus on most frequently executed code paths or commands.
2.  **Resource Efficiency**: Reduce memory and processing requirements, minimize unnecessary tool calls (especially file reads).
3.  **Responsiveness**: Prioritize speed in interactive commands or user-facing parts (if applicable).
4.  **Maintainability Balance**: Balance performance gains with code/process clarity and maintainability.
5.  **Scalability**: Ensure solutions perform well as data volume or system complexity grows. 