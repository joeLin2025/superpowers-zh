# 全量升级 skills 目录技能规范 (Skills Upgrade Spec)

## 1. 背景与目标 (Context & Goals)
- **痛点**: `skills/` 下 16 个技能文档风格与约束深度不一，虽普遍包含 Frontmatter + 概述/核心原则/何时使用，但缺少统一的强制输出、验证闭环与交叉路由一致性，难以达到“最佳能力状态”。参考文件：
  - `skills/brainstorming/SKILL.md`
  - `skills/using-superpowers/SKILL.md`
  - `skills/writing-plans/SKILL.md`
  - 以及 `skills/` 内全部 `SKILL.md`
- **目标**: 形成统一且可审计的 Skill 规范体系，提升每个技能的可执行性、验证性与互操作性，最终让“技能驱动”在所有场景下稳定生效。升级过程必须包含多轮脑暴与实时检索，形成被“敲打过”的强规则集。
- **非目标 (Non-Goals)**: 不引入新的运行时工具、不更改仓库之外的技能、不对业务代码进行改动。

## 2. 核心设计 (Core Design)
- **统一 Skill Schema vNext**
  - Frontmatter 最小字段：`name`, `description`。
  - 强制章节：概述、何时使用、强制流程(Workflow)、输出物(Artifacts)、验证与证据、红旗/反例、例外与降级策略、工具映射。
  - **模板硬约束**：凡是要求生成文件的技能，必须在“输出物(Artifacts)”中给出标准模板（文件路径+Schema/样例），并声明禁止偏离模板。
- **质量基线与评分 Rubric**
  - 维度：可执行性、可验证性、覆盖完整性、歧义消除、跨技能一致性、对抗性规则。
  - 每个技能需要达到“可复现执行 + 可证据化交付”的标准。
- **多轮脑暴 + 实时检索流程**
  - 每个技能至少经历 2 轮脑暴：第 1 轮梳理目标/痛点/失败模式，第 2 轮针对对抗场景与边界案例补强规则。
  - 每个技能在升级时必须进行实时搜索，引用至少 2 条外部权威来源作为规则依据，但**不写入技能文档**，改为记录在计划执行记录中。
- **跨技能路由一致性**
  - 将 `skills/using-superpowers/SKILL.md` 作为路由真源，对其关键词路由表进行扩展与同步到各技能“触发条件”段落。
  - 对 `writing-plans` / `executing-plans` / `verification-before-completion` / `finishing-a-development-branch` 的阶段边界做显式对齐。
- **工具映射与执行约束**
  - 为所有技能加入“工具映射表”小节，确保出现的工具名可被当前环境替代或执行。

## 3. 方案权衡 (Trade-offs)
| 维度 | 方案 A：全量审计 + 重写升级 (推荐) | 方案 B：轻量一致化修订 |
| :--- | :--- | :--- |
| **复杂度** | 高 | 中低 |
| **风险** | 文档改动面大，但质量最优 | 风险较低，但质量提升有限 |
| **维护成本** | 需要建立版本与审计机制 | 维护成本低，但易产生漂移 |

## 4. 风险与副作用 (Risks & Side Effects)
- **受影响文件**:
  - `skills/brainstorming/SKILL.md`
  - `skills/dispatching-parallel-agents/SKILL.md`
  - `skills/executing-plans/SKILL.md`
  - `skills/finishing-a-development-branch/SKILL.md`
  - `skills/receiving-code-review/SKILL.md`
  - `skills/requesting-code-review/SKILL.md`
  - `skills/skill-localization-and-polishing/SKILL.md`
  - `skills/subagent-driven-development/SKILL.md`
  - `skills/systematic-debugging/SKILL.md`
  - `skills/test-driven-development/SKILL.md`
  - `skills/using-git-worktrees/SKILL.md`
  - `skills/using-superpowers/SKILL.md`
  - `skills/ux-prototyping/SKILL.md`
  - `skills/verification-before-completion/SKILL.md`
  - `skills/writing-plans/SKILL.md`
  - `skills/writing-skills/SKILL.md`
  - `docs/specs/2026-02-07-upgrade-skills-suite.md`
- **潜在副作用**:
  - 更强约束可能增加单次任务的准备成本。
  - 路由规则扩展可能触发更多“强制流程”，需要明确降级策略。
  - 新增版本字段要求后续维护，需确认维护责任。
