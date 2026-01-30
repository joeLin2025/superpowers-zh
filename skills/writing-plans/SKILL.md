---
name: writing-plans
description: 当你对多步任务有规范或需求时使用，在接触代码之前
---

# 编写计划 (Writing Plans)

## 概述

编写全面的实施计划，假设工程师对我们的代码库毫无背景知识且品味值得怀疑。记录他们需要知道的一切：每个任务需要触及哪些文件、代码、测试、他们可能需要检查的文档、如何测试。以一口大小 (bite-sized) 的任务形式给他们整个计划。DRY. YAGNI. TDD. 频繁提交。

**强制要求：** 生成的计划文档内容必须**完全使用中文**（代码、路径和技术术语除外）。

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

**每个计划必须以这个头部开始（使用中文标签）：**

```markdown
# [功能名称] 实施计划

> **For Claude:** 必须使用的子技能: 使用 superpowers-zh:executing-plans 来逐项任务实施此计划。

**目标:** [一句话描述这构建了什么]

**架构:** [2-3 句关于方法的描述]

**技术栈:** [关键技术/库]

---
```

## 任务结构

**任务必须使用中文描述和标签：**

```markdown
### 任务 N: [组件名称]

**涉及文件:**
- 创建: `exact/path/to/file.py`
- 修改: `exact/path/to/existing.py:123-145`
- 测试: `tests/exact/path/to/test.py`

**步骤 1: 编写失败的测试**

```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```

**步骤 2: 运行测试以验证失败**

运行: `pytest tests/path/test.py::test_name -v`
预期结果: 失败，并显示 "function not defined"

**步骤 3: 编写最小化实施方案**

```python
def function(input):
    return expected
```

**步骤 4: 运行测试以验证通过**

运行: `pytest tests/path/test.py::test_name -v`
预期结果: 通过 (PASS)

**步骤 5: 提交更改**

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
- **所有描述性文字及对任务、架构和目标的说明必须使用高质量的中文。**

## 执行移交 (Execution Handoff)

保存计划后，提供执行选项：

**"计划已完成并保存至 `docs/plans/<filename>.md`。两个执行选项：**

**1. 子智能体驱动 (Subagent-Driven) (本次会话)** - 我为每个任务分派新的子智能体，任务之间进行审查，快速迭代

**2. 并行会话 (Parallel Session) (单独会话)** - 打开新会话使用 executing-plans，带检查点的批量执行

**选择哪种方法？"**

**如果选择 子智能体驱动:**
- **必须使用的子技能:** 使用 superpowers-zh:subagent-driven-development
- 留在此会话中
- 每个任务新的子智能体 + 代码审查

**如果选择 并行会话:**
- 引导他们在工作树中打开新会话
- **必须使用的子技能:** 新会话使用 superpowers-zh:executing-plans