# Writing-Plans Skill Evolution Spec

## 1. 背景与目标 (Context & Goals)
- **痛点**: 现有 `writing-plans` 对 WBS 分解原则与“断点续传/动态纠偏”缺乏明确约束，计划模板中缺少 Review Checkpoint。
- **目标**: 引入 WBS 100% 规则、任务分解边界、断点续传与纠偏规则，并强制计划内 Review Checkpoint。
- **非目标 (Non-Goals)**: 不修改执行阶段技能；不引入实现代码。

## 2. 核心设计 (Core Design)
- **API 变更**: 新增“Review Checkpoint”任务模板项。
- **数据结构**: 计划模板包含 WBS 规则、任务粒度与验证项。
- **逻辑流**: Spec 已批准 -> WBS 分解 -> 写入计划模板 -> 插入 Review Checkpoint -> 进入执行。

## 3. 方案权衡 (Trade-offs)
| 维度 | 方案 A (推荐) | 方案 B (替代) |
| :--- | :--- | :--- |
| **复杂度** | 中 | 低 |
| **风险** | 低：可追踪、易纠偏 | 中：执行漂移难发现 |
| **维护成本** | 中：模板复杂 | 低：模板简单 |

## 4. 风险与副作用 (Risks & Side Effects)
- **受影响文件**: `skills/writing-plans/SKILL.md`
- **破坏性变更**: 计划文档更长；计划编写时间增加。
