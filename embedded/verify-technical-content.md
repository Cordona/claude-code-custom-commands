---
description: "Anti-hallucination verification methodology for generated technical documentation"
allowed-tools: ["Read", "Grep", "Bash"]
---

# Content Verification Framework
*Anti-Hallucination Standards for Generated Technical Documentation*

**Framework Version:** 1.0.0  
**Purpose:** Command-agnostic content verification methodology  
**Scope:** All generated technical documentation (features, PRs, journals, etc.)

## Framework Overview

Think harder about systematically validating generated technical content against actual codebase reality, preventing hallucination and ensuring accuracy across all documentation types.

This framework provides systematic methodology for validating generated technical content against actual codebase reality, preventing hallucination and ensuring accuracy across all documentation types.

**Core Principle:** Every technical claim, code example, and architectural assertion must be verifiable against the actual codebase or explicitly flagged for manual verification.

## Task 1: Framework Initialization and Execution Plan 📋

Present framework loading and execution approach:

"📋 **Content Verification Framework Initialized**

**Framework Version:** 1.0.0
**Framework Source:** .claude/embedded/verify-technical-content.md
**Verification Methodology:** 5-phase systematic validation

**Execution Plan:**
• **Phase 1:** Content Classification - Categorize all technical content for verification
• **Phase 2:** Cross-Reference Validation - Verify code examples against actual codebase
• **Phase 3:** Technical Detail Fact-Checking - Validate file paths, technology claims, performance assertions
• **Phase 4:** Confidence Assessment - Score verification results and flag uncertain content
• **Phase 5:** Generate Verification Report - Create comprehensive summary with templates

**Verification Scope:** All generated technical documentation will be systematically validated against codebase reality.

**Proceeding with 5-phase verification methodology...**"

## Task 2: Content Classification 📊

**Classify all generated content into verification categories:**

1. **Code Examples and Snippets**
   - Method signatures, class names, annotations
   - Configuration examples and property values
   - API endpoints and request/response structures
   - Database schemas and entity relationships

2. **Architectural Claims**
   - Component relationships and dependencies
   - Integration patterns and external services
   - Data flow descriptions and process workflows
   - Service boundaries and communication protocols

3. **Technical Specifications**
   - File paths and directory structures
   - Technology stack assertions
   - Framework and library usage claims
   - Deployment and infrastructure descriptions

4. **Business Logic Descriptions**
   - Feature capabilities and limitations
   - Validation rules and constraints
   - Error handling and exception scenarios
   - User workflows and interaction patterns

## Task 3: Cross-Reference Validation ✅

**BEFORE REMOVING ANY CONTENT:**
Present summary of content to be removed and request confirmation:
"⚠️ **Content Removal Required**

The following content cannot be verified and will be removed:
- [List specific items that failed verification]

**Impact:** This will modify the generated documentation by removing unverifiable content.

**Alternatives:** Content could be flagged for manual review instead of removal.

**Proceed with removal? (y/n)**"

**For Code Examples and Snippets:**

1. **Exact Code Matching**
   ```
   For each code snippet in generated content:
   - Extract class names, method signatures, annotations
   - Use grep/search tools to locate in actual codebase
   - Verify exact matches or document differences
   - IF CODE CANNOT BE FOUND: Request confirmation before removal (non-existent code)
   - IF CODE SEEMS PLAUSIBLE BUT UNVERIFIABLE: Flag with `[REQUIRES VERIFICATION]`
   ```

2. **Configuration Validation**
   ```
   For each configuration example:
   - Locate actual configuration files
   - Compare property names and structure
   - Verify default values and data types
   - IF CONFIGURATION DOESN'T EXIST: Remove content immediately
   - IF CONFIGURATION CANNOT BE VERIFIED: Flag with `[REQUIRES VERIFICATION]`
   ```

3. **API Contract Verification**
   ```
   For each API endpoint described:
   - Locate controller classes and methods
   - Verify HTTP methods, paths, parameters
   - Confirm request/response structures
   - Validate error codes and exception handling
   - IF API ENDPOINT NOT FOUND: Remove content immediately
   - IF ENDPOINT EXISTS BUT DETAILS UNVERIFIABLE: Flag with `[REQUIRES VERIFICATION]`
   ```

**For Architectural Claims:**

1. **Component Relationship Verification**
   ```
   For each architectural assertion:
   - Identify actual classes and interfaces
   - Verify dependency injection and imports
   - Confirm integration patterns exist
   - Validate service boundaries described
   - IF COMPONENTS DON'T EXIST: Remove content immediately
   - IF RELATIONSHIPS CANNOT BE CONFIRMED: Flag with `[REQUIRES VERIFICATION]`
   ```

2. **Integration Pattern Validation**
   ```
   For each integration described:
   - Locate actual integration code
   - Verify external service configurations
   - Confirm communication protocols
   - Validate error handling patterns
   - IF INTEGRATION CODE NOT FOUND: Remove content immediately
   - IF EXTERNAL SYSTEMS NOT ACCESSIBLE: Flag with `[REQUIRES VERIFICATION]`
   ```

## Task 4: Technical Detail Fact-Checking 🔍

**File Path and Location Verification:**
```
For each file path mentioned:
- Verify file exists at specified location
- Confirm directory structure accuracy
- Validate package/namespace organization
- IF FILE PATH DOESN'T EXIST: Request confirmation before removal
- IF PATH STRUCTURE CANNOT BE VERIFIED: Flag with `[REQUIRES VERIFICATION]`
```

**BEFORE REMOVING FILE PATH CONTENT:**
Present summary and request confirmation:
"⚠️ **File Path Content Removal Required**

