# Best Practices & Professional Command Development

*Master the art of creating maintainable, efficient, and team-ready custom commands*

---

## Table of Contents

1. [Command Design Fundamentals](#command-design-fundamentals)
2. [Prompt Engineering Excellence](#prompt-engineering-excellence)
3. [Performance Optimization](#performance-optimization)
4. [Advanced Workflow Best Practices](#advanced-workflow-best-practices)
5. [Team Collaboration & Organization](#team-collaboration--organization)
6. [Security & Maintenance](#security--maintenance)
7. [Troubleshooting Common Issues](#troubleshooting-common-issues)
8. [Quality Assurance & Testing](#quality-assurance--testing)

---

## Command Design Fundamentals

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

### Efficient File Operations

#### Targeted Search Strategies
```markdown
# ✅ Efficient: Specific Patterns
## Task 1: Targeted Discovery
Use Grep with specific patterns to find relevant files:
- Search for "authentication" in .js, .ts files
- Look for "login" in component directories
- Find test files with "auth" patterns

## Task 2: Selective Reading
Read only the files identified in Task 1 that are directly relevant.

# ❌ Inefficient: Broad Operations
## Task 1: Read everything
Read all files in the project to understand the codebase.
```

#### Smart Context Management
```markdown
# ✅ Incremental Context Building
Build context progressively, adding only information needed for next steps:

1. **Architecture Overview** → 2. **Feature Location** → 3. **Implementation Details**

# ❌ Context Overload
Load all possible context upfront regardless of relevance.
```

### Tool Selection Strategies

| Tool | Best For | Avoid For |
|------|----------|-----------|
| **Grep** | Finding specific patterns across multiple files | Reading file contents |
| **Read** | Getting file contents with line numbers | Searching across files |
| **Glob** | Finding files by name patterns | Content-based searches |
| **Write** | Creating new files or documentation | Modifying existing code |
| **Edit** | Precise modifications to existing files | Creating new files |

### Context Budget Management

```markdown
# ✅ Context-Aware Commands
Think about this analysis: $ARGUMENTS

**Context Strategy:**
1. Start with targeted file discovery
2. Read only essential files for initial understanding  
3. Expand context only if initial analysis reveals gaps
4. Summarize findings before requesting more context

# ❌ Context Wasteful
Read every file, analyze everything, then figure out what's relevant.
```

---

## Advanced Workflow Best Practices

### Design Principles for Complex Workflows

#### 1. **Start with Clear Objectives**
```markdown
# ✅ Good: Clear Objective
Analyze the user authentication system to understand:
- How users log in and maintain sessions
- Security measures implemented
- Integration with external identity providers

# ❌ Unclear: Vague Objective  
Analyze the authentication stuff and see what's there
```

#### 2. **Plan Before Executing**
```markdown
# ✅ Good: Planning First
Think harder about the best approach for analyzing this complex feature:
- What are the key areas to investigate?
- In what order should I examine components?
- What documentation would be most valuable?

[Then execute planned tasks]

# ❌ Poor: Immediate Execution
Search for files related to $ARGUMENTS and create documentation
```

#### 3. **Build Context Progressively**
```markdown
# ✅ Good: Progressive Context
## Task 1: Understand overall system architecture
## Task 2: Identify how this feature fits into the architecture  
## Task 3: Deep dive into feature-specific implementation

# ❌ Poor: Scattered Analysis
## Task 1: Look at some files
## Task 2: Check tests
## Task 3: Write documentation
```

### Sequential Task Dependencies

Structure tasks so each builds upon previous results:

```markdown
# ✅ Clear Dependencies
## Task 1: Discovery (creates foundation)
Identify all components related to $ARGUMENTS feature

## Task 2: Analysis (uses Task 1 results)  
Examine the components found in Task 1 for patterns and architecture

## Task 3: Documentation (synthesizes Tasks 1-2)
Generate comprehensive documentation based on discovery and analysis

# ❌ Poor Dependencies
## Task 1: Create documentation
## Task 2: Find relevant files  
## Task 3: Analyze findings
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

### Human-in-the-Loop Best Practices

#### Strategic Confirmation Points
Use confirmation points before expensive operations:

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
```markdown
# ✅ Clear Confirmation Request
**I found [specific findings]. Should I proceed with [specific next step]?**
Please respond with "yes" to continue or provide alternative instructions.

# ❌ Unclear Request
Let me know what you think about this.
```

---

## Team Collaboration & Organization

### Project vs User-Level Commands

#### **Project Commands** (`.claude/commands/`)
- **Shared with team** through version control
- **Project-specific** workflows and standards
- **Consistent** across all team members

```bash
# Project structure
.claude/
└── commands/
    ├── docs/
    │   ├── generate-api-docs.md
    │   └── update-changelog.md
    ├── review/  
    │   ├── security-audit.md
    │   └── performance-check.md
    └── deploy/
        ├── pre-deploy-check.md
        └── deployment-summary.md
```

#### **User Commands** (`~/.claude/commands/`)
- **Personal** productivity workflows
- **Individual preferences** and shortcuts
- **Not shared** with team

```bash
# User structure  
~/.claude/
└── commands/
    ├── personal/
    │   ├── daily-standup.md
    │   └── time-tracker.md
    └── utilities/
        ├── commit-helper.md
        └── branch-cleaner.md
```

### Directory Organization Patterns

#### By Function
```
.claude/commands/
├── analyze/          # Analysis commands
├── generate/         # Generation commands  
├── review/           # Review commands
└── deploy/           # Deployment commands
```

#### By Team Role
```
.claude/commands/
├── backend/          # Backend team commands
├── frontend/         # Frontend team commands
├── devops/           # DevOps team commands
└── shared/           # Cross-team commands
```

#### By Project Phase
```
.claude/commands/
├── development/      # Active development
├── testing/          # QA and testing
├── deployment/       # Release management
└── maintenance/      # Post-deployment
```

### Version Control Best Practices

#### Commit Command Collections
```bash
# Add new command to project
git add .claude/commands/analyze-performance.md
git commit -m "Add performance analysis command for API endpoints"

# Update existing command
git commit -m "Update security-audit command with OWASP guidelines"

# Document command usage
git commit -m "Add README for custom commands with usage examples"
```

#### Command Documentation
```markdown
# .claude/commands/README.md
# Project Custom Commands

## Analysis Commands
- `/project:analyze-performance` - Analyze API performance bottlenecks
- `/project:analyze-security` - Security vulnerability assessment

## Documentation Commands  
- `/project:generate-api-docs` - Generate API documentation
- `/project:update-changelog` - Update project changelog

## Usage Examples
```bash
# Analyze specific feature performance
/project:analyze-performance "user authentication"

# Generate docs for new API endpoint
/project:generate-api-docs "payment processing API"
```

### Onboarding New Team Members

#### Command Discovery Workflow
```markdown
# onboard-commands.md
---
description: "Help new team members discover and understand project commands"  
allowed-tools: ["Read", "Write"]
---

# Team Command Onboarding

Welcome to our custom command system! Here's how to get started:

## Step 1: Available Commands
List all available project commands and their purposes:
[Command discovery logic]

## Step 2: Usage Examples
Show practical examples of common workflows:
[Example generation logic]

## Step 3: Best Practices
Share team conventions and standards:
[Best practices documentation]
```

---

## Security & Maintenance

### Tool Restrictions Strategy

#### Principle of Least Privilege
```yaml
# ✅ Read-Only Analysis
---
description: "Security analysis - read-only examination"
allowed-tools: ["Read", "Grep", "Glob"]
---

# ✅ Documentation Generation  
---
description: "Generate documentation - controlled file operations"
allowed-tools: ["Read", "Write", "Grep"]
---

# ⚠️ Full Access (use sparingly)
---
description: "Complete workflow automation - requires justification"
allowed-tools: ["Bash", "Read", "Write", "Edit", "Grep", "Glob"]
---
```

#### Security-First Command Design
```markdown
# ✅ Secure Pattern
## Task 1: Read Configuration
Read configuration files to understand security settings (never log secrets)

## Task 2: Analyze Patterns
Identify security patterns without exposing sensitive data

## Task 3: Generate Report
Create security report with sanitized findings

# ❌ Insecure Pattern
## Task 1: Debug Everything
Log all configuration including API keys and secrets
```

### Sensitive Data Protection

#### Data Sanitization Patterns
```markdown
# Built-in Security Practices
When analyzing code that may contain sensitive data:

1. **Never log or display:**
   - API keys, tokens, passwords
   - Database connection strings
   - Internal URLs and endpoints
   
2. **Use generic references:**
   - "API key detected" instead of showing the key
   - "Database connection configured" instead of showing credentials
   
3. **Focus on patterns:**
   - "Hardcoded secrets found in 3 locations"
   - "Insecure configuration detected"
```

### Command Lifecycle Management

#### Version Evolution Strategy
```markdown
# Command Versioning Pattern
analyze-api-v1.md       # Initial version
analyze-api-v2.md       # Enhanced with security checks  
analyze-api-v3.md       # Added performance metrics
analyze-api.md          # Current stable version (symlink or copy of v3)
```

#### Deprecation Workflow
```markdown
# deprecate-command.md
---
description: "Gracefully deprecate old commands and guide users to alternatives"
---

# Command Deprecation Notice

⚠️ **This command is deprecated and will be removed in the next release.**

**Replacement:** Use `/project:new-command-name` instead

**Migration Guide:**
- Old: `/project:old-command arg1`
- New: `/project:new-command arg1`

**What changed:**
[Explanation of improvements and changes]
```

---

## Troubleshooting Common Issues

### Issue 1: Workflow Stalls at Confirmation Points
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

### Issue 2: Tasks Execute Out of Order
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

### Issue 3: Context Loss Between Tasks
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

### Issue 4: Overwhelmingly Complex Output
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

## Quality Assurance & Testing

### Command Validation Checklist

#### Before Committing New Commands
- [ ] **Single Responsibility:** Command has one clear purpose
- [ ] **Clear Naming:** Follows team naming conventions
- [ ] **Appropriate Tools:** Uses minimal necessary tool permissions
- [ ] **Error Handling:** Includes graceful failure scenarios
- [ ] **Documentation:** Has clear description and usage examples
- [ ] **Security:** No sensitive data exposure risks

#### Testing Command Effectiveness
```markdown
# test-command.md
---
description: "Test custom commands with various scenarios"
allowed-tools: ["Read"]
---

# Command Testing Framework

Test the $ARGUMENTS command with these scenarios:

## Test 1: Happy Path
- Standard input and expected behavior
- Verify all tasks complete successfully

## Test 2: Edge Cases  
- Empty or minimal input
- Large/complex input scenarios

## Test 3: Error Conditions
- Invalid input handling
- Missing dependencies or files
- Network/permission failures

## Test 4: Performance
- Response time with typical input
- Context usage efficiency
- Token consumption analysis
```

### Quality Metrics

#### Command Effectiveness Indicators
- **Time to Value:** How quickly does the command provide useful results?
- **Accuracy:** How often does the command produce correct outputs?
- **Consistency:** Does the command behave predictably with similar inputs?
- **Maintainability:** How easy is it to update and improve the command?

#### User Experience Metrics
- **Clarity:** Are the command's prompts and outputs easy to understand?
- **Reliability:** Does the command work consistently across different scenarios?
- **Efficiency:** Does the command minimize unnecessary steps and context usage?
- **Helpfulness:** Does the command provide actionable, valuable results?

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
3. **Tool Selection:** Right tool for the right job

### Professional Development
1. **Team Collaboration:** Shared standards and consistent patterns
2. **Security First:** Principle of least privilege, data protection
3. **Quality Assurance:** Testing, validation, continuous improvement

### Advanced Workflows
1. **Thinking Mode Integration:** Strategic use of reasoning capabilities
2. **Human-in-the-Loop:** Confirmation points before expensive operations
3. **State Management:** Maintain context across sequential tasks

**Remember:** Custom commands are **compute-scaling assets**. Invest time in designing them well, and they'll multiply your impact exponentially.

---

*Next recommended reading: [Command Examples & Templates](06-examples.md) - Explore practical implementations of these best practices*