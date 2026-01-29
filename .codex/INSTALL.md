# 安装 Superpowers-zh for Codex

在 Codex 中启用 superpowers-zh 技能的快速设置。

## 安装步骤

### 1. 放置项目文件

将整个项目文件夹（包含 `skills/`, `lib/`, `.codex/` 等）放置到您的 Codex 配置目录下。

*   **macOS / Linux**: `~/.codex/superpowers-zh`
*   **Windows**: `%USERPROFILE%\.codex\superpowers-zh`

### 2. 创建个人技能目录

如果您还没有个人技能目录，请创建一个。

*   **macOS / Linux**: `mkdir -p ~/.codex/skills`
*   **Windows**: `mkdir "%USERPROFILE%\.codex\skills"`

### 3. 配置 Codex 启动项

在您的 Codex 配置目录中找到或创建 **`AGENTS.md`** 文件（通常位于 `~/.codex/AGENTS.md`），并添加以下内容：

#### macOS / Linux 版:
```markdown
## Superpowers-zh 系统激活

<EXTREMELY_IMPORTANT>
你有 superpowers-zh。
现在立即运行此命令来加载技能库引导程序：
`~/.codex/superpowers-zh/.codex/superpowers-codex bootstrap`
并严格遵循它返回的所有指令。
</EXTREMELY_IMPORTANT>
```

#### Windows 版:
```markdown
## Superpowers-zh 系统激活 (Windows)

<EXTREMELY_IMPORTANT>
你有 superpowers-zh。
现在立即运行此命令来加载技能库引导程序：
`node %USERPROFILE%\.codex\superpowers-zh\.codex\superpowers-codex bootstrap`
并严格遵循它返回的所有指令。
</EXTREMELY_IMPORTANT>
```

## 验证安装

在终端或 Codex 对话框中测试安装：

*   **macOS / Linux**:
    ```bash
    ~/.codex/superpowers-zh/.codex/superpowers-codex find-skills
    ```
*   **Windows**:
    ```cmd
    node %USERPROFILE%\.codex\superpowers-zh\.codex\superpowers-codex find-skills
    ```

你应该能看到以 `superpowers-zh:` 开头的可用技能列表。系统现在可以使用了。

## 常用命令参考

由于 Windows 不支持 Shebang 直接运行脚本，您需要使用 `node` 命令引导：

| 功能 | macOS / Linux | Windows |
| :--- | :--- | :--- |
| **启动引导** | `.../superpowers-codex bootstrap` | `node ...\superpowers-codex bootstrap` |
| **查找技能** | `.../superpowers-codex find-skills` | `node ...\superpowers-codex find-skills` |
| **加载技能** | `.../superpowers-codex use-skill <name>` | `node ...\superpowers-codex use-skill <name>` |

---

本项目基于 [obra/superpowers](https://github.com/obra/superpowers) 进行二次开发与本土化增强。