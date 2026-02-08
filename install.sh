#!/bin/bash

# Superpowers 安装脚本（支持 Codex / Gemini）

set -e

PROJECT_ROOT=$(pwd)

echo "Select agent model to install:"
echo "  1) codex"
echo "  2) gemini"
read -r -p "Enter 1 or 2: " CHOICE

if [ "$CHOICE" = "1" ]; then
  AGENT_NAME="Codex"
  CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
  SKILLS_DIR="$HOME/.agents/skills"
  GLOBAL_CONTEXT="$CODEX_HOME/AGENTS.md"
elif [ "$CHOICE" = "2" ]; then
  AGENT_NAME="Gemini CLI"
  GEMINI_DIR="$HOME/.gemini"
  SKILLS_DIR="$GEMINI_DIR/skills"
  GLOBAL_CONTEXT="$GEMINI_DIR/GEMINI.md"
else
  echo "Invalid selection. Please enter 1 or 2."
  exit 1
fi
echo "🚀 开始安装 Superpowers for $AGENT_NAME..."

# 1. 创建必要的目录
mkdir -p "$SKILLS_DIR"

# 2. 拷贝技能文件
echo "📦 正在部署技能文件到 $SKILLS_DIR..."
cp -R "$PROJECT_ROOT/skills/"* "$SKILLS_DIR/"

# 3. 注入引导内容到上下文文件
echo "💉 正在生成并注入动态引导内容到 $GLOBAL_CONTEXT..."

if [ -f "$GLOBAL_CONTEXT" ]; then
    # 如果文件存在，先备份
    echo "⚠️  $GLOBAL_CONTEXT 已存在，正在备份为 ${GLOBAL_CONTEXT}.old..."
    cp "$GLOBAL_CONTEXT" "${GLOBAL_CONTEXT}.old"
fi

# 调用 Python 脚本生成动态内容并覆盖写入
python3 "$PROJECT_ROOT/scripts/generate_registry.py" --template "$PROJECT_ROOT/bootstrap/BOOTSTRAP.md" --agent-name "$AGENT_NAME" > "$GLOBAL_CONTEXT"

echo "✅ 安装成功！"
echo "请重新启动您的 Agent CLI 即可享受超能力。"
