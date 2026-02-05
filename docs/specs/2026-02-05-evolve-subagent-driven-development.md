# ADR-20260205-06: Evolution of `subagent-driven-development` Skill

## 1. 背景与问题 (Context)
- **当前状态**: 主从智能体之间的协作依赖于简单的 Prompt 传递，缺乏严格的“握手协议”和“边界控制”。子智能体容易“越权”或提交不符合规范的代码。
- **核心挑战**: 如何在单体 LLM 会话中模拟出“高内聚、低耦合”的多智能体协作网络。

## 2. 决策驱动因素 (Drivers)
- **设计原则**: 关注点分离 (SoC)、零信任 (Zero Trust)、契约式协作 (Contract-based Collaboration)。
- **技术约束**: 所有智能体实际上共享同一个上下文窗口（需要人工模拟隔离）。
- **业务目标**: 提升复杂任务的分解和执行效率。

## 3. 候选方案 (Options)
- **Option A (推荐)**: **契约式委派 (Contract-based Delegation)**
    - 引入 **Delegate Protocol**: 包含 `Input`, `Output`, `Constraints`, `Verification` 四要素。
    - 强制 **双重审计 (Double Audit)**: 规格审查 (Spec Review) + 质量审查 (Quality Review)。
    - 明确 **上下文边界**: 子智能体只能看到其任务相关的文件。
    - *Pros*: 极大地降低了“幻觉传染”的风险。
    - *Cons*: 需要更复杂的 Prompt 编排。

- **Option B**: **自由协作模式**
    - 主智能体给出一个大致目标，子智能体自由发挥。
    - *Pros*: 灵活。
    - *Cons*: 容易产生“大泥球”代码，难以集成。

## 4. 决策结果 (Decision)
- **选择**: Option A
- **理由**: 搜索结果中的 "Agent delegation protocols" 强调了明确接口的重要性。在 AI 协作中，模糊是万恶之源。

## 5. 后果 (Consequences)
- **正向**: 复杂任务的成功率将显著提高，代码质量更有保障。
- **负面/风险**: 交互轮次增加。
- **缓解措施**: 通过 `dispatching-parallel-agents` 技能来并行化部分子任务。
