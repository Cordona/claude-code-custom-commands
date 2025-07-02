---
description: "Generate comprehensive feature documentation with intelligent discovery and configurable depth"
allowed-tools: ["Bash", "Read", "Write", "Grep", "Glob"]
---

# Interactive Feature Documentation Generator

Think harder about discovering and analyzing the requested feature to create comprehensive documentation suitable for onboarding and AI context.

Execute each task in the order given to create a feature knowledge capsule.

## Task 1: Discover Feature Components 🔍

Use $ARGUMENTS as the feature description to search for. If $ARGUMENTS is empty, prompt:

"What feature would you like me to explain? 
Examples: 'authentication system', 'JWT handling', 'user permissions', 'file upload process'"

Search the codebase using multiple intelligent strategies:

```bash
# Extract keywords from feature description
# Search for relevant files and components
grep -r "{keywords}" --include="*.java" --include="*.js" --include="*.py" src/
find . -name "*{keyword}*" -type f | grep -E "\.(java|js|py|yml|xml|json)$"

# Look for related test files
find . -name "*Test*" -o -name "*test*" | grep -i "{keywords}"

# Search configuration files
grep -r "{keywords}" --include="*.yml" --include="*.xml" --include="*.properties" .
```

Analyze and present discovered components:

"🎯 **Found Feature: {Detected-Feature-Name}**

**Primary Components:**
• Main Service: {service-file-path}
• Controllers: {controller-files}  
• Configuration: {config-files}
• Database: {schema-files-or-tables}
• Tests: {test-count} test files

**Entry Points:**
• API Endpoints: {api-paths}
• Public Methods: {key-methods}

**Is this the feature you want documented?**
1. Yes, proceed with this scope
2. Refine search (provide more specific terms)
3. Select different components
4. Provide direct file path instead

Your choice (1-4):"

If choice 2, ask for refined description. If choice 3, show component selection menu. If choice 4, accept direct path input.

## Task 2: Confirm Feature Boundaries 🎯

Present the confirmed feature scope and relationships:

"📊 **Feature Scope Confirmation**

**Core Components:** {component-count} files
**Related Systems:** {integration-points}
**Estimated Complexity:** {simple/moderate/complex}

**Dependencies:** 
{list-key-dependencies}

**Used By:**
{list-consumers-of-this-feature}

**Scope looks correct?**
1. Yes, proceed with documentation
2. Add more components  
3. Remove some components
4. Start over with different feature

Your choice (1-4):"

## Task 3: Select Documentation Audience 👥

Present audience options with clear explanations:

"📚 **Documentation Audience Selection**

Who will primarily read this documentation?

**1. Technical (Developers, Architects)**
• Code snippets with implementation details
• Technical terminology and patterns
• Architecture diagrams and data flows
• Integration patterns and data flow
• Test strategies and edge cases

**2. Mixed (Technical + Product Team)**  
• Balanced technical and business language
• Key code insights with behavior explanations
• Visual diagrams emphasized
• Business rules and technical constraints

**3. Non-Technical (Product, Business Stakeholders)**
• Focus on capabilities and user impact
• Minimal code, maximum clarity
• Business flows and scenarios
• Feature limitations and considerations

**Your choice (1-3):**"

## Task 4: Configure Investigation Depth 🔬

Present comprehensive depth options with clear scope definitions:

"🔬 **Investigation Depth Selection**

Choose how comprehensive the analysis should be:

**1. Shallow**
📋 **Includes:**
• Main classes and interfaces only
• High-level architecture overview
• Primary business logic flows
• Basic API endpoints

❌ **Excludes:**
• Test files and coverage analysis
• Configuration files and setup
• Error handling and edge cases
• Performance characteristics
• Integration points

**2. Medium** - **Recommended**
📋 **Includes:**
• Everything from Shallow +
• Key configuration files
• Important test scenarios and coverage
• Basic error handling patterns
• Primary integration points

❌ **Excludes:**
• Complete test suite analysis
• All configuration file variations
• Complex business logic edge cases
• Detailed component interaction patterns

**3. Deep** - **Maximum Detail**
📋 **Includes:**
• Everything from Medium +
• Complete test suite analysis (test scenarios and edge cases)
• All configuration files and environment setup
• Comprehensive error handling and validation flows
• Full integration point mapping
• Detailed business logic flows and decision points
• Complete component interaction patterns

⚠️ **Time Consideration:** Deep analysis may take significant time for complex features.

**Your choice (1-3) [default: 2]:**"

After selection, confirm the scope:

"✅ **Selected: {Chosen-Depth} Investigation**

📊 **Analysis Scope:**
{display-specific-inclusions-based-on-depth}

⏱️ **Estimated time:** {time-estimate}

Proceed with {depth} investigation? (y/n/change-depth):"

## Task 5: Execute Feature Analysis 🕵️

Perform analysis based on the selected depth level:

**For all depths, analyze:**
- Core component structure and responsibilities
- Main business logic flows
- Key public interfaces and methods

