# Best Practices & Professional Command Development

*Master the art of creating maintainable, efficient, and team-ready custom commands*

---

## Table of Contents

1. [Command Design Fundamentals](#command-design-fundamentals)
   - [Single Responsibility Principle](#single-responsibility-principle)
   - [Clear Naming Conventions](#clear-naming-conventions)
   - [Effective $ARGUMENTS Usage](#effective-arguments-usage)
   - [YAML Frontmatter Best Practices](#yaml-frontmatter-best-practices)

2. [Prompt Engineering Excellence](#prompt-engineering-excellence)
   - [High-Level + Low-Level Pattern](#high-level--low-level-pattern)
   - [Context Priming Techniques](#context-priming-techniques)
   - [Dynamic Variable Mastery](#dynamic-variable-mastery)

3. [Performance Optimization](#performance-optimization)
   - [Efficient File Operations](#efficient-file-operations)
   - [Context Budget Management](#context-budget-management)

4. [Advanced Workflow Best Practices](#advanced-workflow-best-practices)
   - [Design Principles for Complex Workflows](#design-principles-for-complex-workflows)
   - [Sequential Task Dependencies](#sequential-task-dependencies)
   - [Thinking Mode Integration](#thinking-mode-integration)



---

## Command Design Fundamentals

**Best Practices:**
1. Single Responsibility Principle - one clear, focused purpose per command
2. Clear Naming Conventions - kebab-case, action verbs, include scope
3. Effective $ARGUMENTS Usage - make commands flexible and reusable
4. YAML Frontmatter Best Practices - use only officially supported options

### Single Responsibility Principle

Each command should have **one clear, focused purpose** that can be explained in a single sentence.

```markdown
# ✅ Good: Single Purpose
# analyze-api-performance.md
Analyze API endpoint performance and identify optimization opportunities

# ❌ Poor: Multiple Purposes  
# analyze-everything.md
Analyze API performance, security issues, code quality, and generate documentation
```

### Clear Naming Conventions

#### **Project Commands** (`/project:command-name`)
- Use **kebab-case** for consistency
- Start with **action verbs**: `analyze`, `generate`, `review`, `optimize`
- Include **scope**: `analyze-api`, `generate-docs`, `review-security`

```markdown
# ✅ Good Command Names
analyze-feature.md          -> /project:analyze-feature
generate-pr-summary.md      -> /project:generate-pr-summary  
review-security.md          -> /project:review-security
optimize-performance.md     -> /project:optimize-performance

# ❌ Poor Command Names
stuff.md                    -> /project:stuff
thing.md                    -> /project:thing
analyze.md                  -> /project:analyze (too vague)
```

#### **User Commands** (`/user:command-name`)
- Place in `~/.claude/commands/` for personal use
- Focus on **workflow automation** and **personal productivity**
- Examples: `deep-think`, `commit-helper`, `code-review`

### Effective $ARGUMENTS Usage

Use `$ARGUMENTS` to make commands flexible and reusable:

```markdown
# ✅ Good: Clear Variable Usage
Analyze the security implications of the $ARGUMENTS feature, focusing on:
- Authentication and authorization
- Input validation
- Data protection measures

# ❌ Poor: Vague Variable Usage
Do something with $ARGUMENTS and make it better
```

#### Multiple Arguments Pattern
```markdown
# For multiple arguments, use descriptive context
Analyze the $ARGUMENTS component and generate documentation for the $ARGUMENTS team.

# Usage: /project:analyze-component "user authentication" "backend"
```

### YAML Frontmatter Best Practices

**⚠️ Important:** Only use officially supported options to ensure compatibility:

```yaml
---
description: "Brief, clear description of what this command does"
allowed-tools: ["Grep", "Read", "Write", "Glob"]
---
```

#### Tool Restrictions Strategy
```yaml
# ✅ Restrictive for Security
allowed-tools: ["Read", "Grep"]  # Read-only analysis

# ✅ Specific for File Operations  
allowed-tools: ["Read", "Write", "Edit"]  # Documentation generation

# ✅ Comprehensive for Complex Workflows
allowed-tools: ["Bash", "Read", "Write", "Grep", "Glob"]  # Full automation
```

---

## Prompt Engineering Excellence

**Best Practices:**
1. High-Level + Low-Level Pattern - strategic objectives + tactical instructions
2. Context Priming Techniques - focus on tokens that matter
3. Dynamic Variable Mastery - understand simple string replacement

### High-Level + Low-Level Pattern

Structure commands with strategic objectives followed by tactical instructions:

```markdown
# ✅ Excellent Pattern
# High-Level Objective
Conduct a comprehensive security analysis of the $ARGUMENTS feature to identify vulnerabilities and recommend improvements.

# Low-Level Instructions
## Task 1: Attack Surface Analysis
- Identify all input points and data flows
- Map authentication and authorization checkpoints
- Document external dependencies and integrations

## Task 2: Vulnerability Assessment  
- Check for common security vulnerabilities (OWASP Top 10)
- Analyze input validation and sanitization
- Review error handling and information disclosure

## Task 3: Security Recommendations
- Prioritize findings by severity and impact
- Provide specific remediation steps
- Suggest preventive measures for future development
```

### Context Priming Techniques

**Focus on tokens that matter** - avoid loading unnecessary context:

```markdown
# ✅ Efficient Context Priming
Read the README.md to understand the project structure, then focus specifically on the $ARGUMENTS module. Analyze only the files directly related to this functionality.

# ❌ Wasteful Context Loading
Read all files in the project to understand everything before analyzing $ARGUMENTS.
```

#### Strategic Context Building
```markdown
# Progressive Context Pattern
## Step 1: Foundation Context
- Project architecture overview
- Technology stack identification  
- Key design patterns

## Step 2: Feature-Specific Context
- Component relationships
- Dependencies and integrations
- Test coverage analysis

## Step 3: Deep Analysis
- Implementation details
- Performance characteristics
- Security considerations
```

### Dynamic Variable Mastery

#### Simple String Replacement
```markdown
# $ARGUMENTS is simple string replacement - not complex parsing
Analyze the $ARGUMENTS feature for performance bottlenecks.

# Usage: /project:analyze-performance "user authentication system"
# Result: "Analyze the user authentication system feature for performance bottlenecks."
```

#### Multi-Argument Patterns
```markdown
# Handle multiple concepts with descriptive context
Review the $ARGUMENTS for $ARGUMENTS issues and provide $ARGUMENTS recommendations.

# Usage: /project:review-code "payment processing" "security" "actionable"
```

---

## Performance Optimization

**Best Practices:**
1. Efficient File Operations - targeted search strategies
2. Context Budget Management - progressive context building

### Efficient File Operations

#### Targeted Search Strategies
```markdown
# Efficient: Specific Patterns
## Task 1: Targeted Discovery
Use Grep with specific patterns to find relevant files:
- Search for "authentication" in .js, .ts files
- Look for "login" in component directories
- Find test files with "auth" patterns

## Task 2: Selective Reading
Read only the files identified in Task 1 that are directly relevant.
```

#### Smart Context Management
```markdown
# Incremental Context Building
Build context progressively, adding only information needed for next steps:

1. **Architecture Overview** → 2. **Feature Location** → 3. **Implementation Details**
```


### Context Budget Management

Focus on strategic context loading for optimal performance:

```markdown
# Context-Aware Commands
Think about this analysis: $ARGUMENTS

**Context Strategy:**
1. Start with targeted file discovery
2. Read only essential files for initial understanding  
3. Expand context only if initial analysis reveals gaps
4. Summarize findings before requesting more context
```

---

## Advanced Workflow Best Practices

**Best Practices:**
1. Design Principles for Complex Workflows - clear objectives, planning first
2. Sequential Task Dependencies - each task builds upon previous results
3. Thinking Mode Integration - strategic use of reasoning capabilities

### Design Principles for Complex Workflows

#### 1. **Start with Clear Objectives**
```markdown
# Clear Objective Example
Analyze the user authentication system to understand:
- How users log in and maintain sessions
- Security measures implemented
- Integration with external identity providers
```

#### 2. **Plan Before Executing**
```markdown
# Planning First Approach
Think harder about the best approach for analyzing this complex feature:
- What are the key areas to investigate?
- In what order should I examine components?
- What documentation would be most valuable?

[Then execute planned tasks]
```

#### 3. **Build Context Progressively**
```markdown
# Progressive Context Building
## Task 1: Understand overall system architecture
## Task 2: Identify how this feature fits into the architecture  
## Task 3: Deep dive into feature-specific implementation
```

### Sequential Task Dependencies

Structure tasks so each builds upon previous results:

```markdown
# Clear Dependencies Example
## Task 1: Discovery (creates foundation)
Identify all components related to $ARGUMENTS feature

## Task 2: Analysis (uses Task 1 results)  
Examine the components found in Task 1 for patterns and architecture

## Task 3: Documentation (synthesizes Tasks 1-2)
Generate comprehensive documentation based on discovery and analysis
```

### Thinking Mode Integration

#### Strategic Thinking Keywords
```markdown
# Basic Analysis
Think about this feature: $ARGUMENTS

# Deep Analysis  
Think harder about this complex system: $ARGUMENTS

# Extended Processing
Think longer about this architectural decision: $ARGUMENTS

# Maximum Depth
Ultrathink about this critical security implementation: $ARGUMENTS
```

#### Planning with Thinking Mode
```markdown
# Comprehensive Planning Pattern
Think harder about analyzing this backend feature: $ARGUMENTS

Consider:
1. **Discovery Strategy:** How to identify all relevant code
2. **Analysis Scope:** What components to examine (API, business logic, data layer, tests)
3. **Documentation Approach:** What format would be most valuable
4. **Validation Method:** How to confirm findings are complete and accurate

Based on your analysis, create a detailed investigation plan.
```



---

## Summary

Mastering custom command best practices enables you to create **professional-grade automation** that scales with your team and projects. The key principles are:

### Design Excellence
1. **Single Responsibility:** One command, one clear purpose
2. **Progressive Context:** Build understanding incrementally  
3. **Strategic Planning:** Think before executing complex workflows

### Performance Optimization
1. **Efficient Operations:** Target searches, selective reading
2. **Context Management:** Load only what's needed when it's needed
3. **Strategic Tool Usage:** Choose appropriate tools for command creation

### Professional Development
1. **Quality Assurance:** Systematic testing and validation processes
2. **Security Considerations:** Safe command design and data protection
3. **Team Integration:** Collaboration patterns and shared standards

### Advanced Workflows
1. **Thinking Mode Integration:** Strategic use of reasoning capabilities
2. **Workflow Design:** Clear objectives and logical task dependencies
3. **State Management:** Maintain context across sequential tasks

**Remember:** Custom commands are **compute-scaling assets**. Invest time in designing them well, and they'll multiply your impact exponentially.

**For practical validation:**
- **[Development Checklist](../../checklists/development/02-development.md)** - **The Daily Genius** - Essential validation for every command
- **[Complete Checklist Collection](../../checklists/README.md)** - 3 focused checklists for systematic command development

**For specialized guidance:**
- **[Security](06-security.md)** - Security-first command design and data protection
- **[Quality Assurance](07-quality-assurance.md)** - Testing frameworks and quality metrics
- **[Troubleshooting](08-troubleshooting.md)** - Debug issues and resolve workflow problems
- **[Team Collaboration](09-team-collaboration.md)** - Organizational setup and team adoption

---

*Next recommended reading: [Security](06-security.md) - Implement security-first command design and data protection*