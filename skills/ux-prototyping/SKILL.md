---
name: ux-prototyping
description: 当需要产出中文友好的 UX 交互原型、Mockup 或验证业务逻辑流时使用。
---

# UX 交互原型 (UX Prototyping)

## 概述

本技能以“快速验证逻辑与路径”为目标，要求输出中文友好、单文件可运行的原型，并确保交互可被演示。

**核心原则**
1. **逻辑优先**：先验证路径，再谈视觉。
2. **单文件交付**：一个 HTML 文件即完成。
3. **中文友好**：禁止英文占位与 Lorem Ipsum。
4. **轻构建**：禁止引入复杂构建工具。

## 何时使用

- 需要快速验证交互流程。
- 需要对齐业务逻辑与用户路径。

## 强制流程 (Workflow)

### 1. 需求澄清
- 目标用户、核心任务、关键路径。
- 必须包含成功与失败分支。

### 2. 单文件模板 (强制)

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[原型名称]</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    :root { --accent: #1f7a5c; --bg1: #f6f2e9; --bg2: #dce7e2; }
  </style>
</head>
<body>
  <main class="min-h-screen">
    <!-- 中文文案 + 关键流程 -->
  </main>
  <script>
    // 必须模拟关键交互（点击、提交、状态切换）
  </script>
</body>
</html>
```

### 3. 视觉与交互约束
- **字体**：使用非默认字体组合（如 `"Noto Serif SC"` + `"Source Sans 3"`），避免默认系统栈。
- **背景**：必须包含渐变或纹理，不得使用纯色平铺。
- **动效**：至少包含 1 个关键流程动画（页面加载或步骤切换）。

## 禁令
- 禁止 React/Vue/webpack 等构建工具。
- 禁止英文占位文本。
- 禁止无交互的纯静态页面。

## 借口粉碎机 (Excuse Smasher)

| 借口 | 事实反击 |
|------|----------|
| “用 React 更快” | 原型的目标是验证逻辑，不是搭建工程。 |
| “文案先留空” | 空文案无法验证真实用户路径。 |
| “不用动效也可以” | 关键步骤无动效会削弱流程可理解性。 |

## 危险信号 (Red Flags)

- 需要 `npm install` 才能运行。
- 页面仅有静态文字没有交互。
- 中文场景出现大量英文残留。
