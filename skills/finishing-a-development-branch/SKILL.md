---
name: finishing-a-development-branch
description: 当实施完成、所有测试通过，且你需要决定如何集成工作时使用——通过提供用于合并、PR 或清理的结构化选项，指导开发工作的完成
---

# 完成开发分支 (Finishing a Development Branch)

## 概述

通过提供清晰的选项并处理选定的工作流，指导开发工作的完成。

**核心原则：** 验证测试 → 展示选项 → 执行选择 → 清理。

**开始时宣布：** "我正在使用 finishing-a-development-branch 技能来完成这项工作。"

**在向用户展示合并/PR 选项、解释分支操作风险或汇报清理状态时，必须使用自然、专业的中文。**

## 流程

### 步骤 1: 验证测试

**在展示选项之前，验证测试通过：**

```bash
# 运行项目的测试套件
npm test / cargo test / pytest / go test ./...
```

**如果测试失败：**
```
测试失败 (<N> 个失败)。必须在完成前修复：

[展示失败]

无法继续合并/PR，直到测试通过。
```

停止。不要进行步骤 2。

**如果测试通过：** 继续步骤 2。

### 步骤 2: 确定基础分支

```bash
# 尝试常见的基础分支
git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null
```

或者询问：“此分支从 main 分离——这正确吗？”

### 步骤 3: 展示选项

确切地展示这 4 个选项：

```
实施完成。你想做什么？

1. Merge back to <base-branch> locally (本地合并回 <基础分支>)
2. Push and create a Pull Request (推送并创建 PR)
3. Keep the branch as-is (I'll handle it later) (保持分支原样，我稍后处理)
4. Discard this work (丢弃此工作)

选择哪个选项？
```

**不要添加解释** - 保持选项简洁。

### 步骤 4: 执行选择

#### 选项 1: 本地合并 (Merge Locally)

```bash
# 切换到基础分支
git checkout <base-branch>

# 拉取最新
git pull

# 合并功能分支
git merge <feature-branch>

# 在合并结果上验证测试
<test command>

# 如果测试通过
git branch -d <feature-branch>
```

然后：清理工作树 (步骤 5)

#### 选项 2: 推送并创建 PR (Push and Create PR)

```bash
# 推送分支
git push -u origin <feature-branch>

# 创建 PR
gh pr create --title "<title>" --body "$(cat <<'EOF'
## Summary
<2-3 bullets of what changed>

## Test Plan
- [ ] <verification steps>
EOF
)"
```

然后：清理工作树 (步骤 5)

#### 选项 3: 保持原样 (Keep As-Is)

汇报：“保留分支 <name>。工作树保留在 <path>。”

**不要清理工作树。**

#### 选项 4: 丢弃 (Discard)

**首先确认：**
```
这将永久删除：
- 分支 <name>
- 所有提交: <commit-list>
- 位于 <path> 的工作树

输入 'discard' 以确认。
```

等待确切的确认。

如果确认：
```bash
git checkout <base-branch>
git branch -D <feature-branch>
```

然后：清理工作树 (步骤 5)

### 步骤 5: 清理工作树

**对于选项 1, 2, 4:**

检查是否在工作树中：
```bash
git worktree list | grep $(git branch --show-current)
```

如果是：
```bash
git worktree remove <worktree-path>
```

**对于选项 3:** 保留工作树。

## 快速参考

| 选项 | 合并 | 推送 | 保留工作树 | 清理分支 |
|--------|-------|------|---------------|----------------|
| 1. Merge locally | ✓ | - | - | ✓ |
| 2. Create PR | - | ✓ | ✓ | - |
| 3. Keep as-is | - | - | ✓ | - |
| 4. Discard | - | - | - | ✓ (强制) |

## 常见错误

**跳过测试验证**
- **问题：** 合并损坏的代码，创建失败的 PR
- **修复：** 在提供选项前始终验证测试

**开放式问题**
- **问题：** “我接下来该做什么？” → 模棱两可
- **修复：** 展示确切的 4 个结构化选项

**自动工作树清理**
- **问题：** 当可能需要时移除工作树（选项 2, 3）
- **修复：** 仅为选项 1 和 4 清理

**丢弃无确认**
- **问题：** 意外删除工作
- **修复：** 要求输入 "discard" 确认

## 危险信号 (Red Flags)

**绝不:**
- 在测试失败时继续
- 在未验证结果测试的情况下合并
- 在无确认的情况下删除工作
- 在无明确请求的情况下强制推送

**始终:**
- 在提供选项前验证测试
- 展示确切的 4 个选项
- 获得选项 4 的输入确认
- 仅为选项 1 和 4 清理工作树

## 集成

**调用者:**
- **subagent-driven-development** (步骤 7) - 所有任务完成后
- **executing-plans** (步骤 5) - 所有批次完成后

**配合:**
- **using-git-worktrees** - 清理该技能创建的工作树
