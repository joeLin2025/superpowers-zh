# ADR-20260205-05: Evolution of `systematic-debugging` Skill

## 1. 背景与问题 (Context)
- **当前状态**: `systematic-debugging` 虽然强调了证据，但缺乏具体的“归因算法”。AI 容易在“假设-验证”循环中发散。缺乏标准化的 RCA (Root Cause Analysis) 输出。
- **核心挑战**: 如何将调试过程从“基于经验的试探”升级为“基于算法的推理”。

## 2. 决策驱动因素 (Drivers)
- **设计原则**: 证据优先 (Evidence First)、最小化变更 (Minimal Change)、可复现性 (Reproducibility)。
- **技术约束**: 无法直接访问用户的 IDE 调试器，只能通过日志和代码修改进行间接观察。
- **业务目标**: 提高 Bug 修复的一次性成功率，减少回归。

## 3. 候选方案 (Options)
- **Option A (推荐)**: **结构化 RCA 工作流**
    - 引入 **5 Whys** 分析法作为强制步骤。
    - 强制产出 **RCA 报告**（包含复现步骤、根本原因、修复方案、预防措施）。
    - 引入 **二分法 (Bisection)** 和 **隔离测试 (Isolation)** 作为标准战术。
    - *Pros*: 系统性强，利于知识沉淀。
    - *Cons*: 流程较重，对简单 Bug 可能显得繁琐。

- **Option B**: **快速修复模式**
    - 仅要求“复现-修复-验证”。
    - *Pros*: 速度快。
    - *Cons*: 容易治标不治本，忽略深层原因。

## 4. 决策结果 (Decision)
- **选择**: Option A
- **理由**: 搜索结果明确指出，科学调试的核心在于“结构化”。通过强制执行 RCA 和 5 Whys，可以有效避免 AI 陷入“猜谜游戏”。

## 5. 后果 (Consequences)
- **正向**: 每一个 Bug 的修复都将成为一次系统质量的提升机会。
- **负面/风险**: 需要教会 Agent 如何写高质量的 RCA。
- **缓解措施**: 在 `SKILL.md` 中提供详细的 RCA 模板。
