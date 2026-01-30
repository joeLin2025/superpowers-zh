---
name: writing-skills
description: "当用户要求创建技能、编写/重写 SKILL.md、生成技能包，或你需要编辑现有技能时使用。融合了 TDD 方法论、需求澄清交互与严格的交付规范。"
---

# 编写技能 (Writing Skills) - 终极融合版

## 概述

**编写技能是应用于流程文档的测试驱动开发 (TDD)，结合了专业的产品交互流程。**

本技能指导你从**接待用户需求**开始，通过**TDD 循环**（红-绿-重构），最终交付一个**结构规范、抗合理化且易于检索**的技能包。

**核心原则：**
1.  **交互先行**：面对模糊需求，先澄清再动手（专业级模式）。
2.  **TDD 铁律**：如果没有先行的失败测试（压力场景），就没有技能。
3.  **防弹设计**：利用心理学原则堵死 Agent 的合理化借口。

## 深度理论参考
- **TDD 深度指南**：见 [references/testing-skills-with-subagents.md](references/testing-skills-with-subagents.md)
- **说服原则与心理学**：见 [references/persuasion-principles.md](references/persuasion-principles.md)
- **Anthropic 官方最佳实践**：见 [references/anthropic-best-practices.md](references/anthropic-best-practices.md)

---

## 第一阶段：需求澄清与交互 (The Interaction)

**在开始编写任何文件之前，先确定交付强度。**

### 1. 判断模式
- **快速模式**（默认）：用户需求明确，只想要草稿。-> **直接进入第二阶段。**
- **专业级模式**：用户需求含糊，或明确要求“专业级/可测试”。-> **执行下方澄清策略。**

### 2. 澄清策略（专业级模式必做）
1.  **猜测意图**：提出 2-4 个合理的意图假设。
2.  **提供选项**：针对关键分歧点提供编号选项（目标、输入、输出、边界）。
3.  **循环收敛**：输出“需求摘要”，直到通过门槛检查。

---

## 第二阶段：TDD 设计 (The Design)

**铁律：没有先行的失败测试，就没有技能。**

在编写 `SKILL.md` 正文之前，必须先设计测试用例（压力场景）。

### TDD 循环映射
| 阶段 | 动作 | 目标 |
|------|------|------|
| **红 (RED)** | 运行无技能压力场景 | 看到 Agent 失败，记录其借口（合理化）。 |
| **绿 (GREEN)** | 编写最小可行技能 | 针对借口编写规则，使 Agent 合规。 |
| **重构 (REFACTOR)** | 堵塞新漏洞 | 发现新借口 -> 添加反击 -> 重新验证。 |

---

## 第三阶段：编写与结构 (The Implementation)

### 1. 标准目录结构
```text
skill-name-kebab-case/
  SKILL.md              # 核心：单一事实源
  scripts/              # 可选：辅助脚本
  references/           # 可选：深度参考资料
  assets/               # 可选：输出素材
```

### 2. SKILL.md 规范结构
- **YAML Frontmatter**：`name` 必须 kebab-case；`description` 只写“何时使用”，**严禁总结工作流**。
- **正文建议章节**：目的、何时使用、流程/步骤、护栏与红旗、示例。

### 3. 抗合理化技巧 (Bulletproofing)
- **明确否定**：不要只说“写测试”，要说“测试前写代码？删除它。”
- **精神与字面**：添加“违反字面意思就是违反精神”。
- **更多绘图规范**：见 [references/graphviz-conventions.dot](references/graphviz-conventions.dot)

**新创建的技能说明文件（SKILL.md）必须包含高质量的中文翻译和说明，确保对中文语境下的 Agent 具有良好的引导性。**

---

## 第四阶段：交付与验证 (Delivery)

### 1. 验证清单 (Checklist)
- [ ] `description` 是否以 "Use when..." 开头且未包含流程步骤？
- [ ] 是否包含针对“红阶段”借口的明确反击？
- [ ] 示例是否包含用户输入原话 + 关键输出片段？
- [ ] 是否遵循了**渐进式披露**（细节移入 references/）？

### 2. 最终输出
一次性输出完整的文件夹名称、`SKILL.md` 内容及辅助文件内容。

---

## 反模式 (Anti-Patterns)
- ❌ **叙述性故事**：用通用原则代替“我曾遇到...”。
- ❌ **“巫毒常量”**：脚本中出现不明原因的幻数。
- ❌ **深层嵌套**：引用链过深（建议引用不超过 1 层深度）。