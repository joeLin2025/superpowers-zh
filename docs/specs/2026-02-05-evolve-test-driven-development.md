# ADR-20260205-04: Evolution of `test-driven-development` Skill

## 1. 背景与问题 (Context)
- **当前状态**: TDD 往往被退化为“先写代码，再补测试”。缺乏对“红-绿-重构”循环的强制性约束。AI 容易生成脆弱的测试或过度 Mock。
- **核心挑战**: 如何在非确定性的 AI 编码环境中强制执行严格的 TDD 纪律。

## 2. 决策驱动因素 (Drivers)
- **设计原则**: Test First, Minimal Implementation, Refactor Safely.
- **技术约束**: 必须兼容各类主流测试框架 (Jest, Pytest 等)。
- **业务目标**: 消除“伪 TDD”，确保代码质量。

## 3. 候选方案 (Options)
- **Option A (推荐)**: **强制性 R-G-R 状态机**
    - 定义三个互斥状态：`RED` (期待失败), `GREEN` (实现通过), `REFACTOR` (优化)。
    - 引入“反模式拦截器”：禁止在 `RED` 阶段写实现，禁止在 `GREEN` 阶段加新功能。
    - 强调“行为测试”而非“实现细节测试”。
    - *Pros*: 彻底根除伪 TDD，提升代码健壮性。
    - *Cons*: 对 Agent 的指令依从性要求极高。

- **Option B**: **建议性 TDD**
    - 仅提示“尽量先写测试”。
    - *Pros*: 灵活。
    - *Cons*: 在压力下容易失效，退化为 Code-First。

## 4. 决策结果 (Decision)
- **选择**: Option A
- **理由**: 搜索结果显示 "TDD anti-patterns"（如缓慢的测试套件、脆弱的测试）严重影响 AI 编码效率。必须通过强制性的流程约束来规避这些陷阱。

## 5. 后果 (Consequences)
- **正向**: 产出的代码将具备极高的可维护性和可测试性。
- **负面/风险**: 初期编码速度可能变慢。
- **缓解措施**: 强调“最小实现”原则，鼓励 Hardcoding 以快速通过测试。
