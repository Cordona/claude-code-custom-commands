# Custom Commands Syntax Reference

*Complete guide to custom command syntax, from basic parameters to advanced patterns*

**🚨 ACCURACY NOTICE**: This guide distinguishes between **officially supported features** (marked with ✅) and **community patterns/custom implementations** (marked with ⚠️). Only use officially supported features for reliable functionality.

---

## 📋 Quick Reference

*For experienced users - complete syntax at a glance*

### **Basic Patterns** ✅
```bash
# Simple command (officially supported)
/user:command "single argument"

# Multiple values in single string (community pattern)
/user:command "file1.js file2.js file3.js"
```

### **Advanced Patterns** ⚠️ 
```bash
# CLI-style flags (custom implementation - not built-in)
/user:command "main argument --flag --option value"

# Note: Requires custom bash parsing in command file
```

### **File Structure**
```markdown
---
allowed-tools: ["Bash(git add:*)", "Bash(git status:*)"]
description: "Create a git commit"
---

# Command Title

Command description and instructions.

$ARGUMENTS

Additional context or processing.
```

### **Template Variables**
| Syntax | Description | Example |
|--------|-------------|---------|
| `$ARGUMENTS` | User input | `/user:cmd "hello world"` |
| `!command` | Context preparation | `!date` includes current date in command context |
| `@file.txt` | File inclusion | `@README.md` includes file content |
| `${VAR}` | Environment variable | `${PROJECT_NAME}` |

### **YAML Configuration Quick Reference**
```yaml
# Officially supported options
allowed-tools: ["Bash(git add:*)", "Bash(git status:*)"]  # Permitted tools with specific commands
description: "Create a git commit"                        # Command description
```

**⚠️ Note**: Only `allowed-tools` and `description` are officially supported in YAML frontmatter. Other options shown in this guide are community patterns or examples for future consideration.

---

## Table of Contents

