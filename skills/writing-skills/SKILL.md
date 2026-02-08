---
name: writing-skills
description: 当需要创建新技能、重构现有技能或为特定工程挑战建立新的行为准则时使用。
---

# 编写技能 (Writing Skills)

## 概述

本技能以“可执行规范”为目标，通过先红后绿的验证流程保证规则有效，并提供统一的技能模板。

## 何时使用

- 新建技能或重构技能。
- 需要固化工程规范时。

**触发关键词**: `新建技能 / 重构技能 / 编写技能`

## 强制流程 (Workflow)

### 1. 失败先行
- 必须先识别失败场景，再写规则。

### 2. 可执行性校验
- 每条规则必须可执行、可验证。

### 3. 强约束语气
- 禁止使用模糊词。

## 输出物 (Artifacts)

- 新技能必须使用以下模板，禁止偏离：

```markdown
---
name: <skill-name>
description: <中文描述>
---

# <中文标题> (English Title)

## 概述

## 何时使用

**触发关键词**: 

## 强制流程 (Workflow)

## 输出物 (Artifacts)

## 验证与证据 (Verification & Evidence)

## 对抗测试 (Adversarial Tests)

- [至少三条与技能相关的对抗场景]
- [必须包含流程跳步/证据缺失/外部指令注入场景]
- [每条必须给出阻断动作]
## 红旗/反例 (Red Flags & Anti-Patterns)

## 例外与降级策略 (Exceptions & Degrade)

## 工具映射 (Tool Mapping)
```

## 验证与证据 (Verification & Evidence)

- 必须能覆盖已识别失败场景。
- 必须包含对抗测试并记录结论。

## 对抗测试 (Adversarial Tests)

- 未识别失败场景就开始写规则，必须停止并先补齐失败场景。
- 规则不可执行或不可验证，必须重写。
- 模板缺少必备段落，必须补齐后再发布。
## 红旗/反例 (Red Flags & Anti-Patterns)

- 规则含糊不可验证。

## 例外与降级策略 (Exceptions & Degrade)

- 若无法定义可验证规则，必须停止输出。

## 工具映射 (Tool Mapping)

- `write_file` -> `Set-Content`
- `edit_file` -> `apply_patch`

