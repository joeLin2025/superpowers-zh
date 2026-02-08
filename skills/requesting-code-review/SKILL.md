---
name: requesting-code-review
description: 当完成功能开发、修复 Bug 或准备合并分支时使用，以发起高质量的审查请求。
---

# 发起代码审查请求 (Requesting Code Review)

## 概述

本技能要求在请求审查前完成自审与上下文注入，帮助审查者聚焦风险与逻辑。

## 何时使用

- 功能开发或 Bug 修复完成。
- 准备合并至主分支。

**触发关键词**: `代码审查 / Review / 评审 / 请求审查`

## 强制流程 (Workflow)

### 1. 自审先行
- 必须完成自审与最小回归验证。

### 2. 上下文注入
- 必须说明为什么做、做了什么、风险与验证。

### 3. 风险自述
- 必须明确未覆盖场景与潜在风险。

## 输出物 (Artifacts)

- 审查请求说明必须使用以下模板：

```text
Review Request:
- Why:
- What:
- Risks:
- Verification:
- Out of Scope:
```

## 验证与证据 (Verification & Evidence)

- 必须附带测试或验证输出摘要。

## 红旗/反例 (Red Flags & Anti-Patterns)

- 无验证就请求审查。
- 缺少风险与范围说明。

## 例外与降级策略 (Exceptions & Degrade)

- 若无法执行验证，必须说明原因并标记为“未验证”。

## 工具映射 (Tool Mapping)

- `run_shell_command` -> `shell_command`
- `git` -> `git` 命令行

