# 核心技能本土化增强实施计划

> **实现:** 必须使用的子技能: 使用 superpowers:executing-plans 来逐项任务实施此计划。

**目标:** 对核心技能进行中文本土化增强，提升交互体验，同时确保所有结构化 Key 和代码标识符保持不变。

**架构:** 采取“外壳汉化，内核保护”的策略。汉化指令、引导语和描述，保留 YAML/JSON Key、变量名和特定格式。

**技术栈:** Markdown, Shell

---

### 任务 1: 增强 `using-superpowers` 技能

**涉及文件:**
- 修改: `skills/using-superpowers/SKILL.md`

**步骤 1: 读取并汉化说明**
读取文件，将 `instructions` 中的所有英文引导、规则描述、以及危险信号表格进行汉化。

**步骤 2: 注入语言约束**
在指令末尾添加：“在引导用户使用其他技能或进行状态确认时，必须使用自然、专业的中文。”

**步骤 3: 验证结构**
确保 `name:` 字段和 `dot` 流程图的代码结构未被破坏。

---

### 任务 2: 增强 `brainstorming` 技能

**涉及文件:**
- 修改: `skills/brainstorming/SKILL.md`

**涉及步骤:**
- 汉化 `instructions` 中的“理解想法”、“探索方法”和“展示设计”流程说明。
- **汉化设计文档模板标签**: 将计划中的 `# Goal`, `# Architecture`, `# Tech Stack` 标题改为 `# 目标`, `# 架构`, `# 技术栈`。
- 注入约束：“头脑风暴的过程讨论和最终的设计文档必须使用中文。”

---

### 任务 3: 增强 `systematic-debugging` 技能

**涉及文件:**
- 修改: `skills/systematic-debugging/SKILL.md`
- 修改: `skills/systematic-debugging/root-cause-tracing.md`
- 修改: `skills/systematic-debugging/defense-in-depth.md`
- 修改: `skills/systematic-debugging/condition-based-waiting.md`

**涉及步骤:**
- 汉化所有调试步骤说明（如 “Observe”, “Hypothesize”, “Experiment” 等概念的中文解释）。
- 汉化 Markdown 文档中的案例说明。
- 注入约束：“调试过程中的假设分析、观察结果记录以及给用户的修复建议必须使用中文。”

---

### 任务 4: 最终一致性检查

**涉及步骤:**
- 运行一个简单的 `brainstorming` 会话，验证它是否生成中文设计。
- 检查所有修改过的文件，确保没有意外汉化了 YAML Key 或变量。

---

**计划已完成。**
