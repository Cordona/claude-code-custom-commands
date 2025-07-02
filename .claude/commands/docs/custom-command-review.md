---
description: "Intelligent custom command quality reviewer using dynamic Development Checklist standards as single source of truth"
allowed-tools: ["Read", "Grep", "Bash"]
---

# Custom Command Quality Review

Think harder about systematically reviewing this custom command against our Development Checklist using dynamic standards loading as single source of truth.

**Command to Review:** $ARGUMENTS

**Key Features:** Dynamic checklist loading, command type detection, contextual standards application, intelligent recommendations, and quality scoring.

Execute each task in sequence to perform a comprehensive command quality review.

## Task 1: Load Development Checklist Standards (Single Source of Truth) 📋

Dynamically load the current Development Checklist to ensure all validation uses the latest standards.

**Dynamic Standards Loading:**

Read and parse `checklists/development/02-development.md` to extract current validation criteria.

**Standards Extraction:**
- Load the complete Development Checklist file
- Parse all checklist categories and items
- Extract validation criteria for contextual application
- Count total standards for quality scoring

**Present loaded standards:**

"📋 **Development Checklist Loaded (Single Source of Truth)**

**Standards Source:** /checklists/development/02-development.md
**Total Validation Criteria:** [Count items from loaded file]
**Checklist Categories:** [List main sections from file]

**Dynamic Standards Active:** All validation will use current checklist standards, ensuring reviews automatically stay current with evolving best practices."

**Note:** This approach ensures that when standards are updated in the Development Checklist, all future reviews automatically use the latest criteria without requiring command updates.

## Task 2: Validate Input and Load Command 🔍

Verify the command file exists and load it for analysis.

**Validation Steps:**
- Check if `$ARGUMENTS` provides a valid file path
- Verify file exists and is readable
- Confirm file has `.md` extension (custom command format)
- Load command content for analysis

**Error Handling:**
- No arguments provided → "❌ Please provide a command file path. Usage: /project:custom-command-review 'path/to/command.md'"
- File not found → "❌ Command file not found: [path]. Please check the file path and try again."
- Not a markdown file → "❌ Invalid file type. Custom commands must be .md files."

**Success Output:** Display command file path and basic file information.

## Task 3: Parse Command Structure 📋

Analyze the command's structure to understand its design and purpose.

**Analysis Objectives:**
- Extract YAML frontmatter (description, allowed-tools)
- Identify command title and purpose
- Detect presence of $ARGUMENTS usage
- Count tasks/sections and complexity indicators
- Analyze tool usage patterns

**Present Parsing Summary:**
```
📊 **Command Structure Analysis:**
- File: [filename]
- Description: [from YAML]
- Tools: [allowed-tools list]
- Arguments: [Used/Not Used]
- Complexity: [Simple/Moderate/Complex]
- Tasks: [number of sections/tasks]
```

## Task 4: Detect Command Type 🎯

Intelligently categorize the command type to enable contextual checklist application.

**Command Type Detection Logic:**

**Parameterized Commands:**
- Uses $ARGUMENTS for user input
- Processes external data or parameters
- Examples: "analyze this code", "review this file"

**Environment-Aware Commands:**
- Analyzes current state without external input
- No $ARGUMENTS usage (or minimal configuration only)
- Examples: git-commit, project-status, current-analysis

**Interactive Workflow Commands:**
- Guides users through multi-step processes
- May use $ARGUMENTS for workflow configuration
- Examples: setup wizards, configuration helpers

**Utility Commands:**
- Performs specific operations or transformations
- May or may not use $ARGUMENTS
- Examples: format-code, generate-template

**Present Command Type Assessment:**
"**Detected Command Type:** [Type] 

**Reasoning:** [Explain why this classification based on structure and usage patterns]

**Checklist Application Strategy:** [Explain which requirements will be applied contextually]"

## Task 5: Apply Dynamic Universal Quality Standards ✅

Evaluate all commands against universal quality requirements loaded from the Development Checklist.

**Dynamic Standards Application:**

