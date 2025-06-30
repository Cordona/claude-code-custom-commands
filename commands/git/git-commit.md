---
description: "Intelligent conventional commit message composer with git analysis"
allowed-tools: ["Bash", "Read"]
---

# Intelligent Commit Message Composer

Think harder about analyzing the current git changes to compose an optimal conventional commit message.

Execute each task in the order given to create a high-quality conventional commit message.

## Task 1: Analyze Repository State 🔍

Run `git status` and `git diff --stat` to understand the current changes.

Examine:
- Modified, added, and deleted files
- Number of files changed and line modifications
- Branch name for potential ticket extraction
- Scope of changes to determine complexity

Present a brief summary of what you found.

## Task 2: Suggest Commit Type 🎯

Based on your analysis of the changes, suggest the most appropriate conventional commit type.

Present the suggestion with reasoning, then ask:

**Common types available:**
1. **feat** ✨ - New feature or functionality  
2. **fix** 🐛 - Bug fix
3. **docs** 📚 - Documentation changes
4. **style** 💄 - Code style/formatting (no logic changes)
5. **refactor** ♻️ - Code restructuring (no feature/bug changes)
6. **test** ✅ - Adding or updating tests
7. **chore** 🔧 - Maintenance tasks, build changes

**Ask the user:**
"Based on my analysis, I suggest: **[your-suggestion]** because [reasoning].

Your choice:
1. Accept my suggestion
2. Choose a different type from the list  
3. Specify a custom type

## Task 3: Determine Scope 📝

Analyze the file paths from the git changes to suggest an appropriate scope.

Look for patterns like:
- Directory names (auth, api, ui, docs, etc.)
- Component areas being modified
- Logical groupings of the changes

**Ask the user:**
"Based on the file paths, I suggest scope: **[your-suggestion]**

Your choice:
1. Accept suggested scope: `([scope])`
2. Provide different scope
3. Skip scope (no parentheses)"

## Task 4: Compose Subject Line ✍️

Create a concise summary of the changes following conventional commit best practices:
- Maximum 50 characters
- Present tense, imperative mood ("add" not "added")
- No period at the end
- Clear and descriptive

Present your suggestion and ask:

"I suggest: **[your-suggestion]** ([character-count] characters)

Your choice:
1. Accept this message
2. Provide your own message
3. See 5 alternative suggestions"

If the user provides their own message and it exceeds 50 characters:
- ⚠️ Warn about the length limit
- Explain why 50 characters is best practice (git log readability in terminals)
- Ask: "Would you like me to suggest shorter alternatives, or proceed with your message?"

If the user accepts the suggestion for shorter alternatives, provide 5 alternative messages that:
- Stay within the 50-character limit
- Are aligned with the scope of the discovered changes
- Follow conventional commit best practices
- Maintain the essence of the user's original message

## Task 5: Extract Ticket Reference 🎫

Run `git branch --show-current` to get the current branch name.

Attempt to extract ticket information using these patterns:
- **JIRA**: `feature/PROJ-1234-description` → `JIRA: PROJ-1234`
- **GitHub**: `fix/issue-456-description` → `GitHub: #456`  
- **GitLab**: `feature/mr-789-description` → `GitLab: !789`

If extraction succeeds, ask:
"Found ticket reference: **[extracted-reference]**
Include this in the commit message? (y/n)"

If extraction fails, ask:
"Could not extract ticket from branch name: **[branch-name]**

Which system are you using?
1. JIRA (enter ticket like PROJ-1234)
2. GitHub (enter issue number)
3. GitLab (enter MR number)  
4. Other (enter custom reference)
5. None (skip ticket reference)"

## Task 6: Assess Body Requirement 📄

Based on the complexity of changes analyzed in Task 1, determine if a commit body is needed.

**Recommend body for:**
- Changes affecting multiple files/components
- Bug fixes that need explanation
- Features requiring context
- Breaking changes

**Skip body for:**
- Simple one-line changes
- Obvious documentation updates
- Minor refactoring

Present your assessment:
"Based on the change complexity, I **[recommend/don't recommend]** adding a body because [reasoning].

Your choice:
1. Generate a structured body for me
2. I'll write my own body
3. Skip the body"

If option 1 is chosen, create a concise body that:
- Explains what changed and why
- Provides context for the modifications
- Notes any breaking changes or important details
- Keeps it informative but brief

## Task 7: Present Final Message and Execute 👀

Assemble the complete commit message in this format:

```
[type]([scope]): [subject]

[ticket-reference]

[body-if-included]
```

Present the final message and ask:

"📝 **Complete commit message:**
```
[show-complete-message]
```

Your choice:
1. ✅ Copy to clipboard
2. 🚀 Execute git commit  
3. ✏️ Make changes
4. ❌ Start over"

### For clipboard option:
Run the appropriate command for the user's OS:
- **macOS**: `echo "[message]" | pbcopy`
- **Linux**: `echo "[message]" | xclip -selection clipboard`
- **Windows**: `echo "[message]" | clip`

Confirm: "✅ Commit message copied to clipboard! Run `git commit` when ready."

### For git commit option:
Execute: `git commit -m "[complete-message-properly-escaped]"`

Confirm the commit was successful and show the commit hash.