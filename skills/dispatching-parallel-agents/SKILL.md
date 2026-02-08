---
name: dispatching-parallel-agents
description: 当面临 2 个及以上可独立进行、无共享状态且无顺序依赖的任务时，用于调度多个并行智能体以提升执行效率。
---

# 调度并行智能体 (Dispatching Parallel Agents)

## 概述

本技能通过任务隔离与冲突预检，实现安全并行执行，合并前必须完成全量回归验证。

## 何时使用

- 存在 2+ 可独立任务。
- 任务间无共享状态或顺序依赖。

**触发关键词**: `并行 / 多任务 / 可拆分`

## 强制流程 (Workflow)

### 1. 任务隔离
- 每个子任务必须声明修改边界（文件/目录）。
- 任务不得修改同一文件。

### 2. 指令完备
- 必须为每个任务给出输入、输出、验证标准。

### 3. 冲突预检
- 合并前必须检查是否存在文件冲突与逻辑冲突。

### 4. 全量回归
- 合并前必须执行完整测试。

## 输出物 (Artifacts)

- 需为每个子任务提供任务简报：

```text
Task Brief:
- Scope:
- Files:
- Verification:
- Output:
```

## 验证与证据 (Verification & Evidence)

- 必须记录每个子任务的验证结果。
- 合并前必须记录全量回归结果。

## 红旗/反例 (Red Flags & Anti-Patterns)

- 任务间存在文件重叠。
- 合并前未执行回归。

## 例外与降级策略 (Exceptions & Degrade)

- 若无法隔离任务，必须回退为串行执行。

## 工具映射 (Tool Mapping)

- `run_shell_command` -> `shell_command`
- `git` -> `git` 命令行

