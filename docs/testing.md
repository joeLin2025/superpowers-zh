# 测试 Superpowers-zh 技能

本文档描述如何测试 Superpowers-zh 技能，特别是针对复杂技能（如 `subagent-driven-development`）的集成测试。

## 概述

测试涉及子智能体、工作流和复杂交互的技能需要在无头模式下运行实际的 Claude Code 会话，并通过会话脚本验证其行为。

## 测试结构

```
tests/
├── claude-code/
│   ├── test-helpers.sh                    # 共享测试实用程序
│   ├── test-subagent-driven-development-integration.sh
│   ├── analyze-token-usage.py             # Token 分析工具
│   └── run-skill-tests.sh                 # 测试运行器 (如果存在)
```

## 运行测试

### 集成测试

集成测试使用实际技能执行真实的 Claude Code 会话：

```bash
# 运行 subagent-driven-development 集成测试
cd tests/claude-code
./test-subagent-driven-development-integration.sh
```

**注意：** 集成测试可能需要 10-30 分钟，因为它们使用多个子智能体执行真实的实施计划。

### 要求

- 必须从 **Superpowers-zh 插件目录** 运行（不是从临时目录）
- Claude Code 必须已安装且作为 `claude` 命令可用
- 本地开发市场必须在 `~/.claude/settings.json` 中启用：`"Superpowers-zh@superpowers-dev": true`

## 集成测试：subagent-driven-development

### 它测试什么

集成测试验证 `subagent-driven-development` 技能是否正确：

1. **计划加载**：在开始时读取一次计划
2. **完整任务文本**：向子智能体提供完整的任务描述（不让他们读取文件）
3. **自我审查**：确保子智能体在汇报前进行自我审查
4. **审查顺序**：在代码质量审查之前运行规范合规性审查
5. **审查循环**：当发现问题时使用审查循环
6. **独立验证**：规范审查者独立阅读代码，不信任实施者报告

### 它如何工作

1. **设置**：创建一个带有最小实施计划的临时 Node.js 项目
2. **执行**：在无头模式下使用该技能运行 Claude Code
3. **验证**：解析会话脚本 (`.jsonl` 文件) 以验证：
   - Skill 工具被调用
   - 子智能体被分派 (Task 工具)
   - TodoWrite 用于跟踪
   - 实施文件被创建
   - 测试通过
   - Git 提交显示正确的工作流
4. **Token 分析**：按子智能体显示 token 使用明细

### 测试输出

```
========================================
 Integration Test: subagent-driven-development
========================================

Test project: /tmp/tmp.xyz123

=== Verification Tests ===

Test 1: Skill tool invoked...
  [PASS] subagent-driven-development skill was invoked

Test 2: Subagents dispatched...
  [PASS] 7 subagents dispatched

Test 3: Task tracking...
  [PASS] TodoWrite used 5 time(s)

Test 6: Implementation verification...
  [PASS] src/math.js created
  [PASS] add function exists
  [PASS] multiply function exists
  [PASS] test/math.test.js created
  [PASS] Tests pass

Test 7: Git commit history...
  [PASS] Multiple commits created (3 total)

Test 8: No extra features added...
  [PASS] No extra features added

=========================================
 Token Usage Analysis
=========================================

Usage Breakdown:
----------------------------------------------------------------------------------------------------
Agent           Description                          Msgs      Input     Output      Cache     Cost
----------------------------------------------------------------------------------------------------
main            Main session (coordinator)             34         27      3,996  1,213,703 $   4.09
3380c209        implementing Task 1: Create Add Function     1          2        787     24,989 $   0.09
34b00fde        implementing Task 2: Create Multiply Function     1          4        644     25,114 $   0.09
3801a732        reviewing whether an implementation matches...   1          5        703     25,742 $   0.09
4c142934        doing a final code review...                    1          6        854     25,319 $   0.09
5f017a42        a code reviewer. Review Task 2...               1          6        504     22,949 $   0.08
a6b7fbe4        a code reviewer. Review Task 1...               1          6        515     22,534 $   0.08
f15837c0        reviewing whether an implementation matches...   1          6        416     22,485 $   0.07
----------------------------------------------------------------------------------------------------

TOTALS:
  Total messages:         41
  Input tokens:           62
  Output tokens:          8,419
  Cache creation tokens:  132,742
  Cache read tokens:      1,382,835

  Total input (incl cache): 1,515,639
  Total tokens:             1,524,058

  Estimated cost: $4.67
  (at $3/$15 per M tokens for input/output)

========================================
 Test Summary
========================================

STATUS: PASSED
```

## Token 分析工具

### 用法

从任何 Claude Code 会话分析 token 使用情况：

```bash
python3 tests/claude-code/analyze-token-usage.py ~/.claude/projects/<project-dir>/<session-id>.jsonl
```

### 查找会话文件

会话脚本存储在 `~/.claude/projects/` 中，工作目录路径已编码：

