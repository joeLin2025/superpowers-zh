# 全量升级 skills 目录技能规范 - 实施计划

**依据文档**: `docs/specs/2026-02-07-upgrade-skills-suite.md`
**目标**: 按 Spec 对 `skills/` 下 16 个技能进行“多轮脑暴 + 实时检索 + 模板硬约束”的升级，形成一致、可审计的技能体系。

## 决策记录 (Decisions)
- **工作区模式**: Current Directory
- **交付模式**: Manual

## 任务清单 (Tasks)

- [x] **Task 01: 基线盘点与升级清单**
    - [ ] 动作: 盘点全部 `skills/**/SKILL.md`，列出是否“输出文件型技能”，并定义升级清单顺序。
    - [ ] 验证: 运行 `Get-ChildItem -Path skills -Recurse -Filter SKILL.md`，记录结果到本计划“执行记录”。
    - [ ] 提交: `chore: baseline skills upgrade inventory`
    - 验证记录:
      ```text
      C:\Users\ayyk\projects\superpowers-zh\skills\brainstorming\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\dispatching-parallel-agents\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\executing-plans\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\finishing-a-development-branch\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\receiving-code-review\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\requesting-code-review\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\skill-localization-and-polishing\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\subagent-driven-development\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\systematic-debugging\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\test-driven-development\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\using-git-worktrees\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\using-superpowers\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\ux-prototyping\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\verification-before-completion\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\writing-plans\SKILL.md
      C:\Users\ayyk\projects\superpowers-zh\skills\writing-skills\SKILL.md
      ```

- [x] **Task 02: 统一 Skill Schema vNext 模板与 Rubric（文档内嵌）**
    - [ ] 动作: 为所有技能确定统一章节与最小 Frontmatter 字段，并定义“输出文件型技能模板”标准（路径+Schema/样例+禁止偏离声明）。
    - [ ] 验证: 在执行记录中列出最终章节清单与模板硬约束条款。
    - [ ] 提交: `docs: define skill schema vNext`
    - 执行记录:
      - Frontmatter 最小字段: `name`, `description`
      - 统一章节清单:
        1) 概述
        2) 何时使用（包含触发条件/路由关键字）
        3) 强制流程 (Workflow)
        4) 输出物 (Artifacts)
        5) 验证与证据 (Verification & Evidence)
        6) 红旗/反例 (Red Flags & Anti-Patterns)
        7) 例外与降级策略 (Exceptions & Degrade)
        8) 工具映射 (Tool Mapping)
      - 输出文件型技能模板硬约束（必须逐条写入技能文档）:
        - 明确输出路径或路径模式（含变量含义）。
        - 提供可复制的模板（Schema/样例），禁止偏离。
        - 说明必填字段与验证方法（最少 1 条验证规则）。
      - 检索记录约束:
        - 外部检索来源仅记录在计划执行记录中，不写入技能文档。
      - Rubric 评分维度:
        - 可执行性: 规则是否可直接操作。
        - 可验证性: 是否有可重复的证据生成方式。
        - 覆盖完整性: 关键流程是否无缺口。
        - 歧义消除: 是否避免模糊描述。
        - 跨技能一致性: 与路由真源是否一致。
        - 对抗性规则: 是否覆盖失败/违规场景。

