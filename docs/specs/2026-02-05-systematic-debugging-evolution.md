# Systematic-Debugging Skill Evolution Spec

## 1. 背景与目标 (Context & Goals)
- **痛点**: 现有调试流程缺乏 RCA 模板与最小可复现(MRE)标准化输出。
- **目标**: 强化 MRE、假设验证、二分定位与 RCA 输出，明确“无复现不修复”。
- **非目标 (Non-Goals)**: 不加入自动化工具或脚本。

## 2. 核心设计 (Core Design)
- **API 变更**: 增加 MRE 与 RCA 输出模板。
- **数据结构**: Debug 记录必须包含假设-证据链。
- **逻辑流**: 环境审计 -> MRE -> 假设/验证 -> 二分定位 -> RCA -> 修复。

## 3. 方案权衡 (Trade-offs)
| 维度 | 方案 A (推荐) | 方案 B (替代) |
| :--- | :--- | :--- |
| **复杂度** | 中 | 低 |
| **风险** | 低：证据闭环 | 中：猜测修复 |
| **维护成本** | 中 | 低 |

## 4. 风险与副作用 (Risks & Side Effects)
- **受影响文件**: `skills/systematic-debugging/SKILL.md`
- **破坏性变更**: 调试耗时上升，但结果更可靠。
