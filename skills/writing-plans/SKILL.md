---
name: writing-plans
description: 当持有已批准的设计规格 (Spec)，并准备进入多步骤实施阶段前使用，用于产出可追踪的执行蓝图。
---

# 编写实施计划 (Writing Plans)

## 概述

本技能将已批准的 Spec 拆解为可执行的原子任务（WBS），并为每一步定义验证方法，确保执行可追踪、可中断、可恢复。

## 何时使用

- 已有经确认的 Spec。
- 任务跨多个文件或预计分多批完成。
- 用户要求“计划 / 分解 / 实施蓝图”。

**触发关键词**: `计划 / 分解 / 实施 / WBS`

## 强制流程 (Workflow)

### 1. 零点确认
- 必须确认已有批准 Spec；没有 Spec 必须回退到 `brainstorming`。
- 必须确认工作区模式与交付模式，并写入计划文件。

### 2. WBS 原子化
- 任务必须拆到可验证、可提交的粒度。
- 单个任务修改量不得过大（上限 <= 50 行核心逻辑）。

### 3. 验证闭环
- 每个任务必须包含“验证”步骤。
- 验证必须可重复（脚本/命令/可观察输出）。

### 4. 执行门禁
- 未经用户批准的计划禁止执行。
- 必须将执行计划文件路径告知并作为唯一执行依据。

## 输出物 (Artifacts)

- **必须生成计划文件**：`docs/plans/[YYYY-MM-DD]-[task-name].md`。
- 必须使用以下模板，禁止偏离：

```markdown
# [Plan Title]

**依据文档**: [Spec Link]
**目标**: [简述目标]

## 决策记录 (Decisions)
- **工作区模式**: [Current Directory / Worktree]
- **交付模式**: [Manual / Local Auto-commit]
- **执行模式**: [Auto-continue / Checkpoint Confirm]

## 任务清单 (Tasks)

- [ ] **Task 01: [任务名]**
    - [ ] 动作: [要做什么]
    - [ ] 验证: [验证方法/命令]
    - [ ] 提交: `feat: [message]`
```

## 验证与证据 (Verification & Evidence)

- 计划文件必须存在且包含“决策记录 + 任务清单”。
- 每个任务必须有明确验证方法。

## 对抗测试 (Adversarial Tests)

- 缺少已批准 Spec 仍试图规划，必须回退到 brainstorming。
- 任务缺少验证步骤或粒度过大，必须拆分并补齐验证。
- 未经用户批准就请求执行，必须停止。
## 红旗/反例 (Red Flags & Anti-Patterns)

- 未经批准就进入执行。
- 任务缺少验证步骤。
- 任务粒度过大或含糊。

## 例外与降级策略 (Exceptions & Degrade)

- 若无法拆解（信息不足），必须回到 Spec 补充范围。
- 若用户拒绝计划，必须停止执行。

## 工具映射 (Tool Mapping)

- `write_file` -> `Set-Content`
- `edit_file` -> `apply_patch`
- `run_shell_command` -> `shell_command`

