# Advanced Workflows & Multi-Step Commands

*Master sophisticated automation with sequential task orchestration and thinking mode integration*

---

## Table of Contents

1. [Introduction to Advanced Workflows](#introduction-to-advanced-workflows)
2. [Planning with Thinking Mode](#planning-with-thinking-mode)
3. [Sequential Task Dependencies](#sequential-task-dependencies)
4. [Multi-Step Workflow Examples](#multi-step-workflow-examples)
5. [Real-World Examples](#real-world-examples)

---

## Introduction to Advanced Workflows

Advanced workflows transform custom commands from simple prompt templates into **sophisticated automation systems** that can orchestrate complex, multi-step processes using Claude Code's built-in capabilities.

### What Makes a Workflow "Advanced"

**✅ Multi-Step Sequences:**
- Tasks that build upon previous results
- Sequential dependencies between operations
- Dynamic content generation based on discoveries

**✅ Thinking Mode Integration:**
- Strategic use of planning capabilities
- Complex analysis requiring deep reasoning
- Synthesis of multiple information sources

**✅ Interactive Decision Points:**
- Human-in-the-loop confirmation
- Conditional logic based on findings
- Error handling and recovery

**✅ Comprehensive Automation:**
- End-to-end process completion
- Multiple file operations
- Context-aware task execution

### When to Use Advanced Workflows

#### ✅ **Perfect Use Cases:**
- **Feature Investigation:** Deep analysis of existing codebase features
- **Architecture Documentation:** Comprehensive system documentation generation
- **Code Quality Audits:** Multi-stage analysis and reporting
- **Migration Planning:** Complex change analysis and planning
- **Testing Strategy Development:** Comprehensive test planning and implementation
- **Content Verification Workflows:** Generate → Verify → Report → Fix cycles
- **Embedded Framework Integration:** User choice → Framework execution → Results synthesis

#### ❌ **Avoid for:**
- Simple, one-off tasks
- Quick code explanations
- Basic file operations
- Tasks without clear sequential dependencies

### Core Principles

1. **Plan First, Execute Second:** Use thinking mode to create detailed plans
2. **Validate Intermediate Results:** Include confirmation points for critical decisions
3. **Build Context Progressively:** Each step should enhance understanding for the next
4. **Handle Failures Gracefully:** Include error detection and recovery strategies
5. **Generate Valuable Outputs:** End with actionable documentation or insights

### The Strategic Goal: Scaling Compute

The ultimate purpose of an advanced workflow is to allow an engineer to **scale their impact by scaling their compute**. A single, well-designed command can trigger a cascade of analysis, tool use, and reasoning that is equivalent to many hours of manual work. By encoding complex processes into reusable commands, you transform the CLI into a powerful force multiplier for your engineering efforts.


---

## Planning with Thinking Mode

Claude Code's thinking mode (introduced in version 0.2.44) enables sophisticated planning and reasoning for complex workflows.

### Thinking Mode Keywords

**Official Keywords** (case-insensitive):
- **`think`** - Basic extended thinking
- **`think harder`** - Deeper analysis and reasoning
- **`think longer`** - Extended processing time for complex problems
- **`ultrathink`** - Maximum thinking depth for sophisticated challenges

### How to Structure Planning Commands

#### Basic Planning Pattern
```markdown
# Feature Analysis Command

Think harder about analyzing this feature: $ARGUMENTS

**Planning Phase:**
1. Understand the feature requirements
2. Map out investigation strategy
3. Identify key areas to examine
4. Plan documentation structure

**Execution Phase:**
[Detailed steps based on the plan]
```

#### Advanced Planning with Validation
```markdown
# Comprehensive System Analysis

Ultrathink about this system component: $ARGUMENTS

**Deep Planning Requirements:**
- Analyze architectural patterns
- Identify all dependencies
- Map data flow and interactions
- Plan comprehensive documentation
- Consider edge cases and limitations

**Validation Checkpoints:**
- Confirm feature identification accuracy
- Verify completeness of analysis
- Validate documentation approach

[Sequential execution tasks]
```

### Planning Examples

#### Strategic Feature Investigation Planning
```markdown
Think harder about how to investigate this backend feature: $ARGUMENTS

Consider:
1. **Discovery Strategy:** How to identify all relevant code
2. **Analysis Scope:** What components to examine (API, business logic, data layer, tests)
3. **Documentation Approach:** What format would be most valuable
4. **Validation Method:** How to confirm findings are complete and accurate

Based on your analysis, create a detailed investigation plan.
```

---

## Sequential Task Dependencies

Advanced workflows rely on sequential task execution where each step builds upon previous results.

**⚠️ Important Note:** This sequential execution is a **prompting pattern**, not a built-in Claude Code feature. You are providing a single, large prompt with numbered instructions. Claude's ability to follow these steps depends on the clarity of your instructions and the complexity of the tasks.


### Dependency Patterns

#### 1. **Linear Sequence** (Task 1 → Task 2 → Task 3)
```markdown
## Task 1: Discovery
Search and identify all relevant files

## Task 2: Analysis  
Read and analyze the files found in Task 1

## Task 3: Synthesis
Generate documentation based on Task 2 analysis
```

#### 2. **Branching Logic** (Conditional Next Steps)
```markdown
## Task 1: Initial Assessment
Analyze the codebase structure

## Task 2A: If Microservice Architecture
Focus on service boundaries and communication

## Task 2B: If Monolithic Architecture  
Focus on module separation and dependencies
```

#### 3. **Convergent Workflow** (Multiple Inputs → Single Output)
```markdown
## Task 1: Code Analysis
## Task 2: Test Analysis  
## Task 3: Configuration Analysis
## Task 4: Synthesis
Combine all findings into comprehensive documentation
```

### Managing State Between Tasks

#### Pattern A: File-Based State Tracking
*This is a technique pattern - not part of the main Backend Feature Analysis command*

```markdown
## Step 1: Create Investigation Log
Create a file called `analysis_progress.md` to track findings:

# Feature Analysis Progress
## Discovery Phase
- [ ] API endpoints identified
- [ ] Business logic mapped
- [ ] Data models found
- [ ] Tests located

## Files Identified
[To be populated]

## Step 2: Update Progress Continuously  
As you discover components, update the progress file with findings.
```

#### Pattern B: Progressive Context Building
*This is a technique pattern - not part of the main Backend Feature Analysis command*

```markdown
## Phase 1: Foundation Context
Gather basic project information:
- Project structure
- Technology stack
- Architecture patterns

## Phase 2: Feature-Specific Context
Building on Phase 1, focus on the specific feature:
- Related components
- Dependencies
- Integration points

## Phase 3: Deep Analysis
Using all previous context, perform detailed analysis
```


---

## Multi-Step Workflow Examples

These patterns demonstrate how to structure complex commands with sequential dependencies and strategic confirmation points.

### Example 1: Feature Discovery and Documentation

```markdown
# Backend Feature Analysis

Think harder about this feature: $ARGUMENTS

## Step 1: Discovery
- Search for related files using targeted patterns
- Identify main implementation areas
- Map out basic component structure

## Step 2: Analysis Summary
Present findings and ask for confirmation:
- "I found the main implementation in [locations]. Should I proceed with detailed analysis?"

## Step 3: Deep Analysis (after confirmation)
- Examine implementation details
- Analyze dependencies and integration points
- Review test coverage

## Step 4: Documentation Generation
Create comprehensive documentation based on analysis
```

### Example 2: Multi-Stage Code Review

```markdown
# Comprehensive Code Review

## Stage 1: Structure Analysis
Examine overall code organization and architecture patterns

## Stage 2: Quality Assessment
Review code quality, patterns, and potential improvements

## Stage 3: Security Analysis
Check for security vulnerabilities and best practices

## Stage 4: Unified Report
Synthesize findings into actionable recommendations
```

### Strategic Confirmation Points

Use confirmation points before expensive operations:

```markdown
## Validation Checkpoint

**What I Found:**
- [Key findings]
- [Architecture patterns identified]
- [Complexity assessment]

**Next Steps Options:**
- **Option A:** Comprehensive documentation (15-20 minutes)
- **Option B:** Quick overview (5 minutes)
- **Option C:** Focus on specific area you specify

**Which option would you prefer?**
```

### Sequential Task Dependencies

Structure tasks so each builds on previous results:

```markdown
## Task 1: Foundation
Gather basic project information and structure

## Task 2: Feature Context
Using Task 1 findings, focus on specific feature components

## Task 3: Deep Analysis
With full context from Tasks 1-2, perform detailed examination

## Task 4: Synthesis
Generate comprehensive documentation using all previous findings
```

---

## Advanced Integration Patterns

### Embedded Framework Integration

Advanced workflows can leverage **embedded commands** - self-contained framework components that provide sophisticated functionality to multiple consumer commands.

**Common Pattern:** Generation → User Choice → Framework Execution → Results

**Example Integration:**
```markdown
## Task 6: Prompt User for Content Verification ⚡
Present verification option with clear cost/benefit analysis:
- Benefits: Validates claims against codebase, prevents hallucination
- Resources: Additional processing time and token usage

## Task 7: Execute Content Verification Framework 🔍
[Only if user selected 'y']
Execute `.claude/embedded/verify-technical-content.md` for comprehensive validation.

## Task 8: Present Enhanced Results
Combine generation and verification results for quality-assured documentation.
```

**Integration Benefits:**
- **Reusable functionality** across multiple commands
- **Single source of truth** for complex domain logic
- **Automatic framework evolution** benefits all consumers
- **Professional-grade implementation** with comprehensive error handling

**For complete embedded command architecture, implementation patterns, and development guidelines:**
→ **[Embedded Commands Guides](../embedded/)** - Comprehensive architecture and framework development documentation

---

## Real-World Examples

### Example 1: Database Migration Analysis

```markdown
---
description: "Analyze database migration requirements for feature changes"
allowed-tools: ["Grep", "Read", "Write", "Glob"]
---

# Database Migration Analysis
> Think harder about analyzing migration needs for: $ARGUMENTS

## Task 1: Current Schema Analysis
Examine existing database schema related to the feature:
- Current table structures
- Existing relationships
- Constraints and indexes

## Task 2: Proposed Changes Assessment
Analyze what changes are needed:
- New tables or columns required
- Relationship modifications
- Data transformation needs

## Task 3: Migration Risk Assessment
Evaluate migration complexity and risks:
- Data volume impact
- Downtime requirements
- Rollback strategies

## Task 4: Migration Plan Generation
Create detailed migration plan with:
- Step-by-step migration scripts
- Testing procedures
- Rollback procedures
```

### Example 2: API Performance Optimization

```markdown
---
description: "Comprehensive API performance analysis and optimization recommendations"
allowed-tools: ["Grep", "Read", "Write"]
---

# API Performance Analysis
> Think harder about optimizing performance for: $ARGUMENTS

## Task 1: Endpoint Performance Mapping
Identify and analyze all endpoints related to the feature:
- Request processing workflows
- Database query patterns
- External service calls

## Task 2: Bottleneck Identification
Analyze potential performance bottlenecks:
- N+1 query problems
- Inefficient algorithms
- Synchronous blocking operations

## Task 3: Optimization Strategy Development
Create optimization recommendations:
- Query optimization opportunities
- Caching strategies
- Asynchronous processing options

## Task 4: Implementation Roadmap
Generate prioritized optimization plan:
- Quick wins (low effort, high impact)
- Medium-term improvements
- Long-term architectural changes
```

### Example 3: Security Audit Workflow

```markdown
---
description: "Comprehensive security analysis for backend features"
allowed-tools: ["Grep", "Read", "Write"]
---

# Security Audit Analysis
> Think harder about security implications of: $ARGUMENTS

## Task 1: Attack Surface Mapping
Identify all security-relevant components:
- Input validation points
- Authentication/authorization checks
- Data access patterns

## Task 2: Vulnerability Assessment
Analyze potential security vulnerabilities:
- Injection attack vectors
- Authorization bypass opportunities
- Data exposure risks

## Task 3: Security Control Evaluation
Assess existing security measures:
- Input sanitization effectiveness
- Access control implementation
- Logging and monitoring coverage

## Task 4: Security Improvement Plan
Generate actionable security recommendations:
- Critical vulnerabilities to fix immediately
- Security enhancements to implement
- Ongoing security monitoring improvements
```

---

## Summary

Advanced workflows in Claude Code enable sophisticated automation that goes far beyond simple prompt templates. By combining **thinking mode**, **sequential task dependencies**, **human-in-the-loop validation**, and **progressive context building**, you can create powerful automation systems that deliver comprehensive, valuable results.

### Key Takeaways

1. **Plan First:** Use thinking mode to create detailed strategies before execution
2. **Build Progressively:** Each task should enhance context for subsequent tasks
3. **Validate Strategically:** Include confirmation points before expensive operations
4. **Handle Complexity:** Break complex analysis into manageable, sequential steps
5. **Generate Value:** Focus on creating actionable documentation and insights

### Next Steps

- **Practice with the Backend Feature Analysis workflow** - Start with a known feature to understand the pattern
- **Adapt patterns to your needs** - Modify the examples for your specific use cases
- **Build workflow libraries** - Create collections of workflows for common tasks
- **Share with your team** - Establish team standards for advanced workflow development

Advanced workflows represent the cutting edge of Claude Code automation. Master these patterns to unlock unprecedented productivity and insight generation from your AI-assisted development process.

**Ready to build sophisticated automation?** Start with the real-world examples above and experience the power of multi-step, thinking-enabled workflows!

---

*Next recommended reading: [Best Practices Guide](05-best-practices.md) - Master professional command development and optimization techniques*