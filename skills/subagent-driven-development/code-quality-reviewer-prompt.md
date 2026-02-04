# 代码质量审查者提示模板

调度代码质量审查者子智能体时使用此模板。

**目的：** 验证实施是否构建良好（整洁、经过测试、可维护）。

**仅在规范合规性审查通过后调度。**

```
Task 工具 (superpowers:code-reviewer) 或 delegate_to_agent:
  使用 requesting-code-review/code-reviewer.md 处的模板

  WHAT_WAS_IMPLEMENTED: [来自实施者的报告]
  PLAN_OR_REQUIREMENTS: [计划文件] 中的任务 N
  BASE_SHA: [任务之前的提交]
  HEAD_SHA: [当前提交]
  DESCRIPTION: [任务摘要]
```

**代码审查者返回（中文）：** 优势，问题（严重/重要/次要），评估
