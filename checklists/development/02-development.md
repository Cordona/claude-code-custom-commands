# Development Checklist

*Comprehensive daily validation for professional command development - the genius checklist concept*

---

## ✅ **Core Command Quality** *(Essential for every command)*

### **Purpose & Design**
- [ ] **Single Responsibility** - Command has one clear, focused purpose
- [ ] **Clear Naming** - Follows kebab-case with action verb (analyze-*, generate-*, review-*)
- [ ] **Scope Definition** - Purpose can be explained in one sentence
- [ ] **User Value** - Command provides clear, tangible benefits

### **YAML Frontmatter**
- [ ] **Description** - Clear, concise explanation of command purpose
- [ ] **Allowed-Tools** - Minimal necessary tools only
- [ ] **Tool Justification** - Each tool permission justified by specific need
- [ ] **Professional Quality** - Description is grammatically correct and actionable

---

## 🔒 **Security Implementation** *(Built-in security practices)*

### **Data Protection**
- [ ] **No Secret Exposure** - No API keys, passwords, tokens in outputs or logs
- [ ] **Safe Variable Handling** - $ARGUMENTS processed without security risks
- [ ] **Generic References** - Use "API key detected" instead of showing actual keys
- [ ] **Error Message Safety** - Error outputs contain no confidential information

### **Access Control**
- [ ] **Minimal Tool Access** - Only necessary tools granted (principle of least privilege)
- [ ] **Permission Validation** - Each tool permission justified by specific task
- [ ] **Scope Limitation** - Command access limited to required resources
- [ ] **Safe Operations** - No unsafe system commands or file operations

---

## ⚡ **Performance & Efficiency** *(Optimized for speed and resource usage)*

### **Context Management**
- [ ] **Efficient Context** - Avoids unnecessary file reading or broad searches
- [ ] **Progressive Loading** - Context expanded incrementally as needed
- [ ] **Targeted Operations** - Specific patterns instead of broad context loading
- [ ] **Resource Conservation** - Minimal memory and token usage
- [ ] **Strategic Context Building** - Foundation → Feature → Deep analysis progression
- [ ] **Context Budget Management** - Token-aware context loading and optimization
- [ ] **Target vs Broad Search** - Specific search patterns preferred over broad context loading

### **Tool Usage Optimization**
- [ ] **Tool Selection** - Most appropriate tool selected for each task
- [ ] **Operation Efficiency** - Read vs Edit vs Write choices optimized
- [ ] **Context vs Search Balance** - Efficient balance between context and targeted searches
- [ ] **Execution Time** - Reasonable completion time for task scope

---

## 🏗️ **Implementation Standards** *(Professional development practices)*

### **Prompt Engineering Excellence**
- [ ] **High-Level + Low-Level Pattern** - Strategic objectives + tactical instructions
- [ ] **Context Priming** - Efficient approach to context building
- [ ] **Variable Integration** - $ARGUMENTS incorporated naturally and safely
- [ ] **Multi-Argument Patterns** - Multiple $ARGUMENTS handled with descriptive context
- [ ] **Dynamic Variable Mastery** - Understanding of simple string replacement behavior

### **Advanced Reasoning Integration** *(For complex analysis commands)*
- [ ] **Thinking Mode Keywords** - Strategic use of think/think harder/think longer/ultrathink
- [ ] **Planning Phase Requirements** - Think before execute pattern for complex workflows
- [ ] **Strategic Planning Validation** - Planning approach matches task complexity
- [ ] **Complex Workflow Reasoning** - Advanced reasoning integration for multi-step processes

### **Task Organization**
- [ ] **Sequential Dependencies** - Each task builds logically on previous results
- [ ] **Clear Task Boundaries** - Distinct, focused responsibilities per task
- [ ] **Progressive Context** - Information flows properly between tasks
- [ ] **State Management** - Context and findings carried forward effectively
- [ ] **Dependency Patterns** - Linear, branching, or convergent workflows clearly structured

