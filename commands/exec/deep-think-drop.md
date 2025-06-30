---
description: "Deactivate deep thinking mode while preserving learned preferences and offering optional analytics"
allowed-tools: ["Write"]
---

# Deep Thinking Mode Deactivation

Think about gracefully deactivating the intelligent deep thinking mode while preserving learned preferences for future sessions.

Execute each task in the order given to cleanly deactivate deep thinking mode.

## Task 1: Check Current Mode Status 🔍

Detect and analyze the current deep thinking mode state:

Check for active mode markers:
- Look for `[DEEP_THINKING_MODE_ACTIVE]` indicator
- Detect any analysis in progress
- Identify preserved preferences 
- Assess session statistics

If mode is not active:

"❌ **Deep thinking mode is not currently active.**

To activate: `/user:deep-thinking-init`"

If mode is active, proceed to Task 2.

## Task 2: Handle Active Analysis (If Applicable) ⚠️

If deep analysis is currently in progress, manage interruption gracefully:

"⚠️ **Deep analysis in progress:** {current-analysis-topic}
═══════════════════════════════════════

**Would you like to:**
1. Let me finish first (~{estimated-time} min)
2. Stop and save progress
3. Stop immediately

Your choice (1-3):"

Handle user response:
- **Option 1**: Complete analysis, then proceed to deactivation
- **Option 2**: Save current progress, then deactivate
- **Option 3**: Immediately terminate and proceed to deactivation

If no analysis in progress, proceed directly to Task 3.

## Task 3: Simple Deactivation Process 🔄

Perform the core deactivation with progressive disclosure:

"✅ **Deep Thinking Mode: DEACTIVATED**
═══════════════════════════════════════

**Status:**
✓ Complexity detection engine: Offline
✓ Traffic light indicators: Disabled
✓ Standard response mode: Restored

**Preserved for Next Session:**
• Your learned preferences have been saved
• Pattern recognition data maintained
• Domain-specific settings preserved

📊 **Would you like to see session statistics?** (y/n)"

This follows progressive disclosure - simple users get simple confirmation, power users can access detailed analytics.

## Task 4: Optional Session Analytics 📊

**If user chooses 'y' for statistics:**

Present comprehensive session summary:

"📊 **Deep Thinking Session Summary**
═══════════════════════════════════════

**Session Overview:**
• Total queries processed: {query-count}
• Deep analyses performed (🔴): {deep-count}
• Medium complexity queries (🟡): {medium-count}
• Simple queries handled (🟢): {simple-count}
• Session duration: {duration}

🎯 **Learned Preferences (Saved):**
{For each learned preference}
• {domain} → {preference-level} {reasoning}

💡 **Efficiency Insights:**
• Most complex topic: {complex-topic}
• Tokens saved via smart routing: ~{token-savings}
• Efficiency rating: {efficiency-percentage}%
• Learning accuracy: {accuracy-percentage}%

💾 **Export detailed analytics?** (y/n)"

**If user chooses 'n' for statistics:**

"👍 **Got it! Deep thinking mode is off.**

To reactivate anytime: `/user:deep-thinking-init`"

## Task 5: Optional Detailed Analytics Export 💾

**If user requests analytics export:**

"💾 **Export Detailed Analytics**
═══════════════════════════════════════

**This will save:**
• Complete query history and complexity scores
• Response time analysis and token usage
• Learning pattern evolution data
• Preference development timeline

**Save to:** `.claude/analytics/session_{timestamp}.json`

Proceed with export? (y/n)"

**If user confirms export:**

```bash
# Create analytics directory
mkdir -p .claude/analytics

# Generate comprehensive analytics file
# Include: query patterns, learning evolution, efficiency metrics
```

Present completion:

"✅ **Analytics exported successfully!**

📁 **File:** `.claude/analytics/session_{timestamp}.json`
📊 **Contains:** Complete session analysis and learning data

Your thinking mode preferences are preserved for next activation."

**If user declines export:**

"Session complete! Your preferences are saved for next time. 🚀"

## Task 6: Clean State Transition 🧹

Remove active mode markers and ensure clean state:

Remove persistent state markers:
- Clear `[DEEP_THINKING_MODE_ACTIVE]` indicator
- Preserve `[USER_PREFERENCES: {data}]` for future sessions
- Reset `[LEARNING_PATTERNS: DISABLED]` (but preserve learned data)

Validate clean transition:
- Confirm no lingering analysis context
- Verify standard response mode restored
- Ensure preference data safely stored

If state cleanup issues detected:

"⚠️ **Detected incomplete state cleanup**

Some context markers may persist. 
**Force complete reset?** (y/n)"

## Task 7: Present Deactivation Confirmation 🏁

Confirm successful deactivation and provide guidance:

"🏁 **Deep Thinking Mode: Successfully Deactivated**

**Final Status:**
✅ Mode terminated cleanly
✅ Standard Claude behavior restored  
✅ Learned preferences preserved for future sessions
{If analytics exported: ✅ Session analytics saved}

**Your Experience:**
{If statistics were viewed, provide key insight}
{If analytics exported, mention file location}

**Next Steps:**
• I'm back to standard response mode
• Your learned preferences will be restored when you reactivate
• Reactivate anytime: `/user:deep-thinking-init`

Thanks for using Deep Thinking Mode! The system learned valuable patterns from your session that will make future interactions even more efficient. 🧠✨

[DEEP_THINKING_MODE_DROPPED]"

Confirm the deep thinking mode deactivation workflow completed successfully.