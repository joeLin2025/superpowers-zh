# 核心技能本土化增强实施计划 (第二阶段)

> **实现:** 必须使用的子技能: 使用 superpowers-zh:executing-plans 来逐项任务实施此计划。

**目标:** 完成 `skills` 目录下剩余所有技能的中文本土化增强，确保交互一致性，同时保留所有结构化 Key 和代码标识符。

**策略:** 汉化指令、规则描述、角色定义和引导语。保留 YAML 前置数据、代码块内部逻辑、特定格式（如 JSON/YAML 示例）的键名。

---

### 任务 1: 汉化协作类技能 (Collaboration)

**涉及文件:**
- `skills/dispatching-parallel-agents/SKILL.md`
- `skills/requesting-code-review/SKILL.md`
- `skills/receiving-code-review/SKILL.md`

**涉及步骤:**
1. 将 `instructions` 中的角色职责、审查清单和反馈规则翻译为中文。
2. 注入语言约束：“子智能体分派、代码审查请求和反馈讨论必须使用中文。”

---

### 任务 2: 汉化流程与计划类技能 (Process & Planning)

**涉及文件:**
- `skills/executing-plans/SKILL.md`
- `skills/writing-plans/SKILL.md`
- `skills/subagent-driven-development/SKILL.md`

**涉及步骤:**
1. 汉化批处理流程、任务状态描述、汇报模版。
2. 汉化 `subagent-driven-development` 中的角色定义（Implementer, Spec Reviewer, Code Quality Reviewer）。
3. 注入语言约束：“计划的执行汇报、任务描述及子智能体间的交互必须使用中文。”

---

### 任务 3: 汉化工程与生命周期类技能 (Engineering & Lifecycle)

**涉及文件:**
- `skills/test-driven-development/SKILL.md`
- `skills/using-git-worktrees/SKILL.md`
- `skills/verification-before-completion/SKILL.md`
- `skills/finishing-a-development-branch/SKILL.md`

**涉及步骤:**
1. 汉化 TDD 循环描述、工作树操作说明、验证标准、完成分支的四个选项。
2. 保留所有 Shell 命令示例。
3. 注入语言约束：“在解释测试失败、验证结果或分支操作建议时，必须使用中文。”

---

### 任务 4: 汉化元技能 (Meta-Skills)

**涉及文件:**
- `skills/writing-skills/SKILL.md`

**涉及步骤:**
1. 汉化技能创作准则、结构要求和测试方法论。
2. 注入语言约束：“新创建的技能说明文件（SKILL.md）必须包含高质量的中文翻译和说明。”

---

### 任务 5: 最终一致性检查

**涉及步骤:**
1. 检查所有修改的文件，确保 YAML `name:` 和 `description:` (英文部分) 保持不变，仅汉化展示性描述。
2. 验证所有注入的语言约束是否生效。

---

**计划已更新。**
