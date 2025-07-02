# Embedded Commands Reference

*Framework Components for Custom Command Development*

---

## Overview

**Embedded commands** are self-contained framework components that provide reusable functionality for custom commands. Unlike user-facing commands, embedded commands are designed to be executed by other commands as part of larger workflows.

### Architecture Benefits

**🔧 Reusable Components:**
- Single source of truth for complex functionality
- Consistent execution across all commands that use them
- Framework evolution automatically propagates to all consumers

**🎯 Self-Contained Execution:**
- Complete workflow logic contained within embedded command
- No coordination required from calling commands
- Standardized input/output patterns

**⚡ Maintenance Efficiency:**
- Updates to embedded commands benefit all consumers automatically
- Reduced code duplication across command library
- Centralized testing and quality assurance

---

## Embedded Command Catalog

### 🔍 verify-technical-content.md

**Purpose:** Anti-hallucination verification methodology for generated technical documentation

**Location:** `.claude/embedded/verify-technical-content.md`

**Framework Version:** 1.0.0

#### Capabilities

**Content Verification:**
- Validates technical claims against actual codebase
- Cross-references code examples with real implementations
- Fact-checks file paths, API contracts, and architecture assertions
- Provides confidence scoring and risk assessment

**Verification Phases:**
1. **Framework Initialization** - Loading and execution planning
2. **Content Classification** - Categorize content for verification
3. **Cross-Reference Validation** - Verify against actual codebase
4. **Technical Detail Fact-Checking** - Validate paths, technologies, performance claims
5. **Confidence Assessment** - Score results and flag uncertain content
6. **Generate Verification Report** - Comprehensive summary with templates

#### Integration Pattern

**User Commands Integration:**
```markdown
## Task X: Prompt User for Content Verification ⚡
[Present verification option with cost/benefit analysis]

## Task Y: Execute Content Verification Framework 🔍
[Only if user selected 'y']

Execute the complete embedded verification framework from `.claude/embedded/verify-technical-content.md`:
- Framework handles its own initialization and execution planning
- Applies all 6 tasks systematically
- Generates comprehensive verification report
```

#### Commands Using This Framework

**Generation Commands with Optional Verification:**
- **feature-explain.md** - Generate feature documentation with optional verification
- *Future: PR documentation, architecture analysis, API documentation*

**Standalone Verification Commands:**
- **feature-verify.md** - Verify existing documentation against codebase reality

#### Technical Requirements

**Allowed Tools:** `["Read", "Grep", "Bash"]`

**Prerequisites:**
- Access to project codebase for verification
- Readable markdown documentation as input
- File system access for path validation

#### Output Formats

**Verification Summary:**
- Overall confidence level and percentage
- Content accuracy rating and hallucination risk assessment
- Verified, flagged, and removed content counts
- Key findings and recommended actions

**Optional Report Export:**
- Structured markdown report with executive summary
- Detailed verification results by content category
- Risk assessment and remediation guidance
- Saved to `.claude/artifacts/verification/{YYYYMMDD}/`

#### Quality Standards

**High Confidence (90-100%):**
- All code examples verified against actual files
- All architectural claims supported by evidence
- All technical specifications validated
- No flagged content requiring manual review

**Medium/Low Confidence:**
- Partial verification with flagged content for manual review
- Specific gaps identified with remediation guidance
- Content modifications documented and explained

---

## Related Documentation

**User-Facing Commands:**
- **[Complete Command Reference](describe-commands.md)** - All user-invokable commands
- **[Feature Verification Command](../docs/feat/feature-verify.md)** - Standalone verification utility

**Development Guides:**
- **[Embedded Commands Overview](../../guides/embedded/01-embedded-commands-overview.md)** - Architecture and development guidance
- **[Content Verification Guide](../../guides/embedded/02-content-verification.md)** - Framework implementation details
- **[Advanced Workflows](../../guides/custom-commands/04-advanced-workflows.md)** - Integration patterns and examples
- **[Best Practices](../../guides/custom-commands/05-best-practices.md)** - Professional development standards

**Framework Implementation:**
- **[Content Verification Documentation](../../content-verification-documentation.md)** - Framework development guidelines
- **[Development Checklist](../../checklists/development/02-development.md)** - Quality standards and validation

---

**Embedded Commands Reference Complete:** This catalog provides comprehensive documentation for all framework components available for custom command development, with clear integration patterns and development guidelines.