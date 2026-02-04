---
name: using-git-worktrees
description: 当需要在不干扰当前工作区的前提下，处理并发开发、紧急 Bug 修复或进行多版本基准对比时使用。
---

# 使用 Git Worktrees (Using Git Worktrees)

## 概述

Git Worktree 是一种实现“物理级任务隔离”的高级工作流。它允许在同一个仓库中同时检出多个分支到不同的文件目录，从而彻底解决 `git stash` 或 `git checkout` 导致的代码覆盖、构建缓存失效及 IDE 索引重置问题。

**核心原则：**
1.  **物理隔离 (Physical Isolation)**：每个分支独占一个物理目录，确保构建产物和环境配置互不干扰。
2.  **安全准入 (Security Gatekeeping)**：严禁在未被 `.gitignore` 覆盖的目录下创建 Worktree。防止污染主仓库的 Git 状态。
3.  **基线确定性 (Baseline Certainty)**：新创建的 Worktree 必须在通过初始基线测试后方可标记为“可用”。

## 何时使用

- **紧急热修复 (Hotfix)**：在 Feature 分支开发到一半时，需要立即切出干净环境修复生产 Bug。
- **并发评审 (Concurrent Review)**：需要同时运行自己的代码和同事的 PR 分支进行交互测试。
- **环境隔离复现**：需要一个完全不带任何本地未提交更改（Dirty state）的环境来复现特定故障。
- **长时阻塞任务**：当前分支正在进行长达数十分钟的编译或大型集成测试，需在另一目录继续编码。

## 核心法则

### 1. 强制目录层级规范 (Path Hierarchy)
**严禁**随意散落在磁盘各处。必须遵循以下路径决策算法：
- **优先**：项目根目录下的 `.worktrees/`（必须已在 `.gitignore` 中注册）。
- **备选**：用户家目录下的特定统一管理路径（如 `~/.config/gemini/worktrees/[project-name]/`）。
- **动作**：创建前必须执行 `git check-ignore`。若路径未被忽略，**必须**先修改 `.gitignore` 并提交。

### 2. 原子化创建与初始化 (Creation & Init)
创建动作必须包含以下闭环步骤：
1.  **检出**：执行 `git worktree add [path] -b [branch-name]`。
2.  **环境同步**：进入目录后，**无条件执行**依赖安装命令（如 `npm i`, `pip install`, `go mod download`）。
3.  **基线验证**：运行项目的冒烟测试或主干测试。若初始化测试失败，**立即停止**并删除该 Worktree，严禁在故障基线上开发。

### 3. 分支互斥律 (Branch Mutex)
- **铁律**：严禁两个 Worktree 同时挂载同一个分支。
- **动作**：创建前使用 `git worktree list` 检查目标分支是否已被占用。

### 4. 彻底清理协议 (Cleanup Protocol)
任务完成后，**必须**通过 Git 命令而非手动删除文件夹：
- **命令**：`git worktree remove [path]`。
- **目的**：确保 Git 内部索引（Index）得到正确清理，防止产生“僵尸 Worktree”。

## 借口粉碎机 (Excuse Smasher)

| 借口 | 事实反击 |
|------|----------|
| “我用 Stash 很快就能切过去” | Stash 不会隔离 `node_modules` 和二进制产物。大型项目中，重新编译的时间远超创建 Worktree 的时间。 |
| “磁盘空间不够了” | 一个 Worktree 共享同一个 `.git` 对象库，额外的空间仅为源码和依赖。若空间不足，说明需要清理旧的 Worktree 而非放弃该流程。 |
| “我手动删了文件夹，Git 报错了” | 这就是为什么必须使用 `git worktree remove`。手动删除会破坏 Git 内部状态，必须通过 `git worktree prune` 来修复。 |

## 危险信号 (Red Flags)

- **目录污染**：执行 `git status` 时看到了 `.worktrees/` 目录下的文件。
- **基线未验证**：创建了 Worktree 后直接开始写逻辑，而没有确认当前环境是否能跑通测试。
- **路径随意性**：Worktree 被创建在了 `Downloads/` 或 `Desktop/` 等非规范路径。
- **手动管理风险**：通过直接 `rm -rf` 文件夹来清理 Worktree。