**Additional for Medium depth:**
```bash
# Analyze key configuration files
grep -r "feature-related-configs" --include="*.yml" --include="*.properties" .

# Basic test coverage
find . -name "*Test*" | grep -i "feature-name"

# Primary integrations
grep -r "feature-service" --include="*.java" src/
```

**Additional for Deep depth:**
```bash
# Complete test analysis
find . -path "*/test/*" -name "*.java" | xargs grep -l "feature-keywords"

# All configuration file variations
find . -name "*.yml" -o -name "*.xml" -o -name "*.properties" | xargs grep -l "feature"

# Business logic and validation flows
grep -r "validation\|business\|logic\|workflow" {feature-files}

# Full dependency mapping
grep -r "import.*{feature}" src/ | cut -d: -f1 | sort | uniq
```

Present analysis progress:

"🔍 **Analyzing Feature: {Feature-Name}**
═══════════════════════════════════════

✓ Core components ({component-count} files)
{depth-specific-progress-indicators}

🔗 **Discovered relationships:**
• Used by: {consumer-list}
• Depends on: {dependency-list}
{additional-findings-based-on-depth}"

## Task 6: Generate Feature Documentation 📝

Create comprehensive documentation based on audience and depth selections.

Generate appropriate content structure:

**For Technical Audience:**
```markdown
# Feature: {Feature-Name}

**Generated**: {timestamp}
**Branch**: {current-branch}
**Commit**: {current-commit}
**Audience**: Technical
**Depth**: {selected-depth}

## Executive Summary
{2-3 paragraph technical overview}

## Architecture Overview
{mermaid-diagram-of-component-relationships}

## Core Components
{detailed-component-analysis-based-on-depth}

{depth-conditional-sections}
```

**For Non-Technical Audience:**
```markdown
# Feature: {Feature-Name}

**Generated**: {timestamp}
**Audience**: Non-Technical

## What is {Feature-Name}?
{simple-business-explanation}

## Key Capabilities
{what-it-can-and-cannot-do}

## How It Works
{step-by-step-user-experience}

{simplified-technical-explanation-with-analogies}
```

Include depth-appropriate sections:
- **Shallow**: Basic components and flows only
- **Medium**: + Configuration analysis + Key tests + Basic integrations  
- **Deep**: + Complete test analysis + All configs + Business logic flows + Component interactions

## Task 7: Save and Present Results ✅

Create the feature documentation file:

```bash
mkdir -p .claude/artifacts/features
# Generate timestamp-based filename
echo "FEATURE-{feature-name}-{timestamp}.md"
```

Save the generated documentation and present completion summary:

"✅ **Feature documentation generated successfully!**

📁 **File Details:**
- Path: `.claude/artifacts/features/FEATURE-{feature-name}-{timestamp}.md`
- Audience: {selected-audience}
- Depth: {selected-depth}
- Size: {file-size}

📊 **Analysis Summary:**
• Components analyzed: {component-count} files
• {depth-specific-analysis-summary}
• Integration points: {integration-count}
• {test-coverage-if-analyzed}

💡 **How to use this documentation:**

**For AI Sessions:**
1. Include as context when working on {feature-name}
2. Reference for understanding system behavior
3. Use as baseline for modifications

**For Team Members:**
1. Share as onboarding material
2. Review during architecture discussions  
3. Update when feature evolves

🔗 **Related Components:**
{list-discovered-related-files-and-systems}

📂 **Documentation available at:** `.claude/artifacts/features/`"

## Task 6: Prompt User for Content Verification ⚡

Present content verification option with clear cost/benefit analysis:

"🔍 **Content Verification Available**

**Benefits:**
• Validates all technical claims against actual codebase
• Prevents hallucination in generated documentation  
• Provides confidence scoring and quality assessment
• Flags unverifiable content for manual verification

**Resource Requirements:**
• **Time:** Additional processing time for verification analysis
• **Tokens:** Extra token usage for codebase analysis and reporting
• **Tools:** Requires Read, Grep, and Bash access for codebase analysis

**Verification Scope:**
• Code examples and API contracts
• File paths and architecture claims
• Technology stack assertions
• Configuration examples

**Enable content verification for this documentation? (y/n) [default: n]:**"

**Handle User Response:**
- **If 'y':** Proceed to Execute Content Verification Framework task
- **If 'n':** Skip verification and continue with standard workflow
- **If no response:** Default to 'n' (skip verification)

**Cost-Benefit Guidance:**
- **Recommend 'y' for:** Technical documentation, API guides, architecture descriptions
- **Recommend 'n' for:** Simple updates, conceptual content, time-sensitive work

## Task 7: Execute Content Verification Framework 🔍

[Only execute if user selected 'y' in Task 6]

Execute the complete embedded verification framework from `.claude/embedded/verify-technical-content.md`:

**Framework Execution:**
- Framework handles its own initialization and execution planning
- Applies all 6 tasks systematically (initialization + 5 verification phases)
- Generates comprehensive verification report with confidence assessment
- All execution logic contained within embedded framework for consistency

**Self-Contained Execution:** The embedded framework is fully self-executing and requires no additional coordination from the calling command.

Confirm the feature analysis and documentation workflow completed successfully.