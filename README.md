# Superpowers (Gemini CLI / Codex)

为 **Gemini CLI** 与 **Codex** 打造的“超能力”技能包，实现自动引导和进阶开发工作流。

## 功能特性

- **自动引导 (Auto-Bootstrap)**: 启动即获得“超能力”身份，自动检查适用技能。
- **进阶技能集**:
  - `using-superpowers`: 核心调度逻辑。
  - `brainstorming`: 深度脑暴与设计。
  - `writing-plans`: 细粒度实施计划。
  - `test-driven-development`: 严格的 TDD 流程。
- **一键安装**: 简单的脚本即可完成环境配置。

## 安装方法（支持 Gemini CLI / Codex）

### macOS / Linux

在终端运行以下命令：

```bash
git clone https://github.com/joeLin2025/superpowers-zh.git
cd gemini-skills
./install.sh
```

安装完成后，按提示选择 `codex` 或 `gemini`，并重新启动对应 CLI。

### Windows（PowerShell）

前置条件：已安装 **Git** 与 **Python 3**，并确保 `python` 可在 PowerShell 中使用。

在 PowerShell 中执行：

```powershell
git clone https://github.com/joeLin2025/superpowers-zh.git
cd gemini-skills
.\install.ps1
```

如果提示脚本执行策略受限，可先临时允许当前会话：

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\install.ps1
```

安装完成后，按提示选择 `codex` 或 `gemini`，并重新启动对应 CLI。

## 使用说明

一旦安装，Gemini 或 Codex 在处理你的请求前会：
1. 读取全局引导文件：Gemini 为 `GEMINI.md`，Codex 为 `AGENTS.md`。
2. 自动激活 `using-superpowers` 技能。
3. 检查是否有适用的其他技能（如脑暴、TDD等）。
4. 严格按照预定义的高质量工作流执行任务。

---

## 致谢

本项目的核心理念与架构灵感来源于 **Superpowers**。在此向原作者致敬，感谢其开创性的工作。

- **Superpowers**: [obra/superpowers](https://github.com/obra/superpowers)
