---
name: translate-project-files-zh
description: "当用户要求'翻译项目文件'、'批量英译中'、'i18n 本地化'时使用。支持全量/增量模式、术语一致性检查、代码结构保留及自动分批处理。"
---

# 翻译专家：企业级项目本地化 (Project Localization Specialist)

## 目的
执行**高保真、工程级**的批量翻译任务。不仅是文本转换，更是**代码结构维护**。核心能力包括：增量更新（Diff）、术语表一致性（Glossary Enforcement）、格式鲁棒性验证（AST Check）和分批次安全写入。

## 何时使用
- **批量翻译**：用户提供目录，要求翻译其中所有或特定类型的文件。
- **增量更新**：用户表示“只翻译新加的词”、“不要覆盖我修改过的翻译”。
- **高精度要求**：用户强调“术语要统一”、“不要破坏 JSON 结构”、“保留变量名”。
- **多格式处理**：涉及 JSON, YAML, Markdown, TS/JS 对象字面量等混合内容。

## 输入 / 输出
- **输入**：
  - 源路径 (Source Path).
  - 目标路径 (Target Path，如果未指定则需交互确认).
  - *[可选]* 现有术语表或“保持一致”的参考文件.
- **输出**：
  - 严格校验过的目标文件（100% 语法正确）。
  - 变更日志（新增了多少 Key，覆盖了多少）。
  - 待确认清单（不确定的术语）。

## 操作流程 (The Process)

### Phase 1: 侦察与策略 (Recon & Strategy)
1.  **扫描 (Scan)**：使用 `list_directory` 或 `glob` 获取源文件列表。忽略 `.git`, `node_modules` 等非源码目录。
2.  **策略选择 (Select Strategy)**：
    - **检测目标**：检查目标路径下是否存在对应文件。
    - **询问模式**：
      - 若目标文件存在，询问用户：“检测到目标文件已存在。使用**增量模式**（只补全缺失 Key）还是**覆盖模式**（全量重写）？”
      - 若未指定目标路径，**必须**建议一个非覆盖的路径（如 `_zh` 后缀或 `locales/zh/` 目录）。
3.  **术语准备 (Glossary Prep)**：
    - 询问用户是否有核心术语表。
    - 若文件量大 (>10)，主动提出：“是否需要我先扫描一遍源文件，提取高频词生成一份术语表供您确认？”

### Phase 2: 执行循环 (Execution Loop)
**按文件进行处理，每处理完一个文件立即写入，防止上下文丢失。**

对于每个文件：

1.  **读取 (Read)**：
    - 读取 **源文件** (Source).
    - (增量模式) 读取 **现有目标文件** (Target Reference).
2.  **解析与 Diff (Parse & Diff)**：
    - **JSON/YAML**：解析为对象。对比 Source 和 Target 的 Keys。
      - *增量模式*：仅提取 Target 中不存在的 Keys 进行翻译。
      - *覆盖模式*：提取 Source 所有 Values，但保留 Target 中已有的非空 Values（作为参考或直接复用，取决于用户偏好）。
    - **Markdown**：分离 Frontmatter 和 Body。仅翻译 Body 文本和 Frontmatter 中的特定字段 (title, description)。
    - **Code (TS/JS)**：提取字符串字面量或特定的 i18n 函数调用参数。
3.  **翻译 (Translate)**：
    - **Context Injection**：Prompt 中必须包含核心术语表。
    - **Format Protection**：
      - 严禁翻译变量：`{name}`, `{{count}}`, `%s`, `${var}`。
      - 严禁破坏 HTML/XML 标签。
      - 保持缩进和嵌套结构。
4.  **校验 (Validation)**：
    - **语法检查**：尝试解析翻译后的内容（JSON.parse / yaml.load）。如果失败，**必须**自动修复或报错，绝不能写入坏文件。
    - **占位符检查**：对比原文和译文的变量数量/名称是否一致。
5.  **写入 (Commit)**：
    - 使用 `write_file` 写入目标路径。

### Phase 3: 交付与报告 (Delivery)
- 输出汇总报告：
  - ✅ **已更新**：[文件名] (新增 X 条, 更新 Y 条)
  - ⏭️ **已跳过**：[文件名] (无变化)
  - ⚠️ **待确认**：
    - `menu.json`: "Claim" -> 翻译为 "认领" (Context: Task) vs "索赔"?

## 护栏与红旗 (Guardrails & Red Flags)

- **[CRITICAL] JSON 语法死线**：绝不允许写入无法 JSON.parse 的文件。如果 AI 无法保证，必须先写到一个临时文件验证。
- **[CRITICAL] 增量保护**：在增量模式下，**严禁**删除或修改目标文件中已存在的 Key（除非用户明确要求“修正错误翻译”）。
- **禁止过度翻译**：不要翻译 Key（除非是 map 的 key 且确定需要显示）。不要翻译代码关键字 (function, const, true/false)。
- **路径安全**：如果用户模糊地说“翻译一下”，默认不能覆盖源文件。必须创建 `_zh` 副本或询问。

## 示例 (Examples)

### 示例 1：增量更新 (Incremental Update)
**用户**：“`en.json` 加了几个新词，帮我更新一下 `zh.json`，别动我原来的翻译。”
**Agent**：
1. **读取** `en.json` (Source) 和 `zh.json` (Target).
2. **Diff**：发现 `en.json` 有 "new_feature", "settings"，而 `zh.json` 缺失。
3. **翻译**：仅翻译 "new_feature" 和 "settings"。
4. **合并**：将新翻译合并入 `zh.json` 原对象。
5. **写入**：更新 `zh.json`。
6. **报告**：✅ `zh.json`: 新增 2 条翻译。

### 示例 2：术语一致性 (Consistency)
**用户**：“把 docs 目录翻译了，注意 'Agent' 统一翻译成 '智能体'。”
**Agent**：
1. **策略**：全量翻译 `docs/*.md`。
2. **术语注入**：在系统提示词中强制 `{ "Agent": "智能体" }`。
3. **执行**：翻译过程中遇到 "The Agent will..." -> "智能体将..."。
4. **校验**：检查是否有 "代理" 或 "经纪人" 混入，如有则修正。
5. **交付**：完成翻译。

## 常用参考 (References)
- 术语表模板: `skills/translate-project-files-zh/references/glossary_template.md`