```bash
# Example for /Users/user/Documents/GitHub/Superpowers-zh/Superpowers-zh
SESSION_DIR="$HOME/.claude/projects/-Users-user-Documents-GitHub-superpowers-superpowers"

# Find recent sessions
ls -lt "$SESSION_DIR"/*.jsonl | head -5
```

### 它显示什么

- **主会话使用量**：协调员（你或主 Claude 实例）的 Token 使用量
- **每子智能体明细**：每个 Task 调用包含：
  - Agent ID
  - 描述（从提示词提取）
  - 消息计数
  - 输入/输出 tokens
  - 缓存使用量
  - 估计成本
- **总计**：总体 token 使用量和成本估算

### 理解输出

- **高缓存读取**：好 - 意味着提示词缓存正在工作
- **主要的高输入 tokens**：预期 - 协调员拥有完整上下文
- **每子智能体成本相似**：预期 - 每个获得类似的任务复杂性
- **每任务成本**：典型范围是每个子智能体 $0.05-$0.15，取决于任务

## 故障排除

### 技能未加载

**问题**：运行无头测试时未找到技能

**解决方案**：
1. 确保你从 Superpowers-zh 目录运行：`cd /path/to/Superpowers-zh && tests/...`
2. 检查 `~/.claude/settings.json` 在 `enabledPlugins` 中有 `"Superpowers-zh@superpowers-dev": true`
3. 验证技能存在于 `skills/` 目录中

### 权限错误

**问题**：Claude 被阻止写入文件或访问目录

**解决方案**：
1. 使用 `--permission-mode bypassPermissions` 标志
2. 使用 `--add-dir /path/to/temp/dir` 授予对测试目录的访问权限
3. 检查测试目录的文件权限

### 测试超时

**问题**：测试耗时太长并超时

**解决方案**：
1. 增加超时：`timeout 1800 claude ...` (30 分钟)
2. 检查技能逻辑中的无限循环
3. 审查子智能体任务复杂性

### 未找到会话文件

**问题**：测试运行后找不到会话脚本

**解决方案**：
1. 在 `~/.claude/projects/` 中检查正确的项目目录
2. 使用 `find ~/.claude/projects -name "*.jsonl" -mmin -60` 查找最近的会话
3. 验证测试实际运行了（检查测试输出中的错误）

## 编写新的集成测试

### 模板

```bash
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

# Create test project
TEST_PROJECT=$(create_test_project)
trap "cleanup_test_project $TEST_PROJECT" EXIT

# Set up test files...
cd "$TEST_PROJECT"

# Run Claude with skill
PROMPT="Your test prompt here"
cd "$SCRIPT_DIR/../.." && timeout 1800 claude -p "$PROMPT" \
  --allowed-tools=all \
  --add-dir "$TEST_PROJECT" \
  --permission-mode bypassPermissions \
  2>&1 | tee output.txt

# Find and analyze session
WORKING_DIR_ESCAPED=$(echo "$SCRIPT_DIR/../.." | sed 's/\\//-/g' | sed 's/^-//')
SESSION_DIR="$HOME/.claude/projects/$WORKING_DIR_ESCAPED"
SESSION_FILE=$(find "$SESSION_DIR" -name "*.jsonl" -type f -mmin -60 | sort -r | head -1)

# Verify behavior by parsing session transcript
if grep -q '"name":"Skill".*"skill":"your-skill-name"' "$SESSION_FILE"; then
    echo "[PASS] Skill was invoked"
fi

# Show token analysis
python3 "$SCRIPT_DIR/analyze-token-usage.py" "$SESSION_FILE"
```

### 最佳实践

1. **始终清理**：使用 trap 清理临时目录
2. **解析脚本**：不要 grep 用户面向的输出 - 解析 `.jsonl` 会话文件
3. **授予权限**：使用 `--permission-mode bypassPermissions` 和 `--add-dir`
4. **从插件目录运行**：技能仅在从 Superpowers-zh 目录运行时加载
5. **显示 token 使用量**：始终包含 token 分析以获得成本可见性
6. **测试真实行为**：验证创建的实际文件、通过的测试、进行的提交

## 会话脚本格式

会话脚本是 JSONL (JSON Lines) 文件，其中每行是一个代表消息或工具结果的 JSON 对象。

### 关键字段

```json
{
  "type": "assistant",
  "message": {
    "content": [...],
    "usage": {
      "input_tokens": 27,
      "output_tokens": 3996,
      "cache_read_input_tokens": 1213703
    }
  }
}
```

### 工具结果

```json
{
  "type": "user",
  "toolUseResult": {
    "agentId": "3380c209",
    "usage": {
      "input_tokens": 2,
      "output_tokens": 787,
      "cache_read_input_tokens": 24989
    },
    "prompt": "You are implementing Task 1...",
    "content": [{"type": "text", "text": "..."}]
  }
}
```

`agentId` 字段链接到子智能体会话，`usage` 字段包含该特定子智能体调用的 token 使用量。