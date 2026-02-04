#!/bin/bash

# Gemini Superpowers 安装脚本

set -e

GEMINI_DIR="$HOME/.gemini"
SKILLS_DIR="$GEMINI_DIR/skills"
GLOBAL_CONTEXT="$GEMINI_DIR/GEMINI.md"
PROJECT_ROOT=$(pwd)

echo "🚀 开始安装 Gemini Superpowers..."

# 1. 创建必要的目录
mkdir -p "$SKILLS_DIR"

# 2. 拷贝技能文件
echo "📦 正在部署技能文件到 $SKILLS_DIR..."
cp -R "$PROJECT_ROOT/skills/"* "$SKILLS_DIR/"

# 3. 注入引导内容到 GEMINI.md
echo "💉 正在生成并注入动态引导内容到 $GLOBAL_CONTEXT..."

if [ -f "$GLOBAL_CONTEXT" ]; then
    # 如果文件存在，先备份
    echo "⚠️  $GLOBAL_CONTEXT 已存在，正在备份为 ${GLOBAL_CONTEXT}.old..."
    cp "$GLOBAL_CONTEXT" "${GLOBAL_CONTEXT}.old"
fi

# 调用 Python 脚本生成动态内容并覆盖写入
python3 "$PROJECT_ROOT/scripts/generate_registry.py" > "$GLOBAL_CONTEXT"

echo "✅ 安装成功！"
echo "请重新启动您的 Gemini CLI 即可享受超能力。"
