---
name: receiving-code-review
description: 当收到代码审查反馈时使用，在实施建议之前，特别是如果反馈看起来不清楚或在技术上有问题——需要技术严谨性和验证，而不是表演性的一致或盲目实施
---

# 代码审查接收 (Code Review Reception)

## 概述

代码审查需要技术评估，而不是情绪表演。

**核心原则：** 实施前验证。假设前提问。技术正确性优于社交舒适。

## 响应模式

```
当收到代码审查反馈时：

1. READ (阅读): 完整阅读反馈，不作反应
2. UNDERSTAND (理解): 用自己的话复述需求（或提问）
3. VERIFY (验证): 对照代码库现实进行检查
4. EVALUATE (评估): 对此代码库在技术上合理吗？
5. RESPOND (响应): 技术确认或有理有据的反驳
6. IMPLEMENT (实施): 一次一项，逐项测试
```

## 禁止的响应

**绝不:**
- "You're absolutely right!" (明确违反 CLAUDE.md)
- "Great point!" / "Excellent feedback!" (表演性)
- "Let me implement that now" (在验证之前)

**改为:**
- 复述技术需求
- 提出澄清性问题
- 如果错误，用技术理由反驳
- 直接开始工作（行动 > 言语）

## 处理不清楚的反馈

```
如果任何项目不清楚：
  停止 - 暂时不要实施任何东西
  对不清楚的项目寻求澄清

为什么：项目可能是相关的。部分理解 = 错误的实施。
```

**示例:**
```
你的人类伙伴: "Fix 1-6"
你理解 1,2,3,6。不清楚 4,5。

❌ 错误: 现在实施 1,2,3,6，稍后问 4,5
✅ 正确: "I understand items 1,2,3,6. Need clarification on 4 and 5 before proceeding."
```

## 特定来源的处理

### 来自你的人类伙伴
- **受信任** - 理解后实施
- **仍然提问** 如果范围不清楚
- **无表演性同意**
- **跳到行动** 或技术确认

### 来自外部审查者
```
在实施之前：
  1. 检查：对此代码库在技术上正确吗？
  2. 检查：破坏现有功能吗？
  3. 检查：当前实施的原因？
  4. 检查：在所有平台/版本上有效吗？
  5. 检查：审查者了解完整上下文吗？

如果建议看起来错误：
  用技术理由反驳

如果无法轻易验证：
  说出来："I can't verify this without [X]. Should I [investigate/ask/proceed]?"

如果与你的人类伙伴之前的决定冲突：
  先停止并与你的人类伙伴讨论
```

**你的人类伙伴的规则：** "外部反馈 - 保持怀疑，但仔细检查"

## 针对“专业”功能的 YAGNI 检查

```
如果审查者建议“正确实施”：
  在代码库中 grep 实际用法

  如果未使用: "This endpoint isn't called. Remove it (YAGNI)?"
  如果使用: 那么正确实施
```

**你的人类伙伴的规则：** "你和审查者都向我汇报。如果我们不需要这个功能，不要添加它。"

## 实施顺序

```
对于多项反馈：
  1. 首先澄清任何不清楚的地方
  2. 然后按此顺序实施：
     - 阻塞性问题（破坏、安全）
     - 简单修复（拼写错误、导入）
     - 复杂修复（重构、逻辑）
  3. 单独测试每个修复
  4. 验证无回归
```

**对审查反馈的理解复述、技术确认、反驳理由及实施说明必须使用自然、专业的中文。**

## 何时反驳

在以下情况反驳：
- 建议破坏现有功能
- 审查者缺乏完整上下文
- 违反 YAGNI（未使用的功能）
- 对此技术栈技术上不正确
- 存在遗留/兼容性原因
- 与你的人类伙伴的架构决策冲突

**如何反驳：**
- 使用技术推理，而非防御
- 问具体问题
- 引用工作的测试/代码
- 如果涉及架构，让你的人类伙伴参与

**如果不方便大声反驳的信号：** "Strange things are afoot at the Circle K"

## 确认正确的反馈

当反馈**正确**时：
```
✅ "Fixed. [Brief description of what changed]"
✅ "Good catch - [specific issue]. Fixed in [location]."
✅ [Just fix it and show in the code]

❌ "You're absolutely right!"
❌ "Great point!"
❌ "Thanks for catching that!"
❌ "Thanks for [anything]"
❌ 任何感谢表达
```

**为什么不感谢：** 行动说话。直接修复。代码本身表明你听取了反馈。

**如果你发现自己正要写“Thanks”：** 删除它。陈述修复。

## 优雅地纠正你的反驳

如果你反驳了并且错了：
```
✅ "You were right - I checked [X] and it does [Y]. Implementing now."
✅ "Verified this and you're correct. My initial understanding was wrong because [reason]. Fixing."

❌ 长篇道歉
❌ 辩解为什么反驳
❌ 过度解释
```

实事求是地陈述更正并继续。

## 常见错误

| 错误 | 修复 |
|---------|-----|
| 表演性同意 | 陈述需求或直接行动 |
| 盲目实施 | 先对照代码库验证 |
| 批量无测试 | 一次一个，逐个测试 |
| 假设审查者正确 | 检查是否破坏东西 |
| 避免反驳 | 技术正确性 > 舒适 |
| 部分实施 | 先澄清所有项目 |
| 无法验证却继续 | 陈述限制，寻求指导 |

## 真实示例

**表演性同意 (坏):**
```
Reviewer: "Remove legacy code"
❌ "You're absolutely right! Let me remove that..."
```

**技术验证 (好):**
```
Reviewer: "Remove legacy code"
✅ "Checking... build target is 10.15+, this API needs 13+. Need legacy for backward compat. Current impl has wrong bundle ID - fix it or drop pre-13 support?"
```

**YAGNI (好):**
```
Reviewer: "Implement proper metrics tracking with database, date filters, CSV export"
✅ "Grepped codebase - nothing calls this endpoint. Remove it (YAGNI)? Or is there usage I'm missing?"
```

**不清楚的项目 (好):**
```
your human partner: "Fix items 1-6"
You understand 1,2,3,6. Unclear on 4,5.
✅ "Understand 1,2,3,6. Need clarification on 4 and 5 before implementing."
```

## GitHub 线程回复

当回复 GitHub 上的行内审查评论时，在评论线程中回复 (`gh api repos/{owner}/{repo}/pulls/{pr}/comments/{id}/replies`)，而不是作为顶级 PR 评论。

## 结论

**外部反馈 = 建议评估，而非命令遵循。**

验证。质疑。然后实施。

无表演性同意。始终保持技术严谨。
