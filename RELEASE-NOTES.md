# Superpowers-zh 发行说明

## v4.1.1-zh (2026-01-29)

### 本土化与演进

- 项目正式更名为 **Superpowers-zh**。
- 完成了所有核心技能的中文本土化增强。
- 清理了原作者相关的个人记录与链接。
- 在 `README.md` 中保留了对原项目的致谢引用。

---

## v4.1.1 (2026-01-23)

### 修复

**OpenCode: 根据官方文档标准化 `plugins/` 目录 (#343)**

OpenCode 的官方文档使用 `~/.config/opencode/plugins/` (复数)。我们的文档之前使用 `plugin/` (单数)。虽然 OpenCode 接受这两种形式，但我们已统一采用官方惯例以避免混淆。

变更：
- 将仓库结构中的 `.opencode/plugin/` 重命名为 `.opencode/plugins/`
- 更新所有平台上的所有安装文档 (INSTALL.md, README.opencode.md)
- 更新测试脚本以匹配变更

---

本项目基于 [obra/superpowers](https://github.com/obra/superpowers) 进行二次开发与本土化增强。
