# Verification-Before-Completion Skill Evolution Spec

## 1. 背景与目标 (Context & Goals)
- **痛点**: 验收标准散乱，缺少统一证据矩阵与物化格式。
- **目标**: 引入 Definition of Done 思路、证据矩阵与统一交付格式。
- **非目标 (Non-Goals)**: 不定义具体测试工具。

## 2. 核心设计 (Core Design)
- **API 变更**: 增加证据矩阵与验收输出格式。
- **数据结构**: 交付需包含证据清单。
- **逻辑流**: 定义 DoD -> 执行验证 -> 记录证据 -> 宣告完成。

## 3. 方案权衡 (Trade-offs)
| 维度 | 方案 A (推荐) | 方案 B (替代) |
| :--- | :--- | :--- |
| **复杂度** | 中 | 低 |
| **风险** | 低：证据可审计 | 中：口头承诺 |
| **维护成本** | 中 | 低 |

## 4. 风险与副作用 (Risks & Side Effects)
- **受影响文件**: `skills/verification-before-completion/SKILL.md`
- **破坏性变更**: 验证步骤增加。