1. [Command Anatomy](#command-anatomy)
2. [Parameter Handling Mastery](#parameter-handling-mastery)
3. [Advanced Parameter Patterns](#advanced-parameter-patterns)
4. [YAML Frontmatter Complete Reference](#yaml-frontmatter-complete-reference)
5. [Dynamic Content Features](#dynamic-content-features)
6. [Security & Best Practices](#security--best-practices)
7. [Troubleshooting & Debugging](#troubleshooting--debugging)

---

## Command Anatomy

### File Structure Requirements

**✅ Valid Command File:**
```
~/.claude/commands/analyze-code.md
```

**❌ Invalid Patterns:**
```
~/.claude/commands/analyze code.md    # Spaces in filename
~/.claude/commands/analyze-code.txt   # Wrong extension
~/.claude/commands/analyze-code       # No extension
```

### Basic Command Template

```markdown
# Code Analysis Command

Analyze the provided code for potential issues:

$ARGUMENTS

Focus on:
- Code quality and readability
- Performance considerations
- Security vulnerabilities
- Best practice adherence
```

### Enhanced Command with Official YAML Frontmatter

```markdown
---
allowed-tools: ["Bash(find . -name '*.js')"]
description: "Analyzes code for quality, performance, and security issues"
---

# Code Analysis Command

Perform comprehensive code analysis:

$ARGUMENTS

**Analysis includes:**
- Code quality metrics
- Performance bottlenecks
- Security vulnerability scan
- Best practice compliance
```

### Command Discovery Rules

**File Location → Command Name:**
```
~/.claude/commands/optimize.md              → /user:optimize
~/.claude/commands/docs/api.md              → /user:docs:api
.claude/commands/test.md                    → /project:test
.claude/commands/frontend/component.md      → /project:frontend:component
```

**Naming Best Practices:**
- ✅ `security-review.md` - Clear and descriptive
- ✅ `database-optimize.md` - Specific purpose
- ✅ `frontend-component-check.md` - Detailed context
- ❌ `review.md` - Too generic
- ❌ `db-opt.md` - Unclear abbreviations
- ❌ `temp.md` - Non-descriptive

---

## Parameter Handling Mastery

### How $ARGUMENTS Actually Works

**⚠️ Important**: `$ARGUMENTS` is a **simple string replacement** - the entire argument string you provide replaces the `$ARGUMENTS` placeholder.

**Basic Pattern:**
```markdown
# Simple Code Explanation

Explain this code clearly:

$ARGUMENTS

Include purpose, mechanism, and potential improvements.
```

**Usage:**
```bash
/user:explain "function fibonacci(n) { return n <= 1 ? n : fibonacci(n-1) + fibonacci(n-2); }"
```

**What happens**: The text `"function fibonacci(n) { return n <= 1 ? n : fibonacci(n-1) + fibonacci(n-2); }"` replaces `$ARGUMENTS` exactly as provided.

### Multiple Arguments - Reality Check

**⚠️ Important**: Claude Code doesn't have built-in multiple argument parsing. `$ARGUMENTS` is simply replaced with whatever you type after the command.

**What You Can Do:**
```bash
# Single string with multiple values
/user:analyze-files "app.js utils.js config.js"

# Or provide a space-separated list
/user:analyze-files app.js utils.js config.js
```

**What the command receives:**
- **Case 1**: `$ARGUMENTS` = `"app.js utils.js config.js"`
- **Case 2**: `$ARGUMENTS` = `app.js utils.js config.js`

**Basic Multi-Value Handling (Community Pattern):**
```markdown
# Multi-File Analysis

Analyze these files for consistency:

$ARGUMENTS

Note: Provide files as a space-separated list or quoted string.
```

**Advanced Parsing (Custom Implementation):**
If you need sophisticated argument parsing, you can implement it yourself using the `!` context preparation:

```markdown
---
allowed-tools: ["Bash(echo:*)"]
description: "Advanced argument parsing example"
---

# Advanced File Analyzer

## Context
- Arguments provided: !echo "Raw arguments: $ARGUMENTS"
- Parsed files: !echo "$ARGUMENTS" | tr ' ' '\n'

Analyze the following files:

$ARGUMENTS

**Note**: This uses bash command preparation to help parse arguments, but the core `$ARGUMENTS` is still simple string replacement.
```

### Argument Validation Patterns

**Input Validation Command:**
```markdown
# File Processing with Validation

!echo "Validating arguments: $ARGUMENTS"

# Check if arguments provided
!if [ -z "$ARGUMENTS" ]; then
  echo "❌ Error: No arguments provided"
  echo "Usage: /user:process-file 'filename.ext'"
  exit 1
fi

# Extract filename
!FILENAME="$ARGUMENTS"

# Validate file exists (simulated)
!if [ ! -f "$FILENAME" 2>/dev/null ]; then
  echo "⚠️ Warning: File '$FILENAME' may not exist"
fi

**Processing file:** $FILENAME

Analyze file structure, content, and provide recommendations.
```

### Complex Argument Examples

**JSON-Style Parameters:**
```bash
/user:api-test '{"endpoint": "/users", "method": "GET", "headers": {"Authorization": "Bearer token"}}'
```

**Mixed Content Types:**
```bash
/user:deploy-app "my-app" --environment staging --replicas 3 --config config.yaml
```

---

## Advanced Parameter Patterns

**🚨 IMPORTANT DISCLAIMER**: The patterns in this section are **custom implementations** using bash scripting within the context preparation phase. They are **NOT built-in Claude Code features**.

### CLI-Style Flags (Custom Implementation)

**⚠️ Reality Check**: Claude Code does not have built-in flag parsing. The examples below show how you can implement flag-like behavior using bash commands in the context preparation phase, but this is **complex** and **not officially supported**.

#### Boolean Flags (On/Off Switches)

**Git Commit Command with Skip Options:**
```markdown
---
version: "2.1.0"
description: "Smart git commit with optional test and analysis skipping"
category: "git"
changelog:
  "2.1.0": "Added --skip-sonar flag for SonarQube analysis"
  "2.0.0": "Added --skip-tests flag for faster commits"
  "1.0.0": "Basic commit functionality"
---

# Smart Git Commit

!echo "🔍 Processing commit arguments: $ARGUMENTS"

# Parse flags from arguments
!SKIP_TESTS=$(echo "$ARGUMENTS" | grep -q "\--skip-tests" && echo "true" || echo "false")
!SKIP_SONAR=$(echo "$ARGUMENTS" | grep -q "\--skip-sonar" && echo "true" || echo "false")
!SKIP_LINT=$(echo "$ARGUMENTS" | grep -q "\--skip-lint" && echo "true" || echo "false")

# Extract commit message (remove all flags)
!MESSAGE=$(echo "$ARGUMENTS" | sed 's/--[a-z-]*//g' | sed 's/^ *//g' | sed 's/ *$//g')

!if [ -z "$MESSAGE" ]; then
  echo "❌ Error: Commit message is required"
  echo "Usage: /project:commit 'message' [--skip-tests] [--skip-sonar] [--skip-lint]"
  exit 1
fi

**Commit Configuration:**
- **Message:** "$MESSAGE"
- **Skip Tests:** $SKIP_TESTS
- **Skip SonarQube:** $SKIP_SONAR  
- **Skip Linting:** $SKIP_LINT

**Pre-commit Workflow:**

!if [ "$SKIP_LINT" = "false" ]; then
  echo "🔍 Running linter..."
  npm run lint
  echo "✅ Linting complete"
else
  echo "⚠️ Skipping linting as requested"
fi

!if [ "$SKIP_TESTS" = "false" ]; then
  echo "🧪 Running test suite..."
  npm test
  echo "✅ Tests passed"
else
  echo "⚠️ Skipping tests as requested"
fi

!if [ "$SKIP_SONAR" = "false" ]; then
  echo "📊 Running SonarQube analysis..."
  sonar-scanner
  echo "✅ Code quality analysis complete"
else
  echo "⚠️ Skipping SonarQube analysis as requested"
fi

**Creating commit:**
!git add -A
!git status --short
!git commit -m "$MESSAGE"

echo "🎉 Commit created successfully!"
```

**Usage Examples:**
```bash
# Full workflow (default)
/project:commit "Fix user authentication bug"

# Skip tests for quick fixes
/project:commit "Update documentation" --skip-tests

# Skip everything for emergency fixes
/project:commit "Hotfix: Critical security patch" --skip-tests --skip-sonar --skip-lint

# Skip only specific checks
/project:commit "Refactor utility functions" --skip-sonar
```

#### Named Parameter Flags

**File Processing Command with Options:**
```markdown
---
version: "1.5.0"
description: "Advanced file processing with configurable options"
---

# File Processor

!echo "📁 Processing files with options: $ARGUMENTS"

# Parse named parameters
!INPUT_PATTERN=$(echo "$ARGUMENTS" | grep -o '\--pattern [^-]*' | cut -d' ' -f2- | tr -d '"')
!OUTPUT_DIR=$(echo "$ARGUMENTS" | grep -o '\--output [^-]*' | cut -d' ' -f2- | tr -d '"')
!FORMAT=$(echo "$ARGUMENTS" | grep -o '\--format [^-]*' | cut -d' ' -f2- | tr -d '"')
!COMPRESSION=$(echo "$ARGUMENTS" | grep -o '\--compression [^-]*' | cut -d' ' -f2- | tr -d '"')

# Set defaults for missing parameters
!INPUT_PATTERN=${INPUT_PATTERN:-"*.js"}
!OUTPUT_DIR=${OUTPUT_DIR:-"./dist"}
!FORMAT=${FORMAT:-"minified"}
!COMPRESSION=${COMPRESSION:-"gzip"}

**Configuration:**
- **Input Pattern:** $INPUT_PATTERN
- **Output Directory:** $OUTPUT_DIR
- **Format:** $FORMAT
- **Compression:** $COMPRESSION

**Processing Steps:**
1. **Find files:** `find . -name "$INPUT_PATTERN"`
2. **Process format:** Apply $FORMAT transformation
3. **Apply compression:** Use $COMPRESSION algorithm
4. **Output location:** Save to $OUTPUT_DIR

!echo "Files matching pattern '$INPUT_PATTERN':"
!find . -name "$INPUT_PATTERN" | head -10

**Processing recommendations:**
- For production builds, use --format minified --compression gzip
- For development, use --format readable --compression none  
- Large projects benefit from --compression brotli
```

**Usage Examples:**
```bash
# Basic usage with defaults
/user:process-files

# Specify input pattern and output
/user:process-files --pattern "*.ts" --output "./build"

# Full configuration
/user:process-files --pattern "*.js" --output "./dist" --format minified --compression brotli

# Development mode
/user:process-files --pattern "src/**/*.js" --format readable --compression none
```

#### Mixed Arguments with Flags

**Code Review Command:**
```markdown
# Comprehensive Code Review

!echo "👀 Code review request: $ARGUMENTS"

# Parse review options
!INCLUDE_SECURITY=$(echo "$ARGUMENTS" | grep -q "\--security" && echo "true" || echo "false")
!INCLUDE_PERFORMANCE=$(echo "$ARGUMENTS" | grep -q "\--performance" && echo "true" || echo "false")
!INCLUDE_STYLE=$(echo "$ARGUMENTS" | grep -q "\--style" && echo "true" || echo "false")
!QUICK_REVIEW=$(echo "$ARGUMENTS" | grep -q "\--quick" && echo "true" || echo "false")

# Extract code content (everything not starting with --)
!CODE_CONTENT=$(echo "$ARGUMENTS" | sed 's/--[a-z-]*//g' | sed 's/^ *//g')

**Review Configuration:**
- **Security Analysis:** $INCLUDE_SECURITY
- **Performance Review:** $INCLUDE_PERFORMANCE  
- **Style Check:** $INCLUDE_STYLE
- **Quick Mode:** $QUICK_REVIEW

**Code to Review:**
```
$CODE_CONTENT
```

**Review Focus Areas:**

!if [ "$INCLUDE_SECURITY" = "true" ]; then
  echo "🔒 **Security Analysis:**"
  echo "- Input validation and sanitization"
  echo "- Authentication and authorization"
  echo "- SQL injection prevention"
  echo "- XSS protection"
  echo ""
fi

!if [ "$INCLUDE_PERFORMANCE" = "true" ]; then
  echo "⚡ **Performance Review:**"
  echo "- Algorithm efficiency"
  echo "- Memory usage optimization"
  echo "- Database query optimization"
  echo "- Caching opportunities"
  echo ""
fi

!if [ "$INCLUDE_STYLE" = "true" ]; then
  echo "🎨 **Style & Readability:**"
  echo "- Code formatting consistency"
  echo "- Naming conventions"
  echo "- Comment quality"
  echo "- Function/class structure"
  echo ""
fi

!if [ "$QUICK_REVIEW" = "true" ]; then
  echo "⚡ **Quick Review Mode:** Focusing on critical issues only"
fi

Provide detailed analysis based on the selected review areas.
```

**Usage Examples:**
```bash
# Full review
/user:review "function processData(input) { return input.map(x => x * 2); }" --security --performance --style

# Security-focused review
/user:review "SELECT * FROM users WHERE id = $userId" --security

# Quick style check
/user:review "const user = { name: 'john', age: 30 };" --style --quick
```

### Flag Parsing Best Practices

#### Robust Flag Detection

**Enhanced Flag Parsing:**
```markdown
# Advanced Flag Parser

!echo "🔧 Parsing command: $ARGUMENTS"

# Function to extract flag values
!extract_flag_value() {
  local flag_name="$1"
  local args="$2"
  echo "$args" | grep -o "\--$flag_name [^-]*" | cut -d' ' -f2- | tr -d '"'
}

# Function to check boolean flags
!has_flag() {
  local flag_name="$1" 
  local args="$2"
  echo "$args" | grep -q "\--$flag_name" && echo "true" || echo "false"
}

# Parse all flags
!VERBOSE=$(has_flag "verbose" "$ARGUMENTS")
!DRY_RUN=$(has_flag "dry-run" "$ARGUMENTS") 
!OUTPUT_FILE=$(extract_flag_value "output" "$ARGUMENTS")
!LOG_LEVEL=$(extract_flag_value "log-level" "$ARGUMENTS")

# Set defaults
!OUTPUT_FILE=${OUTPUT_FILE:-"output.txt"}
!LOG_LEVEL=${LOG_LEVEL:-"info"}

**Parsed Configuration:**
- **Verbose Mode:** $VERBOSE
- **Dry Run:** $DRY_RUN
- **Output File:** $OUTPUT_FILE
- **Log Level:** $LOG_LEVEL

!if [ "$VERBOSE" = "true" ]; then
  echo "🔍 Verbose logging enabled"
fi

!if [ "$DRY_RUN" = "true" ]; then
  echo "🏃 Dry run mode - no actual changes will be made"
fi
```

#### Error Handling for Flags

**Flag Validation:**
```markdown
# Validate required parameters
!if [ -z "$OUTPUT_FILE" ]; then
  echo "❌ Error: --output flag is required"
  echo "Usage: /user:command --output filename [--verbose] [--dry-run]"
  exit 1
fi

# Validate enum values
!case "$LOG_LEVEL" in
  debug|info|warn|error)
    echo "✅ Valid log level: $LOG_LEVEL"
    ;;
  *)
    echo "❌ Error: Invalid log level '$LOG_LEVEL'"
    echo "Valid options: debug, info, warn, error"
    exit 1
    ;;
esac
```

---

## YAML Frontmatter Reference

*Official configuration options and community patterns*

### What YAML Frontmatter Actually Supports

**🟢 Officially Supported Options:**

```yaml
---
allowed-tools: ["Bash(git add:*)", "Bash(git status:*)"]
description: "Create a git commit"
---
```

**`allowed-tools`**: 
- Restricts which tools the command can use
- Format: `["Bash(command:pattern)", "ToolName"]`
- Example: `["Bash(git add:*)", "Bash(git status:*)"]`

**`description`**:
- Brief description of what the command does
- Single line of text
- Example: `"Create a git commit"`

### ⚠️ **Important Limitations**

**These features are NOT officially supported:**
- ❌ Versioning (`version`, `changelog`)
- ❌ Metadata (`author`, `category`, `tags`)  
- ❌ Execution parameters (`timeout`, `max-arguments`)
- ❌ Team collaboration (`requires-review`, `reviewers`)
- ❌ Environment settings (`working-directory`, `shell`)
- ❌ Complex configuration options

### Community Patterns (Use with Caution)

Some community examples show additional YAML fields, but these are **not processed by Claude Code** and serve only as documentation:

```yaml
---
# Officially supported
allowed-tools: ["Bash(git add:*)"]
description: "Git commit helper"

# Community documentation (not processed by Claude Code)
# version: "1.0.0"  
# author: "team@company.com"
# category: "git"
---
```

### Official Example from Anthropic Documentation

```yaml
---
allowed-tools: ["Bash(git add:*)", "Bash(git status:*)"]
description: "Create a git commit"
---

## Context
- Current git status: !`git status`
- Current branch: !`git branch --show-current`

## Your task
Based on the changes, create a single git commit.
```

This shows the complete YAML frontmatter capabilities currently supported by Claude Code.

---

## Dynamic Content Features

### Context Preparation with Shell Commands

**⚠️ Important**: The `!` syntax runs bash commands **before** the command is sent to Claude, including their output in the command context. This is **context preparation**, not runtime execution.

#### How Context Preparation Works
```markdown
# System Information Command

Current system status:

**Date & Time:** !date
**Current User:** !whoami  
**Working Directory:** !pwd
**Git Branch:** !git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "Not a git repository"

**Your request:** $ARGUMENTS
```

**What happens:**
1. `!date`, `!whoami`, `!pwd`, and `!git rev-parse...` are executed **before** sending to Claude
2. Their output is included in the command text
3. Claude receives the command with the actual values filled in

#### Official Example from Anthropic
```markdown
---
allowed-tools: ["Bash(git add:*)", "Bash(git status:*)"]
description: "Create a git commit"
---

## Context
- Current git status: !`git status`
- Current branch: !`git branch --show-current`

## Your task
Based on the changes, create a single git commit.
```

**Note**: The backtick syntax `!`git command`` is used in the official example.

### File Content Inclusion

#### Static File References
```markdown
# Code Review with Style Guide

Review this code against our style guide:

**Our Style Guide:**
@docs/STYLE_GUIDE.md

**Code to Review:**
$ARGUMENTS

Compare the provided code against our established standards and provide specific feedback.
```

#### Dynamic File Discovery
```markdown
# Project Documentation Review

!echo "📚 Available documentation files:"
!find . -name "*.md" -not -path "./node_modules/*" | head -10

**Package Information:**
@package.json

**Main README:**
@README.md

**Your documentation request:** $ARGUMENTS

Analyze documentation completeness and suggest improvements.
```

### Environment Variable Integration

#### Reading Environment Variables
```markdown
# Environment-Aware Development Helper

**Development Environment:**
- **Node Environment:** ${NODE_ENV:-development}
- **Project Name:** ${PROJECT_NAME:-unknown-project}
- **Debug Level:** ${DEBUG_LEVEL:-info}
- **API Endpoint:** ${API_ENDPOINT:-http://localhost:3000}

**Your Request:** $ARGUMENTS

!if [ "$NODE_ENV" = "production" ]; then
  echo "⚠️ **Production Environment Detected**"
  echo "Please ensure extra caution with any changes."
else
  echo "✅ **Development Environment**"
  echo "Safe to experiment and test changes."
fi

Provide analysis appropriate for the current environment.
```

#### Setting Command-Specific Variables
```markdown
---
environment:
  ANALYSIS_DEPTH: "comprehensive"
  SECURITY_LEVEL: "strict"
  OUTPUT_FORMAT: "detailed"
---

# Security Analysis

**Configuration:**
- **Analysis Depth:** ${ANALYSIS_DEPTH}
- **Security Level:** ${SECURITY_LEVEL}
- **Output Format:** ${OUTPUT_FORMAT}

**Target for Analysis:** $ARGUMENTS

!case "${SECURITY_LEVEL}" in
  "strict")
    echo "🔒 Performing strict security analysis..."
    ;;
  "standard")
    echo "🔍 Performing standard security review..."
    ;;
  "basic")
    echo "👀 Performing basic security check..."
    ;;
esac
```

### Conditional Logic and Templates

#### Simple Conditionals
```markdown
# Smart Code Analysis

!echo "🔍 Analyzing: $ARGUMENTS"

# Detect file type and adjust analysis
!FILE_TYPE=$(echo "$ARGUMENTS" | grep -o '\.[^.]*$' | tr -d '.')

!case "$FILE_TYPE" in
  "js"|"jsx")
    echo "📄 **JavaScript/JSX File Detected**"
    echo "- Focus on ES6+ features and React patterns"
    echo "- Check for proper error handling"
    echo "- Validate async/await usage"
    ;;
  "ts"|"tsx")
    echo "📘 **TypeScript File Detected**"
    echo "- Verify type definitions and interfaces"
    echo "- Check for proper generics usage"
    echo "- Validate strict mode compliance"
    ;;
  "py")
    echo "🐍 **Python File Detected**"
    echo "- Check PEP 8 compliance"
    echo "- Verify proper imports and dependencies"
    echo "- Validate error handling patterns"
    ;;
  *)
    echo "📝 **Generic Code Analysis**"
    echo "- Focus on general code quality"
    echo "- Check for common patterns and anti-patterns"
    ;;
esac

**Code to Analyze:** $ARGUMENTS
```

#### Advanced Template Logic
```markdown
# Adaptive Development Helper

!COMPLEXITY_LEVEL="$1"  # First word of arguments
!REMAINING_ARGS=$(echo "$ARGUMENTS" | sed 's/^[^ ]* *//')

!case "$COMPLEXITY_LEVEL" in
  "beginner")
    echo "🌱 **Beginner Mode Activated**"
    echo "- Detailed explanations provided"
    echo "- Basic concepts highlighted"
    echo "- Step-by-step guidance included"
    ;;
  "intermediate")
    echo "📚 **Intermediate Mode Activated**"
    echo "- Focused on best practices"
    echo "- Common pitfalls highlighted"
    echo "- Optimization suggestions included"
    ;;
  "advanced")
    echo "🚀 **Advanced Mode Activated**"
    echo "- Deep technical analysis"
    echo "- Performance optimization focus"
    echo "- Architecture patterns discussed"
    ;;
  *)
    echo "🎯 **Auto-Detection Mode**"
    echo "- Analyzing complexity automatically"
    COMPLEXITY_LEVEL="auto"
    REMAINING_ARGS="$ARGUMENTS"
    ;;
esac

**Analysis Target:** $REMAINING_ARGS

!if [ "$COMPLEXITY_LEVEL" = "auto" ]; then
  echo "**Detecting complexity level from code patterns...**"
fi
```

---

## Security & Best Practices

### Safe Shell Execution

#### Input Sanitization
```markdown
# Secure File Processor

!echo "🔒 Sanitizing input: $ARGUMENTS"

# Remove potentially dangerous characters
!SAFE_INPUT=$(echo "$ARGUMENTS" | sed 's/[;&|`$(){}]/\\_/g')

!if [ "$SAFE_INPUT" != "$ARGUMENTS" ]; then
  echo "⚠️ Warning: Potentially unsafe characters detected and sanitized"
  echo "Original: $ARGUMENTS"
  echo "Sanitized: $SAFE_INPUT"
fi

**Processing:** $SAFE_INPUT
```

#### Privilege Limitation
```yaml
---
# Restrict command to safe operations only
allowed-tools: ["read", "grep"]       # Only reading and searching
denied-tools: ["write", "edit", "bash", "websocket"]  # No modifications or network

# Additional security
timeout: 30000                        # Prevent long-running operations
max-arguments: 5                      # Limit complexity
environment:
  SAFE_MODE: "true"                   # Enable safe mode
---
```

#### Safe Pattern Examples
```markdown
# Secure Code Analysis

!echo "🛡️ Starting secure analysis..."

# Use read-only operations
!echo "File exists check: $(test -r "$ARGUMENTS" && echo "✅ Readable" || echo "❌ Not accessible")"

# Avoid direct execution of user input
!FILENAME="$ARGUMENTS"
!echo "Analyzing: $FILENAME"

# Use safe commands only
!grep -n "function\|class\|const\|let" "$FILENAME" 2>/dev/null | head -10

**Analysis complete - no system modifications made**
```

### Input Validation Patterns

#### Comprehensive Validation
```markdown
# Input Validation Example

!echo "🔍 Validating input: $ARGUMENTS"

# Check if input is provided
!if [ -z "$ARGUMENTS" ]; then
  echo "❌ Error: No input provided"
  echo "Usage: /user:command 'your input here'"
  exit 1
fi

# Check input length
!INPUT_LENGTH=$(echo "$ARGUMENTS" | wc -c)
!if [ "$INPUT_LENGTH" -gt 1000 ]; then
  echo "❌ Error: Input too long (max 1000 characters)"
  exit 1
fi

# Check for required patterns
!if ! echo "$ARGUMENTS" | grep -q "^[a-zA-Z0-9._-]*$"; then
  echo "⚠️ Warning: Input contains special characters"
  echo "Allowed: letters, numbers, dots, hyphens, underscores"
fi

**Validated Input:** $ARGUMENTS
```

#### File Path Security
```markdown
# Secure File Path Handling

!FILEPATH="$ARGUMENTS"

# Prevent directory traversal
!if echo "$FILEPATH" | grep -q "\.\."; then
  echo "❌ Error: Directory traversal attempt detected"
  echo "Path contains '..' which is not allowed"
  exit 1
fi

# Ensure file is in allowed directory
!if ! echo "$FILEPATH" | grep -q "^\.\/src\/\|^src\/"; then
  echo "❌ Error: File must be in src/ directory"
  echo "Provided path: $FILEPATH"
  exit 1
fi

# Validate file extension
!case "$FILEPATH" in
  *.js|*.ts|*.jsx|*.tsx|*.css|*.scss)
    echo "✅ Valid file type detected"
    ;;
  *)
    echo "⚠️ Warning: Unusual file extension"
    ;;
esac

**Secure file path:** $FILEPATH
```

### Cross-Platform Security

#### Platform-Safe Commands
```markdown
# Cross-Platform File Operations

!echo "🌐 Detecting platform..."

# Use portable commands
!PLATFORM=$(uname -s 2>/dev/null || echo "Unknown")

!case "$PLATFORM" in
  "Darwin")
    echo "🍎 macOS detected"
    FILE_COUNT=$(find . -name "*.js" | wc -l | tr -d ' ')
    ;;
  "Linux")
    echo "🐧 Linux detected"
    FILE_COUNT=$(find . -name "*.js" | wc -l | tr -d ' ')
    ;;
  "MINGW"*|"CYGWIN"*|"MSYS"*)
    echo "🪟 Windows detected"
    FILE_COUNT=$(find . -name "*.js" 2>/dev/null | wc -l | tr -d ' ')
    ;;
  *)
    echo "❓ Unknown platform: $PLATFORM"
    FILE_COUNT="unknown"
    ;;
