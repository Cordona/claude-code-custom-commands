# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository is a community-driven knowledge hub and production command library for Claude Code custom commands. It contains battle-tested commands for daily development workflows, comprehensive learning guides, and a collaborative space for command evolution and improvement.

## Core Philosophy

This repository embodies IndyDevDan's principles for modern engineering:
- **Reusable compute assets** - Custom commands that solve problems permanently
- **Prompt-first mindset** - Building workflows instead of repeating manual prompts
- **Control over prompts** - Transparent, non-black-box AI interactions
- **Context priming** - Domain-specific AI guidance

## Architecture & Command Management

### Command Categories
Commands are organized into three main categories:

- **`commands/docs/`**: Documentation generation and management
  - `dev/`: Development journals and progress tracking
  - `feat/`: Feature investigation and documentation  
  - `pr/`: Pull request document generation
- **`commands/exec/`**: Execution and mode management commands
- **`commands/git/`**: Git workflow integration

### Command Management Script
The repository includes a cross-platform management script at `tools/scripts/sh/manage_commands.sh`:

**Usage:**
```bash
# Make executable (first time)
chmod +x tools/scripts/sh/manage_commands.sh

# Run interactively
./tools/scripts/sh/manage_commands.sh
```

**Operations:**
- **Copy**: Transfer production-ready commands from repository to project/global scope
- **Update**: Edit existing commands with automatic backup
- **List**: View commands with professional table formatting
- **Remove**: Safely delete commands with confirmation and backup

### Command Structure
All commands follow consistent YAML frontmatter structure:
- `description`: Clear command purpose
- `allowed-tools`: List of Claude Code tools the command can use
- Usage instructions and comprehensive implementation guidance

### Documentation Reference
- **[Complete Command Reference](commands/info/describe-commands.md)** - Detailed documentation for all available commands
- **[Setup Guide](guides/custom-commands/02-setup.md)** - Environment configuration
- **[Syntax Reference](guides/custom-commands/03-syntax.md)** - Command syntax and structure
- **[Best Practices](guides/custom-commands/05-best-practices.md)** - Professional development guidelines

## Working with This Repository

### No Build System Required
This repository contains only markdown documentation files and bash scripts. No build, test, or lint commands are needed.

### Adding/Modifying Commands
1. Commands are markdown files following pattern: `{category}-{subcategory}-{action}.md`
2. Use the management script to copy commands between scopes
3. Update the command catalog using `/user:custom-command-update` when making changes
4. Follow the established YAML frontmatter structure

### Cross-Platform Compatibility
The management script works on:
- macOS (bash 3.x compatible)
- Linux (all distributions)
- Windows (Git Bash/WSL/Cygwin)
- BSD and Solaris

### Documentation Updates
When modifying commands:
- The custom command update system automatically synchronizes `commands/info/describe-commands.md`
- Maintains table of contents and quick reference table
- Creates backups before modifications
- Generates professional changelogs

## Key Features

### Command Characteristics
- Interactive workflows with step-by-step guidance
- Preview before action - all commands show previews before saving
- Confidence-based detection for updates and changes
- Timestamped outputs with metadata
- Quality checks and validation
- Learning capabilities that adapt to user preferences

### State Management
- Commands use state markers like `[DEEP_THINKING_MODE_ACTIVE]`
- Mode persistence across sessions
- Clean state transitions with `/user:drop-mode`

## Content Generation Transparency

All content in this repository was generated using Claude Code and other LLMs, with manual review and multi-model validation. See `DISCLAIMER.md` for complete methodology and validation process.