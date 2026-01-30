---
name: utf8-safe-file-handling
description: 当在 Windows 环境下读取、编写或处理包含中文等非 ASCII 字符的文件时使用，以确保 UTF-8 编码的一致性并防止乱码。
---

# UTF-8 安全文件处理 (UTF-8 Safe File Handling)

## 概述

在 Windows 环境下，默认的系统编码（如 GBK）经常与项目要求的 UTF-8 编码冲突，导致 Agent 读取或生成文件时出现乱码。本技能强制执行一套安全的文件处理准则，确保中文内容的完整性。

**核心原则：** 优先使用内置工具，严禁不受控的 Shell 读写。

## 铁律 (The Iron Rules)

### 1. 优先使用内置工具 (Built-in Tools First)
- **读取**：必须使用 `read_file` 工具。**严禁**使用 `run_shell_command` 执行 `type`、`cat` 或 `Get-Content` 来查看包含中文的文件。
- **写入**：必须使用 `write_file` 工具。它会自动以 UTF-8（无 BOM）编码保存文件。
- **修改**：必须使用 `replace` 工具。它在读取和写入时都会保持编码一致性。

### 2. 严禁 Shell 重定向写入 (No Shell Redirection)
- **绝对禁止**使用 `run_shell_command` 的 `>` 或 `>>` 操作符来创建或追加包含中文的文件。
- **理由**：PowerShell 的重定向在不同版本下默认行为不一（可能是 UTF-16 或 ANSI），极易造成损坏。

### 3. Shell 命令防御 (Shell Guardrails)
如果必须使用 `run_shell_command` 处理文件内容（如使用 `grep` 或 `findstr`），必须在命令前缀中强制设置输出编码：

```powershell
# 在 PowerShell 命令执行前设置输出编码为 UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; <你的命令>
```

## 安全与危险示例 (Safe vs. Dangerous)

| 操作 | ❌ 危险方式 (会导致乱码) | ✅ 安全方式 (推荐) |
| :--- | :--- | :--- |
| **读取文件** | `run_shell_command(command="type README.md")` | `read_file(file_path="README.md")` |
| **创建文件** | `run_shell_command(command="echo '中文' > test.txt")` | `write_file(file_path="test.txt", content="中文")` |
| **全局搜索** | `run_shell_command(command="grep -r '关键词' .")` | `search_file_content(pattern="关键词")` |
| **批量修改** | 使用 PowerShell 的 `Set-Content` 脚本 | 多次调用内置的 `replace` 工具 |

## 护栏与红旗 (Guardrails & Red Flags)

- **🚩 看到乱码时**：立即停止。不要尝试通过猜测编码来修复。使用 `git checkout` 恢复文件，并检查是否违背了上述铁律。
- **🚩 处理 `SKILL.md` 时**：这些文件包含大量中文，**必须** 100% 遵循本技能。
- **🚩 环境变量**：在执行 Shell 脚本前，可以尝试设置 `PYTHONIOENCODING=utf-8` 和 `LANG=zh_CN.UTF-8`。

## 结论

**编码正确性是功能正确性的前提。**

在 Windows 上，不要信任任何默认的 Shell 行为。始终使用 Gemini CLI 提供的原生工具来处理文本。
