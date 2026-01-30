# 安装 Superpowers-zh for Gemini CLI

在 Gemini CLI 中一键启用 superpowers-zh 技能库，让你的 Agent 拥有专业级的软件工程能力。

## 前提条件

*   已安装 [Gemini CLI](https://geminicli.com) (>= 1.0.0)
*   本地已克隆 `superpowers-zh` 仓库

## 快速安装

我们提供了自动化脚本，会自动将技能安装到您的 Gemini CLI 全局配置目录 (`~/.gemini/`) 中，并配置必要的引导指令。

### Windows

在 PowerShell 中，进入项目根目录并运行：

```powershell
.\.gemini\install.ps1
```

### macOS / Linux

在终端中，进入项目根目录并运行：

```bash
chmod +x .gemini/install.sh
./.gemini/install.sh
```

## 安装了什么？

安装脚本执行了以下操作：

1.  **部署技能**：将 `skills/` 目录下的所有技能复制到 `~/.gemini/skills/`。
    *   这使得你可以通过 `/skills` 命令查看它们。
    *   Agent 可以通过 `<available_skills>` 标签感知到它们。
2.  **注入协议**：修改 `~/.gemini/GEMINI.md`（Agent 的长期记忆文件）。
    *   添加了 "Superpowers Configuration" 协议。
    *   强制 Agent 在遇到特定任务（如修 Bug、写代码）时**必须**激活对应的技能。
    *   配置了技能别名和触发条件。

## 验证安装

安装完成后，重启您的 Gemini CLI 会话，然后输入：

```
/skills list
```

你应该能看到一系列强大的技能，例如：
*   `brainstorming`
*   `systematic-debugging`
*   `test-driven-development`
*   `utf8-safe-file-handling`

此外，你可以尝试对 Agent 说：
> "我想开发一个新的贪吃蛇游戏"

Agent 应该会自动回复：
> "好的，这看起来像是一个新功能开发任务。我正在激活 `brainstorming` 技能来帮助我们开始..."

## 手动安装 (如果不使用脚本)

如果您更喜欢手动控制，可以执行以下步骤：

1.  复制 `skills/` 文件夹下的所有内容到您的 Gemini 技能目录（通常是 `~/.gemini/skills/` 或 `%USERPROFILE%\.gemini\skills\`）。
2.  编辑 `~/.gemini/GEMINI.md`，将以下内容复制到文件覆盖：

```markdown
# Superpowers Configuration

<EXTREMELY_IMPORTANT>
你已获得 'Superpowers-zh' 技能增强。

**核心指令 (CORE DIRECTIVE):**
哪怕只有 1% 的机会认为某个专业技能适用于当前任务，你**必须**使用 `activate_skill` 激活它。

**工作流 (Workflow):**
1.  **分析需求**：在行动前，检查 `<available_skills>` 列表。
2.  **激活技能**：调用 `activate_skill(name="技能名称")`。
3.  **严格遵循**：哪怕你认为自己知道怎么做，也必须严格按照技能描述中的指令执行。
4. - **绝不**跳过强制性工作流（编码前的头脑风暴，TDD，系统化调试）

**强制映射 (Mandatory Mappings):**
- **新功能/新任务?** -> `activate_skill(name="brainstorming")`
- **编写代码/实现逻辑?** -> `activate_skill(name="test-driven-development")`
- **修复 Bug/排查异常?** -> `activate_skill(name="systematic-debugging")`
- **制定复杂计划?** -> `activate_skill(name="writing-plans")`
- **Windows 文件操作?** -> `activate_skill(name="utf8-safe-file-handling")` (Windows 环境下必须激活)
- **收到代码审查反馈?** -> `activate_skill(name="receiving-code-review")`

**禁止出现的念头 (Forbidden Thoughts):**
- "这只是个小改动" -> **停止**。使用 `systematic-debugging`。
- "我知道该怎么做" -> **停止**。使用技能以确保符合标准化质量。
- "我先看一眼文件" -> **停止**。技能会教你如何系统地查看文件。

**工具映射 (Tool Equivalents):**
- "Skill" 工具 -> `activate_skill`
- "TodoWrite" -> 你的内部计划/响应输出。

你不仅是一个 Agent，你还是一个拥有**超级能力 (Superpowered)** 的工程师。请保持纪律。
</EXTREMELY_IMPORTANT>
```

---
本项目基于 [obra/superpowers](https://github.com/obra/superpowers) 进行二次开发与本土化增强。