Using the checklist loaded in Task 1, apply all universal standards that apply to every command regardless of type:

1. **Extract Universal Standards** from the loaded Development Checklist
2. **Apply Each Standard** systematically to the target command
3. **Assess Compliance** with specific pass/fail evaluation
4. **Document Reasoning** for each assessment

**Universal Standards Categories** (from loaded checklist):
- Core command quality and design principles
- YAML frontmatter requirements and best practices
- Security implementation standards
- Performance and efficiency guidelines
- Documentation and usability requirements

**Evaluation Process:**
For each universal standard from the loaded checklist:
- Check if the command meets the requirement
- Assess the quality of implementation
- Identify any gaps or issues
- Provide specific improvement recommendations

**Generate Universal Standards Report** with specific pass/fail assessments based on current checklist standards.

## Task 6: Apply Dynamic Contextual Quality Standards 🧠

Apply command-type-specific requirements from the loaded checklist intelligently, avoiding inappropriate enforcement.

**Dynamic Contextual Standards Application:**

Using the command type detected in Task 4 and the checklist loaded in Task 1:

1. **Filter Relevant Standards** from the Development Checklist based on command type
2. **Skip Inappropriate Requirements** (e.g., don't enforce $ARGUMENTS for environment-aware commands)
3. **Apply Type-Specific Standards** with proper contextual understanding
4. **Scale Evaluation Complexity** based on command sophistication

**Contextual Intelligence Logic:**

**For Parameterized Commands** (if $ARGUMENTS detected):
- Apply all parameter-related standards from the checklist
- Evaluate argument handling and validation
- Check parameter documentation quality

**For Environment-Aware Commands** (if no $ARGUMENTS):
- Skip parameter-related requirements (mark as "N/A - Environment-aware design")
- Apply environment analysis standards from the checklist
- Focus on context-building and state analysis quality

**For Interactive/Complex Commands:**
- Apply workflow design standards from the checklist
- Evaluate task organization and error handling
- Check advanced feature implementation

**Generate Contextual Standards Report** explaining:
- Which standards were applied and why
- Which standards were skipped and the reasoning
- Command type-specific compliance assessment
- Recommendations based on loaded checklist criteria

## Task 7: Evaluate Documentation & Usability 📖

Assess command documentation, examples, and team integration aspects.

**Documentation Quality Review:**
- **Clear Examples:** Realistic usage scenarios
- **Output Quality:** Actionable, well-formatted results
- **Integration Notes:** Team workflow information
- **Cross-References:** Links to related commands

**Usability Assessment:**
- **Usage Clarity:** Easy to understand and invoke
- **Error Messages:** Helpful guidance for common issues
- **Interactive Elements:** Clear confirmation workflows
- **Team Integration:** Consistent with project patterns

**Generate Documentation & Usability Report with specific recommendations.**

## Task 8: Generate Quality Score and Recommendations 📊

Synthesize all analysis into comprehensive quality assessment with actionable recommendations.

**Quality Scoring:**
- **Universal Standards:** [X/Y items passing]
- **Contextual Standards:** [X/Y applicable items passing]
- **Documentation Quality:** [X/Y items passing]
- **Overall Score:** [X/Y total applicable items]

**Quality Assessment:**
- **✅ Excellent (90-100%):** Enterprise-ready, minimal improvements needed
- **✅ Good (75-89%):** Production-ready with minor enhancements
- **⚠️ Needs Improvement (60-74%):** Functional but requires attention
- **❌ Poor (<60%):** Significant issues requiring major revision

**Improvement Recommendations:**
Present prioritized, actionable recommendations:

**Priority 1: Critical Issues (Must Fix)**
- [List any critical problems that prevent deployment]

**Priority 2: Quality Improvements (Should Fix)**
- [List improvements that enhance quality and usability]

**Priority 3: Enhancements (Nice to Have)**
- [List optional improvements for excellence]

## Task 9: Present Final Review Report 📋

Assemble comprehensive review report with executive summary and detailed findings.

**Executive Summary:**
- Command purpose and type classification
- Overall quality score and assessment
- Key strengths and critical issues
- Deployment readiness status

**Detailed Review:**
- Complete checklist evaluation results using current standards
- Contextual application reasoning
- Specific improvement recommendations
- Implementation guidance for fixes

**Standards Traceability:**
- Standards version used (from loaded checklist)
- Total applicable standards count
- Evaluation approach and contextual intelligence applied

**Next Steps:**
1. **Address Critical Issues** (if any) before using command
2. **Implement Quality Improvements** for better user experience
3. **Consider Enhancements** for excellence
4. **Re-review** after improvements (optional)

**Single Source of Truth Note:**
This review used current Development Checklist standards as single source of truth. Future reviews will automatically use updated standards as they evolve, ensuring consistency and currency.

**Review Completion:** Confirm systematic quality assessment completed with dynamic standards, contextual intelligence, and actionable guidance provided.

## Task 10: Optional Review Export 📄

Offer comprehensive review report export with structured documentation:

"📄 **Export Review Report**

Would you like to save this review analysis as a structured markdown report?

**Benefits:**
• Permanent record of quality assessment and recommendations
• Shareable documentation for team review processes  
• Historical tracking of command quality improvements
• Professional format suitable for project documentation

**File will be saved to:** `.claude/artifacts/reviews/{YYYYMMDD}/REVIEW-{command-name}-{timestamp}.md`

**Export comprehensive review report? (y/n) [default: n]:**"

**If user chooses 'y':**

Create the review report file:

```bash
mkdir -p .claude/artifacts/reviews/$(date +%Y%m%d)
```

Save the generated review report to: `.claude/artifacts/reviews/{YYYYMMDD}/REVIEW-{command-name}-{timestamp}.md`

Use the comprehensive template structure:
- Executive Summary with quality score table
- Command Structure Analysis  
- Detailed Standards Evaluation (Universal, Contextual, Documentation)
- Critical Issues (if any) with code examples
- Improvement Recommendations (Priority 1-3)
- Remediation Plan with implementation guidance
- Standards Traceability and methodology
- Final Assessment with deployment decision

Perform quality validation:
- Verify all analysis data has been included
- Confirm comprehensive template was used
- Check that file was created successfully
- Validate command name was correctly extracted
- Ensure quality scores and recommendations are complete

Write the generated review content to the file with proper error handling.

Present completion summary:

"✅ **Review report exported successfully!**

📁 **File Details:**
- Path: `.claude/artifacts/reviews/{YYYYMMDD}/REVIEW-{command-name}-{timestamp}.md`
- Size: {file-size}KB
- Quality Score: {score}% ({assessment})

📊 **Report Contents:**
• Complete quality assessment with {X} standards evaluated
• {X} improvement recommendations with implementation guidance  
• Detailed remediation plan with priority levels
• Standards traceability and methodology documentation

💡 **Usage:**
- Share with team for command review processes
- Reference for quality improvement tracking
- Include in project documentation
- Use for command development standards

🔍 **All review reports:** `.claude/artifacts/reviews/`"

**If user chooses 'n':**

"Review complete - analysis available in conversation history."

## Usage Examples

### Basic Command Review
```bash
/project:custom-command-review "commands/git/git-commit.md"
```

### Review with Full Analysis
```bash
/project:custom-command-review "commands/docs/feature-analyze.md"
```

### Sample Review Output
```
📊 Command Structure Analysis:
- File: git-commit.md
- Description: Enterprise-grade conventional commit message composer
- Tools: ["Bash", "Read"]
- Arguments: Not Used (Environment-aware design)
- Complexity: Complex
- Tasks: 8 sequential workflow tasks

Detected Command Type: Environment-Aware
Reasoning: Analyzes current git repository state without requiring external parameters

Overall Quality Score: 42/45 applicable items (93% - Excellent)
✅ Enterprise-ready with minimal improvements needed
```

## Related Commands
- **[custom-command-update.md](custom-command-update.md)** - Updates command documentation catalog
- **[describe-commands.md](../../../commands/info/describe-commands.md)** - Complete command reference documentation