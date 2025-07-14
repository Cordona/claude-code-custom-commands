---
description: "Exit any active custom command mode and restore Claude to default behavior"
allowed-tools: ["Read"]
---

# Universal Custom Command Mode Exit

Think about detecting and terminating any active custom command modes to restore clean default Claude behavior.

Execute each task in the order given to safely exit all active custom command modes.

## Task 1: Detect Active Custom Command Modes 🔍

Scan for any active custom command mode indicators:

Check for active mode markers:
- `[DEEP_THINKING_MODE_ACTIVE]` - Deep thinking mode
- `[FEATURE_DOC_MODE_ACTIVE]` - Feature documentation mode  
- `[DEV_JOURNAL_MODE_ACTIVE]` - Development journal mode
- `[PR_DOC_MODE_ACTIVE]` - PR documentation mode
- Any other custom command state indicators

Analyze session context:
- Estimate session duration for active modes
- Identify any pending work or documents in progress
- Assess what accomplishments to highlight

If no custom modes are active:

"ℹ️ **No custom command mode currently active.**

You're already in default Claude mode.
**Available custom commands:** `/user:[command-name]`"

If active modes detected, proceed to Task 2.

## Task 2: Assess Mode-Specific Context 📊

For each detected active mode, gather relevant session information:

**For Deep Thinking Mode:**
- Query complexity distribution
- Learning patterns acquired
- Efficiency metrics

**For Feature Documentation Mode:**
- Documents created or in progress
- Components analyzed
- Investigation depth level

**For Development Journal Mode:**
- Journals created
- Session change tracking
- Captured decisions and TODOs

**For PR Documentation Mode:**
- PR documents generated
- Test results included
- Review complexity assessment

**For Any Other Modes:**
- Mode-specific accomplishments
- Session duration
- Generated artifacts

## Task 3: Present Mode Detection Summary 🎯

Display comprehensive detection results:

**If Single Mode Active:**

"✅ **Detecting Active Custom Command Mode**
═══════════════════════════════════════

**Active Mode:** {mode-name}
**Session Duration:** {duration}
**Key Accomplishments:**
{mode-specific-accomplishments}

**Prepared to terminate mode and restore default behavior.**"

**If Multiple Modes Active:**

"✅ **Detecting Multiple Active Custom Command Modes**
═══════════════════════════════════════

**Active Modes Detected:**
1. {mode-1}: {duration-1} ({accomplishments-1})
2. {mode-2}: {duration-2} ({accomplishments-2})
{additional-modes}

**Prepared to terminate all modes and restore default behavior.**"

## Task 4: Perform Mode-Specific Cleanup 🧹

Execute appropriate cleanup for each detected mode:

**For Deep Thinking Mode:**
- Preserve learned preferences
- Clear complexity detection state
- Save session analytics
- Remove thinking indicators

**For Feature Documentation Mode:**
- Clear investigation context
- Remove file tracking state
- Reset analysis depth settings
- Preserve generated documents

**For Development Journal Mode:**
- Stop change tracking
- Clear session metrics
- Remove temporal markers
- Preserve created journals

**For PR Documentation Mode:**
- Clear git analysis context
- Remove commit templates
- Reset quality check settings
- Preserve generated PR documents

**For Universal Cleanup:**
- Remove all custom command state markers
- Clear any persistent session contexts
- Reset to default Claude behavior
- Validate clean state transition

## Task 5: Handle Any Work in Progress ⚠️

If any modes have work in progress, manage appropriately:

**For Active Document Generation:**

"⚠️ **Work in Progress Detected**

{Mode-name} has active document generation:
• {document-type}: {completion-percentage}% complete

**Options:**
1. Let me finish current work first (~{estimated-time} min)
2. Save progress and exit
3. Discard progress and exit immediately

Your choice (1-3):"

Handle user response:
- **Option 1**: Complete work, then proceed to termination
- **Option 2**: Save current state, then terminate
- **Option 3**: Immediately discard and terminate

**For Completed Work:**
Proceed directly to mode termination.

## Task 6: Execute Mode Termination 🔄

Terminate all active modes and restore default behavior:

**Single Mode Termination:**

"✅ **Dropping Custom Command Mode**
═══════════════════════════════════════

**Terminated Mode:** {mode-name}
**Session Duration:** {duration}
**Accomplishments:** {key-accomplishments}

🔄 **Restoring default Claude behavior...**

✓ Custom mode terminated
✓ State cleared
✓ Default behavior restored

You're now back to standard Claude interaction.
{mode-specific-thank-you-message}"

**Multiple Mode Termination:**

"✅ **Dropping Multiple Custom Command Modes**
═══════════════════════════════════════

**Terminated Modes:**
• {mode-1}: {accomplishments-1}
• {mode-2}: {accomplishments-2}
{additional-modes}

🔄 **Restoring default Claude behavior...**

✓ All custom modes terminated
✓ All custom states cleared
✓ Default behavior restored

You're now back to standard Claude interaction."

## Task 7: Present Clean Exit Confirmation 🏁

Confirm successful mode termination and provide guidance:

**Standard Completion:**

"🏁 **Custom Command Mode Exit: Complete**

**Final Status:**
✅ All custom modes successfully terminated
✅ State cleanup completed
✅ Default Claude behavior restored

**Session Summary:**
{highlight-key-accomplishments-across-all-modes}

**Generated Assets:**
{list-any-files-or-documents-created}

**Next Steps:**
• You're back to standard Claude interaction
• All generated files are preserved
• Activate custom commands anytime with `/user:[command-name]`

Thanks for using the custom command system! 👋

**Quick Reactivation:**
• Feature docs: `/user:doc-feature-explain`
• Dev journals: `/user:doc-dev-progress` 
• PR docs: `/user:doc-pr-create`
• Deep thinking: `/user:deep-thinking-init`

[ALL_CUSTOM_MODES_DROPPED]"

**If State Cleanup Issues:**

"⚠️ **Partial state cleanup detected**

Some context markers may persist from complex mode interactions.

**Force complete reset?** (y/n)

**If 'y':** Remove all possible custom command state markers
**If 'n':** Continue with current cleanup level"

Confirm the universal custom command mode exit workflow completed successfully.