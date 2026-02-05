---
name: using-git-worktrees
description: 当需要在不干扰当前工作区的前提下，处理并发开发、紧急 Bug 修复或进行多版本基准对比时使用。
---

# 使用 Git Worktrees

## 概述

本技能用于在同一仓库中创建多个隔离工作目录，避免污染当前工作区并提升并发效率。

**核心原则**
1. **路径规范**：Worktree 必须位于约定目录。
2. **基线验证**：新 Worktree 必须通过基础测试。
3. **安全清理**：必须用 Git 命令移除 Worktree。

## 何时使用

- 紧急修复与主任务并行。
- 同时验证多个分支或版本。

## 强制流程 (Workflow)

### 1. 路径层级规范
- 首选 `.worktrees/` 目录（需在 `.gitignore` 中忽略）。
- 禁止散落在 `Desktop/`、`Downloads/` 等随机位置。

### 2. 创建与初始化
- `git worktree add [path] -b [branch]`
- 安装依赖并运行基础测试。
- 基线测试失败则立即删除该 worktree。

### 3. 分支互斥
- 同一分支不得在多个 worktree 同时挂载。
- `git worktree list` 必须检查占用情况。

### 4. 清理协议
- `git worktree remove [path]`
- 必要时运行 `git worktree prune`。

## 禁令
- 禁止手动 `rm -rf` 删除 worktree。
- 禁止在未验证基线前开始开发。

## 借口粉碎机 (Excuse Smasher)

| 借口 | 事实反击 |
|------|----------|
| “stash 就够了” | stash 无法隔离依赖与构建产物。 |
| “路径随便放” | 路径污染会导致状态混乱与误删风险。 |
| “直接删文件夹更快” | 必须通过 Git 命令维护索引一致性。 |

## 危险信号 (Red Flags)

- Worktree 未通过基线测试。
- 手动删除 worktree 目录。
- 同一分支被多个 worktree 占用。
