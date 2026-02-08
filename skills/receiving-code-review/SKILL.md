---
name: receiving-code-review
description: 当收到代码审查反馈时，在实施建议之前使用，以确保理性、客观地吸收反馈并改进代码。
---

# 接收代码审查 (Receiving Code Review)

## 概述

本技能要求在实施反馈前先完成理解与验证，确保反馈落地可追踪、可证据化。

## 何时使用

- 收到审查意见或反馈建议。

**触发关键词**: `收到审查 / 审查反馈 / 评审意见`

## 强制流程 (Workflow)

### 1. 逐条理解
- 必须逐条复述反馈含义。
- 不理解时必须先追问，禁止盲改。

### 2. 证据验证
- 必须用日志、测试或实验验证反馈的有效性。

### 3. 有序落实
- 优先处理高风险问题。
- 每条改动必须绑定验证记录。

## 输出物 (Artifacts)

- 回复审查时必须使用以下模板：

```text
Review Response:
- Comment: [审查点]
- Decision: [采纳/不采纳]
- Evidence: [验证结果]
- Action: [改动摘要]
```

## 验证与证据 (Verification & Evidence)

- 每条反馈必须有证据或明确理由。
- 不得仅口头表示“已处理”。

## 红旗/反例 (Red Flags & Anti-Patterns)

- 未理解就直接修改。
- 忽略高风险反馈。

## 例外与降级策略 (Exceptions & Degrade)

- 若反馈与需求冲突，必须回到 Spec 或计划澄清。

## 工具映射 (Tool Mapping)

- `run_shell_command` -> `shell_command`
- `edit_file` -> `apply_patch`

