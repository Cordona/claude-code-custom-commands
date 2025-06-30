# Claude Code Custom Commands Reference

*Complete catalog of available custom commands with descriptions, usage, and examples*

---

## 🎯 About This Reference

This document serves as the **complete developer reference** for all custom commands in this repository. Each command is battle-tested, production-ready, and designed to enhance your development workflow through intelligent automation.

### How to Use Commands
All commands follow the syntax: `/user:command-name [arguments]`

### Quick Setup
- **New to custom commands?** Start with our [Setup Guide](../../guides/custom-commands/02-setup.md)
- **Want to learn more?** Check the [Complete Guide Series](../../guides/custom-commands/README.md)

---

## 📚 Table of Contents

### 📁 [Documentation Commands](#documentation-commands)
- [`dev-journal-create`](#userdev-journal-create---development-progress-journal-generator) - Generate comprehensive development progress journals
- [`dev-journal-update`](#userdev-journal-update---intelligent-development-journal-updater) - Intelligently update existing development journals
- [`feature-explain`](#userfeature-explain---interactive-feature-documentation-generator) - Generate comprehensive feature documentation
- [`feature-update`](#userfeature-update---intelligent-feature-documentation-updater) - Intelligently update existing feature documentation
- [`pr-create`](#userpr-create---professional-pr-document-generator) - Generate professional PR documentation
- [`pr-update`](#userpr-update---intelligent-pr-document-updater) - Intelligently update existing PR documents

### ⚡ [Execution Commands](#execution-commands)
- [`custom-command-drop`](#usercustom-command-drop---universal-custom-command-mode-exit) - Exit any active custom command mode
- [`deep-think-init`](#userdeep-think-init---deep-thinking-mode-activation) - Activate intelligent deep thinking mode
- [`deep-think-drop`](#userdeep-think-drop---deep-thinking-mode-deactivation) - Deactivate deep thinking mode

### 🔧 [Git Commands](#git-commands)
- [`git-commit`](#usergit-commit---intelligent-commit-message-composer) - Intelligent conventional commit message composer
- [`git-config`](#usergit-config---git-configuration-setup) - Interactive Git user configuration

---

## 📊 Quick Reference Table

| Command | Category | Purpose | Interactive | Complexity |
|---------|----------|---------|-------------|------------|
| `dev-journal-create` | 📁 Docs | Generate development progress journals | ✅ | High |
| `dev-journal-update` | 📁 Docs | Update existing development journals | ✅ | High |
| `feature-explain` | 📁 Docs | Generate feature documentation | ✅ | High |
| `feature-update` | 📁 Docs | Update existing feature documentation | ✅ | High |
| `pr-create` | 📁 Docs | Generate PR documentation | ⚡ | Medium |
| `pr-update` | 📁 Docs | Update existing PR documents | ⚡ | Medium |
| `custom-command-drop` | ⚡ Exec | Exit active command modes | ⚡ | Low |
| `deep-think-init` | ⚡ Exec | Activate deep thinking mode | ✅ | Medium |
| `deep-think-drop` | ⚡ Exec | Deactivate deep thinking mode | ✅ | Low |
| `git-commit` | 🔧 Git | Compose commit messages | ✅ | Medium |
| `git-config` | 🔧 Git | Configure Git settings | ✅ | Medium |

**Legend:** ✅ Interactive | ⚡ Automated

---

# Documentation Commands

*Professional documentation generation and maintenance with intelligent analysis*

## `/user:dev-journal-create` - Development Progress Journal Generator

**Category:** 📁 Documentation > Development Journals  
**Purpose:** Generate comprehensive development progress journals with intelligent mode selection and preview  
**Allowed Tools:** Bash, Read, Write, Grep

### Description
A sophisticated system that analyzes your current development session to create structured documentation that captures progress, decisions, and context for both human developers and AI assistants. Features intelligent complexity detection and adaptive mode selection.

### Key Features
- **🧠 Intelligent Mode Selection** - Automatically detects session complexity and recommends optimal documentation depth
- **📊 Session Analysis** - Analyzes git history, branch context, and file changes
- **🎯 Context Preservation** - Captures development decisions and architectural choices
- **📝 Structured Output** - Generates organized, scannable documentation
- **🔄 Preview Generation** - Shows documentation preview before final creation
- **⚡ Quick Mode** - Streamlined workflow for simple progress updates

### When to Use
- At the end of development sessions to document progress
- Before switching contexts or taking breaks from complex features
- When team members need to understand recent development work
- To create handoff documentation for code reviews
- For capturing architectural decisions and trade-offs

### Usage Examples
```bash
# Generate journal with automatic complexity detection
/user:dev-journal-create

# Quick mode for simple progress updates
/user:dev-journal-create --quick

# Generate journal with specific focus area
/user:dev-journal-create "authentication implementation"
```

### How It Works
1. **Session Analysis** - Examines git branch, recent commits, and file changes
2. **Complexity Detection** - Determines optimal documentation depth based on changes
3. **Mode Recommendation** - Suggests quick vs comprehensive documentation approach
4. **Context Gathering** - Collects relevant development context and decisions
5. **Preview Generation** - Shows structured documentation before final creation
6. **Final Output** - Creates comprehensive development journal with timestamps

### Expected Output
- Structured development journal in `.claude/artifacts/journal/{YYYYMMDD}/` directory
- Executive summary of progress and key decisions
- Technical details of implementation approaches
- Context for future development sessions
- Metadata for session analytics and tracking

---

## `/user:dev-journal-update` - Intelligent Development Journal Updater

**Category:** 📁 Documentation > Development Journals  
**Purpose:** Intelligently update existing development journals with drift detection and change preview  
**Allowed Tools:** Bash, Read, Write, Grep, Glob

### Description
An intelligent system that updates existing development journals by detecting implementation changes and applying sophisticated updates while preserving manual edits. Features advanced drift detection to identify when code has changed since the journal was created.

### Key Features
- **🔍 Automatic Journal Detection** - Finds existing development journals for current branch/context
- **🔄 Drift Detection** - Identifies changes between documented state and current implementation
- **📝 Smart Updates** - Preserves manual edits while updating outdated sections
- **👁️ Change Preview** - Shows what will be updated before applying changes
- **📊 Git Integration** - Analyzes git history and current branch state
- **🧠 Intelligent Merging** - Sophisticated logic to merge new content with existing documentation

### When to Use
- When you've made significant progress on a feature since creating the development journal
- To keep documentation in sync with implementation changes
- When team members need updated context on current development state
- Before code reviews to ensure documentation reflects current reality
- After major refactoring or architectural changes

### Usage Examples
```bash
# Update journal for current branch automatically
/user:dev-journal-update

# Update specific journal file
/user:dev-journal-update path/to/journal.md

# Update with drift analysis focus
/user:dev-journal-update --analyze-drift
```

### How It Works
1. **Detects Context** - Analyzes current git branch and recent commits
2. **Locates Journal** - Finds existing development journal for the current work
3. **Analyzes Changes** - Compares documented state with current implementation
4. **Previews Updates** - Shows proposed changes before applying
5. **Smart Merge** - Updates outdated sections while preserving manual additions
6. **Validates Result** - Ensures updated journal maintains quality and coherence

### Expected Output
- Updated development journal with current implementation state
- Preserved manual edits and custom sections
- Change summary showing what was updated
- Confidence indicators for automated changes
- Drift analysis report highlighting implementation evolution

---

## `/user:feature-explain` - Interactive Feature Documentation Generator

**Category:** 📁 Documentation > Feature Documentation  
**Purpose:** Generate comprehensive feature documentation with intelligent discovery and configurable depth  
**Allowed Tools:** Bash, Read, Write, Grep, Glob

### Description
An interactive system that discovers and analyzes requested features to create comprehensive documentation suitable for onboarding and AI context. Uses multiple intelligent strategies to understand feature components and generate thorough documentation.

### Key Features
- **🔍 Intelligent Discovery** - Multi-strategy search to find all feature components
- **🗂️ Component Analysis** - Identifies files, functions, and dependencies related to the feature
- **📚 Comprehensive Documentation** - Generates thorough feature knowledge capsules
- **🎯 Configurable Depth** - Adjustable documentation detail based on needs
- **🔗 Cross-Reference Mapping** - Links related components and dependencies
- **📝 Onboarding Ready** - Creates documentation suitable for new team members

### When to Use
- When onboarding new team members to specific features
- To understand complex or unfamiliar features in the codebase
- Before modifying existing features to understand current implementation
- For creating AI context about specific system components
- When documenting features for architectural reviews

### Usage Examples
```bash
# Discover and document a feature interactively
/user:feature-explain

# Document specific feature with prompt
/user:feature-explain "authentication system"

# Generate comprehensive feature documentation
/user:feature-explain "JWT handling" --depth=comprehensive
```

### How It Works
1. **Feature Discovery** - Uses multiple search strategies to locate feature components
2. **Component Analysis** - Examines code structure, dependencies, and relationships
3. **Context Gathering** - Collects usage patterns, configuration, and examples
4. **Documentation Generation** - Creates structured feature knowledge capsule
5. **Cross-Reference Mapping** - Links related components and dependencies
6. **Quality Review** - Validates completeness and accuracy of documentation

### Expected Output
- Comprehensive feature documentation in `.claude/artifacts/features/` directory
- Component inventory with file locations and purposes
- Usage patterns and configuration examples
- Architecture overview and data flow diagrams
- Integration points and dependency mapping
- Onboarding guide for developers working with the feature

---

## `/user:feature-update` - Intelligent Feature Documentation Updater

**Category:** 📁 Documentation > Feature Documentation  
**Purpose:** Intelligently update existing feature documentation with drift detection and change preview  
**Allowed Tools:** Bash, Read, Write, Grep, Glob

### Description
An intelligent system that updates existing feature documentation by detecting implementation changes and applying sophisticated updates while preserving manual edits. Maintains feature documentation accuracy as code evolves.

### Key Features
- **📍 Document Location** - Intelligently finds existing feature documentation
- **🔄 Implementation Drift** - Detects changes in feature implementation since documentation
- **📝 Smart Updates** - Preserves manual sections while updating outdated information
- **👁️ Change Preview** - Shows proposed updates before applying changes
- **🧠 Intelligent Analysis** - Understands which sections need updates vs preservation
- **📊 Evolution Tracking** - Documents how features have changed over time

### When to Use
- After significant changes to existing features
- When feature documentation becomes outdated
- Before feature reviews or architectural discussions
- To maintain documentation accuracy in evolving codebases
- When onboarding materials need refreshing

### Usage Examples
```bash
# Update feature documentation automatically
/user:feature-update

# Update specific feature documentation
/user:feature-update path/to/feature-doc.md

# Update with implementation analysis
/user:feature-update "user authentication" --analyze-changes
```

### How It Works
1. **Locates Documentation** - Finds existing feature documentation files
2. **Analyzes Implementation** - Examines current feature code and structure
3. **Detects Drift** - Compares documented vs actual implementation
4. **Previews Changes** - Shows what sections will be updated
5. **Smart Update** - Applies changes while preserving manual content
6. **Validates Result** - Ensures updated documentation maintains quality

### Expected Output
- Updated feature documentation reflecting current implementation
- Preserved manual sections and custom content
- Change summary highlighting what was modified
- Implementation evolution notes
- Updated component inventory and relationships

---

## `/user:pr-create` - Professional PR Document Generator

**Category:** 📁 Documentation > Pull Request Documentation  
**Purpose:** Generate professional PR documentation with git analysis and optional test execution  
**Allowed Tools:** Bash, Write, Read

### Description
A professional system that analyzes current git changes and generates comprehensive PR documentation. Creates structured pull request documents with technical details, testing information, and reviewer guidance.

### Key Features
- **📊 Git Analysis** - Analyzes branch changes, commit history, and file modifications
- **📋 Professional Format** - Generates structured PR documents following best practices
- **🧪 Test Integration** - Optional test execution and results inclusion
- **📝 Change Summary** - Clear explanation of what was changed and why
- **🎯 Reviewer Guidance** - Helps reviewers understand changes and focus areas
- **⚡ Quick Generation** - Rapid PR document creation for efficient workflows

### When to Use
- Before creating pull requests to document changes professionally
- When changes are complex and need detailed explanation
- For teams requiring structured PR documentation
- To improve code review efficiency and quality
- When working with distributed teams needing context

### Usage Examples
```bash
# Generate PR documentation for current branch
/user:pr-create

# Generate with test execution
/user:pr-create --run-tests

# Create PR doc with specific focus
/user:pr-create "authentication improvements"
```

### How It Works
1. **Branch Analysis** - Examines current branch changes and commit history
2. **Change Assessment** - Categorizes modifications and impact analysis
3. **Context Gathering** - Collects relevant technical details and rationale
4. **Test Execution** - Optionally runs tests and includes results
5. **Document Generation** - Creates structured PR documentation
6. **Review Preparation** - Adds reviewer guidance and focus areas

### Expected Output
- Professional PR document in `.claude/artifacts/pr/{YYYYMMDD}/` directory
- Executive summary of changes and impact
- Technical implementation details
- Test results and validation information
- Reviewer checklist and focus areas
- Deployment and rollback considerations

---

## `/user:pr-update` - Intelligent PR Document Updater

**Category:** 📁 Documentation > Pull Request Documentation  
**Purpose:** Intelligently update existing PR documents with smart detection and change preview  
**Allowed Tools:** Bash, Write, Read

### Description
An intelligent system that detects existing PR documents and updates them with new changes while preserving manual edits. Maintains PR documentation accuracy as branches evolve during review cycles.

### Key Features
- **🔍 Document Detection** - Automatically finds existing PR documentation for current branch
- **📊 Change Analysis** - Detects new commits and modifications since last update
- **📝 Smart Updates** - Updates technical details while preserving manual reviewer feedback
- **👁️ Change Preview** - Shows what will be updated before applying changes
- **🧠 Intelligent Merging** - Sophisticated logic to merge new content with existing documentation
- **📈 Evolution Tracking** - Documents how the PR has evolved during review

### When to Use
- After making changes during PR review cycles
- When addressing reviewer feedback and updating documentation
- To keep PR documentation current with branch evolution
- When additional commits are added to existing pull requests
- For maintaining accurate PR records throughout review process

### Usage Examples
```bash
# Update PR documentation automatically
/user:pr-update

# Update specific PR document
/user:pr-update path/to/pr-doc.md

# Update with change analysis
/user:pr-update --analyze-evolution
```

### How It Works
1. **Detects Context** - Analyzes current git branch and recent changes
2. **Locates PR Doc** - Finds existing PR documentation for the branch
3. **Analyzes Evolution** - Compares current state with documented state
4. **Previews Updates** - Shows proposed changes before applying
5. **Smart Merge** - Updates outdated sections while preserving manual content
6. **Validates Result** - Ensures updated documentation maintains quality

### Expected Output
- Updated PR documentation reflecting latest changes
- Preserved manual sections and reviewer feedback
- Change evolution summary
- Updated impact analysis and technical details
- Revised reviewer guidance based on changes

---

# Execution Commands

*Mode management and workflow control for enhanced development experience*

## `/user:custom-command-drop` - Universal Custom Command Mode Exit

**Category:** ⚡ Execution > Mode Management  
**Purpose:** Exit any active custom command mode and restore Claude to default behavior  
**Allowed Tools:** Read

### Description
A universal system for detecting and terminating any active custom command modes to restore clean default Claude behavior. Safely exits all active modes while preserving session context and preferences.

### Key Features
- **🔍 Mode Detection** - Automatically detects all active custom command modes
- **🧹 Clean Exit** - Safely terminates modes without losing session context
- **📊 Mode Inventory** - Reports which modes were active before termination
- **⚡ Universal Coverage** - Handles all custom command mode types
- **🛡️ Safe Operation** - Preserves preferences and learned behaviors
- **📝 Exit Summary** - Provides clear confirmation of mode changes

### When to Use
- When you want to return to standard Claude behavior
- If custom command modes become unresponsive or problematic
- Before switching to different types of interactions
- When troubleshooting custom command issues
- To reset Claude to a clean state for new tasks

### Usage Examples
```bash
# Exit all active custom command modes
/user:custom-command-drop

# Drop modes with status report
/user:custom-command-drop --status

# Force exit all modes
/user:custom-command-drop --force
```

### How It Works
1. **Mode Scanning** - Detects active custom command mode indicators
2. **Mode Identification** - Catalogs which specific modes are running
3. **Safe Termination** - Gracefully exits each active mode
4. **Context Preservation** - Maintains session preferences and learned behaviors
5. **Status Reporting** - Confirms successful mode termination
6. **Clean State** - Restores default Claude behavior

### Expected Output
- Confirmation of modes that were terminated
- Summary of session context preserved
- Clean restoration to default Claude behavior
- Status report of any preferences maintained
- Ready state for new interactions or different command types

---

## `/user:deep-think-init` - Deep Thinking Mode Activation

**Category:** ⚡ Execution > Mode Management  
**Purpose:** Activate intelligent deep thinking mode with adaptive complexity detection and learning capabilities  
**Allowed Tools:** Read, Write

### Description
Activates an intelligent reasoning system that applies enhanced cognitive effort based on query complexity while learning your preferences over time. Features adaptive complexity detection, traffic light cognitive state indicators, and preference learning.

### Key Features
- **🧠 Complexity Detection** - Automatically detects query complexity and applies appropriate thinking depth
- **🚦 Traffic Light System** - Visual indicators (🔴🟡🟢) show cognitive state and thinking intensity
- **📚 Preference Learning** - Adapts to your communication style and thinking preferences over time
- **⚙️ Configurable Complexity** - Adjustable thinking thresholds for different types of work
- **📊 Session Analytics** - Tracks thinking patterns and preference evolution
- **🎯 Mode Persistence** - Maintains deep thinking state across conversation turns

### When to Use
- For complex problem-solving requiring deeper analysis
- When working on architectural decisions or system design
- For challenging debugging or troubleshooting sessions
- During learning sessions requiring thorough explanations
- When you want more thoughtful, considered responses

### Usage Examples
```bash
# Activate with automatic complexity detection
/user:deep-think-init

# Activate with specific complexity level
/user:deep-think-init --complexity=high

# Activate with learning mode enabled
/user:deep-think-init --learn-preferences
```

### How It Works
1. **System Initialization** - Activates deep thinking cognitive engine
2. **Complexity Calibration** - Sets up adaptive complexity detection thresholds
3. **Preference Loading** - Retrieves learned preferences from previous sessions
4. **Mode Activation** - Establishes persistent deep thinking state
5. **Status Monitoring** - Begins tracking cognitive state and patterns
6. **Ready State** - Confirms active deep thinking mode with visual indicators

### Expected Output
- Deep thinking mode activation confirmation with 🧠 indicator
- Traffic light system status (🔴🟡🟢) showing current cognitive state
- Complexity detection engine status and thresholds
- Learning system activation and preference loading status
- Session analytics initialization
- Mode persistence confirmation across conversation turns

---

## `/user:deep-think-drop` - Deep Thinking Mode Deactivation

**Category:** ⚡ Execution > Mode Management  
**Purpose:** Deactivate deep thinking mode while preserving learned preferences and offering optional analytics  
**Allowed Tools:** Write

### Description
Gracefully deactivates the intelligent deep thinking mode while preserving learned preferences for future sessions. Offers optional session analytics and maintains preference learning for improved future interactions.

### Key Features
- **🧹 Graceful Deactivation** - Safely terminates deep thinking mode without data loss
- **💾 Preference Preservation** - Saves learned preferences and patterns for future sessions
- **📊 Session Analytics** - Optional detailed analytics of thinking patterns and complexity handling
- **🎯 Learning Retention** - Maintains preference learning improvements
- **📈 Progress Tracking** - Shows how thinking preferences evolved during session
- **⚡ Clean Exit** - Returns to standard response mode efficiently

### When to Use
- When switching from complex to simple tasks
- To return to faster response times for routine queries
- Before ending work sessions to preserve learning progress
- When deep thinking mode is no longer needed
- To review session analytics and thinking patterns

### Usage Examples
```bash
# Deactivate with preference preservation
/user:deep-think-drop

# Deactivate with session analytics
/user:deep-think-drop --show-analytics

# Quick deactivation without reports
/user:deep-think-drop --quick
```

### How It Works
1. **Mode Detection** - Confirms deep thinking mode is currently active
2. **Preference Saving** - Preserves learned communication and thinking preferences
3. **Analytics Generation** - Compiles optional session statistics and patterns
4. **Graceful Shutdown** - Safely terminates deep thinking cognitive processes
5. **Learning Retention** - Ensures preference improvements are maintained
6. **Standard Mode** - Returns to default Claude response behavior

### Expected Output
- Deep thinking mode deactivation confirmation
- Preference preservation status and saved learning progress
- Optional session analytics showing thinking patterns and complexity handling
- Summary of cognitive state changes during the session
- Confirmation of return to standard response mode
- Retained learning status for future deep thinking sessions

---

# Git Commands

*Intelligent Git workflow integration with analysis and automation*

## `/user:git-commit` - Intelligent Commit Message Composer

**Category:** 🔧 Git > Workflow Integration  
**Purpose:** Intelligent conventional commit message composer with git analysis  
**Allowed Tools:** Bash, Read

### Description
An intelligent system that analyzes current git changes to compose optimal conventional commit messages. Examines staged changes, extracts context from branch names, and generates high-quality commit messages following conventional commit standards.

### Key Features
- **📊 Git Analysis** - Analyzes staged changes, file modifications, and repository state
- **🎯 Conventional Commits** - Generates properly formatted conventional commit messages
- **🔍 Context Extraction** - Extracts ticket numbers and context from branch names
- **📝 Quality Validation** - Ensures commit messages meet quality standards
- **🧠 Smart Categorization** - Automatically determines commit type (feat, fix, docs, etc.)
- **⚡ Interactive Refinement** - Allows message refinement before committing

### When to Use
- Before making commits to ensure high-quality commit messages
- When working with teams requiring conventional commit standards
- For maintaining clean, searchable git history
- When commit messages need to integrate with ticketing systems
- To improve code review and change tracking efficiency

### Usage Examples
```bash
# Analyze changes and generate commit message
/user:git-commit

# Generate commit with specific type
/user:git-commit --type=feat

# Interactive commit message composition
/user:git-commit --interactive
```

### How It Works
1. **Repository Analysis** - Examines git status, staged changes, and diff statistics
2. **Context Extraction** - Analyzes branch name for ticket numbers and context
3. **Change Categorization** - Determines appropriate commit type and scope
4. **Message Composition** - Generates conventional commit message
5. **Quality Validation** - Checks message against best practices
6. **Interactive Refinement** - Allows user review and modification before commit

### Expected Output
- Properly formatted conventional commit message
- Analysis of changes and their scope
- Extracted context from branch names and tickets
- Quality validation results
- Option to refine message before committing
- Integration with git commit workflow

---

## `/user:git-config` - Git Configuration Setup

**Category:** 🔧 Git > Workflow Integration  
**Purpose:** Interactive Git user configuration with identity setup and GPG signing  
**Allowed Tools:** Bash

### Description
An interactive system for comprehensive Git configuration including user identity setup, GPG signing configuration, and repository-specific settings. Provides guided setup for optimal Git workflow configuration.

### Key Features
- **👤 Identity Configuration** - Sets up user.name and user.email with validation
- **🔐 GPG Signing Setup** - Configures commit signing with GPG keys
- **🎯 Repository Context** - Handles both global and repository-specific configuration
- **🔍 Current State Analysis** - Analyzes existing configuration before changes
- **⚙️ Team Requirements** - Considers team and organizational Git standards
- **✅ Configuration Validation** - Verifies settings are applied correctly

### When to Use
- When setting up Git for the first time on a new system
- When joining new teams with specific Git configuration requirements
- For configuring GPG signing for security compliance
- When switching between different Git identities for work/personal projects
- To audit and update existing Git configuration

### Usage Examples
```bash
# Interactive Git configuration setup
/user:git-config

# Setup with GPG signing
/user:git-config --enable-gpg

# Repository-specific configuration
/user:git-config --local
```

### How It Works
1. **Current Analysis** - Examines existing Git configuration (global and local)
2. **Identity Setup** - Configures user.name and user.email with validation
3. **GPG Configuration** - Sets up commit signing with available GPG keys
4. **Context Selection** - Chooses between global and repository-specific settings
5. **Team Integration** - Applies team or organizational standards
6. **Validation** - Confirms all configuration changes are applied correctly

### Expected Output
- Configured Git user identity (name and email)
- GPG signing setup (if requested)
- Repository-specific or global configuration as appropriate
- Validation confirmation of all settings
- Summary of configuration changes made
- Guidance for team-specific Git workflow integration

---

## 🔗 Additional Resources

### **Getting Started**
- **[Setup Guide](../../guides/custom-commands/02-setup.md)** - Configure your environment for custom commands
- **[Syntax Reference](../../guides/custom-commands/03-syntax.md)** - Complete command syntax and structure guide
- **[Best Practices](../../guides/custom-commands/05-best-practices.md)** - Professional development and quality guidelines

### **Advanced Usage**
- **[Advanced Workflows](../../guides/custom-commands/04-advanced-workflows.md)** - Multi-step automation and thinking mode integration
- **[Learning Resources](../../guides/custom-commands/06-resources.md)** - Videos, documentation, and external learning content

### **Project Resources**
- **[Main Project README](../../README.md)** - Project overview and community information
- **[Command Installation](../../commands/)** - Install these commands in your environment

---

## 💡 Tips for Effective Usage

### **Command Categories**
- **📁 Documentation Commands** - Use for creating and maintaining project documentation
- **⚡ Execution Commands** - Use for managing workflow modes and enhancing interactions
- **🔧 Git Commands** - Use for streamlined Git workflow and quality commit practices

### **Best Practices**
1. **Start Simple** - Begin with basic commands before exploring advanced features
2. **Use Interactive Features** - Most commands offer interactive modes for guidance
3. **Leverage Intelligence** - Commands adapt to your usage patterns and preferences
4. **Maintain Documentation** - Regularly update documentation using the update commands
5. **Combine Commands** - Use multiple commands together for comprehensive workflows

### **Troubleshooting**
- Use `/user:custom-command-drop` to reset if commands become unresponsive
- Check the allowed tools list if commands fail to execute properly
- Review usage examples for proper syntax and argument formatting
- Consult the [Best Practices Guide](../../guides/custom-commands/05-best-practices.md) for common issues

---

*This reference is maintained automatically. Last updated: $(date)*