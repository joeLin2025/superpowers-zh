# Superpowers-zh

Superpowers-zh 是为你的编程智能体（Coding Agent）打造的一套完整的软件开发工作流，建立在一系列可组合的“技能（Skills）”之上，并包含一些初始指令以确保智能体正确使用这些技能。

## 工作原理

从你启动编程智能体的那一刻起，它就开始工作了。一旦它发现你在构建某种东西，它*不会*直接跳进去写代码。相反，它会退一步问你真正想要做什么。

一旦它通过对话梳理出规范，它会将规范分成足够短的小块展示给你，以便你真正阅读和消化。

在你签署设计方案后，你的智能体将制定一个实施计划。这个计划非常清晰，即使是一个品味差、没有判断力、没有项目背景且讨厌测试的热情初级工程师也能遵循。它强调真正的红/绿 TDD（测试驱动开发）、YAGNI（你不需要它）和 DRY（不要重复自己）。

接下来，一旦你说“开始”，它就会启动一个*子智能体驱动开发（subagent-driven-development）*流程，让智能体逐个完成工程任务，检查和审查他们的工作，然后继续前进。Claude 连续自主工作几个小时而不偏离你制定的计划，这种情况并不罕见。

还有很多其他功能，但这是系统的核心。而且因为技能会自动触发，你不需要做任何特别的事情。你的编程智能体自然就拥有了 Superpowers-zh。

## 安装

**注意：** 安装方式因平台而异。Claude Code 有内置的插件系统。Codex 和 OpenCode 需要手动设置。

### Claude Code (通过插件市场)

在 Claude Code 中，首先注册市场：

```bash
/plugin marketplace add superpowers-zh/superpowers-marketplace
```

然后从该市场安装插件：

```bash
/plugin install superpowers-zh@superpowers-marketplace
```

### 验证安装

检查命令是否出现：

```bash
/help
```

```
# 应该能看到：
# /superpowers-zh:brainstorm - 交互式设计细化
# /superpowers-zh:write-plan - 创建实施计划
# /superpowers-zh:execute-plan - 批量执行计划
```

### Codex

告诉 Codex：

```
Fetch and follow instructions from https://raw.githubusercontent.com/superpowers-zh/superpowers-zh/refs/heads/main/.codex/INSTALL.md
```

**详细文档：** [docs/README.codex.md](docs/README.codex.md)

### OpenCode

告诉 OpenCode：

```
Fetch and follow instructions from https://raw.githubusercontent.com/superpowers-zh/superpowers-zh/refs/heads/main/.opencode/INSTALL.md
```

**详细文档：** [docs/README.opencode.md](docs/README.opencode.md)

## 基本工作流

1. **头脑风暴 (brainstorming)** - 在写代码前激活。通过提问完善粗略的想法，探索替代方案，分章节展示设计以供验证。保存设计文档。

2. **使用 Git 工作树 (using-git-worktrees)** - 在设计获得批准后激活。在新分支上创建隔离的工作区，运行项目设置，验证干净的测试基线。

3. **编写计划 (writing-plans)** - 在设计获批后激活。将工作分解为小任务（每个 2-5 分钟）。每个任务都有确切的文件路径、完整的代码、验证步骤。

4. **子智能体驱动开发 (subagent-driven-development)** 或 **执行计划 (executing-plans)** - 随计划激活。为每个任务分派新的子智能体，进行两阶段审查（先规范合规性，后代码质量），或在有人工检查点的情况下分批执行。

5. **测试驱动开发 (test-driven-development)** - 在实施期间激活。强制执行红-绿-重构（RED-GREEN-REFACTOR）：编写失败的测试，看着它失败，编写最少的代码，看着它通过，提交。删除测试前编写的代码。

6. **请求代码审查 (requesting-code-review)** - 在任务之间激活。根据计划进行审查，按严重程度报告问题。关键问题会阻止进度。

7. **完成开发分支 (finishing-a-development-branch)** - 任务完成时激活。验证测试，提供选项（合并/PR/保留/丢弃），清理工作树。

**智能体会在执行任何任务前检查相关技能。** 这是强制性工作流，不仅仅是建议。

## 内容包含

### 技能库

**测试**
- **test-driven-development** - 红-绿-重构循环（包含反模式参考）

**调试**
- **systematic-debugging** - 4 阶段根本原因流程（包括根本原因追踪、深度防御、基于条件的等待技术）
- **verification-before-completion** - 确保问题确实已修复
- **utf8-safe-file-handling** - 强制 UTF-8 编码安全，防止 Windows 乱码

**协作**
- **brainstorming** - 苏格拉底式设计细化
- **writing-plans** - 详细的实施计划
- **executing-plans** - 带检查点的批量执行
- **dispatching-parallel-agents** - 并发子智能体工作流
- **requesting-code-review** - 预审查清单
- **receiving-code-review** - 响应反馈
- **using-git-worktrees** - 并行开发分支
- **finishing-a-development-branch** - 合并/PR 决策工作流
- **subagent-driven-development** - 带有两阶段审查（先规范合规性，后代码质量）的快速迭代

**元技能**
- **writing-skills** - 遵循最佳实践创建新技能（包括测试方法论）
- **using-superpowers-zh** - 技能系统介绍

## 哲学

- **测试驱动开发 (Test-Driven Development)** - 始终先写测试
- **系统化胜于临时起意 (Systematic over ad-hoc)** - 流程优于猜测
- **降低复杂性 (Complexity reduction)** - 简单是首要目标
- **证据胜于主张 (Evidence over claims)** - 在宣布成功前进行验证

## 开发规范

### 文件编码要求 (UTF-8 No BOM)

为确保跨平台兼容性（Windows/Linux/macOS）及代码解析工具的稳定性，本项目强制要求所有文本文件（`.md`, `.js`, `.json`, `.sh`, `.ps1` 等）必须使用 **UTF-8 无 BOM (No BOM)** 格式。

**严禁行为：**
- 使用带 BOM 的 UTF-8 格式（常见于旧版 Windows 记事本或 PowerShell 重定向）。
- 在 PowerShell 中使用 `>` 或 `>>` 重定向输出到文件（这通常会导致 BOM 或 UTF-16 编码）。请使用 `write_file` 工具或 Node.js 脚本替代。

**检查与修复：**
本项目提供了一个维护脚本，用于扫描并自动移除项目中的 BOM 标记：

```bash
node scripts/ensure-utf8.js
```

建议在提交代码前运行此脚本。

## 贡献

技能直接位于此存储库中。要做出贡献：

1. Fork 存储库
2. 为你的技能创建一个分支
3. 遵循 `writing-skills` 技能来创建和测试新技能
4. 提交 PR

查看 `skills/writing-skills/SKILL.md` 获取完整指南。

## 更新

当你更新插件时，技能会自动更新：

```bash
/plugin update superpowers-zh
```

## 许可证

MIT License - 详情请见 LICENSE 文件

## 支持

- **Issues**: https://github.com/superpowers-zh/superpowers-zh/issues
- **Marketplace**: https://github.com/superpowers-zh/superpowers-marketplace

---

本项目基于 [obra/superpowers](https://github.com/obra/superpowers) 进行二次开发与本土化增强。
