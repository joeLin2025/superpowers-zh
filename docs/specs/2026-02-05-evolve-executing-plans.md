# ADR-20260205-03: Evolution of `executing-plans` Skill

## 1. 背景与问题 (Context)
- **当前状态**: `executing-plans` 缺乏对执行循环的鲁棒性控制。Agent 容易陷入“试错循环”或在上下文过长时产生“认知漂移”。缺乏思维链 (CoT) 的显式验证步骤。
- **核心挑战**: 如何构建一个具备“自我修正”和“认知状态锁定”能力的执行引擎。

## 2. 决策驱动因素 (Drivers)
- **设计原则**: 状态机可靠性 (State Machine Reliability)、思维链验证 (CoT Verification)。
- **技术约束**: 依赖 Markdown 文件作为持久化状态存储。
- **业务目标**: 降低长任务执行过程中的逻辑偏离率。

## 3. 候选方案 (Options)
- **Option A (推荐)**: **状态锁定与 CoT 验证 (State Locking & CoT)**
    - 引入“执行前预言 (Pre-computation)”：在运行代码前，必须先写出预期结果。
    - 强制“原子化验证”：每个步骤必须有配套的验证命令。
    - 引入“漂移熔断”：若连续 2 次尝试失败，必须停止并回滚状态。
    - *Pros*: 极大地提高了执行的确定性和可审计性。
    - *Cons*: 执行速度略有下降（需更多 Token）。

- **Option B**: **宽松执行模式**
    - 允许 Agent 根据报错自动重试，不限制次数。
    - *Pros*: 速度快。
    - *Cons*: 极易陷入死循环或产生幻觉代码。

## 4. 决策结果 (Decision)
- **选择**: Option A
- **理由**: 搜索结果强调了 "Chain of Thought Verification" 和 "Reliability Loops" 的重要性。只有通过显式的状态锁定和预言机制，才能防止 Agent 在长上下文中“迷路”。

## 5. 后果 (Consequences)
- **正向**: 任务执行成功率将显著提升，调试时间减少。
- **负面/风险**: 需要更严格的 Prompt 工程。
- **缓解措施**: 在 `SKILL.md` 中内嵌具体的 CoT 模板。
