---
description: "Execute content verification framework against existing documentation to validate accuracy and detect hallucination"
allowed-tools: ["Read", "Grep", "Bash", "Write"]
---

# Documentation Content Verification

Think harder about systematically validating existing documentation against actual codebase reality to detect hallucination, assess confidence, and provide actionable improvement recommendations.

**Documentation to Verify:** $ARGUMENTS

**Key Features:** Standalone verification, confidence scoring, risk assessment, optional report generation, and actionable remediation guidance.

Execute each task in sequence to perform comprehensive documentation verification.

## Task 1: Validate Input and Load Documentation 📋

Verify the documentation file exists and load it for verification analysis.

**Input Validation:**
- Check if `$ARGUMENTS` provides a valid file path
- Verify file exists and is readable
- Confirm file has `.md` extension (documentation format)
- Validate file contains content for analysis

**Error Handling:**
- No arguments provided → "❌ Please provide a documentation file path. Usage: /user:feature-verify 'path/to/documentation.md'"
- File not found → "❌ Documentation file not found: [path]. Please check the file path and try again."
- Not a markdown file → "❌ Invalid file type. Please provide a markdown (.md) documentation file."
- Empty file → "❌ Documentation file is empty. Please provide a file with content to verify."

**Success Output:**
Present documentation file information and verification readiness:

"📋 **Documentation Loaded for Verification**

**File:** {file-path}
**Size:** {file-size} ({line-count} lines)
**Content Type:** Technical documentation
**Verification Target:** All technical claims, code examples, and architectural assertions

**Verification Scope:**
• Code examples and API contracts
• File paths and directory structures  
• Technology stack assertions
• Configuration examples
• Performance and security claims

**Proceeding with comprehensive content verification...**"

## Task 2: Execute Content Verification Framework 🔍

Execute the complete embedded verification framework from `.claude/embedded/verify-technical-content.md`:

**Framework Execution:**
- Framework handles its own initialization and execution planning
- Applies all 6 tasks systematically (initialization + 5 verification phases)
- Processes the loaded documentation content through each verification phase
- Generates comprehensive verification report with confidence assessment
- All execution logic contained within embedded framework for consistency

**Self-Contained Execution:** The embedded framework is fully self-executing and requires no additional coordination from the calling command.

## Task 3: Present Verification Results Summary 📊

Summarize the verification analysis and present key findings:

**Verification Summary:**
- Overall confidence level achieved
- Number of technical claims verified vs flagged
- Critical issues requiring immediate attention
- Content modifications made during verification
- Risk assessment by content category

**Present Results:**
"📊 **Documentation Verification Complete**

**Overall Assessment:** {confidence-level} ({percentage}% verified)
**Content Accuracy:** {accuracy-rating}
**Hallucination Risk:** {risk-level}

**Verification Results:**
✅ **Verified Content:** {verified-count} items confirmed against codebase
⚠️ **Flagged Content:** {flagged-count} items requiring manual review  
❌ **Removed Content:** {removed-count} items failed verification
🔧 **Modifications Made:** {modification-count} content improvements applied

**Key Findings:**
{summarize-major-findings-and-issues}

**Recommended Actions:**
{list-prioritized-improvement-recommendations}

**Documentation Status:** {enterprise-ready/needs-review/requires-revision}"

## Task 4: Prompt User for Verification Report Export 📄

Offer comprehensive verification report export with structured documentation:

"📄 **Export Verification Report**

Would you like to save this verification analysis as a structured markdown report?

**Benefits:**
• Permanent record of documentation quality assessment
• Shareable verification results for team review processes  
• Historical tracking of documentation accuracy improvements
• Professional audit trail suitable for quality assurance
• Detailed remediation guidance with implementation steps

**File will be saved to:** `.claude/artifacts/verification/{YYYYMMDD}/VERIFY-{doc-name}-{timestamp}.md`

**Export comprehensive verification report? (y/n) [default: n]:**"

**Handle User Response:**
- **If 'y':** Proceed to generate and save verification report
- **If 'n':** Complete verification without report export
- **If no response:** Default to 'n' (skip report generation)

**If user chooses 'y':**

Create the verification report file:

```bash
mkdir -p .claude/artifacts/verification/$(date +%Y%m%d)
```

Save the comprehensive verification report using this structure:
- **Executive Summary** with overall confidence score and risk assessment
- **Documentation Analysis** with file details and content overview
- **Detailed Verification Results** by content category (code, architecture, technical specs, business logic)
- **Critical Issues** with specific examples and remediation guidance
- **Improvement Recommendations** prioritized by impact and effort
- **Risk Assessment** with content categorized by confidence level
- **Remediation Plan** with step-by-step implementation guidance
- **Verification Methodology** and framework version used
- **Final Assessment** with deployment readiness recommendation

**Report Generation Success:**
"✅ **Verification report exported successfully!**

📁 **File Details:**
- Path: `.claude/artifacts/verification/{YYYYMMDD}/VERIFY-{doc-name}-{timestamp}.md`
- Size: {file-size}KB
- Confidence Score: {score}% ({assessment})

📊 **Report Contents:**
• Complete verification analysis with {X} technical claims evaluated
• {X} improvement recommendations with implementation guidance  
• Detailed risk assessment and remediation plan
• Verification methodology and audit trail

💡 **Usage:**
- Share with team for documentation quality review
- Reference for improvement implementation
- Include in project quality assurance processes
- Track documentation accuracy over time

🔍 **All verification reports:** `.claude/artifacts/verification/`"

**If user chooses 'n':**
"Verification complete - analysis available in conversation history."

Confirm the documentation verification workflow completed successfully.

## Usage Examples

### Basic Documentation Verification
```bash
/user:feature-verify "docs/features/authentication.md"
```

### Verify Generated Documentation
```bash
/user:feature-verify ".claude/artifacts/features/user-management-analysis.md"
```

### Team Quality Assurance Process
```bash
# 1. Verify documentation
/user:feature-verify "docs/api/payment-processing.md"

# 2. Export report for review
# [Select 'y' when prompted for report export]

# 3. Share report with team
# File available at: .claude/artifacts/verification/{date}/VERIFY-payment-processing-{timestamp}.md
```

## Integration Notes

**Quality Assurance Workflow:**
- Use after documentation generation commands
- Integrate into documentation review processes
- Apply before publishing or sharing documentation
- Use for legacy documentation quality assessment

**Complementary Commands:**
- **feature-explain.md** - Generate documentation with optional verification
- **custom-command-review.md** - Review command quality with optional export (located in .claude/commands/docs/)
- **verify-technical-content.md** - Embedded verification framework

**Report Integration:**
- Reports follow same format as custom-command-review exports
- Compatible with existing artifact organization
- Supports historical tracking and trend analysis
- Professional format suitable for team processes

## Related Commands
- **[feature-explain.md](feature-explain.md)** - Generate comprehensive feature documentation
- **[custom-command-review.md](../../../.claude/commands/docs/custom-command-review.md)** - Review custom command quality
- **[verify-technical-content.md](../../../embedded/verify-technical-content.md)** - Embedded verification framework