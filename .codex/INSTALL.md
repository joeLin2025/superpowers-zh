# 安装 Superpowers-zh for Codex

在 Codex 中启用 superpowers-zh 技能的快速设置。

## 安装

1. **克隆 superpowers-zh 仓库**:
   ```bash
   mkdir -p ~/.codex/superpowers-zh
   cd ~/.codex/superpowers-zh
   git clone https://github.com/superpowers-zh/superpowers-zh.git .
   ```

2. **创建个人技能目录**:
   ```bash
   mkdir -p ~/.codex/skills
   ```

3. **更新 ~/.codex/AGENTS.md** 以包含此 superpowers-zh 部分：
   ```markdown
   ## Superpowers-zh System

   <EXTREMELY_IMPORTANT>
   You have superpowers-zh. Superpowers teach you new skills and capabilities. RIGHT NOW run: `~/.codex/superpowers-zh/.codex/superpowers-codex bootstrap` and follow the instructions it returns.
   </EXTREMELY_IMPORTANT>
   ```

## 验证

测试安装：
```bash
~/.codex/superpowers-zh/.codex/superpowers-codex bootstrap
```

你应该看到技能列表和引导说明。系统现在可以使用了。