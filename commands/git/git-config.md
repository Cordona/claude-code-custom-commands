---
description: "Interactive Git user configuration with identity setup and GPG signing"
allowed-tools: ["Bash"]
---

# Git Configuration Setup

Think about the optimal Git configuration strategy for the user's development environment.

Execute each task in the logical sequence to set up complete Git identity and signing configuration.

## Task 1: Current State Analysis 🔍

Run git configuration analysis to understand the current setup.

Examine:
- Current user.name and user.email settings
- GPG signing configuration and available keys
- Whether configuration is global or local
- Repository context and team requirements

Present a clear summary of the current state.

## Task 2: Configuration Scope Selection 🎯

Based on the current repository and user setup, recommend configuration scope.

**Configuration Scope Options:**
1. **Global** 🌍 - Apply to all repositories on this machine (`git config --global`)
2. **Local** 📁 - Apply only to current repository (`git config --local`)
3. **Mixed** 🔄 - Set global defaults, with local overrides for this project

**Ask the user:**
"I recommend: **[your-recommendation]** because [reasoning].

Your choice:
1. Accept recommendation
2. Choose different scope
3. Explain the differences"

## Task 3: User Identity Configuration 👤

Configure the fundamental Git identity settings.

**Current Identity:**
- Name: [current-name or "Not set"]
- Email: [current-email or "Not set"]

**Identity Setup:**
1. **Name Configuration**
   - Current: [show current value]
   - Suggested: [if can be improved]
   - Prompt: "Enter your full name for Git commits:"

2. **Email Configuration**
   - Current: [show current value]
   - Suggested: [if can be improved]
   - Prompt: "Enter your email address for Git commits:"

**Show commit preview:**
"Your commits will appear as: **[Name] <[email]>**

Confirm this identity? (y/n)"

## Task 4: GPG Key Discovery & Selection 🔐

Analyze available GPG keys and configure signing.

**GPG Key Analysis:**
Run `gpg --list-secret-keys --keyid-format=long` to find available keys.

**Key Evaluation:**
- Match keys to the configured email address
- Check key expiration status
- Identify the best key for signing

**Present findings and options:**

### If keys are found:
"Found GPG keys for your email:
- **Active Key**: [key-id] (expires: [date])
- **Status**: [valid/expired/expiring-soon]

Your choice:
1. Use this key for Git signing
2. Select different key
3. Skip GPG signing
4. Create new GPG key"

### If no keys found:
"No GPG keys found for [email].

Your choice:
1. Create new GPG key (recommended)
2. Use existing key with different email
3. Skip GPG signing for now
4. Get help with GPG setup"

## Task 5: Advanced Configuration Options ⚙️

Configure additional Git settings for improved workflow.

**Optional Enhancements:**

### GPG Signing Settings
If GPG key selected:
- `commit.gpgsign = true` - Sign all commits
- `tag.gpgsign = true` - Sign all tags
- `gpg.program` - GPG program path (if needed)

### Commit Message Configuration
- Set up commit message template
- Configure preferred editor (nano, vim, code, etc.)
- Set up commit message validation

### Git Aliases & Shortcuts
Suggest useful aliases:
- `git st` → `git status`
- `git co` → `git checkout`
- `git br` → `git branch`
- `git last` → `git log -1 HEAD`

**Ask the user:**
"Which additional configurations would you like?
1. All recommended settings
2. Only GPG signing
3. Custom selection
4. Skip advanced options"

## Task 6: Apply Configuration ✅

Present complete configuration summary and apply changes.

**Configuration Summary:**
```
Scope: [global/local]
User Name: [name]
User Email: [email]
GPG Signing: [enabled/disabled]
GPG Key: [key-id or "None"]
Additional Settings: [list selected options]
```

**Git Commands to Execute:**
```bash
git config [--global/--local] user.name "[name]"
git config [--global/--local] user.email "[email]"
[Additional git config commands based on selections]
```

**Ask for final confirmation:**
"Ready to apply this configuration?

Your choice:
1. ✅ Apply all settings
2. 📝 Modify something first
3. 👀 Show exact commands that will run
4. ❌ Cancel configuration"

### Execute approved configuration
Run the git config commands and confirm each was successful.

## Task 7: Validation & Testing 🧪

Verify the configuration was applied correctly and test functionality.

**Configuration Verification:**
Run verification commands to confirm settings:
- `git config [scope] --list | grep user`
- `git config [scope] --list | grep gpg`
- Check GPG key accessibility

**Testing Process:**

### Identity Test
Show how commits will appear:
```bash
echo "Test commit preview:"
echo "Author: $(git config user.name) <$(git config user.email)>"
```

### GPG Signing Test (if enabled)
Create a test commit to verify GPG signing:
```bash
# Create temporary test
echo "test" > .git-config-test
git add .git-config-test
git commit -m "Test GPG signing configuration"
git verify-commit HEAD
git reset --hard HEAD~1
rm .git-config-test
```

**Results Summary:**
- ✅ Identity configuration: [status]
- ✅ GPG signing: [status/working/not-configured]
- ✅ Additional settings: [status]

**If issues found:**
Provide troubleshooting guidance:
- GPG key trust issues
- Path configuration problems
- Permission or access issues

**Success confirmation:**
"🎉 Git configuration completed successfully!

**Summary:**
- Name: [name]
- Email: [email]
- GPG Signing: [status]
- Scope: [global/local]

You're ready to make commits with your new configuration!"