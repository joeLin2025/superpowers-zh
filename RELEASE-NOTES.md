# Superpowers 发行说明

## v4.1.1 (2026-01-23)

### 修复

**OpenCode: 根据官方文档标准化 `plugins/` 目录 (#343)**

OpenCode 的官方文档使用 `~/.config/opencode/plugins/` (复数)。我们的文档之前使用 `plugin/` (单数)。虽然 OpenCode 接受这两种形式，但我们已统一采用官方惯例以避免混淆。

变更：
- 将仓库结构中的 `.opencode/plugin/` 重命名为 `.opencode/plugins/`
- 更新所有平台上的所有安装文档 (INSTALL.md, README.opencode.md)
- 更新测试脚本以匹配变更

**OpenCode: 修复符号链接说明 (#339, #342)**

- 在 `ln -s` 之前添加显式的 `rm` (修复重新安装时的“文件已存在”错误)
- 添加了 INSTALL.md 中缺失的 skills 符号链接步骤
- 更新了已弃用的 `use_skill`/`find_skills` 引用，改为使用原生的 `skill` 工具

---

## v4.1.0 (2026-01-23)

### 破坏性变更

**OpenCode: 切换到原生技能系统**

Superpowers for OpenCode 现在使用 OpenCode 的原生 `skill` 工具，而不是自定义的 `use_skill`/`find_skills` 工具。这是一种更简洁的集成方式，可与 OpenCode 的内置技能发现功能配合使用。

**需要迁移：** 技能必须符号链接到 `~/.config/opencode/skills/superpowers/` (参见更新后的安装文档)。

### 修复

**OpenCode: 修复会话开始时的智能体重置问题 (#226)**

以前使用 `session.prompt({ noReply: true })` 的引导注入方法会导致 OpenCode 在第一条消息时将选定的智能体重置为“build”。现在使用 `experimental.chat.system.transform` 钩子，直接修改系统提示词而无副作用。

**OpenCode: 修复 Windows 安装 (#232)**

- 移除了对 `skills-core.js` 的依赖 (消除了复制文件而非符号链接时导致的相对导入损坏问题)
- 为 cmd.exe, PowerShell 和 Git Bash 添加了全面的 Windows 安装文档
- 记录了每个平台正确的符号链接与 Junction 用法

**Claude Code: 修复 Claude Code 2.1.x 的 Windows 钩子执行问题**

Claude Code 2.1.x 更改了 Windows 上钩子的执行方式：现在它会自动检测命令中的 `.sh` 文件并添加 `bash ` 前缀。这破坏了多语言包装器模式，因为 `bash "run-hook.cmd" session-start.sh` 会尝试将 .cmd 文件作为 bash 脚本执行。

修复：hooks.json 现在直接调用 session-start.sh。Claude Code 2.1.x 会自动处理 bash 调用。还添加了 .gitattributes 以强制 shell 脚本使用 LF 行尾 (修复 Windows 检出时的 CRLF 问题)。

---

## v4.0.3 (2025-12-26)

### 改进

**加强 using-superpowers 技能以处理显式技能请求**

解决了一种失败模式：即使用户明确按名称请求了某项技能 (例如，“subagent-driven-development, please”)，Claude 有时也会跳过调用该技能。Claude 会认为“我知道那是什么意思”，然后直接开始工作，而不是加载该技能。

变更：
- 更新了“规则”，将“检查技能”改为“调用相关或请求的技能”——强调主动调用而非被动检查
- 添加了“在任何响应或行动之前”——原措辞仅提及“响应”，但 Claude 有时会在响应之前采取行动
- 增加了安慰，即调用错误的技能也没关系——减少犹豫
- 添加了新的危险信号：“我知道那是什么意思” → 知道概念 ≠ 使用技能

**添加显式技能请求测试**

在 `tests/explicit-skill-requests/` 中添加了新的测试套件，验证 Claude 在用户按名称请求技能时是否正确调用技能。包括单轮和多轮测试场景。

## v4.0.2 (2025-12-23)

### 修复

**斜杠命令现在仅限用户使用**

为所有三个斜杠命令 (`/brainstorm`, `/execute-plan`, `/write-plan`) 添加了 `disable-model-invocation: true`。Claude 无法再通过 Skill 工具调用这些命令——它们仅限于用户手动调用。

底层技能 (`superpowers:brainstorming`, `superpowers:executing-plans`, `superpowers:writing-plans`) 仍然可供 Claude 自主调用。此更改可防止混淆，即 Claude 调用一个只是重定向到技能的命令。

## v4.0.1 (2025-12-23)

### 修复

**阐明如何在 Claude Code 中访问技能**

修复了一个令人困惑的模式，即 Claude 会通过 Skill 工具调用技能，然后尝试单独读取技能文件。`using-superpowers` 技能现在明确指出 Skill 工具直接加载技能内容——无需读取文件。

- 在 `using-superpowers` 中添加了“如何访问技能”部分
- 在说明中将“读取技能”改为“调用技能”
- 更新了斜杠命令以使用完全限定的技能名称 (例如，`superpowers:brainstorming`)

**在 receiving-code-review 中添加 GitHub 线程回复指南** (致谢 @ralphbean)

添加了一条关于在原始线程中回复行内审查评论，而不是作为顶级 PR 评论的说明。

**在 writing-skills 中添加自动化优于文档的指南** (致谢 @EthanJStark)

添加了指南，指出机械约束应该自动化，而不是记录在文档中——将技能留给判断调用。

## v4.0.0 (2025-12-17)

### 新功能

**subagent-driven-development 中的两阶段代码审查**

子智能体工作流现在在每项任务后使用两个单独的审查阶段：

1. **规范合规性审查** - 怀疑的审查者验证实施是否完全符合规范。捕捉缺失的需求和过度构建。不信任实施者的报告——阅读实际代码。

2. **代码质量审查** - 仅在规范合规性通过后运行。审查代码是否整洁、测试覆盖率和可维护性。

这捕捉了常见的失败模式，即代码写得很好，但不符合要求。审查是循环的，不是一次性的：如果审查者发现问题，实施者修复，然后审查者再次检查。

其他子智能体工作流改进：
- 控制器向工作者提供完整的任务文本 (而非文件引用)
- 工作者可以在工作前和工作期间提出澄清问题
- 报告完成前的自我审查清单
- 计划在开始时读取一次，提取到 TodoWrite

`skills/subagent-driven-development/` 中的新提示词模板：
- `implementer-prompt.md` - 包含自我审查清单，鼓励提问
- `spec-reviewer-prompt.md` - 针对需求的怀疑性验证
- `code-quality-reviewer-prompt.md` - 标准代码审查

**调试技术与工具整合**

`systematic-debugging` 现在捆绑了支持技术和工具：
- `root-cause-tracing.md` - 通过调用栈向后追踪 Bug
- `defense-in-depth.md` - 在多层添加验证
- `condition-based-waiting.md` - 用条件轮询替换任意超时
- `find-polluter.sh` - 二分查找脚本，用于查找哪个测试造成了污染
- `condition-based-waiting-example.ts` - 实际调试会话中的完整实现

**测试反模式参考**

`test-driven-development` 现在包含 `testing-anti-patterns.md`，涵盖：
- 测试模拟行为而非真实行为
- 向生产类添加仅用于测试的方法
- 在不了解依赖关系的情况下进行模拟
- 隐藏结构假设的不完整模拟

**技能测试基础设施**

用于验证技能行为的三个新测试框架：

`tests/skill-triggering/` - 验证技能是否从简单的提示词触发，无需显式命名。测试 6 项技能以确保仅描述就足够。

`tests/claude-code/` - 使用 `claude -p` 进行无头测试的集成测试。通过会话脚本 (JSONL) 分析验证技能使用情况。包括用于成本跟踪的 `analyze-token-usage.py`。

`tests/subagent-driven-dev/` - 具有两个完整测试项目的端到端工作流验证：
- `go-fractals/` - 带有 Sierpinski/Mandelbrot 的 CLI 工具 (10 个任务)
- `svelte-todo/` - 带有 localStorage 和 Playwright 的 CRUD 应用 (12 个任务)

### 主要变更

**DOT 流程图作为可执行规范**

使用 DOT/GraphViz 流程图重写了关键技能，作为权威的流程定义。散文成为支持内容。

**描述陷阱** (记录在 `writing-skills` 中)：发现当技能描述包含工作流摘要时，描述会覆盖流程图内容。Claude 遵循简短描述而不是阅读详细的流程图。修复：描述必须仅用于触发 (“当 X 时使用”)，不包含流程细节。

**using-superpowers 中的技能优先级**

当多个技能适用时，流程技能 (头脑风暴、调试) 现在明确先于实施技能。“构建 X”首先触发头脑风暴，然后是领域技能。

**brainstorming 触发加强**

描述更改为祈使句：“你必须在任何创造性工作之前使用此技能——创建功能、构建组件、增加功能或修改行为。”

### 破坏性变更

**技能合并** - 合并了六项独立技能：
- `root-cause-tracing`, `defense-in-depth`, `condition-based-waiting` → 捆绑在 `systematic-debugging/` 中
- `testing-skills-with-subagents` → 捆绑在 `writing-skills/` 中
- `testing-anti-patterns` → 捆绑在 `test-driven-development/` 中
- `sharing-skills` 移除 (已过时)

### 其他改进

- **render-graphs.js** - 从技能中提取 DOT 图表并渲染为 SVG 的工具
- **using-superpowers 中的合理化表** - 易于扫描的格式，包括新条目：“我需要更多上下文”，“让我先探索一下”，“这感觉很有效率”
- **docs/testing.md** - 使用 Claude Code 集成测试进行技能测试的指南

---

## v3.6.2 (2025-12-03)

### 修复

- **Linux 兼容性**: 修复了多语言钩子包装器 (`run-hook.cmd`) 以使用符合 POSIX 的语法
  - 将第 16 行特定于 bash 的 `${BASH_SOURCE[0]:-$0}` 替换为标准的 `$0`
  - 解决了 Ubuntu/Debian 系统上 `/bin/sh` 为 dash 时的 "Bad substitution" 错误
  - 修复 #141

---

## v3.5.1 (2025-11-24)

### 变更

- **OpenCode 引导重构**: 从 `chat.message` 钩子切换到 `session.created` 事件进行引导注入
  - 引导程序现在通过 `session.prompt()` 在会话创建时注入，并设置 `noReply: true`
  - 明确告诉模型 using-superpowers 已经加载，以防止重复加载技能
  - 将引导内容生成整合到共享的 `getBootstrapContent()` 辅助函数中
  - 更清洁的单一实现方法 (移除了回退模式)

---

## v3.5.0 (2025-11-23)

### 新增

- **OpenCode 支持**: OpenCode.ai 的原生 JavaScript 插件
  - 自定义工具：`use_skill` 和 `find_skills`
  - 消息插入模式，用于跨上下文压缩的技能持久性
  - 通过 chat.message 钩子自动注入上下文
  - 在 session.compacted 事件上自动重新注入
  - 三层技能优先级：项目 > 个人 > superpowers
  - 项目本地技能支持 (`.opencode/skills/`)
  - 共享核心模块 (`lib/skills-core.js`) 用于与 Codex 代码重用
  - 具有适当隔离的自动化测试套件 (`tests/opencode/`)
  - 特定平台的文档 (`docs/README.opencode.md`, `docs/README.codex.md`)

### 变更

- **重构 Codex 实现**: 现在使用共享的 `lib/skills-core.js` ES 模块
  - 消除 Codex 和 OpenCode 之间的代码重复
  - 技能发现和解析的单一事实来源
  - Codex 通过 Node.js 互操作成功加载 ES 模块

- **改进文档**: 重写 README 以清楚解释问题/解决方案
  - 移除了重复部分和冲突信息
  - 添加了完整的工作流描述 (头脑风暴 → 计划 → 执行 → 完成)
  - 简化了平台安装说明
  - 强调技能检查协议优于自动激活声明

---

## v3.4.1 (2025-10-31)

### 改进

- 优化了 superpowers 引导程序以消除冗余的技能执行。`using-superpowers` 技能内容现在直接在会话上下文中提供，并有明确指南仅对其他技能使用 Skill 工具。这减少了开销并防止了令人困惑的循环，即智能体尽管从会话开始就已经有了内容，仍会手动执行 `using-superpowers`。

## v3.4.0 (2025-10-30)

### 改进

- 简化了 `brainstorming` 技能以回归最初的对话愿景。移除了带有正式清单的繁重 6 阶段流程，转而采用自然对话：一次问一个问题，然后以 200-300 字的章节展示设计以供验证。保留文档和实施移交功能。

## v3.3.1 (2025-10-28)

### 改进

- 更新了 `brainstorming` 技能，要求在提问前进行自主侦察，鼓励以建议为导向的决策，并防止智能体将优先级委托回人类。
- 根据 Strunk 的“风格要素 (Elements of Style)”原则，对 `brainstorming` 技能进行了写作清晰度改进 (省略不必要的词语，将否定形式转换为肯定形式，改进平行结构)。

### Bug 修复

- 阐明了 `writing-skills` 指南，使其指向正确的特定于智能体的个人技能目录 (Claude Code 为 `~/.claude/skills`，Codex 为 `~/.codex/skills`)。

## v3.3.0 (2025-10-28)

### 新功能

**实验性 Codex 支持**
- 添加了统一的 `superpowers-codex` 脚本，带有 bootstrap/use-skill/find-skills 命令
- 跨平台 Node.js 实现 (在 Windows, macOS, Linux 上运行)
- 命名空间技能：superpowers 技能为 `superpowers:skill-name`，个人技能为 `skill-name`
- 当名称匹配时，个人技能覆盖 superpowers 技能
- 干净的技能显示：显示名称/描述，不显示原始 frontmatter
- 有用的上下文：显示每个技能的支持文件目录
- Codex 的工具映射：TodoWrite→update_plan，subagents→manual fallback 等
- 与最小 AGENTS.md 的引导集成，用于自动启动
- Codex 特有的完整安装指南和引导说明

**与 Claude Code 集成的主要区别：**
- 单一统一脚本代替单独工具
- Codex 特定等效项的工具替换系统
- 简化的子智能体处理 (手动工作代替委托)
- 更新术语：“Superpowers 技能”代替“核心技能”

### 添加的文件
- `.codex/INSTALL.md` - Codex 用户安装指南
- `.codex/superpowers-bootstrap.md` - 带有 Codex 适配的引导说明
- `.codex/superpowers-codex` - 具有所有功能的统一 Node.js 可执行文件

**注意：** Codex 支持是实验性的。集成提供核心 superpowers 功能，但可能需要根据用户反馈进行微调。

## v3.2.3 (2025-10-23)

### 改进

**更新 using-superpowers 技能以使用 Skill 工具而非 Read 工具**
- 将技能调用说明从 Read 工具更改为 Skill 工具
- 更新描述：“使用 Read 工具” → “使用 Skill 工具”
- 更新步骤 3：“使用 Read 工具” → “使用 Skill 工具读取并运行”
- 更新合理化列表：“读取当前版本” → “运行当前版本”

Skill 工具是在 Claude Code 中调用技能的正确机制。此更新更正了引导说明，以指导智能体使用正确的工具。

### 更改的文件
- 更新：`skills/using-superpowers/SKILL.md` - 将工具引用从 Read 更改为 Skill

## v3.2.2 (2025-10-21)

### 改进

**加强 using-superpowers 技能以对抗智能体合理化**
- 添加了 EXTREMELY-IMPORTANT 块，使用绝对语言关于强制性技能检查
  - “即使只有 1% 的机会适用技能，你也必须阅读它”
  - “你没有选择。你不能通过合理化来逃避。”
- 添加了 MANDATORY FIRST RESPONSE PROTOCOL (强制性首次响应协议) 清单
  - 智能体在任何响应之前必须完成的 5 步流程
  - 明确的“无此响应 = 失败”后果
- 添加了 Common Rationalizations (常见合理化) 部分，包含 8 种具体的逃避模式
  - “这只是一个简单的问题” → 错误
  - “我可以快速检查文件” → 错误
  - “让我先收集信息” → 错误
  - 加上观察到的智能体行为中的另外 5 种常见模式

这些更改解决了观察到的智能体行为，即尽管有明确指示，他们仍会合理化跳过技能使用。强有力的语言和先发制人的反驳旨在使不合规变得更加困难。

### 更改的文件
- 更新：`skills/using-superpowers/SKILL.md` - 添加了三层强制执行以防止跳过技能的合理化

## v3.2.1 (2025-10-20)

### 新功能

**插件现在包含代码审查智能体**
- 在插件的 `agents/` 目录中添加了 `superpowers:code-reviewer` 智能体
- 智能体根据计划和编码标准提供系统的代码审查
- 以前需要用户拥有个人智能体配置
- 所有技能引用已更新为使用命名空间的 `superpowers:code-reviewer`
- 修复 #55

### 更改的文件
- 新增：`agents/code-reviewer.md` - 带有审查清单和输出格式的智能体定义
- 更新：`skills/requesting-code-review/SKILL.md` - 引用 `superpowers:code-reviewer`
- 更新：`skills/subagent-driven-development/SKILL.md` - 引用 `superpowers:code-reviewer`

## v3.2.0 (2025-10-18)

### 新功能

**头脑风暴工作流中的设计文档**
- 在头脑风暴技能中添加了第 4 阶段：设计文档
- 设计文档现在在实施前写入 `docs/plans/YYYY-MM-DD-<topic>-design.md`
- 恢复了在技能转换期间丢失的原始头脑风暴命令的功能
- 在工作树设置和实施计划之前编写文档
- 使用子智能体进行测试以验证时间压力下的合规性

### 破坏性变更

**技能引用命名空间标准化**
- 所有内部技能引用现在使用 `superpowers:` 命名空间前缀
- 更新格式：`superpowers:test-driven-development` (以前只是 `test-driven-development`)
- 影响所有 REQUIRED SUB-SKILL, RECOMMENDED SUB-SKILL 和 REQUIRED BACKGROUND 引用
- 与使用 Skill 工具调用技能的方式保持一致
- 更新的文件：brainstorming, executing-plans, subagent-driven-development, systematic-debugging, testing-skills-with-subagents, writing-plans, writing-skills

### 改进

**设计与实施计划命名**
- 设计文档使用 `-design.md` 后缀以防止文件名冲突
- 实施计划继续使用现有的 `YYYY-MM-DD-<feature-name>.md` 格式
- 两者都存储在 `docs/plans/` 目录中，名称区分明确

## v3.1.1 (2025-10-17)

### Bug 修复

- **修复 README 中的命令语法** (#44) - 更新所有命令引用以使用正确的命名空间语法 (即 `/superpowers:brainstorm` 而不是 `/brainstorm`)。插件提供的命令由 Claude Code 自动命名空间化，以避免插件之间的冲突。

## v3.1.0 (2025-10-17)

### 破坏性变更

**技能名称标准化为小写**
- 所有技能 frontmatter `name:` 字段现在使用与目录名称匹配的小写 kebab-case
- 示例：`brainstorming`, `test-driven-development`, `using-git-worktrees`
- 所有技能公告和交叉引用已更新为小写格式
- 这确保了目录名称、frontmatter 和文档之间的一致命名

### 新功能

**增强的头脑风暴技能**
- 添加了显示阶段、活动和工具使用的快速参考表
- 添加了用于跟踪进度的可复制工作流清单
- 为何时重新访问早期阶段添加了决策流程图
- 添加了全面的 AskUserQuestion 工具指南和具体示例
- 添加了“提问模式”部分，解释何时使用结构化与开放式问题
- 将关键原则重组为可扫描的表格

**Anthropic 最佳实践集成**
- 添加了 `skills/writing-skills/anthropic-best-practices.md` - 官方 Anthropic 技能编写指南
- 在 writing-skills SKILL.md 中引用以获得全面指导
- 提供渐进式披露、工作流和评估的模式

### 改进

**技能交叉引用清晰度**
- 所有技能引用现在使用明确的需求标记：
  - `**REQUIRED BACKGROUND:**` - 必须了解的先决条件
  - `**REQUIRED SUB-SKILL:**` - 工作流中必须使用的技能
  - `**Complementary skills:**` - 可选但有帮助的相关技能
- 移除了旧路径格式 (`skills/collaboration/X` → 只是 `X`)
- 更新了集成部分，带有分类的关系 (必需与互补)
- 使用最佳实践更新了交叉引用文档

**与 Anthropic 最佳实践对齐**
- 修复了描述语法和语态 (完全第三人称)
- 添加了用于扫描的快速参考表
- 添加了 Claude 可以复制和跟踪的工作流清单
- 对非显而易见的决策点适当使用流程图
- 改进了可扫描的表格格式
- 所有技能都在 500 行建议以内

### Bug 修复

- **重新添加缺失的命令重定向** - 恢复了在 v3.0 迁移中意外删除的 `commands/brainstorm.md` 和 `commands/write-plan.md`
- 修复了 `defense-in-depth` 名称不匹配 (原为 `Defense-in-Depth-Validation`)
- 修复了 `receiving-code-review` 名称不匹配 (原为 `Code-Review-Reception`)
- 修复了 `commands/brainstorm.md` 对正确技能名称的引用
- 移除了对不存在的相关技能的引用

### 文档

**writing-skills 改进**
- 使用明确的需求标记更新了交叉引用指南
- 添加了对 Anthropic 官方最佳实践的引用
- 改进了显示正确技能引用格式的示例

## v3.0.1 (2025-10-16)

### 变更

我们现在使用 Anthropic 的第一方技能系统！

## v2.0.2 (2025-10-12)

### Bug 修复

- **修复本地技能仓库领先于上游时的错误警告** - 当本地仓库有领先于上游的提交时，初始化脚本会错误地警告“上游有新技能可用”。现在的逻辑正确区分了三种 git 状态：本地落后 (应更新)、本地领先 (无警告) 和分叉 (应警告)。

## v2.0.1 (2025-10-12)

### Bug 修复

- **修复插件上下文中的 session-start 钩子执行** (#8, PR #9) - 钩子因 "Plugin hook error" 默默失败，阻止技能上下文加载。修复方法：
  - 当 BASH_SOURCE 在 Claude Code 的执行上下文中未绑定时，使用 `${BASH_SOURCE[0]:-$0}` 回退
  - 添加 `|| true` 以优雅地处理过滤状态标志时的空 grep 结果

---

# Superpowers v2.0.0 发行说明

## 概述

Superpowers v2.0 通过重大的架构转变，使技能更易于访问、维护和社区驱动。

标题变更由于 **技能库分离**：所有技能、脚本和文档已从插件移动到专用存储库 ([obra/superpowers-skills](https://github.com/obra/superpowers-skills))。这使得 superpowers 从单体插件转变为管理技能库本地克隆的轻量级垫片。技能在会话开始时自动更新。用户通过标准 git 工作流分叉并贡献改进。技能库的版本独立于插件。

除基础设施外，此版本还添加了九项专注于解决问题、研究和架构的新技能。我们以祈使语气和更清晰的结构重写了核心 **using-skills** 文档，使 Claude 更容易理解何时以及如何使用技能。**find-skills** 现在输出可以直接粘贴到 Read 工具中的路径，消除了技能发现工作流中的摩擦。

用户体验无缝操作：插件自动处理克隆、分叉和更新。贡献者会发现新架构使改进和共享技能变得微不足道。此版本为技能作为社区资源快速发展奠定了基础。

## 破坏性变更

### 技能库分离

**最大的变化：** 技能不再位于插件中。它们已移动到位于 [obra/superpowers-skills](https://github.com/obra/superpowers-skills) 的单独存储库。

**这对你意味着什么：**

- **首次安装：** 插件自动将技能克隆到 `~/.config/superpowers/skills/`
- **分叉：** 在设置过程中，如果您安装了 `gh`，系统将提供分叉技能库的选项
- **更新：** 技能在会话开始时自动更新 (尽可能快进)
- **贡献：** 在分支上工作，本地提交，向上一级提交 PR
- **不再有遮蔽：** 旧的两层系统 (个人/核心) 被单库分支工作流取代

**迁移：**

如果您有现有安装：
1. 您的旧 `~/.config/superpowers/.git` 将备份到 `~/.config/superpowers/.git.bak`
2. 旧技能将备份到 `~/.config/superpowers/skills.bak`
3. 将在 `~/.config/superpowers/skills/` 创建 obra/superpowers-skills 的全新克隆

### 移除的功能

- **个人 superpowers 覆盖系统** - 被 git 分支工作流取代
- **setup-personal-superpowers 钩子** - 被 initialize-skills.sh 取代

## 新功能

### 技能库基础设施

**自动克隆与设置** (`lib/initialize-skills.sh`)
- 在首次运行时克隆 obra/superpowers-skills
- 如果安装了 GitHub CLI，提供分叉创建
- 正确设置 upstream/origin 远程
- 处理旧安装的迁移

**自动更新**
- 每次会话开始时从跟踪远程获取
- 尽可能自动合并快进
- 需要手动同步时通知 (分支分叉)
- 使用 pulling-updates-from-skills-repository 技能进行手动同步

### 新技能

**解决问题技能** (`skills/problem-solving/`)
- **collision-zone-thinking** - 强制无关概念在一起以产生涌现的见解
- **inversion-exercise** - 翻转假设以揭示隐藏的约束
- **meta-pattern-recognition** - 发现跨领域的普遍原则
- **scale-game** - 在极端情况下进行测试以暴露基本真理
- **simplification-cascades** - 发现消除多个组件的见解
- **when-stuck** - 调度到正确的解决问题技术

**研究技能** (`skills/research/`)
- **tracing-knowledge-lineages** - 了解想法如何随时间演变

**架构技能** (`skills/architecture/`)
- **preserving-productive-tensions** - 保留多种有效方法，而不是强迫过早解决

### 技能改进

**using-skills (原 getting-started)**
- 从 getting-started 重命名为 using-skills
- 用祈使语气完全重写 (v4.0.0)
- 预先加载关键规则
- 为所有工作流添加了“为什么”解释
- 在引用中始终包含 /SKILL.md 后缀
- 更清晰地区分刚性规则和灵活模式

**writing-skills**
- 交叉引用指南从 using-skills 移入
- 添加了 token 效率部分 (字数目标)
- 改进了 CSO (Claude 搜索优化) 指南

**sharing-skills**
- 更新为新的分支和 PR 工作流 (v2.0.0)
- 移除了个人/核心拆分引用

**pulling-updates-from-skills-repository** (新)
- 与上游同步的完整工作流
- 替换旧的 "updating-skills" 技能

### 工具改进

**find-skills**
- 现在输出带有 /SKILL.md 后缀的完整路径
- 使路径可直接用于 Read 工具
- 更新了帮助文本

**skill-run**
- 从 scripts/ 移动到 skills/using-skills/
- 改进文档

### 插件基础设施

**会话开始钩子**
- 现在从技能库位置加载
- 在会话开始时显示完整的技能列表
- 打印技能位置信息
- 显示更新状态 (更新成功 / 落后于上游)
- 将“技能落后”警告移动到输出末尾

**环境变量**
- `SUPERPOWERS_SKILLS_ROOT` 设置为 `~/.config/superpowers/skills`
- 在所有路径中一致使用

## Bug 修复

- 修复了分叉时重复添加上游远程的问题
- 修复了 find-skills 输出中双重 "skills/" 前缀
- 从 session-start 中移除了过时的 setup-personal-superpowers 调用
- 修复了整个钩子和命令中的路径引用

## 文档

### README
- 更新为新的技能库架构
- 突出显示 superpowers-skills 库的链接
- 更新了自动更新描述
- 修复了技能名称和引用
- 更新了 Meta 技能列表

### 测试文档
- 添加了全面的测试清单 (`docs/TESTING-CHECKLIST.md`)
- 创建了用于测试的本地市场配置
- 记录了手动测试场景

## 技术细节

### 文件变更

**新增：**
- `lib/initialize-skills.sh` - 技能库初始化和自动更新
- `docs/TESTING-CHECKLIST.md` - 手动测试场景
- `.claude-plugin/marketplace.json` - 本地测试配置

**移除：**
- `skills/` 目录 (82 个文件) - 现在在 obra/superpowers-skills 中
- `scripts/` 目录 - 现在在 obra/superpowers-skills/skills/using-skills/ 中
- `hooks/setup-personal-superpowers.sh` - 已过时

**修改：**
- `hooks/session-start.sh` - 使用来自 ~/.config/superpowers/skills 的技能
- `commands/brainstorm.md` - 更新了指向 SUPERPOWERS_SKILLS_ROOT 的路径
- `commands/write-plan.md` - 更新了指向 SUPERPOWERS_SKILLS_ROOT 的路径
- `commands/execute-plan.md` - 更新了指向 SUPERPOWERS_SKILLS_ROOT 的路径
- `README.md` - 为新架构完全重写

### 提交历史

此版本包括：
- 20+ 次提交用于技能库分离
- PR #1: 受 Amplifier 启发的解决问题和研究技能
- PR #2: 个人 superpowers 覆盖系统 (后来被替换)
- 多项技能细化和文档改进

## 升级说明

### 全新安装

```bash
# In Claude Code
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

插件自动处理一切。

### 从 v1.x 升级

1. **备份您的个人技能** (如果有)：
   ```bash
   cp -r ~/.config/superpowers/skills ~/superpowers-skills-backup
   ```

2. **更新插件：**
   ```bash
   /plugin update superpowers
   ```

3. **在下次会话开始时：**
   - 旧安装将自动备份
   - 将克隆新的技能库
   - 如果您有 GitHub CLI，系统将提供分叉选项

4. **迁移个人技能** (如果您有)：
   - 在本地技能库中创建一个分支
   - 从备份中复制您的个人技能
   - 提交并推送到您的分叉
   - 考虑通过 PR 贡献回去

## 接下来

### 对于用户

- 探索新的解决问题技能
- 尝试用于技能改进的分支工作流
- 将技能贡献回社区

### 对于贡献者

- 技能库现在位于 https://github.com/obra/superpowers-skills
- 分叉 → 分支 → PR 工作流
- 参见 skills/meta/writing-skills/SKILL.md 了解文档的 TDD 方法

## 已知问题

目前没有。

## 致谢

- 受 Amplifier 模式启发的解决问题技能
- 社区贡献和反馈
- 对技能有效性的广泛测试和迭代

---

**完整更新日志：** https://github.com/obra/superpowers/compare/dd013f6...main
**技能库：** https://github.com/obra/superpowers-skills
**Issues：** https://github.com/obra/superpowers/issues