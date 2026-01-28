# Superpowers for Codex

使用 Superpowers 与 OpenAI Codex 的完整指南。

## 快速安装

告诉 Codex:

```
Fetch and follow instructions from https://raw.githubusercontent.com/obra/superpowers/refs/heads/main/.codex/INSTALL.md
```

## 手动安装

### 先决条件

- OpenAI Codex 访问权限
- Shell 访问权限以安装文件

### 安装步骤

#### 1. 克隆 Superpowers

```bash
mkdir -p ~/.codex/superpowers
git clone https://github.com/obra/superpowers.git ~/.codex/superpowers
```

#### 2. 安装引导程序

引导程序文件包含在仓库中的 `.codex/superpowers-bootstrap.md`。Codex 将自动使用克隆位置的它。

#### 3. 验证安装

告诉 Codex:

```
Run ~/.codex/superpowers/.codex/superpowers-codex find-skills to show available skills
```

你应该看到带有描述的可用技能列表。

## 用法

### 查找技能

```
Run ~/.codex/superpowers/.codex/superpowers-codex find-skills
```

### 加载技能

```
Run ~/.codex/superpowers/.codex/superpowers-codex use-skill superpowers:brainstorming
```

### 引导所有技能

```
Run ~/.codex/superpowers/.codex/superpowers-codex bootstrap
```

这会加载带有所有技能信息的完整引导程序。

### 个人技能

在 `~/.codex/skills/` 中创建你自己的技能：

```bash
mkdir -p ~/.codex/skills/my-skill
```

创建 `~/.codex/skills/my-skill/SKILL.md`:

```markdown
---
name: my-skill
description: Use when [condition] - [what it does]
---

# My Skill

[Your skill content here]
```

同名的个人技能覆盖 superpowers 技能。

## 架构

### Codex CLI 工具

**位置:** `~/.codex/superpowers/.codex/superpowers-codex`

一个 Node.js CLI 脚本，提供三个命令：
- `bootstrap` - 加载带有所有技能的完整引导程序
- `use-skill <name>` - 加载特定技能
- `find-skills` - 列出所有可用技能

### 共享核心模块

**位置:** `~/.codex/superpowers/lib/skills-core.js`

Codex 实现使用共享的 `skills-core` 模块（ES 模块格式）进行技能发现和解析。这与 OpenCode 插件使用的模块相同，确保跨平台的一致行为。

### 工具映射

为 Claude Code 编写的技能通过以下映射适配 Codex：

- `TodoWrite` → `update_plan`
- 带有子智能体的 `Task` → 告诉用户子智能体不可用，直接工作
- `Skill` 工具 → `~/.codex/superpowers/.codex/superpowers-codex use-skill`
- 文件操作 → 原生 Codex 工具

## 更新

```bash
cd ~/.codex/superpowers
git pull
```

## 故障排除

### 技能未找到

1. 验证安装：`ls ~/.codex/superpowers/skills`
2. 检查 CLI 是否工作：`~/.codex/superpowers/.codex/superpowers-codex find-skills`
3. 验证技能有 SKILL.md 文件

### CLI 脚本不可执行

```bash
chmod +x ~/.codex/superpowers/.codex/superpowers-codex
```

### Node.js 错误

CLI 脚本需要 Node.js。验证：

```bash
node --version
```

应显示 v14 或更高版本（推荐 v18+ 以支持 ES 模块）。

## 获取帮助

- 报告问题: https://github.com/obra/superpowers/issues
- 主要文档: https://github.com/obra/superpowers
- 博客文章: https://blog.fsck.com/2025/10/27/skills-for-openai-codex/

## 注意

Codex 支持是实验性的，可能需要根据用户反馈进行微调。如果你遇到问题，请在 GitHub 上报告。