### **Error Handling**
- [ ] **Graceful Failure** - Handles invalid, empty, or unexpected inputs safely
- [ ] **User-Friendly Errors** - Clear, actionable error messages
- [ ] **Fallback Strategies** - Alternative approaches for common failures
- [ ] **Recovery Guidance** - Specific steps to resolve common issues

### **Advanced Workflow Design** *(For multi-step commands)*
- [ ] **Human-in-the-Loop Confirmation** - Strategic confirmation points before expensive operations
- [ ] **Validation Checkpoints** - Intermediate result validation for critical decisions
- [ ] **Conditional Logic Patterns** - Branching workflows based on findings (if/then patterns)
- [ ] **State Management** - Context and findings properly maintained across sequential tasks
- [ ] **Error Recovery Strategies** - Specific handling for workflow failures and partial results

---

## 📖 **Documentation & Usability** *(Clear communication and user experience)*

### **Usage Clarity**
- [ ] **Clear Examples** - Realistic usage scenarios with sample inputs
- [ ] **Parameter Documentation** - $ARGUMENTS usage and expectations clear
- [ ] **Output Quality** - Results are actionable, well-formatted, and useful
- [ ] **Valuable Outputs Focus** - Commands generate actionable documentation or insights
- [ ] **Integration Notes** - How command fits with team workflows
- [ ] **Interactive Decision Points** - Clear confirmation workflows for user choices

### **Team Integration**
- [ ] **Naming Conventions** - Follows team/project naming patterns
- [ ] **Consistency** - Aligns with existing team command patterns
- [ ] **File Organization** - Placed in appropriate directory structure
- [ ] **Cross-References** - Links to related commands when helpful

---

## 🧪 **Quality Validation** *(Testing and verification)*

### **Functional Testing**
- [ ] **Basic Testing** - Tested with typical usage scenario
- [ ] **Edge Case Check** - Handles empty, minimal, and unusual inputs
- [ ] **Error Testing** - Validated behavior with invalid inputs
- [ ] **Output Verification** - Results match expectations and requirements

### **Integration Testing**
- [ ] **Tool Compatibility** - All specified tools work as expected
- [ ] **Workflow Integration** - Command fits existing team workflows
- [ ] **Performance Validation** - Execution time within acceptable range
- [ ] **Team Compatibility** - Other team members can understand and use command

---

## 🚀 **Pre-Commit Validation** *(Final quality check)*

### **Release Readiness**
- [ ] **All Testing Complete** - Functional, edge case, and error testing passed
- [ ] **Documentation Complete** - All necessary information included and accurate
- [ ] **Security Verified** - No identified security risks or data exposure
- [ ] **Team Standards Met** - Follows established team patterns and requirements
- [ ] **Performance Acceptable** - Efficiency and resource usage appropriate
- [ ] **Review Ready** - Command ready for team review process

---

## 🔗 **Next Steps**

### **Ready for Deployment**
When all items above are checked, proceed to **[Post-Development Checklist](03-post-development.md)** for testing, deployment, and monitoring validation.

### **Need Additional Guidance**
- **[Best Practices Guide](../../guides/custom-commands/05-best-practices.md)** - Professional development patterns
- **[Security Guide](../../guides/custom-commands/06-security.md)** - Security implementation details
- **[Quality Assurance Guide](../../guides/custom-commands/07-quality-assurance.md)** - Testing strategies and quality standards

---

## 💡 **Development Tips**

### **Daily Usage**
- **Use this checklist for every command** - builds quality habits
- **Check items as you develop** - don't wait until the end
- **Focus on one section at a time** - prevents overwhelm

### **Quality Balance**
- **Security and performance are built-in** - not added later
- **User experience matters** - commands should be delightful to use
- **Team integration is essential** - commands are team assets

---

**🎯 The Daily Genius:** This checklist covers 80% of command quality with focused, practical validation. Master these practices for consistently excellent commands.

---

*Great commands result from consistent application of these standards. Use this checklist daily to build professional-quality automation that scales your impact.*