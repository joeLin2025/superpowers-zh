---
name: skill-localization-and-polishing
description: 当需要创建、翻译或优化中文技能文档，且要求实现高信噪比、强约束力的专家级规范时使用。
---

# 技能本地化与极致打磨 (Skill Localization & Polishing)

## 概述

本技能负责将技能文档升级为高约束、可审计的专家规则体系，并通过对抗测试提升稳健性。

## 何时使用

- 翻译或优化技能文档。
- 新建专家角色规范。

**触发关键词**: `优化技能 / 编写规范 / 打磨`

## 强制流程 (Workflow)

### 1. 外部知识注入
- 必须执行实时搜索获取权威参考。
- 搜索来源仅记录在执行记录中，不写入技能文档。

### 2. 架构级脑暴
- 必须进行至少两轮脑暴。
- 输出角色画像、核心工作流、禁止项。

### 3. 对抗测试
- 必须模拟违规行为并补洞。

### 4. 信噪比审计
- 删除“建议/可能/通常”等弱约束词。
- 每条规则必须可执行、可验证。

## 输出物 (Artifacts)

- 必须输出技能文档的改动摘要：

```text
Polish Report:
- Scope:
- Key Changes:
- Risks:
```

## 验证与证据 (Verification & Evidence)

- 必须证明规则可执行与可审计。
- 必须记录对抗测试结论。

## 对抗测试 (Adversarial Tests)

- 未执行外部搜索或无权威来源记录，必须停止并补齐搜索记录。
- 未完成两轮脑暴或缺少角色画像/工作流/禁止项，必须补齐。
- 对抗测试未记录结论，必须停止并补齐记录。
## 红旗/反例 (Red Flags & Anti-Patterns)

- 跳过外部搜索。
- 使用模糊表达。
- 无对抗测试记录。

## 例外与降级策略 (Exceptions & Degrade)

- 若无法获得权威来源，必须说明原因并停止更新。

## 工具映射 (Tool Mapping)

- `read_file` -> `Get-Content`
- `write_file` -> `Set-Content`
- `edit_file` -> `apply_patch`

