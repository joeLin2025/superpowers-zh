---
name: requesting-code-review
description: 当完成任务、实施主要功能或在合并之前使用，以验证工作是否符合要求
---

# 请求代码审查 (Requesting Code Review)

分派 `superpowers:code-reviewer` 子智能体在问题级联之前捕捉它们。该智能体的角色定义在 `./AGENT.md` 中。

**核心原则：** 尽早审查，经常审查。

## 何时请求审查

**强制:**
- 在子智能体驱动开发的每个任务之后
- 完成主要功能后
- 合并到 main 之前

**可选但有价值:**
- 卡住时（新视角）
- 重构前（基线检查）
- 修复复杂 Bug 后

## 如何请求

**1. 获取 git SHAs:**
```bash
BASE_SHA=$(git rev-parse HEAD~1)  # or origin/main
HEAD_SHA=$(git rev-parse HEAD)
```

**2. 分派 code-reviewer 子智能体:**

使用 Task 工具并指定 `superpowers:code-reviewer` 类型，填充 `code-reviewer.md` 任务模板。

**占位符:**
- `{WHAT_WAS_IMPLEMENTED}` - 你刚刚构建了什么
- `{PLAN_OR_REQUIREMENTS}` - 它应该做什么
- `{BASE_SHA}` - 起始提交
- `{HEAD_SHA}` - 结束提交
- `{DESCRIPTION}` - 简要摘要

**3. 对反馈采取行动:**
- 立即修复关键 (Critical) 问题
- 在继续前修复重要 (Important) 问题
- 记录次要 (Minor) 问题以供稍后处理
- 如果审查者错误，反驳（带有理由）

## 示例

```
[刚刚完成任务 2: 添加验证函数]

You: 在继续之前让我请求代码审查。

BASE_SHA=$(git log --oneline | grep "Task 1" | head -1 | awk '{print $1}')
HEAD_SHA=$(git rev-parse HEAD)

[分派 superpowers:code-reviewer 子智能体]
  WHAT_WAS_IMPLEMENTED: 对话索引的验证和修复函数
  PLAN_OR_REQUIREMENTS: 任务 2 来自 docs/plans/deployment-plan.md
  BASE_SHA: a7981ec
  HEAD_SHA: 3df7661
  DESCRIPTION: 添加了带有 4 种问题类型的 verifyIndex() 和 repairIndex()

[子智能体返回]:
  优势: 清晰的架构，真实的测试
  问题:
    重要: 缺少进度指示器
    次要: 报告间隔的魔法数字 (100)
  评估: 准备好继续

You: [修复进度指示器]
[继续到任务 3]
```

**代码审查请求的描述、任务总结及后续的反馈讨论必须使用自然、专业的中文。**

## 与工作流集成

**子智能体驱动开发 (Subagent-Driven Development):**
- 每个任务后审查
- 在问题复合之前捕捉它们
- 在移动到下一个任务前修复

**执行计划 (Executing Plans):**
- 每批次（3 个任务）后审查
- 获取反馈，应用，继续

**临时开发 (Ad-Hoc Development):**
- 合并前审查
- 卡住时审查

## 危险信号 (Red Flags)

**绝不:**
- 因为“很简单”而跳过审查
- 忽略关键问题
- 带着未修复的重要问题继续
- 与有效的技术反馈争论

**如果审查者错误:**
- 用技术理由反驳
- 展示证明其有效的代码/测试
- 请求澄清

参见模板：./code-reviewer.md