# Claude Code Custom Commands

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A community-driven knowledge hub and production command library for Claude Code custom commands. Features battle-tested commands for daily development workflows, comprehensive learning guides, and a collaborative space for command evolution and improvement.

## ⚡ Ready to Use Our Custom Commands? (For the Impatient 😊)

**Warning:** This script will definitely NOT empty your bank account, drain your crypto wallet, or order 47 pizzas to your address. We promise it only does boring command management stuff.

**Still paranoid?** Ask Claude to audit it with this prompt:
```
Please audit the bash script at tools/scripts/sh/manage_commands.sh for security. 
Specifically check if it:
(1) Makes network calls or external connections
(2) Modifies system files outside the project directory
(3) Accesses sensitive data (passwords, keys, personal files)
(4) Executes remote code or downloads external scripts
(5) Has any malicious or suspicious behavior

Provide a detailed security assessment with your findings.
```
They'll confirm it's just doing local file management (and probably roast our bash coding style 😅).

```bash
./tools/scripts/sh/manage_commands.sh
```

**What this script ACTUALLY does:**
- **Installs commands** - Copies battle-tested commands from this repo to your Claude setup
- **Updates commands** - Keeps your existing commands in sync with latest versions  
- **Lists commands** - Shows what you have installed with nice formatting
- **Removes commands** - Safely deletes commands with backups

---

## 🧠 The Philosophy: Why Prompts Are the New Code