The following file paths cannot be verified and will be removed:
- [List specific file paths that don't exist]

**Impact:** This will remove file path references from the documentation.

**Alternatives:** File paths could be flagged for manual verification instead of removal.

**Proceed with file path removal? (y/n)**"

**Technology Stack Validation:**
```
For each technology claim:
- Check dependency files (package.json, pom.xml, etc.)
- Verify framework versions and configurations
- Confirm library usage in actual code
- Validate technology compatibility assertions
- IF DEPENDENCY NOT FOUND IN PROJECT FILES: Request confirmation before removal
- IF TECHNOLOGY CLAIMS CANNOT BE VERIFIED: Flag with `[REQUIRES VERIFICATION]`
```

**BEFORE REMOVING TECHNOLOGY CLAIMS:**
Present summary and request confirmation:
"⚠️ **Technology Claims Removal Required**

The following technology claims cannot be verified and will be removed:
- [List specific technology assertions that failed verification]

**Impact:** This will remove unverifiable technology references from the documentation.

**Alternatives:** Technology claims could be flagged for manual review instead of removal.

**Proceed with technology claims removal? (y/n)**"

**Performance and Security Claims:**
```
For each performance/security assertion:
- Locate actual implementation evidence
- Verify configuration settings exist
- Confirm monitoring and logging setup
- IF NO IMPLEMENTATION EVIDENCE FOUND: Remove content immediately
- IF CLAIMS CANNOT BE SUBSTANTIATED: Flag with `[REQUIRES VERIFICATION]`
- REPLACE SPECIFIC UNVERIFIABLE DETAILS WITH GENERIC DESCRIPTIONS:
  - "implements CircuitBreaker pattern" → "implements resilience patterns"
  - "uses 500ms timeout" → "uses configurable timeout"
  - "stores in Redis cache" → "uses caching layer"
  - "processes 1000 requests/sec" → "handles high throughput"
```

## Task 5: Confidence Assessment 📈

**Confidence Scoring Criteria:**

**High Confidence (90-100%):**
- All code examples verified against actual files
- All architectural claims supported by evidence
- All file paths and configurations confirmed
- All technical specifications validated
- No flagged content requiring manual review

**Medium Confidence (70-89%):**
- Most code examples verified (>80%)
- Core architectural claims supported
- Some minor discrepancies or gaps identified
- 1-3 items flagged for manual verification
- Technical specifications mostly accurate

**Low Confidence (50-69%):**
- Significant gaps in verification (>20% unverified)
- Multiple architectural claims cannot be confirmed
- Several code examples not found in codebase
- Multiple items requiring manual verification
- Technical specifications contain assumptions

**Very Low Confidence (<50%):**
- Major verification failures
- Extensive unverifiable content
- Multiple hallucination indicators
- Requires substantial manual review
- Content may need regeneration

## Task 6: Generate Verification Report 📝

**Error Recovery for Partial Failures:**
```
IF VERIFICATION PROCESS ENCOUNTERS ERRORS:
1. Document specific failure points and reasons
2. Continue verification for remaining content where possible
3. Generate partial verification report with clear limitations
4. Recommend manual review for failed verification sections
5. Provide specific guidance for resolving verification failures
```

**Recovery Strategies:**
- **Tool Access Issues:** Recommend alternative verification approaches
- **File Not Found Errors:** Suggest manual file system verification
- **Network/External Dependencies:** Flag for offline verification
- **Parsing Errors:** Provide specific content formatting guidance

**Mandatory Template Usage:**

1. **Apply Standard Verification Summary Template**
   Use this exact template structure, replacing all {placeholder} values with actual findings:

```markdown
## Content Verification Summary

**Framework Version:** 1.0.0
**Verification Date:** {current-date-timestamp}
**Content Type:** {feature-doc/pr-doc/dev-journal/etc}

### Verification Results

**✅ Verified Content:**
- {X} code examples cross-referenced with actual files
- {X} architectural components confirmed in codebase  
- {X} API contracts validated against controllers
- {X} file paths verified as existing
- {X} configuration examples matched to actual configs

**⚠️ Flagged for Manual Review:**
- {Description of content requiring domain expert verification}
- {External system references not accessible for verification}
- {Performance claims requiring validation}

**❌ Removed Content:**
- {Description of content removed due to verification failure}
- {Non-existent code references eliminated}
- {Invented configuration properties removed}

**📊 Confidence Assessment:**
- **Overall Confidence Level:** {High/Medium/Low/Very Low}
- **Verification Coverage:** {percentage}% of technical content verified
- **Manual Review Required:** {Yes/No}
- **Regeneration Recommended:** {Yes/No}

### Quality Assurance

**Content Accuracy:** {Excellent/Good/Needs Improvement/Poor}
**Hallucination Risk:** {Minimal/Low/Medium/High}
**Documentation Reliability:** {Enterprise-Ready/Good/Needs Review/Not Ready}
```

2. **Apply Risk Assessment Template**
   Add this section immediately after the verification summary:

```markdown
### Content Risk Assessment

**🟢 Low Risk Content (High Confidence)**
- {List all code examples verified against actual implementation}
- {List architectural descriptions that match real component relationships}
- {List technical specifications confirmed in project files}

**🟡 Medium Risk Content (Manual Review Needed)**
- {List specific items requiring expert validation}
- {List external integration claims needing verification}
- {List performance assertions requiring measurement}

**🔴 High Risk Content (Removed or Regeneration Needed)**
- {List items removed due to verification failure}
- {List content with hallucination indicators}
- {List technical claims without supporting evidence}
```

3. **Ensure Template Compliance**
   - Verify all template sections are completed with actual data (no {placeholder} text remains)
   - Confirm confidence percentages are calculated correctly based on verification results
   - Include framework version (1.0.0) and current verification date
   - Validate that verification coverage percentage reflects actual analysis performed