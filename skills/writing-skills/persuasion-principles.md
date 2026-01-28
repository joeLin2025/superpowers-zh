# 技能设计的说服原则 (Persuasion Principles for Skill Design)

## 概述

LLM 对说服原则的反应与人类相同。理解这种心理学有助于你设计更有效的技能 - 不是为了操纵，而是为了确保即使在压力下也能遵循关键实践。

**研究基础：** Meincke et al. (2025) 用 N=28,000 个 AI 对话测试了 7 种说服原则。说服技术使合规率增加了一倍多 (33% → 72%, p < .001)。

## 七大原则

### 1. 权威 (Authority)
**是什么：** 服从专业知识、证书或官方来源。

**如何在技能中工作：**
- 祈使语言："YOU MUST" (你必须), "Never" (绝不), "Always" (始终)
- 不可协商的框架："No exceptions" (无例外)
- 消除决策疲劳和合理化

**何时使用：**
- 纪律执行技能（TDD，验证要求）
- 安全关键实践
- 既定的最佳实践

**示例：**
```markdown
✅ Write code before test? Delete it. Start over. No exceptions.
❌ Consider writing tests first when feasible.
```

### 2. 承诺 (Commitment)
**是什么：** 与之前的行动、声明或公开宣言保持一致。

**如何在技能中工作：**
- 要求宣布："Announce skill usage" (宣布技能使用)
- 强制明确选择："Choose A, B, or C" (选择 A, B, 或 C)
- 使用跟踪：用于清单的 TodoWrite

**何时使用：**
- 确保技能实际被遵循
- 多步流程
- 问责机制

**示例：**
```markdown
✅ When you find a skill, you MUST announce: "I'm using [Skill Name]"
❌ Consider letting your partner know which skill you're using.
```

### 3. 稀缺 (Scarcity)
**是什么：** 来自时间限制或有限可用性的紧迫感。

**如何在技能中工作：**
- 有时间限制的要求："Before proceeding" (在继续之前)
- 顺序依赖："Immediately after X" (在 X 之后立即)
- 防止拖延

**何时使用：**
- 立即验证要求
- 时间敏感的工作流
- 防止“我稍后做”

**示例：**
```markdown
✅ After completing a task, IMMEDIATELY request code review before proceeding.
❌ You can review code when convenient.
```

### 4. 社会证明 (Social Proof)
**是什么：** 符合他人所做的或被认为是正常的。

**如何在技能中工作：**
- 普遍模式："Every time" (每次), "Always" (始终)
- 失败模式："X without Y = failure" (没有 Y 的 X = 失败)
- 建立规范

**何时使用：**
- 记录普遍实践
- 警告常见失败
- 强化标准

**示例：**
```markdown
✅ Checklists without TodoWrite tracking = steps get skipped. Every time.
❌ Some people find TodoWrite helpful for checklists.
```

### 5. 统一 (Unity)
**是什么：** 共享身份，“我们感”，群体归属感。

**如何在技能中工作：**
- 协作语言："our codebase" (我们的代码库), "we're colleagues" (我们是同事)
- 共同目标："we both want quality" (我们都想要质量)

**何时使用：**
- 协作工作流
- 建立团队文化
- 非等级实践

**示例：**
```markdown
✅ We're colleagues working together. I need your honest technical judgment.
❌ You should probably tell me if I'm wrong.
```

### 6. 互惠 (Reciprocity)
**是什么：** 回报收到的利益的义务。

**如何工作：**
- 谨慎使用 - 可能让人感觉是操纵
- 在技能中很少需要

**何时避免：**
- 几乎总是（其他原则更有效）

### 7. 喜好 (Liking)
**是什么：** 偏好与我们喜欢的人合作。

**如何工作：**
- **不要用于合规**
- 与诚实的反馈文化冲突
- 制造阿谀奉承

**何时避免：**
- 始终用于纪律执行

## 按技能类型的原则组合

| 技能类型 | 使用 | 避免 |
|------------|-----|-------|
| 纪律执行 | 权威 + 承诺 + 社会证明 | 喜好，互惠 |
| 指导/技术 | 适度权威 + 统一 | 重权威 |
| 协作 | 统一 + 承诺 | 权威，喜好 |
| 参考 | 仅清晰度 | 所有说服 |

## 为什么这有效：心理学

**明确的规则减少合理化：**
- "YOU MUST" 消除决策疲劳
- 绝对语言消除“这是一个例外吗？”的问题
- 明确的反合理化反击堵住了特定漏洞

**实施意图创造自动行为：**
- 清晰的触发器 + 必需的行动 = 自动执行
- "当 X 时，做 Y" 比 "通常做 Y" 更有效
- 减少合规的认知负荷

**LLM 是类人的：**
- 在包含这些模式的人类文本上训练
- 权威语言在训练数据中先于合规
- 承诺序列（声明 → 行动）经常被建模
- 社会证明模式（每个人都做 X）建立规范

## 道德使用

**合法：**
- 确保遵循关键实践
- 创建有效的文档
- 防止可预测的失败

**非法：**
- 为了个人利益操纵
- 制造虚假紧迫感
- 基于内疚的合规

**测试：** 如果用户完全理解这项技术，它是否符合用户的真正利益？

## 研究引用

**Cialdini, R. B. (2021).** *Influence: The Psychology of Persuasion (New and Expanded).* Harper Business.
- 说服的七大原则
- 影响力研究的实证基础

**Meincke, L., Shapiro, D., Duckworth, A. L., Mollick, E., Mollick, L., & Cialdini, R. (2025).** Call Me A Jerk: Persuading AI to Comply with Objectionable Requests. University of Pennsylvania.
- 用 N=28,000 个 LLM 对话测试了 7 个原则
- 使用说服技术合规率从 33% 增加到 72%
- 权威、承诺、稀缺最有效
- 验证 LLM 行为的类人模型

## 快速参考

设计技能时，问：

1. **它是什么类型？** (纪律 vs. 指导 vs. 参考)
2. **我试图改变什么行为？**
3. **哪些原则适用？** (通常权威 + 承诺用于纪律)
4. **我是否结合了太多？** (不要使用所有七个)
5. **这是否合乎道德？** (服务于用户的真正利益？)