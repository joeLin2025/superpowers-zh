# Claude Code 技能测试

使用 Claude Code CLI 的 Superpowers-zh 技能的自动化测试。

## 概述

此测试套件验证技能是否被正确加载以及 Claude 是否按预期遵循它们。测试在无头模式 (`claude -p`) 下调用 Claude Code 并验证行为。

## 要求

- Claude Code CLI 已安装并在 PATH 中 (`claude --version` 应该工作)
- 本地 Superpowers-zh 插件已安装 (见主 README 了解安装)

## 运行测试

### 运行所有快速测试 (推荐):
```bash
./run-skill-tests.sh
```

### 运行集成测试 (慢，10-30 分钟):
```bash
./run-skill-tests.sh --integration
```

### 运行特定测试:
```bash
./run-skill-tests.sh --test test-subagent-driven-development.sh
```

### 运行并显示详细输出:
```bash
./run-skill-tests.sh --verbose
```

### 设置自定义超时:
```bash
./run-skill-tests.sh --timeout 1800  # 集成测试为 30 分钟
```

## 测试结构

### test-helpers.sh
技能测试的通用函数:
- `run_claude "prompt" [timeout]` - 用提示词运行 Claude
- `assert_contains output pattern name` - 验证模式存在
- `assert_not_contains output pattern name` - 验证模式缺席
- `assert_count output pattern count name` - 验证确切计数
- `assert_order output pattern_a pattern_b name` - 验证顺序
- `create_test_project` - 创建临时测试目录
- `create_test_plan project_dir` - 创建示例计划文件

### 测试文件

每个测试文件：
1. 引用 `test-helpers.sh`
2. 使用特定提示词运行 Claude Code
3. 使用断言验证预期行为
4. 成功时返回 0，失败时返回非零

## 示例测试

```bash
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "=== Test: My Skill ==="

# Ask Claude about the skill
output=$(run_claude "What does the my-skill skill do?" 30)

# Verify response
assert_contains "$output" "expected behavior" "Skill describes behavior"

echo "=== All tests passed ==="
```

## 当前测试

### 快速测试 (默认运行)

#### test-subagent-driven-development.sh
测试技能内容和要求 (~2 分钟):
- 技能加载和可访问性
- 工作流排序 (代码质量之前的规范合规性)
- 记录的自我审查要求
- 记录的计划阅读效率
- 记录的规范合规性审查者的怀疑态度
- 记录的审查循环
- 记录的任务上下文提供

### 集成测试 (使用 --integration 标志)

#### test-subagent-driven-development-integration.sh
完整工作流执行测试 (~10-30 分钟):
- 创建带有 Node.js 设置的真实测试项目
- 创建带有 2 个任务的实施计划
- 使用 subagent-driven-development 执行计划
- 验证实际行为：
  - 计划在开始时读取一次 (不是每个任务)
  - 子智能体提示词中提供完整的任务文本
  - 子智能体在汇报前进行自我审查
  - 规范合规性审查发生在代码质量之前
  - 规范审查者独立阅读代码
  - 产生工作实施
  - 测试通过
  - 创建适当的 git 提交

**它测试什么:**
- 工作流实际上是端到端工作的
- 我们的改进实际上已应用
- 子智能体正确遵循技能
- 最终代码是功能性的并经过测试

## 添加新测试

1. 创建新测试文件: `test-<skill-name>.sh`
2. 引用 test-helpers.sh
3. 使用 `run_claude` 和断言编写测试
4. 添加到 `run-skill-tests.sh` 中的测试列表
5. 设为可执行: `chmod +x test-<skill-name>.sh`

## 超时考虑

- 默认超时：每个测试 5 分钟
- Claude Code 可能需要时间响应
- 如果需要，使用 `--timeout` 调整
- 测试应集中以避免长时间运行

## 调试失败的测试

使用 `--verbose`，你将看到完整的 Claude 输出：
```bash
./run-skill-tests.sh --verbose --test test-subagent-driven-development.sh
```

没有 verbose，只有失败显示输出。

## CI/CD 集成

在 CI 中运行:
```bash
# 为 CI 环境使用显式超时运行
./run-skill-tests.sh --timeout 900

# 退出码 0 = 成功, 非零 = 失败
```

## 注意

- 测试验证技能*指令*，而不是完整执行
- 完整工作流测试会非常慢
- 专注于验证关键技能要求
- 测试应具有确定性
- 避免测试实施细节