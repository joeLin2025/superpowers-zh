# Merge Skill Authoring Skills Plan

**依据文档**: docs/specs/2026-02-08-merge-skill-authoring.md
**目标**: 合并 writing-skills 与 skill-localization-and-polishing 为单一技能，并更新路由与引用。

## 决策记录 (Decisions)
- **工作区模式**: Current Directory
- **交付模式**: Manual
- **执行模式**: Checkpoint Confirm

## 任务清单 (Tasks)

- [x] **Task 01: 确认合并后技能命名与处置策略**
    - [ ] 动作: 提出默认技能名与触发关键词集合，确认是否保留旧技能为“弃用占位”或直接删除。
    - [x] 验证: 用户确认记录写入计划文件。
    - [ ] 提交: `docs: record merged skill naming decision`
    - 执行记录:
      - 变更摘要: 确认合并后技能名为 `skill-authoring`，旧技能处置为 `remove`，触发关键词集合按两者合并。
      - 验证输出: 用户于 2026-02-08 确认 1) skill-authoring 2) remove 3) 合并触发关键词。

- [x] **Task 02: 生成新技能文档**
    - [x] 动作: 新建 `skills/<new-skill>/SKILL.md`，合并两技能流程与约束。
    - [x] 验证: `rg -n "触发关键词"` 与 `rg -n "对抗测试"` 命中新技能；文档包含全部必备段落。
    - [ ] 提交: `docs: add merged skill`
    - 执行记录:
      - 变更摘要: 创建合并后的新技能文档 `skills/skill-authoring/SKILL.md`。
      - 验证输出: `rg -n "触发关键词|对抗测试" skills/skill-authoring/SKILL.md` 命中。

- [x] **Task 03: 更新路由**
    - [x] 动作: 更新 `skills/using-superpowers/SKILL.md` 的路由关键词指向新技能。
    - [x] 验证: `rg -n "writing-skills|skill-localization-and-polishing" skills/using-superpowers/SKILL.md` 无旧路由。
    - [ ] 提交: `docs: update routing to merged skill`
    - 执行记录:
      - 变更摘要: 更新路由关键词指向 `skill-authoring`。
      - 验证输出: `rg -n "writing-skills|skill-localization-and-polishing" skills/using-superpowers/SKILL.md` 无输出。

- [x] **Task 04: 处理旧技能**
    - [x] 动作: 按 Task 01 决策删除旧技能或改为弃用占位（指向新技能）。
    - [x] 验证: `rg -n "writing-skills|skill-localization-and-polishing" skills` 仅保留允许位置。
    - [ ] 提交: `docs: deprecate or remove old skills`
    - 执行记录:
      - 变更摘要: 删除旧技能目录 `skills/writing-skills` 与 `skills/skill-localization-and-polishing`。
      - 验证输出: `rg -n "writing-skills|skill-localization-and-polishing" skills` 无输出。

- [x] **Task 05: 结构一致性验证**
    - [x] 动作: 运行技能结构扫描与内容核对。
    - [x] 验证: 无缺失段落、触发关键词与对抗测试。
    - [ ] 提交: `docs: verify skill structure`
    - 执行记录:
      - 变更摘要: 执行技能结构一致性扫描。
      - 验证输出: `SUMMARY Total:15 MissingFrontMatter:0 MissingAny:0`。

- [x] **Task 06: 清理临时脚本**
    - [x] 动作: 删除 `tmp-update-adversarial.ps1`（及其他确认的临时文件）。
    - [x] 验证: `git status -sb` 无临时脚本残留。
    - [ ] 提交: `chore: remove temporary scripts`
    - 执行记录:
      - 变更摘要: 删除临时脚本。
      - 验证输出: `git status -sb` 未显示临时脚本残留。