esac

**JavaScript files found:** $FILE_COUNT

**Your request:** $ARGUMENTS
```

---

## Troubleshooting & Debugging

### Common Syntax Issues

#### Parameter Problems
```markdown
**Issue:** `$ARGUMENTS` appears literally in output
**Cause:** Variable substitution not working
**Solutions:**
1. Check file is saved as .md extension
2. Verify command discovery with /user:list or /project:list  
3. Restart Claude Code session
4. Check file permissions (should be readable)

**Issue:** Multi-word arguments not working
**Cause:** Improper quoting
**Solutions:**
✅ Correct: /user:command "multiple words here"
❌ Incorrect: /user:command multiple words here
```

#### YAML Frontmatter Issues
```yaml
# ❌ INVALID YAML - Will cause errors
---
version: 1.0.0          # Missing quotes for version
description: Multi-line
description continues   # Invalid multi-line syntax
allowed-tools:          # Missing list format
  read
  bash
---

# ✅ VALID YAML - Correct format  
---
version: "1.0.0"        # Quoted version string
description: "Multi-line description using proper YAML syntax"
allowed-tools:          # Proper list format
  - "read"
  - "bash"
---
```

#### Shell Command Issues
```markdown
**Issue:** Shell commands (!command) not executing
**Cause:** Various platform or permission issues
**Debug Steps:**
1. Test command manually: `date`
2. Check permissions: `which date`
3. Verify shell availability: `echo $SHELL`
4. Try simple command first: `!echo "test"`

