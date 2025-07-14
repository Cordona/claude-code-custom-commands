---
description: "Generate professional PR documentation with git analysis and optional test execution"
allowed-tools: ["Bash", "Write", "Read"]
---

# Professional PR Document Generator

Think harder about analyzing the current git changes and generating comprehensive PR documentation.

Execute each task in the order given to create a professional pull request document.

## Task 1: Analyze Repository State 🔍

Run git commands to understand the current branch and changes:

```bash
git rev-parse --abbrev-ref HEAD
git diff --stat origin/main
git log origin/main..HEAD --oneline
```

Examine and present:
- Current branch name
- Files modified, added, deleted
- Number of commits and line changes
- Overall scope and complexity of changes

## Task 2: Extract Context Information 🎯

Parse the branch name to extract ticket information using these patterns:
- **JIRA**: `feature/PROJ-1234-description` → `PROJ-1234`
- **GitHub**: `fix/issue-456-description` → `#456`
- **GitLab**: `feature/mr-789-description` → `!789`

Analyze the file paths to determine:
- Primary scope (auth, api, ui, docs, etc.)
- Components affected
- Estimated review complexity (simple/moderate/complex)

If ticket extraction fails, note it for manual addition later.

## Task 3: Interactive Test Execution Decision 🧪

Present the test execution choice to the user:

"🧪 **Test Execution Choice:**

Would you like me to run tests and include real results in the PR documentation? 

**Benefits of running tests:**
- Current test coverage metrics
- Actual pass/fail statistics  
- Fresh performance data
- Real execution results

**Consider skipping if:**
- Tests take very long to run
- CI/CD will handle test execution
- You need a quick PR draft

**Your choice:**
1. ✅ Run tests now and include results
2. ⏭️ Skip tests (CI/CD will handle)

Please choose (1 or 2):"

**If choice 1 (Run tests):**
Execute the test suite and capture:
- Test execution output
- Coverage percentages
- Performance metrics
- Pass/fail counts

**If choice 2 (Skip tests):**
Note that tests will be handled by CI/CD pipeline.

## Task 4: Create Directory Structure 📁

Create the organized directory structure:

```bash
mkdir -p .claude/artifacts/pr/$(date +%Y%m%d)
```

The file will be saved as: `.claude/artifacts/pr/{YYYYMMDD}/PR-{branch-name}.md`

Confirm the directory creation was successful.

## Task 5: Generate PR Document Content 📝

Create a comprehensive PR document using the appropriate template based on the test execution choice from Task 3.

**If tests were executed, include this structure:**

```markdown
# Pull Request: {descriptive-title-based-on-changes}

**Branch:** `{current-branch}`  
**Target:** `main`  
**Author:** {git-user-name}  
**Date:** {current-date}  
**Ticket:** {extracted-ticket-or-TBD}  

## 🎯 Summary

{one-paragraph-summary-based-on-git-analysis}

## 🔍 Problem Statement

{describe-what-this-pr-solves-based-on-changes}

## 💡 Solution Approach

{explain-implementation-strategy-from-file-analysis}

## 📋 Changes Overview

### Files Modified
{list-each-changed-file-with-brief-description}

### Key Changes
{high-level-changes-from-git-analysis}

## ✅ Testing

### Test Execution Results
```
🧪 Test Suite Execution Results:
Tests run: {actual-count}, Failures: {actual-failures}, Errors: {actual-errors}, Skipped: {actual-skipped}
Overall Coverage: {actual-coverage}%
Execution Time: {actual-time}s

Coverage Breakdown:
• Line Coverage: {actual-line-coverage}%
• Branch Coverage: {actual-branch-coverage}%  
• Method Coverage: {actual-method-coverage}%

{include-relevant-test-output-and-metrics}
```

### Test Performance Metrics
{include-performance-data-if-available}

### Manual Testing Performed
{describe-manual-testing-steps-actually-completed}

## 🚀 Deployment Considerations

{assess-deployment-needs-based-on-changes}

## 🔍 Review Guide

**Estimated review time:** {estimate-based-on-complexity}
**Areas requiring attention:** {highlight-complex-changes}

## 🎯 Definition of Done

- ✅ All tests pass ({actual-test-count} tests verified)
- [ ] Peer review completed
- [ ] Documentation updated

## 📎 Related Links

- Ticket: {extracted-ticket-link}

---
*Generated on {date} for branch `{branch-name}`*
*Test results included from live execution*
```

**If tests were skipped, use this structure instead:**

```markdown
# Pull Request: {descriptive-title-based-on-changes}

**Branch:** `{current-branch}`  
**Target:** `main`  
**Author:** {git-user-name}  
**Date:** {current-date}  
**Ticket:** {extracted-ticket-or-TBD}  

## 🎯 Summary

{one-paragraph-summary-based-on-git-analysis}

## 🔍 Problem Statement

{describe-what-this-pr-solves-based-on-changes}

## 💡 Solution Approach

{explain-implementation-strategy-from-file-analysis}

## 📋 Changes Overview

### Files Modified
{list-each-changed-file-with-brief-description}

### Key Changes
{high-level-changes-from-git-analysis}

## ✅ Testing

### Testing Approach
{describe-comprehensive-testing-strategy-based-on-changes}

### Unit Testing
{detail-unit-testing-approach-for-specific-changes}

### Integration Testing  
{explain-integration-testing-strategy-for-affected-components}

### Manual Testing Performed
{provide-detailed-manual-testing-steps-actually-performed}

### Test Coverage Strategy
{explain-how-test-coverage-addresses-the-changes}

### Edge Cases Considered
{list-edge-cases-and-error-conditions-tested}

### Regression Testing
{describe-regression-testing-to-ensure-no-breakage}

> 📝 **Note:** Automated test execution results will be provided by CI/CD pipeline

## 🚀 Deployment Considerations

{assess-deployment-needs-based-on-changes}

## 🔍 Review Guide

**Estimated review time:** {estimate-based-on-complexity}
**Areas requiring attention:** {highlight-complex-changes}

## 🎯 Definition of Done

- [ ] All tests pass (pending CI/CD execution)
- [ ] Peer review completed  
- [ ] Documentation updated

## 📎 Related Links

- Ticket: {extracted-ticket-link}

---
*Generated on {date} for branch `{branch-name}`*
*Test results pending - will be added by CI/CD*
```

Replace all placeholders with actual data from previous tasks.

## Task 6: Save Document with Validation ✅

Write the generated content to the file:
`.claude/artifacts/pr/{YYYYMMDD}/PR-{branch-name}.md`

Perform quality validation:
- Verify all placeholder text has been replaced with real data
- Confirm proper template was used based on test execution choice
- Check that file was created successfully
- Validate branch name was correctly extracted

If any validation fails, note the issue and continue with file creation.

## Task 7: Present Results and Confirmation 👀

Present the completion summary:

"✅ **PR document created successfully!**

📁 **File Details:**
- Path: `.claude/artifacts/pr/{YYYYMMDD}/PR-{branch-name}.md`
- Template: {with-tests/without-tests}
- Size: {file-size}

📊 **Document Summary:**
- Branch: `{branch-name}`
- Files changed: {count}
- Lines modified: +{additions} -{deletions}
- Tests executed: {yes/no}
- Ticket: {extracted-ticket}

💡 **Next steps:**
1. Review the generated document
2. Add screenshots if applicable  
3. Update deployment notes if needed
4. Share with your team for review

🔍 **Recent PRs available at:** `.claude/artifacts/pr/`"

Confirm the workflow completed successfully.