> "Fast and easy access to compute is the winning condition for engineers in the generative AI age"
> 
> — **IndyDevDan** ([GitHub: @disler](https://github.com/disler))

### The Four Pillars of Modern Engineering

> - **Master the prompt chain, master the agent**
> - **Don't let anyone take the prompt away from you**
> - **Don't let anyone hide the prompt that's getting executed**
> - **The prompts give you the compute**

### Seven Principles for Engineering Success

1. **Embrace the prompt-first mindset** - Your prompt skills directly determine your impact
2. **Build reusable compute assets** - Custom commands that solve problems permanently
3. **Think in terms of workflows, not tasks** - Chain multiple AI operations together
4. **Leverage multiple models** - Different AIs catch different issues and provide varied perspectives
5. **Stay in control of the prompts** - Don't rely on black-box solutions that hide the prompting logic
6. **Focus on context priming** - Help AI understand your specific domain and requirements
7. **Design for reusability** - Create templates that work across projects and team members

This repository embodies these principles by providing you with **reusable prompt templates** (custom commands) that put you in control of your AI workflows. Instead of repeating the same prompts manually, you build **compute assets** that compound your productivity over time.

## 🤖 Content Generation Transparency

**Important:** All content in this repository was generated using **Claude Code** and other LLMs, with manual review and multi-model validation. 

**📋 [Complete Disclosure](DISCLAIMER.md)** - Full methodology, validation process, and community review guidelines.

*We believe in complete transparency about AI-assisted development and welcome human review to ensure accuracy and quality.*

## 🎯 What This Repository Provides

### **⚡ Production-Ready Commands**
Battle-tested custom commands actively used in daily development workflows:

**📋 [Complete Command Reference](commands/info/describe-commands.md)** - Detailed documentation for all user-facing commands.

**🔧 [Embedded Commands Reference](commands/info/describe-embedded-commands.md)** - Framework components for command development.

**📚 [Embedded Commands Guides](guides/embedded/)** - Architecture and implementation guides for embedded command development.

*These aren't just examples - they're production tools built for real work, refined through community feedback, and designed for immediate adoption.*

### **🔍 Content Verification System**
Anti-hallucination framework for validating generated technical documentation:

**Key Features:**
- **Automated verification** against actual codebase reality
- **Confidence scoring** with risk assessment and quality metrics
- **Human-in-the-loop confirmation** for content modifications
- **Professional reporting** with comprehensive audit trails

**Available Commands:**
- **feature-verify.md** - Standalone verification for existing documentation
- **Embedded verification** - Optional verification in generation commands (feature-explain.md, etc.)
- **verify-technical-content.md** - Self-contained verification framework for command developers

### **📚 Comprehensive Knowledge Hub**
Complete guide series and learning resources for mastering custom commands:
- **Foundation knowledge** - Understanding, setup, and syntax mastery
- **Advanced patterns** - Multi-step workflows and professional techniques  
- **Community wisdom** - Best practices and real-world insights

### **📋 Professional Validation Checklists**
Focused, actionable checklists for ensuring command quality throughout the development lifecycle:

**📝 [Complete Checklist Collection](checklists/README.md)** - Systematic validation for professional command development.

*Modular checklists covering development lifecycle, domain expertise, and quick reference validation - designed for daily use by individuals and teams.*

## 🚀 Quick Start


### **New to Custom Commands?**
1. **[📖 Start Here: Custom Commands Overview](guides/custom-commands/01-overview.md)** - Learn what custom commands are and why they're powerful
2. **[🛠️ Setup Guide](guides/custom-commands/02-setup.md)** - Get your environment configured in 15 minutes
3. **[⚡ Install Commands](commands/)** - Add production-ready commands to your workflow

### **Ready to Go Deeper?**
- **[📚 Complete Guide Series](guides/custom-commands/README.md)** - Full learning path with 10 comprehensive guides
- **[📖 Syntax Reference](guides/custom-commands/03-syntax.md)** - Complete syntax guide with multi-argument handling and YAML frontmatter
- **[🚀 Advanced Workflows](guides/custom-commands/04-advanced-workflows.md)** - Multi-step automation with thinking mode integration
- **[✨ Best Practices](guides/custom-commands/05-best-practices.md)** - Professional command creation and performance optimization
- **[🔒 Security](guides/custom-commands/06-security.md)** - Security-first command design and data protection
- **[🎯 Quality Assurance](guides/custom-commands/07-quality-assurance.md)** - Testing frameworks and quality metrics
- **[🔧 Troubleshooting](guides/custom-commands/08-troubleshooting.md)** - Debug workflow issues and resolve problems
- **[👥 Team Collaboration](guides/custom-commands/09-team-collaboration.md)** - Organizational setup and team adoption
- **[📚 Learning Resources](guides/custom-commands/10-learning-resources.md)** - Curated videos, documentation, and external learning content

## 🛠️ Command Management Script

### **Cross-Platform Command Manager**
Use the included management script to easily copy production-ready commands from this repository, update existing commands, list commands, and safely remove commands across both project and global scopes.

**Script Location:** `tools/scripts/sh/manage_commands.sh`  
**Compatibility:** macOS, Linux, Windows (Git Bash/WSL/Cygwin), BSD, Solaris

### **Quick Usage**
```bash
# Make script executable (first time only)
chmod +x tools/scripts/sh/manage_commands.sh

# Run the interactive command manager
./tools/scripts/sh/manage_commands.sh
```

### **What the Script Does**
- **🔍 Auto-Detection**: Detects your OS and Claude directory structure automatically
- **📋 Scope Management**: Works with both project-local and global command scopes
- **⚡ Interactive Interface**: Guided prompts with file browser navigation
- **🛡️ Safe Operations**: Automatic backups before modifications and removals
- **📦 Repository Integration**: Copies battle-tested commands from this repository
- **🎯 Command Operations**: Copy, update, list, and remove existing commands

### **Supported Operations**

#### **Copy Commands from Repository**
- **Copy All**: Install the entire collection of battle-tested commands to your scope
- **Browse & Select**: Navigate the repository and choose specific commands to copy
- **Conflict Resolution**: Smart handling when commands already exist in your scope
- **Structure Preservation**: Maintains original command organization and metadata

#### **Update Existing Commands**
- **Interactive File Browser**: Navigate your command directories to find commands to edit
- **Safe Editing**: Automatic backup creation before any modifications
- **Structure Preservation**: Maintains YAML frontmatter and command formatting

#### **List Commands**
- **Scope Overview**: View all commands in both project and global scopes
- **Professional Display**: Beautifully formatted table with category statistics
- **Cross-Scope Comparison**: See what commands are available in each scope

#### **Remove Commands Safely**
- **Confirmation Prompts**: Double-check before any deletion
- **Automatic Backup**: Creates timestamped backups before removal
- **Flexible Selection**: Remove individual commands or multiple commands

### **Workflow Example**
```bash
# 1. Run the script
./tools/scripts/sh/manage_commands.sh

# 2. Choose scope (project or global)
# → Script detects available scopes automatically

# 3. Select operation
# → copy: Copy commands from this repository
# → update: Edit existing commands with backup
# → remove: Safely delete commands with confirmation
# → list: View all commands in beautiful table format

# 4. Follow interactive prompts
# → Copy: Browse repository or copy all commands
# → Update: Navigate and select commands to edit
# → Remove: Select commands to delete with backup
# → List: Instant overview of all available commands
```

### **Advanced Features**
- **Cross-Platform Compatibility**: Works on all major platforms with bash support
- **Intelligent Path Handling**: Handles Windows/Unix path differences automatically  
- **Backup System**: Creates timestamped backups before any modifications
- **Input Validation**: Robust validation for command names and descriptions
- **Error Recovery**: Graceful error handling with retry logic
- **Progress Tracking**: Clear status updates throughout operations

### **Repository Commands Structure**
This repository contains production-ready commands organized by category:

**📁 Documentation Commands (`/commands/docs/`)**
- Development journals and progress tracking
- Feature documentation and analysis  
- Pull request documentation generation

**⚡ Execution Commands (`/commands/exec/`)**
- Mode management and workflow control
- Deep thinking activation and deactivation
- Universal command mode exit functionality

**🔧 Git Commands (`/commands/git/`)**
- Intelligent commit message composition
- Git configuration and setup automation

**Command Format:**
All commands follow consistent YAML frontmatter structure with description, allowed-tools, usage instructions, and comprehensive implementation guidance. See the [Complete Command Reference](commands/info/describe-commands.md) for details on each command.

### **Troubleshooting**
- **Permission Issues**: Run `chmod +x tools/scripts/sh/manage_commands.sh` to make script executable
- **Path Detection**: Script auto-detects Claude directories across all platforms automatically
- **Backup Recovery**: All backups stored in `/tmp/claude_commands_backup_[timestamp]/` with full restore capability
- **Windows Users**: Requires Git Bash, WSL, or Cygwin for bash compatibility
- **Repository Not Found**: Ensure you're running the script from within this repository directory
- **Copy Conflicts**: Script handles existing commands intelligently with user confirmation

---

## 🌟 Why This Repository Matters

This repository serves as the **community hub** for custom commands development, providing:

- **⚡ Battle-Tested Commands**: Production tools refined through real-world usage
- **📚 Knowledge Preservation**: Comprehensive guides and best practices
- **🚀 Workflow Acceleration**: Immediate productivity gains through proven patterns
- **🤝 Community Collaboration**: Shared improvement and collective wisdom
- **🎯 Strategic Advantage**: Implementation of IndyDevDan's compute scaling principles

## 📖 Complete Guide Series (10 Guides Available)

Our comprehensive guide series covers everything you need to master custom commands:

### **✅ Complete Learning System (Guides 1-10)**
1. **[Custom Commands Overview](guides/custom-commands/01-overview.md)** - What custom commands are and how they work
2. **[Setup Guide](guides/custom-commands/02-setup.md)** - Cross-platform installation and team collaboration setup  
3. **[Syntax Reference](guides/custom-commands/03-syntax.md)** - Complete syntax with multi-argument handling and YAML frontmatter
4. **[Advanced Workflows](guides/custom-commands/04-advanced-workflows.md)** - Multi-step automation with thinking mode integration
5. **[Best Practices](guides/custom-commands/05-best-practices.md)** - Professional command creation and performance optimization
6. **[Security](guides/custom-commands/06-security.md)** - Security-first command design and data protection
7. **[Quality Assurance](guides/custom-commands/07-quality-assurance.md)** - Testing frameworks and quality metrics
8. **[Troubleshooting](guides/custom-commands/08-troubleshooting.md)** - Debug workflow issues and resolve problems
9. **[Team Collaboration](guides/custom-commands/09-team-collaboration.md)** - Organizational setup and team adoption
10. **[Learning Resources](guides/custom-commands/10-learning-resources.md)** - Curated videos, documentation, and external learning content

### **📋 Future Development**
- **Real-World Examples** - Production-ready commands for immediate use
- **Advanced Templating** - Complex parameter handling and meta-commands
- **Team Onboarding** - Strategies for scaling custom commands across organizations

## 🎯 Perfect For

- **Daily Users** who want production-ready commands for immediate workflow enhancement
- **Teams** seeking battle-tested, collaborative command libraries
- **Contributors** interested in evolving and improving command effectiveness
- **Learners** who want comprehensive custom commands knowledge and techniques
- **Innovators** building on proven patterns to create new workflow solutions

## 🤝 Contributing & Community Feedback

This repository thrives on community collaboration and real-world usage feedback:

- **Command Improvement** - Submit refinements to existing commands based on your usage
- **Bug Reports** - Found issues with commands in daily use? Help us fix them
- **Feature Requests** - Suggest new commands or enhancements to existing ones
- **Usage Stories** - Share how commands work (or don't work) in your specific workflows
- **Knowledge Contributions** - Improve guides, documentation, and best practices
- **Performance Feedback** - Help optimize commands for better efficiency and reliability

*Your feedback directly shapes these production tools - every improvement benefits the entire community.*

## 👥 Contact & Community

### **Project Maintainer**
**Ventsislav Stoevski** - *AI Workflow Specialist & Custom Commands Architect*

Building production-ready AI development tools and comprehensive knowledge resources for the custom commands community. Focused on creating battle-tested commands that deliver real workflow acceleration.

### **📞 Get in Touch**

**Primary Channels:**
- 🐛 **Issues & Bug Reports**: [GitHub Issues](https://github.com/Cordona/claude-code-custom-commands/issues) 
- 💡 **Feature Requests**: [GitHub Issues](https://github.com/Cordona/claude-code-custom-commands/issues) with `enhancement` label
- 🤝 **Professional Inquiries**: [ventsislav.stoevski@cordona.tech](mailto:ventsislav.stoevski@cordona.tech)
- 💼 **Business & Partnerships**: [cordona.tech](https://cordona.tech)
- 🔗 **Professional Network**: [LinkedIn](https://www.linkedin.com/in/ventsislav-stoevski/)
- 👨‍💻 **Follow Development**: [@Cordona](https://github.com/Cordona)

### **⚡ Community Engagement**

**We Value:**
- **Real-world usage feedback** - How commands perform in your daily workflows
- **Improvement suggestions** - Specific enhancements based on actual usage
- **Knowledge sharing** - Insights from your custom commands experience
- **Collaborative spirit** - Professional, constructive communication

**Response Times:**
- GitHub Issues: 24-48 hours
- Email inquiries: 1-2 business days
- Community contributions: Reviewed weekly

*This is a community-driven project. Your engagement directly improves these production tools for everyone.*

## 📞 Getting Help

1. **[Start with the Overview](guides/custom-commands/01-overview.md)** for basic concepts
2. **[Check the Setup Guide](guides/custom-commands/02-setup.md)** for configuration issues
3. **[Browse the Complete Guide Series](guides/custom-commands/README.md)** for comprehensive coverage
4. **[Consult Official Documentation](https://docs.anthropic.com/en/docs/claude-code)** for general Claude Code help

---

**Ready to scale your compute impact?** [Start with the Custom Commands Overview](guides/custom-commands/01-overview.md) and join the community building the future of AI-enhanced development! 🚀