**Issue:** Complex shell commands failing
**Cause:** Shell syntax errors or missing tools
**Solutions:**
- Break complex commands into simpler parts
- Test each part individually
- Use proper shell escaping
- Check tool availability with `which command`
```

### Debugging Techniques

#### Debug Mode Command
```markdown
---
version: "1.0.0-debug"
description: "Debug mode for troubleshooting command issues"
---

# Command Debugger

!echo "🐛 DEBUG MODE ACTIVATED"
!echo "===================="

**Environment Info:**
- **Shell:** !echo $SHELL
- **Platform:** !uname -s 2>/dev/null || echo "Unknown"  
- **Working Directory:** !pwd
- **Current User:** !whoami
- **Date/Time:** !date

**Input Analysis:**
- **Raw Arguments:** [$ARGUMENTS]
- **Argument Count:** !echo "$ARGUMENTS" | wc -w
- **Character Count:** !echo "$ARGUMENTS" | wc -c

**File System Check:**
- **Current Directory Contents:** !ls -la | head -5
- **Command File Location:** !find ~/.claude/commands -name "*.md" | head -3

**Git Context (if available):**
- **Repository:** !git rev-parse --show-toplevel 2>/dev/null || echo "Not a git repository"
- **Branch:** !git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "No git info"

**Process Your Request:** $ARGUMENTS
```

#### Validation Command
```markdown
# Command Syntax Validator

