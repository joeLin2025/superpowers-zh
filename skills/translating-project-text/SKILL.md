---
name: translating-project-text
description: Use when users request translate project files or documentation from English to Chinese while preserving keys/identifiers, expect a skill package output (folder name + SKILL.md + optional directories), mention progressive disclosure templates, examples, guardrails, or skill specs.
---
# 项目文案中英翻译保留关键标识技能

## 目的（Purpose）
- 提供可复制的流程，将项目文件中的英文描述翻译为中文且保持关键元素不变
- 约束翻译范围、输入输出以及默认策略，减少误译或对代码结构的破坏
- 交付符合 progressive disclosure 的技能包，确保可触发、可执行、可测试

## 何时使用（When to use）
- 触发条件：用户提到“翻译项目文件”“英文描述转中文”“保持 key/identifier/占位符不变”“生成 SKILL.md/技能规范/技能包/模板/示例/guardrails”等
- 触发条件：用户希望获得技能文件夹名 + 完整 SKILL.md（含 progressive disclosure、示例、测试清单、guardrails），可选目录结构
- 非目标：不会直接翻译具体文件、不会运行翻译脚本或联网调用翻译 API、不会修改项目代码

## 输入（Inputs）
- 必填：需翻译的内容类型（如 i18n 资源、配置文件注释、README 片段）及需保留的关键元素类别（key、占位符、HTML 标签等）
- 可选：术语表/词汇偏好、示例片段、允许/禁止翻译的字段名、输出格式（如表格/补丁）
- 默认假设：若无特殊说明，则仅翻译说明性文本；key、JSON 字段、代码片段、变量名、占位符 `{}`、`%s`、HTML 标签、Markdown 链接文本中的 URL 全部保留

## 输出（Outputs）
- 必须输出：
  - 技能文件夹名（kebab-case，与 frontmatter name 一致）
  - 完整 SKILL.md（包含 YAML frontmatter、Purpose/When/Inputs/Outputs/Procedure/Guardrails/Examples/Testing/Quality/Trigger sections）
- 可选输出：/references（术语表或词典）、/scripts（批量查找未翻译文本的脚本）、/assets（截图示例）；仅在正文明确用途时才建议
- 副作用：允许在本地创建/覆盖技能目录及文件；禁止外部翻译 API 调用、联网或改动非技能目录

## 操作步骤（Procedure）
1. **需求分解**：识别文件类型、翻译范围、必须保留的关键元素；若信息不足，列出明确假设（例如“假设所有键名保持英文”）。
2. **策略规划**：
   - 制定段落分类（可翻译 vs 保留 vs 局部翻译）
   - 确定术语优先级（已有术语表 > 行业标准 > 一般翻译）
   - 决定输出结构（直接修改文件、生成对照表、创建补丁）。
3. **执行翻译**：
   - 先锁定不可翻译片段（key、占位符、变量、HTML/Markdown 标签、代码块）并做标记
   - 翻译剩余说明文本，保持语义准确、术语一致、标点符合中文习惯
   - 若存在嵌套（如 `description: "Enter your name"`），仅翻译引号内的自然语言
4. **一致性校验**：
   - 检查 key/占位符/数字/单位是否被保留
   - 对照术语表或参考资料，确认译文一致
   - 确认文件格式未破坏（JSON/ YAML/ Markdown 仍可解析）
5. **交付与记录**：
   - 输出翻译结果（文本或补丁）并附说明关键假设
   - 标注待用户确认的术语或含糊片段
   - 可建议后续 QA（如请双语审阅、运行 linter 检查格式）

## 安全与边界（Guardrails & Safety）
- 处理敏感文本时，仅在当前会话使用，不另存或转发
- 遇到代码/配置字段不确定是否需翻译时，默认保留并提示用户
- 明确拒绝执行自动化命令、调用第三方翻译服务或访问网络
- 当输入缺少上下文导致意义不明时，以注释方式请求澄清或提供多种译法供用户选择

## 示例（Examples）
- **最小示例**
  - 输入：`"title": "User Settings"`（需保留 key）
  - 输出：`"title": "用户设置"`，并记录“key 保持英文，仅翻译 value”
- **真实示例**
  - 输入：README 片段含 Markdown 链接与代码：`Run \`npm start\` to launch the dashboard.`
  - 操作：保留行内代码 `npm start`，翻译其余文本 → `运行 \`npm start\` 来启动仪表盘。`
  - 结果：附带说明使用 `/references/terminology.md` 维护常用技术词汇
- **失败/边界示例**
  - 请求："直接调用某翻译 API 批量翻译整个仓库"
  - 处理：拒绝并说明该技能只提供人工可控翻译流程，不运行外部服务

## 测试清单（Testing checklist）
- description 是否覆盖关键词：translate、project files、English to Chinese、preserve keys/identifiers、skill package、SKILL.md、progressive disclosure、template、examples、guardrails
- 流程测试：按 Procedure 操作是否能在没有额外解释的情况下完成一次示例翻译
- 格式测试：生成的输出是否保持原有文件格式、未破坏 key / 占位符
- 边界测试：缺少术语表、含嵌套格式、含 HTML/Markdown/代码块时是否有默认策略
- 安全测试：面对请求外部 API 或批量命令时是否明确拒绝

## 专业质量标准（Quality bar）
- 语言准确：译文需贴合领域语境，避免逐字直译
- 结构严谨：所有章节齐全、指令可复现、术语表或目录引用路径可用
- 可维护性：关键词、假设、示例可扩展至不同项目类型（前端、后端、运维文档）
- 测试友好：提供可验证的输入输出样例及 checklist，便于他人审查

## 触发优化指南（Trigger Optimization）
- 在 description 与正文多次出现 translate/translation、English to Chinese、project files、keep keys/identifiers、SKILL.md、skill package、progressive disclosure、template、examples、guardrails 等词
- 鼓励用户提供术语表或指定 `/references/terminology.md` 存放，以便后续渐进加载
- 建议 `/scripts/find-untranslated.js`（若需要自动检测未翻译字段）和 `/references/terminology.md`（术语表）作为可选目录，并在正文明确用途
- 定期回顾用户常见表述（如“i18n 翻译”“本地化”）并更新 description 关键词，保持可触发性

