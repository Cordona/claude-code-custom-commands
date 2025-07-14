---
description: "Enterprise-grade conventional commit message composer with comprehensive git analysis and error handling"
allowed-tools: ["Bash", "Read"]
---

# Intelligent Commit Message Composer

Think harder about analyzing the current git changes to compose an optimal conventional commit message.

**Key Features:** State management, error recovery, intelligent analysis, dual workflow support (IDE + CLI), and quality assurance.

Execute each task in sequence to create a high-quality conventional commit message.

## Task 0: Validate Environment 🔍

Verify proper environment for commit message composition using these git commands:
- `git rev-parse --is-inside-work-tree` (check git repository)
- `git diff --name-only | wc -l` (count unstaged changes)
- `git diff --cached --name-only | wc -l` (count staged changes)
- `git status --porcelain | wc -l` (total changes)

**Success Criteria:** Inside git repository AND has changes (staged OR unstaged).

**Error Handling:**
- Not in git repository → "❌ Not in a git repository. Please run this command from within a git project."
- No changes at all → "❌ No changes found. Please make some changes to your files before creating a commit message."

Initialize tracking state for workflow continuity.

## Task 1: Analyze Repository State 🔍

Execute comprehensive repository analysis to understand change context and complexity.

**Analysis Objectives:**
- Determine file categories (source, tests, docs, config) and change complexity
- Identify affected directories for scope suggestions
- Detect repository patterns (monorepo vs standard structure)
- Extract branch information for ticket reference detection

**Use appropriate git commands:** `git status --porcelain`, `git diff --cached --stat`, `git branch --show-current`, `git diff --cached --numstat`

**Present Summary:**
```
📊 **Repository Analysis:**
- Files: [count] ([categories])
- Complexity: [Simple/Moderate/Complex]
- Areas: [affected directories]
- Branch: [current-branch]
```

## Task 2: Suggest Commit Type 🎯

Analyze changes using intelligent pattern recognition to suggest the most appropriate conventional commit type.

**Analysis Approach:**
- File pattern analysis (extensions, paths, content nature)
- Directory context and change scope
- Modification type assessment (new, modified, deleted)

**Present intelligent suggestion with reasoning:**

"Based on my analysis, I suggest: **[type]** because [reasoning].

**Available types:** feat ✨, fix 🐛, docs 📚, style 💄, refactor ♻️, test ✅, chore 🔧

**Your choice:**
1. Accept my suggestion
2. Choose different type
3. Specify custom type"

## Task 3: Determine Scope 📝

Suggest optimal scope using intelligent directory pattern recognition.

**Pattern Recognition:**
- **Monorepo:** packages/*, apps/*, libs/*, services/* → suggest component name
- **Standard:** src/auth/, components/, docs/ → suggest logical area
- **Smart Grouping:** Identify most specific scope encompassing all changes

Present scope suggestion with reasoning and offer alternatives (accept/modify/skip).

## Task 4: Compose Subject Line ✍️

Create concise, impactful summary following conventional commit standards (≤50 characters, imperative mood, clear and specific).

Present suggestion with character count and analysis. Offer alternatives if requested or if user's message exceeds 50 characters.

## Task 5: Extract Ticket Reference 🎫

Analyze branch name for ticket references using pattern recognition:
- **JIRA:** feature/PROJ-1234 → JIRA: PROJ-1234
- **GitHub:** fix/issue-456 → GitHub: #456  
- **GitLab:** feature/mr-789 → GitLab: !789

If extraction fails, prompt for ticket system and reference, or skip.

## Task 6: Assess Body Requirement 📄

Intelligently assess if commit body is needed based on change complexity and type.

**Recommend body for:** Complex changes (>10 files or >200 lines), cross-component changes, bug fixes needing context, new features, breaking changes.

**Skip body for:** Simple changes (1-3 files, <50 lines), obvious updates, minor formatting.

If body recommended and accepted, generate structured content explaining what changed, why, and any implementation notes.

## Task 7: Present Final Message and Execute 👀

Assemble complete conventional commit message and present with quality validation.

**Format:** `[type]([scope]): [subject]\n\n[ticket]\n\n[body]`

**Quality Check:** Verify format compliance, length limits, imperative mood, and consistency.

**User Options:**
1. ✅ Copy to clipboard (recommended for IDE workflow)
2. 🚀 Execute git commit immediately
3. ✏️ Make modifications
4. 🔄 Regenerate options
5. ❌ Cancel

**For Clipboard:** Use appropriate OS command (pbcopy/xclip/clip) with proper escaping.

**For Git Commit:** 
- Check staging status: if unstaged changes exist, offer to stage or copy to clipboard
- Execute `git commit -m "[message]"` with proper escaping and validation
- Confirm success with commit hash and summary

Handle errors gracefully with specific guidance and recovery options.