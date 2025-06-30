# Custom Commands Setup Guide

*Get your custom command environment configured and organized for maximum productivity*

---

## Table of Contents

1. [Quick Setup](#quick-setup)
2. [Command Directory Organization](#command-directory-organization)  
3. [Command File Structure](#command-file-structure)
4. [Team & Sharing Setup](#team--sharing-setup)
5. [Command-Specific Configuration](#command-specific-configuration)
6. [Testing Your Setup](#testing-your-setup)
7. [Troubleshooting Commands](#troubleshooting-commands)

---

## Quick Setup

*Get your first custom command working in 5 minutes*

### Step 1: Create Command Directories

**For personal commands (available across all projects):**
```bash
mkdir -p ~/.claude/commands
```

**For project commands (shared with your team):**
```bash
# Run this in your project root
mkdir -p .claude/commands
```

### Step 2: Create Your First Command

**Simple example command:**
```bash
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

### Step 3: Test Your Command

1. **Start Claude Code** in any directory
2. **Try your command**: `/user:explain "function add(a, b) { return a + b; }"`
3. **Verify it works** - you should see a detailed code explanation

### Step 4: Create a Project Command

```bash
# In your project directory
cat > .claude/commands/review.md << 'EOF'
Review this code following our team standards:

$ARGUMENTS

Focus on:
- Code quality and best practices
- Potential bugs or edge cases
- Performance considerations
- Consistency with our codebase
EOF
```

**Test project command**: `/project:review "your code here"`

---

## Command Directory Organization

### Understanding Command Discovery

Claude Code finds commands by scanning specific directories:

```
Personal Commands (available everywhere):
~/.claude/commands/                    → /user:command-name

Project Commands (team-shared):
project-root/.claude/commands/         → /project:command-name
```

### File-to-Command Mapping

```
File Path                              → Command
~/.claude/commands/optimize.md         → /user:optimize
~/.claude/commands/docs/api.md         → /user:docs:api
.claude/commands/test.md               → /project:test
.claude/commands/frontend/review.md    → /project:frontend:review
```

### Organizational Strategies

#### Strategy 1: By Purpose
```
~/.claude/commands/
├── analyze/
│   ├── performance.md     → /user:analyze:performance
│   ├── security.md        → /user:analyze:security
│   └── complexity.md      → /user:analyze:complexity
├── generate/
│   ├── tests.md           → /user:generate:tests
│   ├── docs.md            → /user:generate:docs
│   └── comments.md        → /user:generate:comments
└── refactor/
    ├── extract-method.md  → /user:refactor:extract-method
    └── simplify.md        → /user:refactor:simplify
```

#### Strategy 2: By Technology
```
.claude/commands/
├── frontend/
│   ├── component-review.md    → /project:frontend:component-review
│   └── accessibility.md       → /project:frontend:accessibility
├── backend/
│   ├── api-design.md          → /project:backend:api-design
│   └── performance.md         → /project:backend:performance
└── database/
    ├── query-optimize.md      → /project:database:query-optimize
    └── schema-review.md       → /project:database:schema-review
```

#### Strategy 3: By Development Stage
```
.claude/commands/
├── planning/
│   └── feature-breakdown.md
├── development/
│   ├── code-review.md
│   └── bug-analysis.md
├── testing/
│   ├── test-plan.md
│   └── edge-cases.md
└── deployment/
    └── checklist.md
```

### Naming Best Practices

**✅ Good Command Names:**
- `code-review.md` - Clear and descriptive
- `api-design.md` - Specific purpose
- `security-audit.md` - Unambiguous

**❌ Avoid These Patterns:**
- `review.md` - Too generic
- `code review.md` - Spaces cause issues
- `cr.md` - Unclear abbreviations
- `temp-123.md` - Temporary names

---

## Command File Structure

### Basic Command Template

```markdown
# Command Title (optional but recommended)

Brief description of what this command does.

$ARGUMENTS

Additional context or instructions.
```

### Enhanced Command with Configuration

```markdown
---
description: "Reviews code for security vulnerabilities"
category: "security"
author: "security-team"
---

# Security Code Review

Perform a comprehensive security review of this code:

$ARGUMENTS

Focus on:
- Input validation and sanitization
- Authentication and authorization
- SQL injection vulnerabilities
- XSS prevention
- Sensitive data handling
```

### Command with Dynamic Content

```markdown
# Project Context Code Review

Review this code in the context of our current project:

**Current Project**: !basename $(pwd)
**Git Branch**: !git rev-parse --abbrev-ref HEAD
**Modified Files**: !git diff --name-only

**Code to Review**: $ARGUMENTS

Consider our project's specific patterns and standards.
```

### Template Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `$ARGUMENTS` | User-provided input | `/user:cmd "user input here"` |
| `!command` | Execute shell command | `!date` outputs current date |
| `@file.txt` | Include file contents | `@README.md` includes README |

---

## Team & Sharing Setup

### Git Integration for Project Commands

#### What to Commit
```gitignore
# .gitignore - INCLUDE these in version control
.claude/commands/          # Team-shared commands
```

#### What NOT to Commit
```gitignore
# .gitignore - EXCLUDE these from version control
.claude/settings.local.json    # Personal project settings
.claude/cache/                 # Command cache
.claude/logs/                  # Debug logs
```

### Team Command Standards

Create `.claude/commands/README.md` for your team:

```markdown
# Team Custom Commands

## Naming Conventions
- Use kebab-case: `feature-review.md`
- Be descriptive: `security-audit.md` not `audit.md`
- Group by purpose: `frontend/`, `backend/`, `testing/`

## Required Commands
Every project should have:
- `code-review.md` - Standard code review process
- `bug-analysis.md` - Bug investigation workflow
- `feature-spec.md` - Feature specification template

## Command Structure
All team commands should include:
1. Clear description of purpose
2. Expected input format
3. Example usage
4. Team-specific context (coding standards, frameworks)

## Testing New Commands
Before committing:
1. Test with sample inputs
2. Verify arguments work correctly
3. Check for typos and clarity
4. Get review from another team member
```

### Sharing Personal Commands

**Option 1: Copy useful personal commands to project**
```bash
# Copy a useful personal command to project
cp ~/.claude/commands/optimize.md .claude/commands/optimize.md
```

**Option 2: Create personal command templates for team**
```bash
# Create team-commands/ directory with templates
mkdir team-commands/personal/
cp ~/.claude/commands/*.md team-commands/personal/
```

---

## Command-Specific Configuration

### YAML Frontmatter Options

**⚠️ Official Support Limited**: Only `allowed-tools` and `description` are officially supported by Claude Code.

```yaml
---
# Officially supported options
description: "Brief description of command purpose"
allowed-tools: ["Bash(git add:*)", "Read"]

# Community documentation patterns (not processed by Claude Code)
# category: "code-analysis"
# author: "team@company.com"
# version: "1.0.0"
---
```

**Note**: Other YAML fields may appear in community examples but are not processed by Claude Code. They serve only as documentation for team reference.

### Command Variables and Environment

```markdown
# Environment-Aware Command

Analyze this $LANGUAGE code:

$ARGUMENTS

**Environment Context:**
- Project: $PROJECT_NAME
- Framework: $FRAMEWORK
- Environment: $NODE_ENV

Use our $FRAMEWORK specific best practices.
```

Set environment variables:
```bash
export PROJECT_NAME="MyProject"
export FRAMEWORK="React"
export LANGUAGE="TypeScript"
```

---

## Testing Your Setup

### Verification Checklist

**✅ Directory Structure**
```bash
# Check personal commands directory
ls -la ~/.claude/commands/

# Check project commands directory (in project root)
ls -la .claude/commands/
```

**✅ Command Discovery**
```bash
# Start Claude Code and try:
/user:hello "test"           # Should work if you created hello.md
/project:review "test code"  # Should work if in project with review.md
```

**✅ Arguments Working**
- Commands should receive your input where `$ARGUMENTS` appears
- Multi-word arguments should work: `/user:cmd "multiple words here"`
- Special characters should be handled correctly

**✅ Directory Navigation**
- Project commands should work when Claude is started from project root
- Project commands should work from subdirectories within the project
- Personal commands should work from anywhere

### Quick Test Commands

**Test personal command:**
```bash
cat > ~/.claude/commands/test.md << 'EOF'
✅ Personal command test successful! 

Your input was: $ARGUMENTS

Time: !date
Directory: !pwd
EOF

# Test: /user:test "this is working"
```

**Test project command:**
```bash
cat > .claude/commands/test.md << 'EOF'
✅ Project command test successful!

Your input was: $ARGUMENTS

Project: !basename $(pwd)
Git status: !git status --porcelain | wc -l
EOF

# Test: /project:test "project command works"
```

---

## Troubleshooting Commands

### Common Issues

#### Problem: "Command not found"
**Symptoms**: `/user:mycommand` returns "Unknown command"

**Solutions**:
```bash
# 1. Check file exists and has .md extension
ls ~/.claude/commands/mycommand.md

# 2. Check file permissions
ls -la ~/.claude/commands/mycommand.md
# Should show: -rw-r--r-- (readable)

# 3. Fix permissions if needed
chmod 644 ~/.claude/commands/mycommand.md

# 4. Restart Claude Code session
```

#### Problem: Arguments not working
**Symptoms**: `$ARGUMENTS` appears literally instead of being replaced

**Solutions**:
```bash
# 1. Check exact spelling (case-sensitive)
grep "ARGUMENTS" ~/.claude/commands/mycommand.md

# 2. Ensure proper usage
/user:mycommand "quoted arguments"  # ✅ Good
/user:mycommand unquoted args       # ❌ May not work
```

#### Problem: Project commands not available
**Symptoms**: `/project:command` not found but file exists

**Solutions**:
```bash
# 1. Ensure Claude Code started from project directory or subdirectory
pwd  # Should be in project tree

# 2. Check .claude/commands/ directory exists in project root
ls -la .claude/commands/

# 3. Navigate to project root and restart Claude
cd /path/to/project/root
claude
```

#### Problem: Command executes but produces errors
**Symptoms**: Command runs but shell commands (!) fail

**Solutions**:
```bash
# 1. Test shell commands manually
date                    # Should work
git rev-parse --abbrev-ref HEAD  # Should show branch name

# 2. Check if commands exist and have permissions
which git               # Should show path
which date              # Should show path

# 3. Simplify command to isolate issue
# Remove shell commands (!...) temporarily
```

### Debugging Command Files

**View command as Claude sees it:**
```bash
# Check command file content
cat ~/.claude/commands/mycommand.md

# Look for invisible characters
cat -A ~/.claude/commands/mycommand.md

# Check line endings (should not show ^M)
```

**Test argument substitution:**
```bash
# Create simple test command
cat > ~/.claude/commands/debug.md << 'EOF'
Debug test:
- Input: [$ARGUMENTS]
- Length: ${#ARGUMENTS}
- Working directory: !pwd
EOF

# Test with: /user:debug "test input"
```

### Performance Issues

#### Slow Command Discovery
**If commands take long to appear:**

```bash
# 1. Check number of command files
find ~/.claude/commands -name "*.md" | wc -l
find .claude/commands -name "*.md" | wc -l

# 2. Look for circular symlinks
find ~/.claude/commands -type l

# 3. Organize commands into subdirectories if you have many
```

#### Commands Timeout
**If commands take too long to execute:**

```bash
# 1. Simplify command content
# 2. Remove complex shell commands
# 3. Consider breaking complex commands into smaller ones
```

---

## Next Steps

### Now That You're Set Up

1. **Explore Examples**: Browse the [example commands](../../commands/) for inspiration
2. **Learn Syntax**: Read the [Syntax Reference](03-syntax.md) for advanced features
3. **Best Practices**: Check out [Best Practices](04-best-practices.md) for command design
4. **Team Setup**: Review [Team Collaboration](06-team.md) for sharing strategies

### Building Your Command Library

**Start with these essential commands:**
- **Code review** - Standardize your review process
- **Bug analysis** - Systematic debugging approach
- **Documentation** - Generate consistent docs
- **Testing** - Create test cases and scenarios

**Gradually add specialized commands:**
- Framework-specific analysis
- Performance optimization
- Security auditing
- Refactoring assistance

---

## Summary

Custom command setup focuses on **directory organization** and **file structure** rather than complex installation. The key success factors are:

1. **Correct directories**: `~/.claude/commands/` for personal, `.claude/commands/` for project
2. **Proper file naming**: Use `.md` extension and descriptive names
3. **Team coordination**: Establish shared standards and Git practices
4. **Testing and validation**: Verify commands work as expected
5. **Iterative improvement**: Start simple and gradually add sophistication

Your custom commands are now ready to streamline your development workflow! 🚀

**Next recommended step**: [Learn advanced syntax features](03-syntax.md) to create more powerful commands.