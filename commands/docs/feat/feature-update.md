---
description: "Intelligently update existing feature documentation with drift detection and change preview"
allowed-tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# Intelligent Feature Documentation Updater

Think harder about updating existing feature documentation to detect implementation changes and apply intelligent updates while preserving manual edits.

Execute each task in the order given to update an existing feature document with sophisticated change management.

## Task 1: Locate and Validate Feature Document 📍

If $ARGUMENTS is provided, use it as the feature document path. If $ARGUMENTS is empty, prompt:

"What feature documentation would you like to update?

📁 **Available feature documents:**"

```bash
# List available feature documents with metadata
find .claude/artifacts/features -name "FEATURE-*.md" -type f -exec stat -f "%m %N" {} \; | sort -rn | head -10 | while read timestamp path; do
    echo "• $(basename "$path") ($(date -r $timestamp '+%Y-%m-%d %H:%M') - $((($(date +%s) - $timestamp) / 86400)) days ago)"
done
```

For the selected document, validate and present details:

```bash
# Get document metadata
git log -1 --format="%H %cr %an" "$DOCUMENT_PATH"
wc -c "$DOCUMENT_PATH"
```

Present validation summary:

"📄 **Found: {document-name}**

**Document Details:**
• Created: {creation-date} ({days-ago} days ago)
• Size: {file-size}
• Author: {author}
• Original commit: {commit-hash}

**Proceed with update analysis?**
1. Yes, analyze this document
2. Select different document
3. Cancel

Your choice (1-3):"

## Task 2: Configure Investigation Strategy 🔬

Present investigation depth options with clear scope definitions:

"🔬 **Re-investigation Depth Selection**

How thoroughly should I analyze the feature for changes?

**1. Full Investigation** - **Recommended**
📋 **Includes:**
• Complete re-analysis of all documented components
• Detection of new relationships and dependencies
• Identification of removed or deprecated components
• Comprehensive change magnitude calculation
• Full architectural evolution assessment

**2. Changed Files Only**
📋 **Includes:**
• Focus on files modified since document creation
• Git diff analysis for specific changes
• Targeted component re-examination
• Basic change detection

**3. Quick Verification**
📋 **Includes:**
• Verify documented components still exist
• Check for major structural changes only
• Basic drift detection

Your choice (1-3) [default: 1]:"

Extract the original documentation metadata:

```bash
# Extract original commit from document if present
grep -o "commit [a-f0-9]\{7,\}" "$DOCUMENT_PATH" | head -1 | cut -d' ' -f2
```

## Task 3: Execute Feature Re-investigation 🔍

Based on the selected depth, perform re-investigation of the feature:

"🔍 **Re-investigating Feature Components**
═══════════════════════════════════════════════════════════════

**Current Analysis vs Original Documentation:**"

**For all depths, analyze:**
```bash
# Get current state compared to original documentation date
git log --since="$DOCUMENT_DATE" --name-only --pretty=format: | sort | uniq > changed_files.tmp

# Extract feature name and components from existing documentation
grep -E "^# Feature:|^## [A-Z]" "$DOCUMENT_PATH"
```

**Additional for Full Investigation:**
```bash
# Comprehensive component analysis
grep -r "{feature-keywords}" --include="*.java" --include="*.js" --include="*.py" src/
find . -name "*Test*" | grep -i "{feature-keywords}"
grep -r "{feature-keywords}" --include="*.yml" --include="*.xml" --include="*.properties" .
```

**Additional for Changed Files Only:**
```bash
# Focus on modified files since document creation
git diff --stat "$ORIGINAL_COMMIT"..HEAD
git log "$ORIGINAL_COMMIT"..HEAD --oneline
```

Present discovery progress:

"✓ **Discovery Progress:**
• Core components: {component-count} files ({change-indicator})
• Configuration files: {config-count} files ({change-indicator})
• Test files: {test-count} files ({change-indicator})
• Dependencies: {dependency-count} detected ({change-indicator})

🔗 **Change Detection Summary:**
• Files modified: {modified-count}
• Files added: {added-count}
• Files removed: {removed-count}
• Lines changed: +{additions} -{deletions}"

## Task 4: Analyze Changes with Confidence Scoring 📊

Apply sophisticated change detection with confidence scoring algorithm:

```bash
# Calculate change metrics
git diff --stat "$ORIGINAL_COMMIT"..HEAD | tail -1
git log "$ORIGINAL_COMMIT"..HEAD --oneline | wc -l
```

Implement confidence scoring:
- Component name match: +40 points
- File modification date: +30 points
- Functionality preservation: +20 points
- Architecture consistency: +10 points

Present comprehensive change analysis:

"📊 **Change Analysis Report**
═══════════════════════════════════════

🔄 **ARCHITECTURAL CHANGES:**

