# SOTA Skill Evolution Plan (Optimized)

**依据文档**: User Request (Re-plan)
**目标**: 对 `skills/` 下 16 个技能逐一进行“可追踪升级”，每个子任务包含多轮搜索与头脑风暴，并通过 `skill-localization-and-polishing` 收敛最终产物；每个产物需多轮自查后才进入下一任务。

## 决策记录 (Decisions)
- **工作区模式**: Current Directory
- **交付模式**: Manual (User Review before commit)

## 全局执行规则 (Global Rules)
- **记忆清洗**: 每个子任务开始前必须执行“记忆清洗”，只保留当前任务目标与必要上下文。
- **多轮探索**: 每个子任务至少 2 轮 Search + 2 轮 Brainstorm，且必须覆盖不同来源/角度。
- **收敛机制**: 使用 `skill-localization-and-polishing` 对草稿进行强约束打磨后再定稿。
- **多轮自查**: 每个子任务完成后至少 2 轮自查（结构一致性、规则可执行性、证据完整性），自查结果写回本计划。
- **防幻觉**: 所有外部依据必须注明来源；若证据不足不得进入 Rewrite。
- **串行推进**: 未完成自查不得进入下一子任务。
- **最终汇报**: 全部子任务自动完成后输出总体总结报告。

## 任务清单 (Tasks)

### Phase 1: Meta & Planning Skills (核心大脑)

- [ ] **Task 01: Evolve `using-superpowers` (The Kernel)**
  - [ ] Memory Reset: 清洗上下文，仅保留当前任务目标
  - [ ] Search Round 1: meta-prompting
  - [ ] Search Round 2: orchestration patterns
  - [ ] Brainstorm Round 1: 路由规则
  - [ ] Brainstorm Round 2: 混合意图处理
  - [ ] Rewrite: `skills/using-superpowers/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1: 结构/规则完整性
  - [ ] Self-Check Round 2: 证据/禁令覆盖
  - [ ] Verify: 借口粉碎机覆盖“习惯性忽略”场景

- [ ] **Task 02: Evolve `brainstorming` (The Architect)**
  - [ ] Memory Reset
  - [ ] Search Round 1: ADR 模板
  - [ ] Search Round 2: 设计思维框架
  - [ ] Brainstorm Round 1: ADR 标准输出
  - [ ] Brainstorm Round 2: 反向压力测试
  - [ ] Rewrite: `skills/brainstorming/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: Spec 模板包含反向压力测试

- [ ] **Task 03: Evolve `writing-plans` (The Navigator)**
  - [ ] Memory Reset
  - [ ] Search Round 1: WBS 最佳实践
  - [ ] Search Round 2: 计划拆解方法
  - [ ] Brainstorm Round 1: 断点续传
  - [ ] Brainstorm Round 2: 动态纠偏
  - [ ] Rewrite: `skills/writing-plans/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: Task Schema 含 Review Checkpoint

- [ ] **Task 04: Evolve `executing-plans` (The Worker)**
  - [ ] Memory Reset
  - [ ] Search Round 1: 执行循环可靠性
  - [ ] Search Round 2: 验证方法
  - [ ] Brainstorm Round 1: 状态同步
  - [ ] Brainstorm Round 2: 熔断机制
  - [ ] Rewrite: `skills/executing-plans/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: 明确证据持久化要求

### Phase 2: Implementation & Quality (执行与质量)

- [ ] **Task 05: Evolve `test-driven-development`**
  - [ ] Memory Reset
  - [ ] Search Round 1: TDD 反模式
  - [ ] Search Round 2: 测试异味
  - [ ] Brainstorm Round 1: 红-绿-重构
  - [ ] Brainstorm Round 2: 测试质量门禁
  - [ ] Rewrite: `skills/test-driven-development/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: 禁止“补测”条款明确

- [ ] **Task 06: Evolve `systematic-debugging`**
  - [ ] Memory Reset
  - [ ] Search Round 1: 科学调试
  - [ ] Search Round 2: RCA 模板
  - [ ] Brainstorm Round 1: MRE
  - [ ] Brainstorm Round 2: 二分定位
  - [ ] Rewrite: `skills/systematic-debugging/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: “无复现不修复”铁律

