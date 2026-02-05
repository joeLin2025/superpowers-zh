# Requesting-Code-Review Skill Evolution Spec

## 1. 背景与目标 (Context & Goals)
- **痛点**: PR 请求缺少标准化上下文与风险自述，容易增加审查成本。
- **目标**: 引入结构化 PR 模板、风险自述与自审清单，确保审查者具备完整上下文。
- **非目标 (Non-Goals)**: 不定义具体代码审查结论标准。

## 2. 核心设计 (Core Design)
- **API 变更**: 增加风险自述与自审清单。
- **数据结构**: PR 模板包含 Why/What/Risks/Verification。
- **逻辑流**: 自审 -> 模板补全 -> 请求审查。

## 3. 方案权衡 (Trade-offs)
| 维度 | 方案 A (推荐) | 方案 B (替代) |
| :--- | :--- | :--- |
| **复杂度** | 中 | 低 |
| **风险** | 低：审查效率高 | 中：背景缺失 |
| **维护成本** | 中 | 低 |

## 4. 风险与副作用 (Risks & Side Effects)
- **受影响文件**: `skills/requesting-code-review/SKILL.md`
- **破坏性变更**: PR 准备耗时增加。
