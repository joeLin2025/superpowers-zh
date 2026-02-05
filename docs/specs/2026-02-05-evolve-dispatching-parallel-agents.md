# ADR-20260205-07: Evolution of `dispatching-parallel-agents` Skill

## 1. 背景与问题 (Context)
- **当前状态**: `dispatching-parallel-agents` 的并行模型较为简单，仅强调文件隔离，缺乏对复杂任务的“归约 (Reduce)”和“冲突解决”机制。
- **核心挑战**: 如何将 LLM 的并行能力从“简单的多文件编辑”升级为类似 MapReduce 的“分治-归约”架构，以处理超大规模任务。

## 2. 决策驱动因素 (Drivers)
- **设计原则**: MapReduce Pattern (Map-Reduce 模式)、Dependency Injection (依赖注入)、Conflict Resolution (冲突解决)。
- **技术约束**: 必须在单体 Agent 框架内模拟并行流。
- **业务目标**: 提升大规模重构或迁移任务的吞吐量。

## 3. 候选方案 (Options)
- **Option A (推荐)**: **MapReduce 架构**
    - **Map 阶段**: 将任务分解为无状态的子任务（Subtasks）。
    - **Shuffle 阶段**: (模拟) 检查并解决子任务间的文件锁和依赖关系。
    - **Reduce 阶段**: 强制执行“全量回归”和“一致性检查”，合并代码。
    - *Pros*: 架构清晰，可扩展性强，适合处理复杂的大规模任务。
    - *Cons*: 流程相对繁琐。

- **Option B**: **简单并行模式**
    - 仅强调文件互斥，不做复杂的归约处理。
    - *Pros*: 简单。
    - *Cons*: 容易在合并阶段产生逻辑冲突。

## 4. 决策结果 (Decision)
- **选择**: Option A
- **理由**: 搜索结果表明，"LLM×MapReduce" 模式是处理复杂长序列任务的最佳实践。通过引入 Reduce 阶段的强制校验，可以有效降低合并风险。

## 5. 后果 (Consequences)
- **正向**: 能够安全地处理涉及数十个文件的重构任务。
- **负面/风险**: 需要更强的任务分解能力（Map 阶段的 Prompt 设计至关重要）。
- **缓解措施**: 在 `SKILL.md` 中增加“任务分解模板”。
