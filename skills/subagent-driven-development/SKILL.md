---
name: subagent-driven-development
description: 当在当前会话中执行涉及复杂逻辑、多步骤实施或需要严格隔离审查的计划任务时使用。
---

# 子代理驱动开发 (Subagent-Driven Development)

## 概述

本技能将复杂任务拆解为角色隔离的子任务，并通过零信任审计与双层审查防止偏差与漏改。

## 何时使用

- 多步骤、复杂实现需要隔离执行与审查。
- 并行执行多个原子任务。

**触发关键词**: `子代理 / 多角色 / 隔离审查`

## 强制流程 (Workflow)

### 1. 角色隔离
- 实现者不做审查。
- 审查者不写实现。

### 2. 任务委派
- 必须明确任务边界、输入、输出、验收标准。

### 3. 零信任审计
- 子代理输出必须被验证。
- 不可直接合并未经验证的输出。

### 4. 双层复核
- 实现完成后必须经过独立审查。

## 输出物 (Artifacts)

- 子代理任务说明必须使用以下模板：

```text
Subtask:
- Role:
- Scope:
- Inputs:
- Outputs:
- Verification:
```

## 验证与证据 (Verification & Evidence)

- 必须记录审查意见与验证结果。

## 红旗/反例 (Red Flags & Anti-Patterns)

- 实现者与审查者角色混合。
- 未验证就合并子代理输出。

## 例外与降级策略 (Exceptions & Degrade)

- 若无法找到独立审查者，必须回退为单代理执行并强化自审。

## 工具映射 (Tool Mapping)

- `run_shell_command` -> `shell_command`
- `edit_file` -> `apply_patch`

