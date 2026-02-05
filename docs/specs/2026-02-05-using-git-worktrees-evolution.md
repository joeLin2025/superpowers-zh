# Using-Git-Worktrees Skill Evolution Spec

## 1. 背景与目标 (Context & Goals)
- **痛点**: Worktree 流程缺少清晰的路径层级规范与清理协议。
- **目标**: 明确创建、验证与清理步骤，强化路径层级规范。
- **非目标 (Non-Goals)**: 不改变 Git 的基础命令。

## 2. 核心设计 (Core Design)
- **API 变更**: 增加路径层级与清理协议。
- **数据结构**: Worktree 记录包含路径与基线验证。
- **逻辑流**: 选择路径 -> 创建 -> 基线验证 -> 执行 -> 清理。

## 3. 方案权衡 (Trade-offs)
| 维度 | 方案 A (推荐) | 方案 B (替代) |
| :--- | :--- | :--- |
| **复杂度** | 中 | 低 |
| **风险** | 低：路径可控 | 中：目录污染 |
| **维护成本** | 中 | 低 |

## 4. 风险与副作用 (Risks & Side Effects)
- **受影响文件**: `skills/using-git-worktrees/SKILL.md`
- **破坏性变更**: 初次使用门槛上升。
