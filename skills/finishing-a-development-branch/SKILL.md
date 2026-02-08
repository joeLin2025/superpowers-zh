---
name: finishing-a-development-branch
description: 当实施完成、所有测试通过，并且需要决定如何集成工作或准备发起 PR 时使用。
---

# 完成开发分支与集成 (Finishing a Development Branch)

## 概述

本技能确保合并前质量与历史整洁，避免将临时状态带入主干，并提供统一的合并/PR 说明模板。

## 何时使用

- 计划任务全部完成并验证通过。
- 准备发起 PR 或合并至主干。

**触发关键词**: `完成 / 合并 / 准备 PR / 集成`

## 强制流程 (Workflow)

### 1. 全量验证
- 必须运行测试与静态检查。
- 任一失败必须先修复再进入合并。

### 2. 环境净化
- 必须清理临时日志、调试代码与无关文件。

### 3. 历史整洁
- 提交必须原子且语义明确。
- 禁止混入计划外改动。

### 4. 合并说明
- 必须提供合并/PR 说明，包含风险与验证信息。

## 输出物 (Artifacts)

- 合并/PR 说明必须使用以下模板：

```text
Title: [简要标题]
Why: [为什么要改]
What: [做了什么]
Risks: [潜在风险]
Verification: [测试/验证命令]
```

## 验证与证据 (Verification & Evidence)

- 必须记录测试命令与结果摘要。
- 必须声明是否存在未覆盖场景。

## 红旗/反例 (Red Flags & Anti-Patterns)

- 测试未通过仍请求合并。
- PR 说明缺少风险或验证。
- 混入计划外变更。

## 例外与降级策略 (Exceptions & Degrade)

- 若测试耗时过长，必须说明范围与原因，并标记为“未全量验证”。

## 工具映射 (Tool Mapping)

- `run_shell_command` -> `shell_command`
- `git` -> `git` 命令行

