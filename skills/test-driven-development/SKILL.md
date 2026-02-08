---
name: test-driven-development
description: 在实施任何逻辑变更或修复 Bug 之前使用，强制执行先写测试、后写实现的研发模式。
---

# 测试驱动开发 (TDD)

## 概述

本技能通过“红-绿-重构”闭环确保每一行实现都有明确行为约束，禁止“先实现后补测”。

## 何时使用

- 新功能或新接口。
- 逻辑变更涉及核心路径。

**触发关键词**: `TDD / 测试驱动 / 先写测试`

## 强制流程 (Workflow)

### 1. Red
- 必须先写失败测试，证明需求存在。

### 2. Green
- 只写最小实现让测试通过。

### 3. Refactor
- 通过后再重构，保持测试绿灯。

### 4. 禁止补测
- 实现后补测试视为违规。

## 输出物 (Artifacts)

- 如需新增测试文件，必须遵循以下模板骨架（语言无关）：

```text
# tests/<unit>_test.<ext>
# Arrange
# Act
# Assert
```

## 验证与证据 (Verification & Evidence)

- 必须记录失败测试与通过测试的输出摘要。
- 必须能重现 Red -> Green 的过程。

## 对抗测试 (Adversarial Tests)

- 先写实现或补测，必须停止并回到 Red 步骤。
- 无失败测试输出或不可复现，必须先修复测试。
- Red 或 Green 过程未记录，必须补齐输出摘要。
## 红旗/反例 (Red Flags & Anti-Patterns)

- 无失败测试就写实现。
- 为了通过测试而修改测试期望。

## 例外与降级策略 (Exceptions & Degrade)

- 若无法编写可验证测试，必须说明原因并停止实现。

## 工具映射 (Tool Mapping)

- `run_shell_command` -> `shell_command`
- 测试框架使用项目内现有工具，禁止引入新框架。

