# 代码质量审查者提示词模板 (Code Quality Reviewer Prompt Template)

当分派代码质量审查者子智能体时使用此模板。

**目的：** 验证实施构建良好（整洁、经过测试、可维护）

**仅在规范合规性审查通过后分派。**

```
Task tool (superpowers:code-reviewer):
  Use template at requesting-code-review/code-reviewer.md

  WHAT_WAS_IMPLEMENTED: [来自实施者的报告]
  PLAN_OR_REQUIREMENTS: 任务 N 来自 [计划文件]
  BASE_SHA: [任务前的提交]
  HEAD_SHA: [当前提交]
  DESCRIPTION: [任务摘要]
```

**代码审查者返回：** 优势，问题 (关键/重要/次要)，评估