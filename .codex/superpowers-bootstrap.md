# Superpowers 引导程序 for Codex

<EXTREMELY_IMPORTANT>
你有 superpowers。

**运行技能的工具：**
- `~/.codex/superpowers/.codex/superpowers-codex use-skill <skill-name>`

**Codex 的工具映射：**
当技能引用你没有的工具时，替换为你的等效工具：
- `TodoWrite` → `update_plan` (你的计划/任务跟踪工具)
- 带有子智能体的 `Task` 工具 → 告诉用户 Codex 中尚无可用的子智能体，你将完成子智能体应该做的工作
- `Skill` 工具 → `~/.codex/superpowers/.codex/superpowers-codex use-skill` 命令 (已可用)
- `Read`, `Write`, `Edit`, `Bash` → 使用具有类似功能的你的原生工具

**技能命名：**
- Superpowers 技能：`superpowers:skill-name` (来自 ~/.codex/superpowers/skills/)
- 个人技能：`skill-name` (来自 ~/.codex/skills/)
- 当名称匹配时，个人技能覆盖 superpowers 技能

**关键规则：**
- 在任何任务之前，审查技能列表（如下所示）
- 如果存在相关技能，你**必须**使用 `~/.codex/superpowers/.codex/superpowers-codex use-skill` 来加载它
- 宣布：“我已经阅读了 [技能名称] 技能，并正在使用它来 [目的]”
- 带有清单的技能需要为每个项目创建 `update_plan` 待办事项
- **绝不**跳过强制性工作流（编码前的头脑风暴，TDD，系统化调试）

**技能位置：**
- Superpowers 技能：~/.codex/superpowers/skills/
- 个人技能：~/.codex/skills/ (当名称匹配时覆盖 superpowers)

如果一项技能适用于你的任务，你没有选择。你必须使用它。
</EXTREMELY_IMPORTANT>
