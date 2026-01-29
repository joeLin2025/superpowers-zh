---
name: verification-before-completion
description: 当准备声称工作已完成、已修复或已通过时使用，在提交或创建 PR 之前——要求在做出任何成功声明之前运行验证命令并确认输出；始终是证据优先于断言
---

# 完成前验证 (Verification Before Completion)

## 概述

未经验证就声称工作已完成是不诚实，而不是效率。

**核心原则：** 始终是证据优先于声称。

**违反此规则的字面意义就是违反此规则的精神。**

## 铁律

```
NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
(没有新的验证证据，绝不声称完成)
```

如果你没有在此消息中运行验证命令，你就不能声称它通过。

**在陈述任何成功声称、展示验证证据、或解释验证失败原因时，必须使用自然、专业的中文。**

## 门控功能

```
在声称任何状态或表达满意之前：

1. IDENTIFY (识别): 什么命令证明此声称？
2. RUN (运行): 执行完整命令（新的，完整的）
3. READ (阅读): 完整输出，检查退出代码，计算失败
4. VERIFY (验证): 输出是否确认声称？
   - 如果否: 用证据陈述实际状态
   - 如果是: 用证据陈述声称
5. ONLY THEN (只有那时): 做出声称

跳过任何步骤 = 撒谎，而不是验证
```

## 常见失败

| 声称 | 需要 | 不足以 |
|-------|----------|----------------|
| 测试通过 | 测试命令输出：0 失败 | 之前的运行，“应该通过” |
| Linter 干净 | Linter 输出：0 错误 | 部分检查，推断 |
| 构建成功 | 构建命令：退出码 0 | Linter 通过，日志看起来不错 |
| Bug 已修复 | 测试原始症状：通过 | 代码已更改，假设已修复 |
| 回归测试有效 | 红-绿循环已验证 | 测试通过一次 |
| 智能体已完成 | VCS diff 显示更改 | 智能体报告“成功” |
| 需求已满足 | 逐行清单 | 测试通过 |

## 危险信号 - 停止

- 使用 "should"（应该）, "probably"（可能）, "seems to"（似乎）
- 在验证前表达满意 ("Great!", "Perfect!", "Done!", 等)
- 准备提交/推送/PR 但未验证
- 信任智能体成功报告
- 依赖部分验证
- 想着“就这一次”
- 累了想结束工作
- **任何暗示成功但未运行验证的措辞**

## 合理化预防

| 借口 | 现实 |
|--------|---------|
| “现在应该工作了” | **运行**验证 |
| “我有信心” | 信心 ≠ 证据 |
| “就这一次” | 无例外 |
| “Linter 通过了” | Linter ≠ 编译器 |
| “智能体说成功了” | 独立验证 |
| “我累了” | 疲惫 ≠ 借口 |
| “部分检查足够了” | 部分证明不了什么 |
| “换个说法所以规则不适用” | 精神重于字面 |

## 关键模式

**测试:**
```
✅ [Run test command] [See: 34/34 pass] "All tests pass"
❌ "Should pass now" / "Looks correct"
```

**回归测试 (TDD 红-绿):**
```
✅ Write → Run (pass) → Revert fix → Run (MUST FAIL) → Restore → Run (pass)
❌ "I've written a regression test" (without red-green verification)
```

**构建:**
```
✅ [Run build] [See: exit 0] "Build passes"
❌ "Linter passed" (linter doesn't check compilation)
```

**需求:**
```
✅ Re-read plan → Create checklist → Verify each → Report gaps or completion
❌ "Tests pass, phase complete"
```

**智能体委托:**
```
✅ Agent reports success → Check VCS diff → Verify changes → Report actual state
❌ Trust agent report
```

## 为什么这很重要

来自 24 个失败记忆：
- 你的人类伙伴说“我不相信你”——信任破裂
- 未定义的函数发布了——会崩溃
- 缺失的需求发布了——不完整的功能
- 时间浪费在错误的完成上 → 重定向 → 返工
- 违反：“诚实是核心价值观。如果你撒谎，你将被替换。”

## 何时应用

**始终在以下之前：**
- 任何形式的成功/完成声称
- 任何满意的表达
- 关于工作状态的任何积极陈述
- 提交、创建 PR、任务完成
- 移动到下一个任务
- 委托给智能体

**规则适用于：**
- 确切短语
- 释义和同义词
- 成功的暗示
- 任何暗示完成/正确性的沟通

## 结论

**验证没有捷径。**

运行命令。阅读输出。然后声称结果。

这是不可协商的。