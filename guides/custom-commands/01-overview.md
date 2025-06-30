# Custom Commands Overview

*Master Claude Code's custom commands feature - from basic concepts to immediate productivity*

---

## Table of Contents

1. [What Are Custom Commands?](#what-are-custom-commands)
2. [Core Concepts & Fundamentals](#core-concepts--fundamentals)
3. [Command Scopes: Project vs User](#command-scopes-project-vs-user)
4. [Basic Usage Examples](#basic-usage-examples)
5. [When to Use Custom Commands](#when-to-use-custom-commands)
6. [Command Categories & Common Patterns](#command-categories--common-patterns)
7. [Getting Started in 5 Minutes](#getting-started-in-5-minutes)
8. [Advanced Features Preview](#advanced-features-preview)
9. [What's Next & Learning Path](#whats-next--learning-path)

---

## What Are Custom Commands?

Custom commands in Claude Code are **user-defined prompt templates** stored as Markdown files that can be invoked using slash command syntax. They allow you to create reusable, parameterized prompts that streamline repetitive development tasks.

### How They Work

Instead of typing the same complex prompt repeatedly:
```
"Analyze this code for performance issues, focusing on time complexity, 
memory usage, and potential bottlenecks. Provide specific recommendations 
with code examples."
```

You create a custom command and simply type:
```
/user:optimize $ARGUMENTS
```

### Built-in vs Custom Commands

| Built-in Commands | Custom Commands |
|-------------------|-----------------|
| `/help`, `/clear`, `/login` | `/project:test`, `/user:optimize` |
| Hardcoded functionality | User-defined prompts |
| System behavior control | Development workflow automation |
| Cannot be modified | Fully customizable |

### Key Benefits

- **🚀 Efficiency**: Execute complex workflows with simple commands
- **🔄 Consistency**: Standardized prompts across team members
- **📚 Knowledge Sharing**: Capture and share domain expertise
- **🎯 Focus**: Eliminate prompt engineering during development
- **⚡ Speed**: Instant access to specialized prompts

---

## Core Concepts & Fundamentals

### File-Based Command System

Custom commands are **Markdown files** containing prompt templates:

```markdown
# File: optimize.md
Analyze this code for performance issues:

$ARGUMENTS

Focus on:
- Time complexity analysis
- Memory usage optimization
- Bottleneck identification
- Specific improvement recommendations
```

### Command Discovery

Claude Code automatically discovers commands by:
1. **Scanning directories** for `.md` files
2. **Converting filenames** to command names
3. **Adding appropriate prefixes** based on location

```
Directory Structure → Command Name
.claude/commands/optimize.md → /project:optimize
~/.claude/commands/review.md → /user:review
```

### Dynamic Parameters

Use `$ARGUMENTS` to make commands flexible:

```bash
/user:optimize "this function that calculates fibonacci numbers"
# Replaces $ARGUMENTS with the quoted text
```

---

## Command Scopes: Project vs User

Claude Code supports two command scopes with different use cases and storage locations:

### Project Commands (`/project:`)

**Storage Location**: `.claude/commands/` in your project directory

**Use Cases**:
- Team-shared commands
- Project-specific workflows
- Domain-specific prompts
- Standardized development processes

**Example Structure**:
```
my-project/
├── .claude/
│   └── commands/
│       ├── test.md           → /project:test
│       ├── deploy.md         → /project:deploy
│       └── frontend/
│           └── component.md  → /project:frontend:component
├── src/
└── package.json
```

**Benefits**:
- ✅ Shared via version control
- ✅ Team consistency
- ✅ Project-specific context
- ✅ Automatic availability for all team members

### User Commands (`/user:`)

**Storage Location**: `~/.claude/commands/` in your home directory

**Use Cases**:
- Personal productivity commands
- Cross-project utilities
- Individual workflow preferences
- Experimental commands

**Example Structure**:
```
~/.claude/
└── commands/
    ├── optimize.md         → /user:optimize
    ├── security-check.md   → /user:security-check
    └── docs/
        └── explain.md      → /user:docs:explain
```

**Benefits**:
- ✅ Available across all projects
- ✅ Personal customization
- ✅ Private to your workflow
- ✅ Persistent across projects

### Directory Organization & Namespacing

Create subdirectories for logical grouping:

```
.claude/commands/
├── git/
│   ├── commit.md      → /project:git:commit
│   └── pr.md          → /project:git:pr
├── docs/
│   ├── api.md         → /project:docs:api
│   └── readme.md      → /project:docs:readme
└── test/
    ├── unit.md        → /project:test:unit
    └── integration.md → /project:test:integration
```

---

## Basic Usage Examples

### Example 1: Simple Code Review Command

**File**: `~/.claude/commands/review.md`
```markdown
Please review this code for:
- Code quality and best practices
- Potential bugs or edge cases
- Performance considerations
- Security vulnerabilities

$ARGUMENTS
```

**Usage**:
```bash
/user:review "function calculateTotal(items) { return items.reduce((sum, item) => sum + item.price, 0); }"
```

### Example 2: Project-Specific Test Generation

**File**: `.claude/commands/test.md`
```markdown
Generate comprehensive unit tests for the following code using our project's testing framework (Jest with React Testing Library):

$ARGUMENTS

Requirements:
- Cover all code paths and edge cases
- Follow our naming conventions (describe/it blocks)
- Include proper setup/teardown
- Mock external dependencies appropriately
- Test both success and error scenarios
```

**Usage**:
```bash
/project:test "@components/UserProfile.jsx"
```

### Example 3: Parameterized Documentation Command

**File**: `.claude/commands/docs/api.md`
```markdown
Create API documentation for the following endpoint:

$ARGUMENTS

Include:
- Endpoint description and purpose
- Request/response schemas
- Example requests and responses
- Error codes and handling
- Authentication requirements
- Rate limiting information
```

**Usage**:
```bash
/project:docs:api "PUT /api/users/{id}/profile - Update user profile endpoint"
```

### Example 4: Multi-Step Workflow Command

**File**: `.claude/commands/feature.md`
```markdown
Help me implement a new feature following our development workflow:

Feature: $ARGUMENTS

Please:
1. Analyze the requirements and break down into tasks
2. Suggest the file structure and components needed
3. Identify potential dependencies and integrations
4. Create implementation plan with testing strategy
5. Highlight any security or performance considerations
6. Provide initial code scaffolding
```

**Usage**:
```bash
/project:feature "user authentication with social login"
```

---

## When to Use Custom Commands

### Perfect Scenarios for Custom Commands

#### ✅ **Repetitive Development Tasks**
- Code reviews with consistent criteria
- Test generation following specific patterns
- Documentation creation with standard formats
- Refactoring with established patterns

#### ✅ **Team Standardization**
- Consistent code review processes
- Standardized commit message formats
- Unified documentation templates
- Shared debugging approaches

#### ✅ **Complex Multi-Step Workflows**
- Feature implementation pipelines
- Deployment preparation checklists
- Performance optimization processes
- Security audit procedures

#### ✅ **Domain-Specific Knowledge**
- Framework-specific best practices
- Company coding standards
- Industry-specific requirements
- Technology-specific patterns

### When NOT to Use Custom Commands

#### ❌ **One-off Tasks**
- Unique debugging scenarios
- Experimental explorations
- Simple, straightforward requests

#### ❌ **Highly Variable Contexts**
- Tasks requiring extensive customization
- Context-dependent analysis
- Ad-hoc investigations

### Decision Framework

Ask yourself:
1. **Will I use this prompt again?** If yes, consider a custom command
2. **Would my team benefit from this?** If yes, create a project command
3. **Is the prompt complex or multi-step?** Custom commands reduce errors
4. **Does it follow a pattern?** Commands ensure consistency

---

## Command Categories & Common Patterns

### 1. Development Workflow Commands

#### Code Analysis & Review
```markdown
# File: review-security.md
Perform a security-focused code review:

$ARGUMENTS

Focus on:
- Input validation and sanitization
- Authentication and authorization
- SQL injection vulnerabilities
- XSS prevention
- Sensitive data handling
```

#### Testing & Quality Assurance
```markdown
# File: test-e2e.md
Generate end-to-end tests for this user workflow:

$ARGUMENTS

Requirements:
- Use Cypress with our custom commands
- Cover happy path and error scenarios
- Include accessibility testing
- Add visual regression tests
- Document test data requirements
```

### 2. Documentation Commands

#### API Documentation
```markdown
# File: docs-api.md
Create comprehensive API documentation:

$ARGUMENTS

Include:
- OpenAPI/Swagger specification
- Example requests/responses
- Error handling documentation
- Authentication examples
- SDK usage examples
```

#### Code Explanation
```markdown
# File: explain.md
Explain this code in detail for different audiences:

$ARGUMENTS

Provide explanations for:
- New team members (basic concepts)
- Experienced developers (implementation details)
- Technical stakeholders (architectural decisions)
- Code reviewers (potential issues and improvements)
```

### 3. Git & Version Control Commands

#### Commit Message Generation
```markdown
# File: commit.md
Generate a conventional commit message for these changes:

$ARGUMENTS

Format: type(scope): description

Types: feat, fix, docs, style, refactor, test, chore
Include breaking change notes if applicable
Keep description under 50 characters
Add detailed body if needed
```

#### Pull Request Templates
```markdown
# File: pr.md
Create a comprehensive pull request description:

$ARGUMENTS

Include:
- Clear summary of changes
- Testing instructions
- Screenshots if UI changes
- Breaking changes documentation
- Reviewer checklist
- Related issue links
```

### 4. Project Management Commands

#### Task Breakdown
```markdown
# File: breakdown.md
Break down this feature into development tasks:

$ARGUMENTS

Provide:
- User stories and acceptance criteria
- Technical tasks with time estimates
- Dependencies and prerequisites
- Testing requirements
- Documentation needs
- Deployment considerations
```

#### Progress Tracking
```markdown
# File: progress.md
Create a development progress report:

$ARGUMENTS

Include:
- Completed tasks and milestones
- Current blockers and challenges
- Next steps and priorities
- Risk assessment
- Timeline updates
- Resource requirements
```

---

## Getting Started in 5 Minutes

### Quick Setup Guide

#### Step 1: Choose Your Scope
**For personal use across all projects:**
```bash
mkdir -p ~/.claude/commands
```

**For team sharing in current project:**
```bash
mkdir -p .claude/commands
```

#### Step 2: Create Your First Command
```bash
# Personal command
echo "Optimize this code for performance: \$ARGUMENTS" > ~/.claude/commands/optimize.md

# Project command  
echo "Review this code following our team standards: \$ARGUMENTS" > .claude/commands/review.md
```

#### Step 3: Test Your Command
```bash
# Open Claude Code in your project
claude

# Try your new command
/user:optimize "function that processes large arrays"
/project:review "@src/components/UserList.jsx"
```

#### Step 4: Enhance with Structure
```markdown
# File: ~/.claude/commands/optimize.md
# Performance Optimization Analysis

Analyze the following code for performance improvements:

$ARGUMENTS

Please provide:
- **Time Complexity**: Current and optimized analysis
- **Memory Usage**: Identify memory leaks or excessive allocation
- **Bottlenecks**: Specific performance bottlenecks
- **Recommendations**: Concrete improvement suggestions with code examples
- **Trade-offs**: Any trade-offs between performance and readability

Focus on practical, implementable optimizations.
```

### Common First Commands to Try

#### 1. Code Explanation Command
```bash
mkdir -p ~/.claude/commands
cat > ~/.claude/commands/explain.md << 'EOF'
Explain this code clearly and concisely:

$ARGUMENTS

Include:
- What the code does (purpose)
- How it works (mechanism)
- Key concepts or patterns used
- Potential improvements or concerns
EOF
```

#### 2. Bug Investigation Command
```bash
cat > ~/.claude/commands/debug.md << 'EOF'
Help me debug this issue:

$ARGUMENTS

Please:
1. Analyze the problem description and symptoms
2. Identify likely root causes
3. Suggest debugging steps and techniques
4. Provide potential solutions with code examples
5. Recommend prevention strategies
EOF
```

#### 3. Test Generation Command
```bash
mkdir -p .claude/commands
cat > .claude/commands/test.md << 'EOF'
Generate comprehensive tests for:

$ARGUMENTS

Requirements:
- Cover all major code paths
- Include edge cases and error scenarios
- Follow testing best practices
- Use appropriate test structure and naming
- Include setup and cleanup as needed
EOF
```

### Troubleshooting Quick Start Issues

#### Command Not Found
- ✅ Check file extension is `.md`
- ✅ Verify directory path (`.claude/commands/` or `~/.claude/commands/`)
- ✅ Restart Claude Code session
- ✅ Use correct prefix (`/project:` or `/user:`)

#### Arguments Not Working
- ✅ Use `$ARGUMENTS` exactly (case-sensitive)
- ✅ Quote multi-word arguments: `/user:cmd "multiple words"`
- ✅ Check for typos in variable name

---

## Advanced Features Preview

*These features will be covered in detail in dedicated documentation files*

### YAML Frontmatter Configuration

**⚠️ Limited Official Support**: Only `allowed-tools` and `description` are officially supported by Claude Code.

```markdown
---
description: "Optimizes code for performance with detailed analysis"
allowed-tools: ["Bash(git status:*)", "Read"]
---

# Performance Optimization Command
Analyze this code for performance improvements: $ARGUMENTS
```

**Note**: Other YAML fields like `category`, `author`, `version` are community patterns for documentation only and are not processed by Claude Code.

### Dynamic Content with Shell Commands

**Context Preparation**: Shell commands (using `!`) run before sending the command to Claude, including their output in the command context:

```markdown
# Current Git Status Analysis
Analyze the current repository state:

Current branch: !git rev-parse --abbrev-ref HEAD
Recent commits: !git log --oneline -5
Modified files: !git diff --name-only

$ARGUMENTS
```

**Note**: These commands execute during context preparation, not at runtime. The output is included in the prompt sent to Claude.

### File References

Include file contents dynamically:
```markdown
# Code Review with Context
Review this code considering our style guide:

Style Guide: @docs/STYLE_GUIDE.md
Code to Review: $ARGUMENTS
```


### Conditional Logic and Templates

**⚠️ Custom Implementation**: Create adaptive commands using bash scripting in context preparation:

```markdown
# Smart Code Analysis
!if [[ "$ARGUMENTS" == *".test."* ]]; then
  echo "Analyzing test code with testing-specific criteria:"
else
  echo "Analyzing production code with standard criteria:"
fi

$ARGUMENTS
```

**Note**: This uses bash scripting during context preparation phase. Claude Code doesn't have built-in conditional logic - this is a custom pattern using shell commands.

---

## What's Next & Learning Path

### Recommended Reading Order

After mastering this overview, continue with these specialized guides:

1. **📋 [Setup Guide](02-setup.md)**
   - Command directory setup and organization  
   - Cross-platform configuration
   - Team collaboration setup

2. **📖 [Syntax Reference](03-syntax.md)**
   - Complete command syntax documentation
   - YAML frontmatter options
   - Advanced parameter handling

3. **✨ [Best Practices](04-best-practices.md)**
   - Anthropic's official recommendations
   - Community best practices
   - Command design principles

4. **🔧 [Advanced Patterns](05-advanced.md)**
   - Meta-commands and automation
   - Workflow orchestration
   - Complex parameter handling

5. **👥 [Team Collaboration](06-team.md)**
   - Sharing commands effectively
   - Establishing team standards
   - Git integration strategies

### Practical Next Steps

#### Immediate Actions (Next 15 minutes)
- [ ] Create your first personal command in `~/.claude/commands/`
- [ ] Test it with a simple code example
- [ ] Create a project command in `.claude/commands/`
- [ ] Share with a teammate for feedback

#### Short Term (This Week)
- [ ] Identify 3-5 repetitive tasks you do daily
- [ ] Convert them to custom commands
- [ ] Organize commands with subdirectories
- [ ] Document your team's command standards

#### Long Term (This Month)
- [ ] Build a comprehensive command library
- [ ] Contribute to community command repositories  
- [ ] Train your team on effective command usage
- [ ] Explore advanced command patterns

### Additional Resources

#### Official Claude Code Documentation
- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code) - General Claude Code features
- [Slash Commands Reference](https://docs.anthropic.com/en/docs/claude-code/slash-commands) - Built-in commands and custom command basics

#### Community Examples
- [Awesome Claude Code Commands](https://github.com/hesreallyhim/awesome-claude-code) - Community command collection
- Real-world usage examples and case studies

#### Getting Help
- **[Complete Guide Series](README.md)** - Full custom commands learning path
- **[Setup Guide](02-setup.md)** - Configuration and troubleshooting
- Official Claude Code documentation for general issues

### Success Metrics

You'll know you've mastered custom commands when:
- ✅ You naturally think in terms of reusable prompts
- ✅ Your development workflow becomes noticeably faster
- ✅ Your team adopts and extends your commands
- ✅ You contribute back to the community
- ✅ You can debug and optimize complex command workflows

---

## Summary

Custom commands transform Claude Code from a helpful assistant into a **personalized development environment** tailored to your specific needs and workflows. They represent a paradigm shift from ad-hoc prompting to **systematic, reusable prompt engineering**.

### Key Takeaways

1. **Custom commands are Markdown files** containing prompt templates with dynamic parameters
2. **Two scopes available**: Project commands (team-shared) and user commands (personal)
3. **Simple syntax**: `/project:command` and `/user:command` with `$ARGUMENTS`
4. **Perfect for repetitive tasks**, team standardization, and complex workflows
5. **Advanced features** enable sophisticated automation and integration
6. **Community-driven** with growing ecosystem of shared commands and best practices

Start small, think big, and gradually build a command library that amplifies your development productivity. The investment in creating good commands pays dividends in time saved, consistency gained, and knowledge shared across your team.

Ready to transform your development workflow? **[Set up your first command](02-setup.md)** now and experience the power of personalized AI assistance!