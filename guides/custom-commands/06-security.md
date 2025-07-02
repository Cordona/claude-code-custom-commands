# Security & Command Safety

*Secure command development, data protection, and lifecycle management*

---

## Table of Contents

1. [Security Principles](#security-principles)
   - [Tool Restrictions Strategy](#tool-restrictions-strategy)
   - [Security-First Command Design](#security-first-command-design)

2. [Data Protection](#data-protection)
   - [Sensitive Data Protection](#sensitive-data-protection)
   - [Data Sanitization Patterns](#data-sanitization-patterns)

3. [Command Lifecycle Security](#command-lifecycle-security)
   - [Version Evolution Strategy](#version-evolution-strategy)
   - [Secure Deprecation Workflow](#secure-deprecation-workflow)

---

## Security Principles

**Best Practices:**
1. Tool Restrictions Strategy - principle of least privilege
2. Security-First Command Design - secure patterns and data protection
3. Lifecycle Security - secure versioning and deprecation

### Tool Restrictions Strategy

#### Principle of Least Privilege

Grant commands only the minimum tools necessary for their function:

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

#### Security Risk Assessment
**Before granting tool access, consider:**
- **What data will the command access?** (source code, configuration, secrets)
- **What operations are necessary?** (read-only analysis vs file modification)
- **What is the blast radius?** (single file vs entire repository)
- **Who will use this command?** (trusted team vs external contributors)

### Security-First Command Design

Design commands with security built-in from the start:

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

**For comprehensive security validation:** See the **[Development Checklist](../../checklists/development/02-development.md)** - Section "🔒 Security Implementation" contains built-in security practices including minimal tool access, data protection, and safe operations.

---

## Data Protection

**Best Practices:**
1. Sensitive Data Protection - never expose secrets or credentials
2. Data Sanitization Patterns - generic references instead of actual values
3. Pattern-Based Analysis - focus on security patterns, not specific data

### Sensitive Data Protection

#### Critical Data Categories
Commands must never log, display, or process these data types unsafely:

**Credentials & Secrets:**
- API keys, tokens, passwords
- Database connection strings
- Private keys and certificates
- OAuth secrets and refresh tokens

**Internal Information:**
- Internal URLs and endpoints
- Server configurations and topologies
- User data and personal information
- Proprietary business logic

### Data Sanitization Patterns

#### Built-in Security Practices
When analyzing code that may contain sensitive data:

```markdown
# ✅ Secure Data Handling

1. **Never log or display:**
   - API keys, tokens, passwords
   - Database connection strings
   - Internal URLs and endpoints
   
2. **Use generic references:**
   - "API key detected" instead of showing the key
   - "Database connection configured" instead of showing credentials
   - "Authentication endpoint found" instead of showing URLs
   
3. **Focus on patterns:**
   - "Hardcoded secrets found in 3 locations"
   - "Insecure configuration detected"
   - "Missing encryption for sensitive data"
```

#### Security Analysis Templates
```markdown
# Security Report Template
## Configuration Security
- ✅ Environment variables used for secrets
- ⚠️ Hardcoded API key detected in [file] (sanitized reference)
- ❌ Database password in plain text

## Access Control
- ✅ Authentication required for sensitive endpoints
- ⚠️ Authorization checks incomplete in [module]

## Data Protection
- ✅ HTTPS enforced for all communications
- ❌ Sensitive data logged without encryption
```

---

## Command Lifecycle Security

**Best Practices:**
1. Version Evolution Strategy - secure command versioning and updates
2. Secure Deprecation Workflow - safe removal of outdated commands
3. Access Control - manage who can modify and deploy commands

### Version Evolution Strategy

#### Secure Command Versioning
```markdown
# Command Versioning Pattern
analyze-api-v1.md       # Initial version
analyze-api-v2.md       # Enhanced with security checks  
analyze-api-v3.md       # Added performance metrics
analyze-api.md          # Current stable version (symlink or copy of v3)
```

#### Security Considerations for Updates
- **Backward Compatibility:** Ensure security improvements don't break existing workflows
- **Access Control:** Limit who can publish new command versions
- **Testing:** Security-focused testing before deploying updates
- **Documentation:** Clear security changelog for each version

### Secure Deprecation Workflow

#### Safe Command Retirement
```markdown
# deprecate-command.md
---
description: "Gracefully deprecate old commands and guide users to alternatives"
allowed-tools: ["Read", "Write"]
---

# Command Deprecation Notice

⚠️ **This command is deprecated and will be removed in the next release.**

**Security Reason:** [If applicable - e.g., "Uses insecure authentication method"]

**Replacement:** Use `/project:new-command-name` instead

**Migration Guide:**
- Old: `/project:old-command arg1`
- New: `/project:new-command arg1`

**Security Improvements:**
[List security enhancements in replacement command]

**Deprecation Timeline:**
- **Phase 1:** Warning notices (current)
- **Phase 2:** Command disabled (date)
- **Phase 3:** Command removed (date)
```

**For deprecation security validation:** See the **[Post-Development Checklist](../../checklists/development/03-post-development.md)** - Section "Command Lifecycle Security" contains specific steps for secure command deprecation and retirement.

---

## Security Governance

### Team Security Practices

#### Command Review Process
1. **Security Review:** All commands undergo security assessment before deployment
2. **Principle of Least Privilege:** Default to minimal tool access, justify exceptions
3. **Regular Audits:** Periodic review of existing commands for security issues
4. **Incident Response:** Process for handling security issues in deployed commands

#### Security Training
- **Secure Development:** Training on secure command development practices
- **Threat Modeling:** Understanding attack vectors for custom commands
- **Data Protection:** Best practices for handling sensitive information
- **Incident Response:** How to respond to security issues

### Monitoring & Compliance

#### Security Monitoring
- **Usage Tracking:** Monitor how commands access sensitive resources
- **Anomaly Detection:** Identify unusual command behavior patterns
- **Access Logging:** Track who executes which commands when
- **Error Monitoring:** Watch for security-related command failures

#### Compliance Considerations
- **Data Governance:** Ensure commands comply with data protection regulations
- **Access Controls:** Implement proper authorization for sensitive commands
- **Audit Trails:** Maintain logs for compliance and forensic analysis
- **Regular Assessment:** Periodic security assessments of command library

---

## Summary

Secure command development requires security-first thinking throughout the entire command lifecycle. The key principles are:

### Design Security
1. **Principle of Least Privilege:** Minimal tool access for each command's function
2. **Secure by Default:** Build security into commands from the start
3. **Data Protection:** Never expose sensitive data in outputs or logs

### Operational Security
1. **Lifecycle Management:** Secure versioning, updates, and deprecation processes
2. **Access Controls:** Proper authorization for command development and deployment
3. **Monitoring:** Continuous security monitoring of command usage

### Governance Security
1. **Review Processes:** Security assessment before command deployment
2. **Team Training:** Security education for all command developers
3. **Compliance:** Adherence to organizational and regulatory requirements

**Remember:** Security is not a feature to add later - it must be embedded in every aspect of command development, from initial design through end-of-life.

**For security validation:**
- **[Development Checklist](../../checklists/development/02-development.md)** - Built-in security practices during development
- **[Post-Development Checklist](../../checklists/development/03-post-development.md)** - Security validation before deployment

**For implementation guidance:** See [Best Practices](05-best-practices.md) for secure command creation patterns and [Quality Assurance](07-quality-assurance.md) for security testing strategies.

---

*Next recommended reading: [Quality Assurance](07-quality-assurance.md) - Ensure command quality through testing and validation*