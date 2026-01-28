---
name: writing-plans
description: 当你对多步任务有规范或需求时使用，在接触代码之前
---

# 编写计划 (Writing Plans)

## 概述

编写全面的实施计划，假设工程师对我们的代码库毫无背景知识且品味值得怀疑。记录他们需要知道的一切：每个任务需要触及哪些文件、代码、测试、他们可能需要检查的文档、如何测试。以一口大小 (bite-sized) 的任务形式给他们整个计划。DRY. YAGNI. TDD. 频繁提交。

假设他们是一个熟练的开发人员，但对我们的工具集或问题领域几乎一无所知。假设他们不太懂良好的测试设计。

**开始时宣布：** "我正在使用 writing-plans 技能来创建实施计划。"

**上下文：** 这应该在专用的工作树中运行（由 brainstorming 技能创建）。

**保存计划至：** `docs/plans/YYYY-MM-DD-<feature-name>.md`

## 一口大小的任务粒度 (Bite-Sized Task Granularity)

**每一步是一个动作 (2-5 分钟):**
- "编写失败的测试" - 步骤
- "运行它以确保它失败" - 步骤
- "实施最少的代码使测试通过" - 步骤
- "运行测试并确保它们通过" - 步骤
- "提交" - 步骤

## 计划文档头

**每个计划必须以这个头部开始：**

```markdown
# [Feature Name] Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** [一句话描述这构建了什么]

**Architecture:** [2-3 句关于方法的描述]

**Tech Stack:** [关键技术/库]

---
```

## 任务结构

```markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

**Step 1: Write the failing test**

```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```

**Step 2: Run test to verify it fails**

Run: `pytest tests/path/test.py::test_name -v`
Expected: FAIL with "function not defined"

**Step 3: Write minimal implementation**

```python
def function(input):
    return expected
```

**Step 4: Run test to verify it passes**

Run: `pytest tests/path/test.py::test_name -v`
Expected: PASS

**Step 5: Commit**

```bash
git add tests/path/test.py src/path/file.py
git commit -m "feat: add specific feature"
```
```

## 记住
- 始终使用确切的文件路径
- 计划中提供完整的代码（不仅仅是“添加验证”）
- 带有预期输出的确切命令
- 使用 @ 语法引用相关技能
- DRY, YAGNI, TDD, 频繁提交

## 执行移交 (Execution Handoff)

保存计划后，提供执行选项：

**"计划已完成并保存至 `docs/plans/<filename>.md`。两个执行选项：**

**1. Subagent-Driven (本次会话)** - 我为每个任务分派新的子智能体，任务之间进行审查，快速迭代

**2. Parallel Session (单独会话)** - 打开新会话使用 executing-plans，带检查点的批量执行

**选择哪种方法？"**

**如果选择 Subagent-Driven:**
- **REQUIRED SUB-SKILL:** 使用 superpowers:subagent-driven-development
- 留在此会话中
- 每个任务新的子智能体 + 代码审查

**如果选择 Parallel Session:**
- 引导他们在工作树中打开新会话
- **REQUIRED SUB-SKILL:** 新会话使用 superpowers:executing-plans