!echo "✅ Command validation starting..."

# Test basic functionality
!echo "✓ Shell execution working"

# Test variable substitution
!if [ -n "$ARGUMENTS" ]; then
  echo "✓ Arguments received: [$ARGUMENTS]"
else
  echo "⚠️ No arguments provided"
fi

# Test file operations
!if [ -r "package.json" ]; then
  echo "✓ File reading capability confirmed"
else
  echo "⚠️ No package.json found (normal for non-Node projects)"
fi

# Test git integration
!if git rev-parse --git-dir >/dev/null 2>&1; then
  echo "✓ Git repository detected"
  echo "  Branch: $(git rev-parse --abbrev-ref HEAD)"
else
  echo "⚠️ Not in a git repository"
fi

**Validation Summary:**
- Command structure: ✅ Valid
- Variable substitution: ✅ Working  
- Shell integration: ✅ Active
- File system access: ✅ Available

**Your request:** $ARGUMENTS
```

### Performance Optimization

#### Efficient Command Patterns
```markdown
# Performance-Optimized Command

!echo "⚡ Optimized execution starting..."

# Cache expensive operations
!if [ ! -f "/tmp/project_stats_cache" ] || [ $(find /tmp/project_stats_cache -mmin +60 2>/dev/null | wc -l) -gt 0 ]; then
  echo "📊 Generating fresh project statistics..."
  find . -name "*.js" | wc -l > /tmp/project_stats_cache