- [ ] **Task 07: Evolve `subagent-driven-development`**
  - [ ] Memory Reset
  - [ ] Search Round 1: 多智能体协作
  - [ ] Search Round 2: 委派协议
  - [ ] Brainstorm Round 1: 握手协议
  - [ ] Brainstorm Round 2: 零信任审计
  - [ ] Rewrite: `skills/subagent-driven-development/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: JSON 汇报格式完整

- [ ] **Task 08: Evolve `dispatching-parallel-agents`**
  - [ ] Memory Reset
  - [ ] Search Round 1: MapReduce
  - [ ] Search Round 2: 并行拆解
  - [ ] Brainstorm Round 1: 物理隔离
  - [ ] Brainstorm Round 2: 合并冲突预防
  - [ ] Rewrite: `skills/dispatching-parallel-agents/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: “全量回归”硬性要求

### Phase 3: Workflow & Review (协作保障)

- [ ] **Task 09: Evolve `requesting-code-review`**
  - [ ] Memory Reset
  - [ ] Search Round 1: 代码审查指南
  - [ ] Search Round 2: PR 模板实践
  - [ ] Brainstorm Round 1: 自我审查清单
  - [ ] Brainstorm Round 2: 上下文注入
  - [ ] Rewrite: `skills/requesting-code-review/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: PR 模板包含风险自述

- [ ] **Task 10: Evolve `receiving-code-review`**
  - [ ] Memory Reset
  - [ ] Search Round 1: Egoless programming
  - [ ] Search Round 2: 反馈处理方法
  - [ ] Brainstorm Round 1: 分类处理
  - [ ] Brainstorm Round 2: 非防御性验证
  - [ ] Rewrite: `skills/receiving-code-review/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: “验证即尊重”原则明确

- [ ] **Task 11: Evolve `finishing-a-development-branch`**
  - [ ] Memory Reset
  - [ ] Search Round 1: 分支策略
  - [ ] Search Round 2: 历史清理
  - [ ] Brainstorm Round 1: 环境净化
  - [ ] Brainstorm Round 2: 原子化提交
  - [ ] Rewrite: `skills/finishing-a-development-branch/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: Squash/Rebase 规范明确

### Phase 4: Specialized Skills (专家工具)

- [ ] **Task 12: Evolve `using-git-worktrees`**
  - [ ] Memory Reset
  - [ ] Search Round 1: worktree 流程
  - [ ] Search Round 2: 隔离开发
  - [ ] Brainstorm Round 1: 目录规范
  - [ ] Brainstorm Round 2: 清理协议
  - [ ] Rewrite: `skills/using-git-worktrees/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: 路径层级规范

- [ ] **Task 13: Evolve `ux-prototyping`**
  - [ ] Memory Reset
  - [ ] Search Round 1: 快速原型
  - [ ] Search Round 2: 用户中心设计
  - [ ] Brainstorm Round 1: 单文件交付
  - [ ] Brainstorm Round 2: 中文友好
  - [ ] Rewrite: `skills/ux-prototyping/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: 禁用复杂构建工具

- [ ] **Task 14: Evolve `verification-before-completion`**
  - [ ] Memory Reset
  - [ ] Search Round 1: Definition of Done
  - [ ] Search Round 2: 验收清单
  - [ ] Brainstorm Round 1: 证据矩阵
  - [ ] Brainstorm Round 2: 验收流程
  - [ ] Rewrite: `skills/verification-before-completion/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: 证据物化格式

- [ ] **Task 15: Evolve `skill-localization-and-polishing`**
  - [ ] Memory Reset
  - [ ] Search Round 1: Prompt 工程
  - [ ] Search Round 2: 系统提示优化
  - [ ] Brainstorm Round 1: 对抗测试
  - [ ] Brainstorm Round 2: 原理注入
  - [ ] Rewrite: `skills/skill-localization-and-polishing/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing` (自我打磨)
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: 信噪比审计标准

- [ ] **Task 16: Evolve `writing-skills`**
  - [ ] Memory Reset
  - [ ] Search Round 1: Meta-prompting
  - [ ] Search Round 2: 可执行文档
  - [ ] Brainstorm Round 1: 先红后绿
  - [ ] Brainstorm Round 2: 验收标准
  - [ ] Rewrite: `skills/writing-skills/SKILL.md`
  - [ ] Polish: `skill-localization-and-polishing`
  - [ ] Self-Check Round 1
  - [ ] Self-Check Round 2
  - [ ] Verify: Document Schema 强制性
