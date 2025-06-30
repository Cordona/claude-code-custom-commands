# Claude Code Custom Commands

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A community-driven knowledge hub and production command library for Claude Code custom commands. Features battle-tested commands for daily development workflows, comprehensive learning guides, and a collaborative space for command evolution and improvement.

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

**📋 [Complete Command Reference](commands/info/describe-commands.md)** - Detailed documentation for all available commands.

*These aren't just examples - they're production tools built for real work, refined through community feedback, and designed for immediate adoption.*

### **📚 Comprehensive Knowledge Hub**
Complete guide series and learning resources for mastering custom commands:
- **Foundation knowledge** - Understanding, setup, and syntax mastery
- **Advanced patterns** - Multi-step workflows and professional techniques  
- **Community wisdom** - Best practices and real-world insights

## 🚀 Quick Start

### **New to Custom Commands?**
1. **[📖 Start Here: Custom Commands Overview](guides/custom-commands/01-overview.md)** - Learn what custom commands are and why they're powerful
2. **[🛠️ Setup Guide](guides/custom-commands/02-setup.md)** - Get your environment configured in 15 minutes
3. **[⚡ Install Commands](commands/)** - Add production-ready commands to your workflow

### **Ready to Go Deeper?**
- **[📚 Complete Guide Series](guides/custom-commands/README.md)** - Full learning path with 6 comprehensive guides
- **[📖 Syntax Reference](guides/custom-commands/03-syntax.md)** - Complete syntax guide with multi-argument handling and YAML frontmatter
- **[🚀 Advanced Workflows](guides/custom-commands/04-advanced-workflows.md)** - Multi-step automation with thinking mode integration
- **[✨ Best Practices](guides/custom-commands/05-best-practices.md)** - Professional development, security, and team collaboration
- **[📚 Learning Resources](guides/custom-commands/06-resources.md)** - Curated videos, documentation, and external learning content

## 📂 Repository Structure

```
claude-code-custom-commands/
├── README.md                    # This file - project overview
├── DISCLAIMER.md                # Content generation transparency and methodology
├── LICENSE                      # Apache 2.0 open source license
├── commands/                    # Production-ready commands for daily use
│   ├── docs/                   # Documentation generation commands
│   ├── exec/                   # Execution and mode management  
│   ├── git/                    # Git workflow integration
│   └── info/                   # Documentation and reference materials
│       └── describe_commands.md # Complete command reference and documentation
├── guides/
│   └── custom-commands/        # Comprehensive custom commands guides (6 guides)
│       ├── README.md           # Guide series index and learning path
│       ├── 01-overview.md      # Introduction and core concepts
│       ├── 02-setup.md         # Platform setup and configuration
│       ├── 03-syntax.md        # Complete syntax reference
│       ├── 04-advanced-workflows.md  # Multi-step automation patterns
│       ├── 05-best-practices.md      # Professional development guide
│       └── 06-resources.md     # Curated learning resources and videos
├── tools/scripts/sh/           # Command management utilities
│   └── manage_commands.sh      # Cross-platform command manager
└── CLAUDE.md                   # Instructions for Claude Code
```

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

## 📖 Complete Guide Series (6 Guides Available)

Our comprehensive guide series covers everything you need to master custom commands:

### **✅ Complete Learning System (Guides 1-6)**
1. **[Custom Commands Overview](guides/custom-commands/01-overview.md)** - What custom commands are and how they work
2. **[Setup Guide](guides/custom-commands/02-setup.md)** - Cross-platform installation and team collaboration setup  
3. **[Syntax Reference](guides/custom-commands/03-syntax.md)** - Complete syntax with multi-argument handling and YAML frontmatter
4. **[Advanced Workflows](guides/custom-commands/04-advanced-workflows.md)** - Multi-step automation with thinking mode integration
5. **[Best Practices](guides/custom-commands/05-best-practices.md)** - Professional development, security, team collaboration, and troubleshooting
6. **[Learning Resources](guides/custom-commands/06-resources.md)** - Curated videos, documentation, and external learning content

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