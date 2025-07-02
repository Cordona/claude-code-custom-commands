# Troubleshooting & Problem Solving

*Debug workflow issues, resolve command problems, and maintain robust operations*

---

## Table of Contents

1. [Common Issues & Solutions](#common-issues--solutions)
   - [Workflow Stalls at Confirmation Points](#workflow-stalls-at-confirmation-points)
   - [Tasks Execute Out of Order](#tasks-execute-out-of-order)
   - [Context Loss Between Tasks](#context-loss-between-tasks)
   - [Overwhelmingly Complex Output](#overwhelmingly-complex-output)

2. [Debugging Strategies](#debugging-strategies)
   - [Debugging Complex Workflows](#debugging-complex-workflows)

3. [Workflow Problem Solving](#workflow-problem-solving)
   - [Human-in-the-Loop Issues](#human-in-the-loop-issues)
   - [Tool Selection Problems](#tool-selection-problems)
   - [Context Management Issues](#context-management-issues)
   - [Anti-Pattern Recognition](#anti-pattern-recognition)

---

## Common Issues & Solutions

**Best Practices:**
1. Workflow Stalls Prevention - clear confirmation requests
2. Task Execution Order - proper task dependencies
3. Context Loss Prevention - state management between tasks
4. Output Scope Management - appropriate detail levels

### Workflow Stalls at Confirmation Points

**Symptoms:** Command stops and waits indefinitely  
**Cause:** Unclear confirmation request or missing user prompt  
**Solution:**
```markdown
# ✅ Clear Confirmation Request
**I found [specific findings]. Should I proceed with [specific next step]?**
Please respond with "yes" to continue or provide alternative instructions.

# ❌ Unclear Request
Let me know what you think about this.
```

### Tasks Execute Out of Order

**Symptoms:** Later tasks reference information not yet gathered  
**Cause:** Poor task dependency design  
**Solution:**
```markdown
# ✅ Clear Dependencies
## Task 1: Discovery (creates foundation)
## Task 2: Analysis (uses Task 1 results)
## Task 3: Documentation (synthesizes Tasks 1-2)

# ❌ Poor Dependencies
## Task 1: Create documentation
## Task 2: Find relevant files
## Task 3: Analyze findings
```

### Context Loss Between Tasks

**Symptoms:** Later tasks don't reference earlier findings  
**Cause:** No state management between tasks  
**Solution:**
```markdown
# ✅ State Management
## Task 1: Create tracking file with findings
## Task 2: Update tracking file with additional discoveries
## Task 3: Use complete tracking file for final synthesis

# ❌ No State Management
Each task operates independently without building on previous work
```

### Overwhelmingly Complex Output

**Symptoms:** Generated documentation is too detailed or unfocused  
**Cause:** No scope management or user preference consideration  
**Solution:**
```markdown
# ✅ Scope Management
Before generating documentation, confirm:
- Level of detail needed (overview vs comprehensive)
- Target audience (developers vs stakeholders)  
- Specific focus areas of interest

# ❌ No Scope Control
Generate maximum detail documentation regardless of needs
```

---

## Debugging Strategies

**Best Practices:**
1. Debugging Complex Workflows - systematic troubleshooting approach

### Debugging Complex Workflows

#### Debug Mode Pattern
```markdown
# debug-workflow.md
---
description: "Debug complex workflows step by step"
allowed-tools: ["Read"]
---

# Workflow Debug Mode

Think about this workflow: $ARGUMENTS

**Planned Tasks:**
1. [Task 1 description and expected outputs]
2. [Task 2 description and dependencies on Task 1]  
3. [Task 3 description and synthesis approach]

**Dependencies Check:**
- Task 2 depends on: [Task 1 outputs]
- Task 3 depends on: [Task 1 + Task 2 outputs]

**Would you like me to execute this plan step by step?**
```

#### Incremental Development Strategy
```markdown
# Start Simple, Add Complexity
1. **Version 1:** Basic discovery and summary
2. **Version 2:** Add configuration analysis  
3. **Version 3:** Add test coverage analysis
4. **Version 4:** Add comprehensive documentation generation
```

---

## Workflow Problem Solving

**Best Practices:**
1. Human-in-the-Loop Issues - solving confirmation and workflow stalls
2. Tool Selection Problems - when commands use wrong tools for tasks
3. Context Management Issues - fixing context overload and inefficiency
4. Anti-Pattern Recognition - identifying and correcting problematic patterns

### Human-in-the-Loop Issues

#### Strategic Confirmation Points
**Problem:** Commands stall waiting for user input or provide unclear choices
**Solution:** Use confirmation points before expensive operations:

```markdown
## Validation Checkpoint

**What I Found:**
- Main implementation in [specific locations]
- Architecture pattern: [pattern identified]
- Complexity level: [assessment]
- Test coverage: [coverage status]

**Next Steps Options:**
- **Option A:** Comprehensive documentation (15-20 minutes)
- **Option B:** Quick overview (5 minutes)
- **Option C:** Focus on specific area you specify

**Which option would you prefer?**
```

#### Clear Confirmation Patterns
**Problem:** Vague confirmation requests that confuse users
**Solution:** Specific, actionable confirmation requests:

```markdown
# ✅ Clear Confirmation Request
**I found [specific findings]. Should I proceed with [specific next step]?**
Please respond with "yes" to continue or provide alternative instructions.

# ❌ Unclear Request
Let me know what you think about this.
```

### Tool Selection Problems

**Problem:** Commands use inefficient or inappropriate tools for specific tasks
**Solution:** Tool selection troubleshooting guide:

| Tool | Best For | Avoid For | When It Fails |
|------|----------|-----------|---------------|
| **Grep** | Finding specific patterns across multiple files | Reading file contents | Use Read instead |
| **Read** | Getting file contents with line numbers | Searching across files | Use Grep instead |
| **Glob** | Finding files by name patterns | Content-based searches | Use Grep instead |
| **Write** | Creating new files or documentation | Modifying existing code | Use Edit instead |
| **Edit** | Precise modifications to existing files | Creating new files | Use Write instead |

### Context Management Issues

#### Context Overload Problems
**Symptoms:** Commands load too much unnecessary context, causing slow performance
**Diagnosis:** Look for these patterns:

```markdown
# ❌ Context Overload Pattern
Read all files in the project to understand everything before analyzing $ARGUMENTS.

# ✅ Efficient Context Pattern  
Read the README.md to understand the project structure, then focus specifically on the $ARGUMENTS module.
```

#### Context Waste Detection
**Problem:** Commands request irrelevant context that doesn't contribute to results
**Solution:** Progressive context building:

```markdown
# ❌ Context Wasteful
Read every file, analyze everything, then figure out what's relevant.

# ✅ Context-Aware Commands
**Context Strategy:**
1. Start with targeted file discovery
2. Read only essential files for initial understanding  
3. Expand context only if initial analysis reveals gaps
4. Summarize findings before requesting more context
```

### Anti-Pattern Recognition

#### Inefficient File Operations
**Problem Pattern:** Broad, unfocused file operations that waste time and context
**Recognition Signs:**
```markdown
# ❌ Inefficient: Broad Operations
## Task 1: Read everything
Read all files in the project to understand the codebase.

# ✅ Efficient: Specific Patterns
## Task 1: Targeted Discovery
Use Grep with specific patterns to find relevant files:
- Search for "authentication" in .js, .ts files
- Look for "login" in component directories
```

#### Poor Workflow Planning
**Problem Pattern:** Commands that execute without planning or jump directly to implementation
**Recognition Signs:**
```markdown
# ❌ Poor: Immediate Execution
Search for files related to $ARGUMENTS and create documentation

# ✅ Good: Planning First
Think harder about the best approach for analyzing this complex feature:
- What are the key areas to investigate?
- In what order should I examine components?
[Then execute planned tasks]
```

#### Scattered Analysis Patterns
**Problem Pattern:** Tasks that don't build upon each other logically
**Recognition Signs:**
```markdown
# ❌ Poor: Scattered Analysis
## Task 1: Look at some files
## Task 2: Check tests
## Task 3: Write documentation

# ✅ Good: Progressive Context
## Task 1: Understand overall system architecture
## Task 2: Identify how this feature fits into the architecture  
## Task 3: Deep dive into feature-specific implementation
```

---

## Summary

Effective troubleshooting is essential for maintaining robust custom commands that work reliably in real-world scenarios. The key principles are:

### Issue Prevention
1. **Clear Communication:** Unambiguous confirmation requests and task descriptions
2. **Logical Dependencies:** Sequential tasks that build upon previous results
3. **State Management:** Maintain context and findings across workflow steps
4. **Scope Control:** Appropriate output levels based on user needs

### Problem Diagnosis
1. **Systematic Approach:** Debug mode patterns for complex workflow analysis
2. **Root Cause Analysis:** Identify underlying issues, not just symptoms
3. **Pattern Recognition:** Spot common anti-patterns and problematic designs
4. **Tool Selection:** Choose appropriate tools for each troubleshooting scenario

### Resolution Strategies
1. **Incremental Debugging:** Start simple and add complexity progressively
2. **Context Management:** Fix context overload and inefficiency issues
3. **Workflow Optimization:** Resolve human-in-the-loop and confirmation problems
4. **Dependency Mapping:** Clear understanding of task interdependencies

**Remember:** Effective troubleshooting combines systematic analysis with practical problem-solving skills. Master these techniques to quickly resolve command issues and maintain smooth workflows.

**For preventive measures:** See [Quality Assurance](07-quality-assurance.md) for testing and validation strategies to prevent issues before they occur.

---

*Next recommended reading: [Team Collaboration & Organization](09-team-collaboration.md) - Implement commands effectively across teams*