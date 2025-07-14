---
description: "Synchronize all project documentation when custom commands are updated with professional changelog generation"
allowed-tools: [ "Bash", "Read", "Write", "Edit", "MultiEdit", "Grep", "Glob", "LS" ]
---

# Command Documentation Synchronizer

Think harder about synchronizing all project documentation when custom commands are updated, ensuring consistency across
documentation ecosystem with professional change tracking.

Execute each task in the order given to maintain documentation integrity with sophisticated change management.

## Task 1: Command Discovery & Analysis 🔍

Analyze the updated command to understand its functionality and documentation impact.

**If $ARGUMENTS provided:** Use the provided command path directly.

**If no arguments provided:** Prompt the user for the command path:

"🔍 **Command Update Documentation Synchronizer**

Which custom command was updated? Please provide the absolute path to the command file.

**Examples:**

- `/full/path/to/commands/docs/dev/dev-journal-create.md`
- `/full/path/to/commands/exec/deep-think-init.md`
- `/full/path/to/commands/git/git-commit.md`

**Command path:** "

**Command Analysis:**

Validate the command file exists and analyze its structure and functionality:

1. **Validate the command path** and ensure it's a valid custom command file
2. **Extract command metadata** from the file path:
    - **Category:** Parent directory name (e.g., `git` from `commands/git/git-commit.md`)
    - **Command name:** Filename without extension (e.g., `git-commit`)
    - **Relative path:** Full path from commands directory
3. **Analyze command functionality** by reading:
    - YAML frontmatter for description and allowed tools
    - Command title and main description
    - Task count and complexity indicators
    - Interactive elements and validation steps

**Present comprehensive analysis summary including:**

- Command name, category, and file path
- Functionality overview and complexity assessment
- Task structure and interactive capabilities
- Any significant changes or enhancements detected

"📊 **Command Analysis Complete:**

**Command Details:**

- Name: `$COMMAND_NAME`
- Category: `$COMMAND_CATEGORY`
- Complexity: $TASK_COUNT tasks
- Interactive: $HAS_INTERACTIVE
- Validation: $HAS_VALIDATION

Ready to analyze documentation impact? (y/n)"

## Task 2: Documentation Impact Assessment 📚

Identify all documentation files that reference the updated command and assess the scope of required updates.

**Search Strategy:**

1. **Find command references** across all markdown files using appropriate search patterns
2. **Identify high-priority files** that always need updating (catalog, README, guides)
3. **Assess update scope** based on the number of files and reference complexity
4. **Calculate change impact** to determine synchronization strategy

**Priority Assessment:**

- **Critical files:** Command catalog, main README, guide documentation
- **Reference files:** Any documentation containing command usage examples
- **Scope classification:** Simple (1-3 files), Moderate (4-8 files), Complex (9+ files)

**Present comprehensive impact assessment including:**

- Update scope classification (Simple/Moderate/Complex)
- Total files requiring synchronization
- Critical vs. optional file breakdown
- Recommended synchronization strategy

**Provide user options:**

1. **Full synchronization** - Update all references (recommended)
2. **Critical only** - Update just high-priority files
3. **Review specific files** - Choose which files to update
4. **Preview changes first** - See what would change before deciding

Handle user choice appropriately for next task.

## Task 3: Interactive Update Strategy Selection 🎯

Configure the update strategy based on the user's choice from Task 2.

**Strategy Configuration:**

1. **Full synchronization:** Update all identified files with command references
2. **Critical only:** Update just high-priority documentation files
3. **Selective updates:** Allow user to choose specific files from the identified list
4. **Preview first:** Generate preview before any updates

**For selective updates:** Present a clear file selection interface and parse user choices.

**Present strategy confirmation including:**

- Selected strategy type
- Number of files to update
- Estimated completion time
- List of files in scope

Confirm readiness to proceed with the chosen strategy.

## Task 4: Documentation Synchronization Preview 📋

**CRITICAL: Show detailed preview before making ANY changes to documentation files.**