else
  echo "📋 Using cached project statistics..."
fi

!JS_FILE_COUNT=$(cat /tmp/project_stats_cache 2>/dev/null || echo "0")

**Project Stats (cached):**
- **JavaScript Files:** $JS_FILE_COUNT

**Your request:** $ARGUMENTS

# Process efficiently without redundant operations
```

#### Large Project Handling
```markdown
# Large Project Command

!echo "🏗️ Large project optimization enabled..."

# Limit expensive operations
!echo "Sample of JavaScript files (first 10):"
!find . -name "*.js" -not -path "./node_modules/*" | head -10

# Use efficient tools
!echo "Quick file count:"
!find . -name "*.js" -not -path "./node_modules/*" | wc -l

**Note:** Optimized for large codebases - showing sample results only.

**Your request:** $ARGUMENTS
```

---

## Summary

This comprehensive syntax reference covers everything from basic parameter handling to advanced CLI-style patterns. Key takeaways:

### **Essential Syntax Patterns**
1. **Basic Commands** - File structure, naming, and simple `$ARGUMENTS`
2. **Multiple Arguments** - Space-separated and structured parameter handling
3. **CLI-Style Flags** - Boolean flags and named parameters using shell parsing
4. **YAML Configuration** - Versioning, security, and team collaboration settings

### **Advanced Features**
- **Dynamic Content** - Shell execution, file inclusion, environment variables
- **Security Controls** - Input validation, privilege limitation, safe patterns
- **Debugging Tools** - Validation commands, debug modes, performance optimization

### **Best Practices**
- Always validate input for security and reliability
- Use YAML frontmatter for complex commands and team environments
- Implement proper error handling and user feedback
- Design for cross-platform compatibility
- Version your commands for team collaboration

### **Next Steps**
- **[Best Practices Guide](04-best-practices.md)** - Command design principles and optimization
- **[Advanced Patterns](05-advanced.md)** - Complex workflows and meta-commands
- **[Team Collaboration](06-team.md)** - Sharing strategies and standards

Your custom commands can now be as sophisticated as traditional CLI tools while maintaining the simplicity and power of Claude Code integration! 🚀