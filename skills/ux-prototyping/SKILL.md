---
name: ux-prototyping
description: 当需要产出中文友好的 UX 交互原型、Mockup 或验证业务逻辑流时使用。
---

# UX 交互原型 (UX Prototyping)

## 概述

本技能以“快速验证逻辑与路径”为目标，要求输出中文友好、单文件可运行的原型，并确保交互可演示。

## 何时使用

- 需要快速验证交互流程或业务逻辑。

**触发关键词**: `UX / 原型 / Mockup / 交互`

## 强制流程 (Workflow)

### 1. 逻辑优先
- 先验证路径与状态流转，再处理视觉细节。

### 2. 单文件交付
- 必须输出单个 HTML 文件，可直接打开运行。

### 3. 中文友好
- 禁止英文占位与 Lorem Ipsum。

### 4. 轻构建
- 禁止引入复杂构建工具。

## 输出物 (Artifacts)

- 必须生成单文件原型：`prototypes/[YYYY-MM-DD]-[name].html`。
- 必须使用以下模板，禁止偏离：

```html
<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>[原型名称]</title>
  <style>
    :root { --bg: #f7f7f7; --text: #222; }
    body { font-family: "Noto Sans SC", sans-serif; margin: 0; background: var(--bg); color: var(--text); }
  </style>
</head>
<body>
  <main id="app">
    <h1>[标题]</h1>
    <p>[说明文字]</p>
  </main>
  <script>
    // 交互逻辑写在这里
  </script>
</body>
</html>
```

## 验证与证据 (Verification & Evidence)

- 必须可在浏览器直接打开运行。
- 关键流程必须可点击演示。

## 红旗/反例 (Red Flags & Anti-Patterns)

- 使用英文占位或 Lorem Ipsum。
- 引入复杂构建工具。

## 例外与降级策略 (Exceptions & Degrade)

- 若需外部依赖，必须说明原因并最小化依赖。

## 工具映射 (Tool Mapping)

- `write_file` -> `Set-Content`
- `run_shell_command` -> `shell_command`

