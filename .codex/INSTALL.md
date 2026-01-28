# 安装 Superpowers for Codex

在 Codex 中启用 superpowers 技能的快速设置。

## 安装

1. **克隆 superpowers 仓库**:
   ```bash
   mkdir -p ~/.codex/superpowers
   cd ~/.codex/superpowers
   git clone https://github.com/obra/superpowers.git .
   ```

2. **创建个人技能目录**:
   ```bash
   mkdir -p ~/.codex/skills
   ```

3. **更新 ~/.codex/AGENTS.md** 以包含此 superpowers 部分：
   ```markdown
   ## Superpowers System

   <EXTREMELY_IMPORTANT>
   You have superpowers. Superpowers teach you new skills and capabilities. RIGHT NOW run: `~/.codex/superpowers/.codex/superpowers-codex bootstrap` and follow the instructions it returns.
   </EXTREMELY_IMPORTANT>
   ```

## 验证

测试安装：
```bash
~/.codex/superpowers/.codex/superpowers-codex bootstrap
```

你应该看到技能列表和引导说明。系统现在可以使用了。