{For each detected change with confidence >= 70%}
**{Change-Category}** (Confidence: {confidence}%)
   Documentation: {original-state}
   Current: {current-state}
   Evidence:
   • {specific-evidence-1}
   • {specific-evidence-2}
   • {specific-evidence-3}

📈 **IMPROVEMENTS DETECTED:**
{List improvements with metrics}

⚠️ **REMOVED/DEPRECATED:**
{List removed components with evidence}

🆕 **NEW COMPONENTS:**
{List new components with descriptions}

**Overall Change Magnitude:** {percentage}% ({severity-level})"

Calculate change magnitude:
- Minor changes: < 30%
- Moderate changes: 30-60%
- Major changes: 60-85%
- Fundamental rewrite: > 85%

If change magnitude > 70%, warn:

"⚠️ **Significant Structural Changes Detected!**

Change Magnitude: {percentage}% ({severity-level})

**Recommendation:** {recommendation-based-on-magnitude}

**Options:**
1. Update existing document (preserve history)
2. Create new version (FEATURE-{name}-V2)
3. Mark current as deprecated, create fresh documentation

Your choice (1-3):"

## Task 5: Generate Comprehensive Change Preview 📝

**CRITICAL: Show detailed preview before making ANY changes to the feature document.**

Create comprehensive diff-style preview:

"📝 **Documentation Update Preview**
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

{Generate line-by-line diff preview showing:}
- Lines to be added with + prefix
- Lines to be removed with - prefix
- Sections to be updated with clear before/after
- New sections to be added
- Metadata updates (timestamps, version info)

📊 **Preview Summary:**
• Lines to add: {add-count}
• Lines to remove: {remove-count}
• Lines to modify: {modify-count}
• Sections to add: {new-sections}
• Sections to update: {updated-sections}
• Change magnitude: {percentage}%

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

👀 **Review these changes carefully!**

**Your choice:**
1. [A]ccept all changes
2. [R]eview section by section
3. [M]odify specific sections
4. [C]ancel update

Please choose (A/R/M/C):"

If option R (Review section by section):
Present each section change for individual approval.

If option M (Modify specific sections):
Show section-by-section modification options.

## Task 6: Create Change Log and Apply Updates ✅

After user approval, apply changes using intelligent merging:

```bash
# Create change log directory structure
mkdir -p .claude/artifacts/feature-changes/$(date +%Y%m%d)

# Generate change log filename
echo "CHANGELOG-{feature-name}-UPDATE-$(date +%Y%m%d-%H%M%S).md"
```

Apply smart merging strategy:
- Update sections marked with `<!-- AUTOMATED:START -->` and `<!-- AUTOMATED:END -->`
- Preserve all content outside automated sections
- Add visual change indicators:
  - ✨ for NEW items
  - 🔄 for UPDATED items
  - 🗑️ for REMOVED items
- Maintain user comments and custom notes

Generate comprehensive change log:

```markdown
# Feature Documentation Change Log

**Feature**: {feature-name}
**Document**: {document-path}
**Update Date**: {current-timestamp}
**Update Number**: {sequence-number}
**Change Magnitude**: {percentage}% ({severity-level})

## 📊 Summary of Changes

### 🏗️ Architectural Evolution
| Component | Previous | Current | Impact |
|-----------|----------|---------|--------|
{architecture-change-table}

### 📈 Metrics Evolution
| Metric | Previous | Current | Change |
|--------|----------|---------|---------|
{metrics-change-table}

### 🆕 New Capabilities
{new-capabilities-list}

### ⚠️ Breaking Changes
{breaking-changes-list}

### 📝 Documentation Structure Changes
{structure-changes-list}

## 🔍 Technical Details
{detailed-technical-changes}

## 📌 Migration Notes
{migration-guidance}
```

Update the feature document with approved changes and proper change indicators.

## Task 7: Present Results and Confirmation 👀

Present completion summary:

"✅ **Feature documentation updated successfully!**

📁 **File Details:**
- Updated: {document-path}
- Change log: .claude/artifacts/feature-changes/{date}/CHANGELOG-{feature-name}-UPDATE-{timestamp}.md
- Update magnitude: {percentage}% ({severity-level})

📊 **Summary of Changes Applied:**
• Added {count} new sections
• Updated {count} existing sections
• Applied {count} component changes
• Preserved all custom notes and edits
• Updated review time estimate: {old-estimate} → {new-estimate} minutes

🔄 **Change Indicators Added:**
• ✨ NEW items marked
• 🔄 UPDATED items marked
• 🗑️ REMOVED items marked

📝 **Update History:**
Entry added to feature update tracking for transparency

💡 **Next steps:**
1. Review the highlighted changes in the document
2. Validate change log for breaking changes
3. Share updated documentation with team if significant changes
4. Consider creating v2 if feature continues evolving significantly

🔍 **Updated documentation available at:** {document-path}
📚 **Change history available at:** .claude/artifacts/feature-changes/{date}/"

Confirm the intelligent update workflow completed successfully.