Generate a comprehensive preview of all planned documentation changes:

**Preview Strategy:**

1. **Analyze each file** in the update scope to identify specific changes needed
2. **Categorize updates** by type (catalog entries, references, examples, navigation)
3. **Estimate impact** of each change on existing content structure
4. **Present clear summary** of what will be modified, added, or synchronized

**Preview Content:**

- **Planned changes** for each file with specific details
- **Update types** (catalog entry, reference update, example synchronization)
- **Impact assessment** (content additions, modifications, structural changes)
- **Change summary** with file count and scope

**User Approval Options:**

1. **Accept all changes** - Proceed with full synchronization
2. **Review file by file** - Approve each file individually
3. **Modify scope** - Change which files to update
4. **Cancel operation** - Exit without changes

Handle user choice and proceed to implementation or return to previous tasks as needed.

## Task 5: Apply Approved Documentation Changes ✏️

Apply the approved documentation changes systematically and safely.

**Documentation Update Strategy:**

1. **Create Backups:** Safely backup all files before making changes
2. **Update Command Catalog:** Synchronize the main command catalog with current functionality
3. **Update Reference Files:** Align README and guide documentation
4. **Maintain Structure:** Preserve existing content organization while updating references

**Primary Update Tasks:**

**Command Catalog Synchronization:**

- Extract updated command metadata and functionality details
- Update or create catalog entry with current capabilities
- Synchronize usage examples and command descriptions
- Update quick reference tables and navigation

**Reference File Updates:**

- Update command mentions in README and guide files
- Align usage examples with current functionality
- Synchronize navigation links and learning paths
- Maintain consistency across all documentation

**Quality Assurance:**

- Validate all updates maintain content structure
- Ensure no broken links or references
- Add appropriate change indicators and timestamps
- Create comprehensive change tracking

## Task 6: Professional Changelog Generation 📋

Generate a professional changelog documenting all updates made to the command and related documentation.

**Changelog Location & Structure:**

- **Directory:** `commands/info/changelogs/{category}/{command-name}/`
- **File naming:** `{command-name}-YYYYMMDD-HHMMSS.md`
- **Index file:** `commands/info/changelogs/README.md` (update with new entry)

**Required Content Sections:**

1. **Command Metadata:**
    - Command name, category, date, time
    - Updated by (git user.name)
    - File path reference

2. **Summary:**
    - Purpose of documentation synchronization
    - Scope of changes applied

3. **Changes Made:**
    - **Changed:** Updated command catalog, synchronized references
    - **Fixed:** Resolved documentation drift, corrected descriptions
    - Detailed list of files modified

4. **Impact Assessment:**
    - User impact level (typically Low for documentation)
    - Consistency improvements achieved
    - Documentation files updated

5. **Technical Details:**
    - Command file path
    - Documentation files updated count
    - Synchronization scope and complexity
    - Backup location reference

6. **Files Modified:**
    - Complete list with descriptions of changes per file

**Changelog Index Management:**

- Update the master index file with new changelog entry
- Maintain chronological listing of all command updates

## Task 7: Validation & Results Summary ✅

Validate all updates and present comprehensive completion summary.

**Validation Strategy:**

1. **File Validation:** Verify all updated files exist and are accessible
2. **Changelog Verification:** Confirm changelog was created successfully
3. **Syntax Checking:** Basic markdown validation for updated files
4. **Quality Assurance:** Overall process validation and error checking

**Completion Summary:**
Present comprehensive results including:

- **Files Updated:** List of all synchronized documentation files
- **Changelog Generated:** Location and format details
- **Changes Applied:** Summary of synchronization activities
- **Quality Validation:** Pass/fail status for all validation checks
- **Impact Assessment:** User impact and consistency improvements
- **Next Steps:** Recommended follow-up actions
- **Resources:** Links to updated files and change history

**Success Criteria:**

- All documentation files successfully synchronized
- Professional changelog generated with complete change tracking
- No validation errors in updated files
- Clear completion summary with actionable next steps