- [x] **Task 03: 升级 `skills/using-superpowers/SKILL.md`（路由真源）**
    - [ ] 动作: 完成 2 轮脑暴 + 实时检索，补充 Schema、输出物、验证与证据、红旗/反例、例外/降级策略、工具映射。
    - [ ] 验证: 在执行记录中写入 2 轮脑暴要点 + 搜索来源清单。
    - [ ] 提交: `docs: upgrade using-superpowers skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 统一路由真源与输出模板，防止“未激活即执行”。
        - 痛点: 路由关键词不足、工具缺失时缺少降级模板。
        - 失败模式: 工具输出被当指令、外部来源未标注。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 提示注入 + 指令污染，需硬性分级与结构化输出。
        - 边界: 多技能冲突、无 Spec 直接写计划。
      - 实时检索来源:
        - OWASP LLM Top 10: https://owasp.org/www-project-top-10-for-large-language-model-applications/
        - OWASP GenAI LLM01: https://genai.owasp.org/llm01/
        - OpenAI Instruction Hierarchy (2024): https://openai.com/index/the-instruction-hierarchy/
        - OpenAI Agent Builder Safety: https://platform.openai.com/docs/guides/agent-builder-safety
        - NIST AI RMF FAQ: https://www.nist.gov/itl/ai-risk-management-framework/ai-risk-management-framework-faqs
      - 变更说明: 已移除技能文档中的“参考依据”章节，检索来源仅保留在计划执行记录中。

- [x] **Task 04: 升级 `skills/brainstorming/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，补齐统一章节与模板硬约束（若输出文件则给模板）。
    - [ ] 验证: 记录脑暴要点与来源，确认章节完整。
    - [ ] 提交: `docs: upgrade brainstorming skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 强制 Spec 物化，避免模糊需求直达实现。
        - 痛点: 上下文缺失导致方案空转。
        - 失败模式: 未产出 Spec、仅单一方案。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 以“时间紧”为由跳过 Spec。
        - 边界: 严禁进入计划/实现阶段。
      - 实时检索来源:
        - MADR (ADR Template): https://github.com/adr/madr
        - IEEE 1016-2009 SDD Standard: https://standards.ieee.org/ieee/1016/4502/

- [x] **Task 05: 升级 `skills/writing-plans/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，强化计划模板一致性、验证闭环、工具映射。
    - [ ] 验证: 记录脑暴要点与来源，确认模板硬约束落地。
    - [ ] 提交: `docs: upgrade writing-plans skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 通过 WBS 原子化保证可执行。
        - 痛点: 计划缺少决策记录与验证项。
        - 失败模式: 任务粒度过大、验证缺失。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 用“先执行后补计划”规避流程。
        - 边界: 没有批准的计划禁止执行。
      - 实时检索来源:
        - PMI Practice Standard for WBS: https://www.pmi.org/standards/work-breakdown-structures-third-edition
        - PMI Process Groups: https://www.pmi.org/standards/process-groups

- [x] **Task 06: 升级 `skills/executing-plans/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，强化执行证据物化与失败熔断，补齐统一章节。
    - [ ] 验证: 记录脑暴要点与来源，确认章节完整。
    - [ ] 提交: `docs: upgrade executing-plans skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 批次化执行与证据闭环。
        - 痛点: 执行过程漂移与无法审计。
        - 失败模式: 连续执行无停顿、无验证记录。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 跳过检查点与失败继续推进。
        - 边界: 任何失败必须熔断。
      - 实时检索来源:
        - PMI Process Groups: https://www.pmi.org/standards/process-groups
        - PRINCE2 Manage by Stages: https://prince2.wiki/principles/manage-by-stages/

- [x] **Task 07: 升级 `skills/verification-before-completion/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，补齐统一章节与证据要求。
    - [ ] 验证: 记录脑暴要点与来源。
    - [ ] 提交: `docs: upgrade verification-before-completion skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 以证据为唯一完成标准。
        - 痛点: 口头宣称完成但无验证日志。
        - 失败模式: 无交付说明、风险未披露。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 以“时间紧”跳过验证。
        - 边界: 未验证即停止交付。
      - 实时检索来源:
        - Scrum Guide (Definition of Done): https://scrumguides.org/scrum-guide.html
        - NASA Systems Engineering Handbook: https://www.nasa.gov/reference/systems-engineering-handbook/

- [x] **Task 08: 升级 `skills/finishing-a-development-branch/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，补齐统一章节并对齐阶段边界。
    - [ ] 验证: 记录脑暴要点与来源。
    - [ ] 提交: `docs: upgrade finishing-a-development-branch skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 合并前质量与历史整洁。
        - 痛点: PR 说明不完整、验证缺失。
        - 失败模式: 未通过测试仍合并。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 混入计划外改动。
        - 边界: 未通过验证禁止合并。
      - 实时检索来源:
        - Google Engineering Practices: Code Review: https://google.github.io/eng-practices/review/
        - GitHub Docs: About pull requests: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests

- [x] **Task 09: 升级 `skills/systematic-debugging/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，补齐统一章节并加入对抗规则。
    - [ ] 验证: 记录脑暴要点与来源。
    - [ ] 提交: `docs: upgrade systematic-debugging skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 证据链闭环，避免猜测修复。
        - 痛点: 无复现仍改代码。
        - 失败模式: 多变量同时改动。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 以“直觉”代替证据。
        - 边界: 无复现不修复。
      - 实时检索来源:
        - Microsoft Debugger Documentation: https://learn.microsoft.com/en-us/visualstudio/debugger/
        - GDB Manual (Debugging with GDB): https://sourceware.org/gdb/current/onlinedocs/gdb/

- [x] **Task 10: 升级 `skills/test-driven-development/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，补齐统一章节并强化测试模板与禁例。
    - [ ] 验证: 记录脑暴要点与来源。
    - [ ] 提交: `docs: upgrade test-driven-development skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 红-绿-重构闭环固化。
        - 痛点: 先实现后补测导致测试失真。
        - 失败模式: 无失败测试直接实现。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 为了赶进度省略测试。
        - 边界: 没有失败测试禁止写实现。
      - 实时检索来源:
        - Microsoft: Unit testing best practices: https://learn.microsoft.com/en-us/dotnet/core/testing/unit-testing-best-practices
        - Agile Alliance: Test-Driven Development (TDD): https://www.agilealliance.org/glossary/tdd/

- [x] **Task 11: 升级 `skills/dispatching-parallel-agents/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，补齐统一章节并强化并发安全边界。
    - [ ] 验证: 记录脑暴要点与来源。
    - [ ] 提交: `docs: upgrade dispatching-parallel-agents skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 并行任务互不干扰、可安全合并。
        - 痛点: 任务边界不清导致冲突。
        - 失败模式: 合并前缺少全量回归。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: “小改动”借口跳过回归。
        - 边界: 合并前必须回归验证。
      - 实时检索来源:
        - Git SCM Book: Branching and Merging: https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell
        - Google SRE Book: Managing Change: https://sre.google/sre-book/managing-change/

- [x] **Task 12: 升级 `skills/subagent-driven-development/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，补齐统一章节并强化零信任审计模板。
    - [ ] 验证: 记录脑暴要点与来源。
    - [ ] 提交: `docs: upgrade subagent-driven-development skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 实现与审查隔离，确保质量闭环。
        - 痛点: 角色混用导致盲点。
        - 失败模式: 未验证输出直接合并。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 以“赶进度”跳过审查。
        - 边界: 没有独立审查禁止合并。
      - 实时检索来源:
        - NIST SP 800-207 Zero Trust Architecture: https://csrc.nist.gov/publications/detail/sp/800-207/final
        - Google Engineering Practices: Code Review: https://google.github.io/eng-practices/review/

- [x] **Task 13: 升级 `skills/receiving-code-review/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，补齐统一章节与反馈闭环模板。
    - [ ] 验证: 记录脑暴要点与来源。
    - [ ] 提交: `docs: upgrade receiving-code-review skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 反馈落地可审计。
        - 痛点: 未理解就修改导致返工。
        - 失败模式: 高风险反馈被忽略。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 以“我觉得没问题”拒绝反馈。
        - 边界: 未验证禁止结论。
      - 实时检索来源:
        - Google Engineering Practices: Code Review: https://google.github.io/eng-practices/review/
        - SmartBear: Best Practices for Peer Code Review: https://smartbear.com/learn/code-review/best-practices-for-peer-code-review/

- [x] **Task 14: 升级 `skills/requesting-code-review/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，补齐统一章节与审查请求模板。
    - [ ] 验证: 记录脑暴要点与来源。
    - [ ] 提交: `docs: upgrade requesting-code-review skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 提供完整上下文，提升审查质量。
        - 痛点: 缺少风险与验证信息。
        - 失败模式: 无自审就请求审查。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 以“改动小”省略说明。
        - 边界: 必须提供 Why/What/Risks/Verification。
      - 实时检索来源:
        - GitHub Docs: Requesting a pull request review: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/requesting-a-pull-request-review
        - Google Engineering Practices: Code Review: https://google.github.io/eng-practices/review/

- [x] **Task 15: 升级 `skills/using-git-worktrees/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，补齐统一章节并强化安全清理模板。
    - [ ] 验证: 记录脑暴要点与来源。
    - [ ] 提交: `docs: upgrade using-git-worktrees skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 隔离工作区并避免污染主线。
        - 痛点: 手动删除导致 Git 状态异常。
        - 失败模式: 未记录 worktree 与分支对应关系。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 直接删除目录规避清理流程。
        - 边界: 必须使用 git worktree 命令清理。
      - 实时检索来源:
        - Git Docs: git-worktree: https://git-scm.com/docs/git-worktree
        - Pro Git: Git Tools - Worktree: https://git-scm.com/book/en/v2/Git-Tools-Worktree

- [x] **Task 16: 升级 `skills/ux-prototyping/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，补齐统一章节与原型输出模板。
    - [ ] 验证: 记录脑暴要点与来源。
    - [ ] 提交: `docs: upgrade ux-prototyping skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 快速验证交互路径。
        - 痛点: 过度追求视觉导致验证延迟。
        - 失败模式: 原型不可运行或非中文。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 引入复杂构建链条拖慢验证。
        - 边界: 必须单文件可运行。
      - 实时检索来源:
        - Nielsen Norman Group: Prototyping in UX Design: https://www.nngroup.com/articles/prototyping-ux-design/
        - Usability.gov: Prototyping: https://www.usability.gov/how-to-and-tools/methods/prototyping.html

- [x] **Task 17: 升级 `skills/skill-localization-and-polishing/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，补齐统一章节并强化本地化质量模板。
    - [ ] 验证: 记录脑暴要点与来源。
    - [ ] 提交: `docs: upgrade skill-localization-and-polishing skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 规则高信噪比与可审计。
        - 痛点: 文档松散、缺少可验证性。
        - 失败模式: 规则模糊或不可执行。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 以“简洁”为由删除关键约束。
        - 边界: 规则必须可执行与可验证。
      - 实时检索来源:
        - Google Developer Documentation Style Guide: https://developers.google.com/style
        - Microsoft Writing Style Guide: https://learn.microsoft.com/en-us/style-guide/welcome/

- [x] **Task 18: 升级 `skills/writing-skills/SKILL.md`**
    - [ ] 动作: 2 轮脑暴 + 实时检索，补齐统一章节与技能文档模板。
    - [ ] 验证: 记录脑暴要点与来源。
    - [ ] 提交: `docs: upgrade writing-skills skill`
    - 执行记录:
      - 脑暴第 1 轮（目标/痛点/失败模式）:
        - 目标: 统一模板与强约束语气。
        - 痛点: 规则描述含糊、难以执行。
        - 失败模式: 规则不可验证。
      - 脑暴第 2 轮（对抗/边界补强）:
        - 对抗: 使用弱约束词绕过规则。
        - 边界: 必须用强约束术语。
      - 实时检索来源:
        - RFC 2119 (Key words for use in RFCs): https://www.rfc-editor.org/rfc/rfc2119
        - Google Developer Documentation Style Guide: https://developers.google.com/style

- [x] **Task 19: 跨技能一致性与模板校验**
    - [ ] 动作: 检查所有技能是否包含统一章节、Frontmatter 字段与输出模板。
    - [ ] 验证: 运行 `Get-ChildItem -Path skills -Recurse -Filter SKILL.md | ForEach-Object { Select-String -Path $_.FullName -Pattern "name:|description:|输出物|验证与证据|工具映射" }`，记录要点到执行记录。
    - [ ] 提交: `docs: verify skills schema consistency`
    - 验证记录:
      ```text
      skills\brainstorming\SKILL.md:2:name: brainstorming
      skills\brainstorming\SKILL.md:3:description: 当需要进行新功能开发、架构设计、重构或解决模糊问题，且需将需求转化为具体技术规范时使用。
      skills\brainstorming\SKILL.md:43:## 输出物 (Artifacts)
      skills\brainstorming\SKILL.md:73:## 验证与证据 (Verification & Evidence)
      skills\brainstorming\SKILL.md:90:## 工具映射 (Tool Mapping)
      skills\dispatching-parallel-agents\SKILL.md:2:name: dispatching-parallel-agents
      skills\dispatching-parallel-agents\SKILL.md:3:description: 当面临 2 个及以上可独立进行、无共享状态且无顺序依赖的任务时，用于调度多个并行智能体以提升执行效率。
      skills\dispatching-parallel-agents\SKILL.md:34:## 输出物 (Artifacts)
      skills\dispatching-parallel-agents\SKILL.md:46:## 验证与证据 (Verification & Evidence)
      skills\dispatching-parallel-agents\SKILL.md:60:## 工具映射 (Tool Mapping)
      skills\executing-plans\SKILL.md:2:name: executing-plans
      skills\executing-plans\SKILL.md:3:description: 当需要严格按书面计划分批执行任务，并确保每一步都经过验证与审查时使用。
      skills\executing-plans\SKILL.md:41:## 输出物 (Artifacts)
      skills\executing-plans\SKILL.md:52:## 验证与证据 (Verification & Evidence)
      skills\executing-plans\SKILL.md:68:## 工具映射 (Tool Mapping)
      skills\finishing-a-development-branch\SKILL.md:2:name: finishing-a-development-branch
      skills\finishing-a-development-branch\SKILL.md:3:description: 当实施完成、所有测试通过，并且需要决定如何集成工作或准备发起 PR 时使用。
      skills\finishing-a-development-branch\SKILL.md:35:## 输出物 (Artifacts)
      skills\finishing-a-development-branch\SKILL.md:47:## 验证与证据 (Verification & Evidence)
      skills\finishing-a-development-branch\SKILL.md:62:## 工具映射 (Tool Mapping)
      skills\receiving-code-review\SKILL.md:2:name: receiving-code-review
      skills\receiving-code-review\SKILL.md:3:description: 当收到代码审查反馈时，在实施建议之前使用，以确保理性、客观地吸收反馈并改进代码。
      skills\receiving-code-review\SKILL.md:31:## 输出物 (Artifacts)
      skills\receiving-code-review\SKILL.md:43:## 验证与证据 (Verification & Evidence)
      skills\receiving-code-review\SKILL.md:57:## 工具映射 (Tool Mapping)
      skills\requesting-code-review\SKILL.md:2:name: requesting-code-review
      skills\requesting-code-review\SKILL.md:3:description: 当完成功能开发、修复 Bug 或准备合并分支时使用，以发起高质量的审查请求。
      skills\requesting-code-review\SKILL.md:30:## 输出物 (Artifacts)
      skills\requesting-code-review\SKILL.md:43:## 验证与证据 (Verification & Evidence)
      skills\requesting-code-review\SKILL.md:56:## 工具映射 (Tool Mapping)
      skills\skill-localization-and-polishing\SKILL.md:2:name: skill-localization-and-polishing
      skills\skill-localization-and-polishing\SKILL.md:3:description: 当需要创建、翻译或优化中文技能文档，且要求实现高信噪比、强约束力的专家级规范时使用。
      skills\skill-localization-and-polishing\SKILL.md:36:## 输出物 (Artifacts)
      skills\skill-localization-and-polishing\SKILL.md:47:## 验证与证据 (Verification & Evidence)
      skills\skill-localization-and-polishing\SKILL.md:62:## 工具映射 (Tool Mapping)
      skills\subagent-driven-development\SKILL.md:2:name: subagent-driven-development
      skills\subagent-driven-development\SKILL.md:3:description: 当在当前会话中执行涉及复杂逻辑、多步骤实施或需要严格隔离审查的计划任务时使用。
      skills\subagent-driven-development\SKILL.md:35:## 输出物 (Artifacts)
      skills\subagent-driven-development\SKILL.md:48:## 验证与证据 (Verification & Evidence)
      skills\subagent-driven-development\SKILL.md:61:## 工具映射 (Tool Mapping)
      skills\systematic-debugging\SKILL.md:2:name: systematic-debugging
      skills\systematic-debugging\SKILL.md:3:description: 当遇到 Bug、测试失败或非预期行为时，在提出修复方案前使用，以确保基于证据的科学排障。
      skills\systematic-debugging\SKILL.md:37:## 输出物 (Artifacts)
      skills\systematic-debugging\SKILL.md:42:## 验证与证据 (Verification & Evidence)
      skills\systematic-debugging\SKILL.md:57:## 工具映射 (Tool Mapping)
      skills\test-driven-development\SKILL.md:2:name: test-driven-development
      skills\test-driven-development\SKILL.md:3:description: 在实施任何逻辑变更或修复 Bug 之前使用，强制执行先写测试、后写实现的研发模式。
      skills\test-driven-development\SKILL.md:33:## 输出物 (Artifacts)
      skills\test-driven-development\SKILL.md:44:## 验证与证据 (Verification & Evidence)
      skills\test-driven-development\SKILL.md:58:## 工具映射 (Tool Mapping)
      skills\using-git-worktrees\SKILL.md:2:name: using-git-worktrees
      skills\using-git-worktrees\SKILL.md:3:description: 当需要在不干扰当前工作区的前提下，处理并发开发、紧急 Bug 修复或进行多版本基准对比时使用。
      skills\using-git-worktrees\SKILL.md:31:## 输出物 (Artifacts)
      skills\using-git-worktrees\SKILL.md:42:## 验证与证据 (Verification & Evidence)
      skills\using-git-worktrees\SKILL.md:55:## 工具映射 (Tool Mapping)
      skills\using-superpowers\SKILL.md:2:name: using-superpowers
      skills\using-superpowers\SKILL.md:3:description: 在开始任何对话、接收新指令或准备执行任务前使用，确立“技能驱动”的元规则，强制要求激活对应的专家模式。
      skills\using-superpowers\SKILL.md:76:## 输出物 (Artifacts)
      skills\using-superpowers\SKILL.md:84:## 验证与证据 (Verification & Evidence)
      skills\using-superpowers\SKILL.md:106:## 工具映射 (Tool Mapping)
      skills\ux-prototyping\SKILL.md:2:name: ux-prototyping
      skills\ux-prototyping\SKILL.md:3:description: 当需要产出中文友好的 UX 交互原型、Mockup 或验证业务逻辑流时使用。
      skills\ux-prototyping\SKILL.md:32:## 输出物 (Artifacts)
      skills\ux-prototyping\SKILL.md:61:## 验证与证据 (Verification & Evidence)
      skills\ux-prototyping\SKILL.md:75:## 工具映射 (Tool Mapping)
      skills\verification-before-completion\SKILL.md:2:name: verification-before-completion
      skills\verification-before-completion\SKILL.md:3:description: 在声称修复完成、功能交付或准备提交代码前使用，确立“证据优先”的验收基准。
      skills\verification-before-completion\SKILL.md:33:## 输出物 (Artifacts)
      skills\verification-before-completion\SKILL.md:44:## 验证与证据 (Verification & Evidence)
      skills\verification-before-completion\SKILL.md:59:## 工具映射 (Tool Mapping)
      skills\writing-plans\SKILL.md:2:name: writing-plans
      skills\writing-plans\SKILL.md:3:description: 当持有已批准的设计规格 (Spec)，并准备进入多步骤实施阶段前使用，用于产出可追踪的执行蓝图。
      skills\writing-plans\SKILL.md:38:## 输出物 (Artifacts)
      skills\writing-plans\SKILL.md:62:## 验证与证据 (Verification & Evidence)
      skills\writing-plans\SKILL.md:78:## 工具映射 (Tool Mapping)
      skills\writing-skills\SKILL.md:2:name: writing-skills
      skills\writing-skills\SKILL.md:3:description: 当需要创建新技能、重构现有技能或为特定工程挑战建立新的行为准则时使用。
      skills\writing-skills\SKILL.md:30:## 输出物 (Artifacts)
      skills\writing-skills\SKILL.md:36:name: <skill-name>
      skills\writing-skills\SKILL.md:37:description: <中文描述>
      skills\writing-skills\SKILL.md:50:## 输出物 (Artifacts)
      skills\writing-skills\SKILL.md:52:## 验证与证据 (Verification & Evidence)
      skills\writing-skills\SKILL.md:58:## 工具映射 (Tool Mapping)
      skills\writing-skills\SKILL.md:61:## 验证与证据 (Verification & Evidence)
      skills\writing-skills\SKILL.md:73:## 工具映射 (Tool Mapping)
      ```

- [x] **Task 20: 最终汇总与交付说明**
    - [ ] 动作: 汇总每个技能的升级要点、引用来源与模板清单。
    - [ ] 验证: 在本计划底部写入最终交付说明与证据链接。
    - [ ] 提交: `docs: summarize skills upgrade results`
    - 交付说明:
      - 升级完成的技能: brainstorming, writing-plans, executing-plans, verification-before-completion, finishing-a-development-branch, systematic-debugging, test-driven-development, dispatching-parallel-agents, subagent-driven-development, receiving-code-review, requesting-code-review, using-git-worktrees, ux-prototyping, skill-localization-and-polishing, writing-skills, using-superpowers。
      - 统一字段: 所有技能已包含 `name` 与 `description`。
      - 统一章节: 概述、何时使用、强制流程、输出物、验证与证据、红旗/反例、例外与降级策略、工具映射。
      - 文件模板: Spec/Plan/UX 原型/新技能模板已写入对应技能文档。

## 批次审查记录

- 批次 1（Task 01-03）: 通过。未发现阻塞，继续执行后续任务。
- 批次 2（Task 04-06）: 通过。章节与模板统一完成，继续执行后续任务。
- 批次 3（Task 07-09）: 通过。验证与交付规则补齐，继续执行后续任务。
- 批次 4（Task 10-12）: 通过。测试与并行/审查规则补齐，继续执行后续任务。
- 批次 5（Task 13-15）: 通过。审查与 worktree 规则补齐，继续执行后续任务。
- 批次 6（Task 16-18）: 通过。原型与写作规范补齐，继续执行后续任务。
- 批次 7（Task 19-20）: 通过。一致性校验完成并输出最终汇总。

## 变更记录

- 2026-02-07: 按需求取消技能文档“参考依据”章节，外部检索来源仅记录在计划执行记录中。
  - 参考来源:
    - OWASP LLM Top 10: https://owasp.org/www-project-top-10-for-large-language-model-applications/
    - OWASP GenAI LLM01: https://genai.owasp.org/llm01/
    - OpenAI Instruction Hierarchy (2024): https://openai.com/index/the-instruction-hierarchy/
    - OpenAI Agent Builder Safety: https://platform.openai.com/docs/guides/agent-builder-safety
    - NIST AI RMF FAQ: https://www.nist.gov/itl/ai-risk-management-framework/ai-risk-management-framework-faqs
- 2026-02-07: 明确 `activate_skill` 为“工具名”而非技能名，修正文案表述。
  - 参考来源:
    - OpenAI Instruction Hierarchy: https://openai.com/index/the-instruction-hierarchy/
    - OpenAI Agents JS Guardrails: https://openai.github.io/openai-agents-js/guides/guardrails/
