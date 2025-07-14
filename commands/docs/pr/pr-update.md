---
description: "Intelligently update existing PR documents with smart detection and change preview"
allowed-tools: ["Bash", "Write", "Read"]
---

# Intelligent PR Document Updater

Think harder about detecting existing PR documents and intelligently updating them with new changes while preserving manual edits.

Execute each task in the order given to update an existing PR document with sophisticated change management.

## Task 1: Detect Existing PR Document 🔍

Run git commands to analyze the current context:

```bash
git rev-parse --abbrev-ref HEAD
git log -1 --format="%H %cr"
```

Search for existing PR documents using intelligent detection:

```bash
# Check standard location
find .claude/artifacts/pr -name "PR-*{branch-name}*.md" -mtime -7 | sort -r

# Check git history for PR edits
git log --name-only --pretty=format: | grep "PR-.*\.md" | sort | uniq

# Check legacy locations
find . -maxdepth 2 -name "PR-*.md" -type f
```

Apply confidence scoring algorithm:
- Branch name match: +40 points
- Recent modification: +30 points  
- Contains current files: +20 points
- Standard location: +10 points

Present the best match with confidence score:

"🎯 **PR Document Analysis:**

Best match ({confidence}% confidence):
📄 {file-path}
   ✓ Matches current branch name
   ✓ Modified {time-ago}
   ✓ Contains files from recent changes

**Your choice:**
1. Use recommended PR (recommended)
2. Select from other candidates
3. Enter custom path
4. Create new PR instead

Please choose (1-4):"

If choice 1 selected, proceed. If choice 2, show selection menu with all candidates and confidence scores.

## Task 2: Analyze Changes Since Last Update 🎯

Examine the selected PR document and analyze what has changed:

```bash
# Get document last modified time
git log -1 --format="%H %cr" {selected-pr-file}

# Analyze changes since document creation
git diff --stat {last-pr-commit}..HEAD
git log {last-pr-commit}..HEAD --oneline
```

Assess the scope of changes:
- Count new, modified, and deleted files
- Calculate lines added/removed
- Determine if scope has significantly expanded
- Estimate impact on review complexity

Present change summary:

"📊 **Changes Since Last Update:**
- Document last updated: {time-ago}
- New commits: {count}
- Files changed: +{new} ~{modified} -{deleted}
- Lines changed: +{additions} -{deletions}
- Scope assessment: {simple/moderate/complex/major-expansion}"

If major scope expansion detected (>3x files or >5x lines), warn:

"⚠️ **Major Scope Change Detected!**
This PR has evolved substantially. Consider:
1. Continue update (preserve history)
2. Create fresh PR document  
3. Split into multiple PRs

Recommendation: {recommendation}
Proceed anyway? (y/n)"

## Task 3: Interactive Test Execution Decision 🧪

Present the test execution choice:

"🧪 **Test Execution Choice:**

Would you like me to run tests and update results in the PR documentation?

**Benefits of running tests:**
- Fresh coverage metrics  
- Current pass/fail statistics
- Accurate performance data
- Updated test execution results

**Consider skipping if:**
- Tests take very long to run
- No test-related changes made
- CI/CD has recent results

**Your choice:**
1. ✅ Run tests now and include updated results
2. ⏭️ Skip tests (preserve existing results)

Please choose (1 or 2):"

**If choice 1 (Run tests):**
Execute the test suite and capture:
- Test execution output and statistics
- Coverage percentages and changes
- Performance metrics if available
- Pass/fail counts and any failures

**If choice 2 (Skip tests):**
Note that existing test results will be preserved.

## Task 4: Generate Change Preview 📋

**CRITICAL: Show detailed preview before making ANY changes to the PR document.**

Create a comprehensive preview of what will be modified:

"📝 **PR Update Preview:**
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 📄 Files Section Changes
WILL ADD:
{list-new-files-with-descriptions}

WILL UPDATE:  
{list-modified-files-with-expanded-descriptions}

WILL REMOVE:
{list-deleted-files}

## ✅ Testing Section Changes
{if-tests-run-show-before-after-comparison}
{if-tests-skipped-show-preservation-note}

## 📝 Commits Section Changes
WILL ADD:
{list-new-commits-since-last-update}

## 🎯 Metadata Updates
WILL UPDATE:
• Last Updated: {current-timestamp}
• Lines changed: {new-totals}
• Review time estimate: {old-estimate} → {new-estimate}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

👀 **Review these changes carefully!**

**Your choice:**
1. [P]roceed with update
2. [M]odify specific sections  
3. [C]ancel update

Please choose (P/M/C):"

**If choice M (Modify):**
Show section-by-section modification options:
"Which sections would you like to modify?
[ ] Files Section
[ ] Testing Section  
[ ] Commits Section
[ ] Metadata Updates

Select sections to customize (space-separated numbers):"

## Task 5: Apply Approved Changes 📝

After user approval, apply changes using intelligent merging:

```bash
# Read existing PR document
# Parse automated vs manual sections
# Apply updates while preserving user edits
```

Use smart merging strategy:
- Update sections marked with `<!-- AUTOMATED:START -->` and `<!-- AUTOMATED:END -->`
- Preserve all content outside automated sections
- Add visual change indicators:
  - ✨ for NEW items
  - 🔄 for UPDATED items  
  - 🗑️ for REMOVED items
- Maintain user comments and custom notes

Apply changes in this order:
1. Update Files Modified section with change indicators
2. Update Testing section (if tests were run)
3. Add new commits to commit history
4. Update PR metadata (timestamps, line counts)
5. Append to PR Update History table

## Task 6: Update History and Validation ✅

Add entry to the PR Update History section:

```markdown
## 📝 PR Update History

<!-- AUTOMATED:START -->
| Date | Time | Action | Key Changes | Test Status |
|------|------|--------|-------------|-------------|
{existing-entries}
| {current-date} | {current-time} | Updated | +{new-files} files, {feature-summary} | Tests: {test-summary} {status-emoji} |
<!-- AUTOMATED:END -->
```

Perform quality validation:
- Verify all placeholder text replaced with real data
- Confirm proper change indicators applied
- Check that user content was preserved
- Validate markdown syntax
- Ensure file paths are correct
- Verify test data is current (if tests run)

If any validation fails, note the issue but continue with file save.

## Task 7: Present Results and Confirmation 👀

Present the completion summary:

"✅ **PR document updated successfully!**

📁 **File Details:**
- Updated: {file-path}
- Template: {with-tests/without-tests}
- Size: {file-size}

📊 **Summary of Changes Applied:**
• Added {count} new files to documentation
• Updated {count} existing file descriptions
• {test-results-summary}
• Added {count} new commits
• Preserved all custom notes and edits
• Updated review time estimate: {old} → {new} minutes

🔄 **Change Indicators Added:**
• ✨ NEW items marked
• 🔄 UPDATED items marked  
• 🗑️ REMOVED items marked

📝 **Update History:**
Entry added to PR Update History table for transparency

💡 **Next steps:**
1. Review the highlighted changes in the document
2. Add screenshots if UI changes were made
3. Update deployment notes if needed
4. Share updated PR with your team

🔍 **View updated PR at:** {file-path}"

Confirm the intelligent update workflow completed successfully.