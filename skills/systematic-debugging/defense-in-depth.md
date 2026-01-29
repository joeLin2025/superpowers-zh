# 纵深防御验证 (Defense-in-Depth Validation)

## 概述

当你修复由无效数据引起的 Bug 时，在一个地方添加验证感觉就足够了。但那单一的检查可能会被不同的代码路径、重构或模拟绕过。

**核心原则：** 在数据通过的**每一层**进行验证。使 Bug 在结构上成为不可能。

## 为什么多层

单一验证：“我们修复了 Bug”
多层：“我们让 Bug 变得不可能”

不同的层捕捉不同的情况：
- 入口验证捕捉大多数 Bug
- 业务逻辑捕捉边缘情况
- 环境卫士防止上下文特定的危险
- 调试日志帮助当其他层失败时

## 四个层

### 第 1 层：入口点验证
**目的：** 在 API 边界拒绝明显无效的输入

```typescript
function createProject(name: string, workingDirectory: string) {
  if (!workingDirectory || workingDirectory.trim() === '') {
    throw new Error('workingDirectory cannot be empty');
  }
  if (!existsSync(workingDirectory)) {
    throw new Error(`workingDirectory does not exist: ${workingDirectory}`);
  }
  if (!statSync(workingDirectory).isDirectory()) {
    throw new Error(`workingDirectory is not a directory: ${workingDirectory}`);
  }
  // ... proceed
}
```

### 第 2 层：业务逻辑验证
**目的：** 确保数据对此操作有意义

```typescript
function initializeWorkspace(projectDir: string, sessionId: string) {
  if (!projectDir) {
    throw new Error('projectDir required for workspace initialization');
  }
  // ... proceed
}
```

### 第 3 层：环境卫士
**目的：** 防止特定上下文中的危险操作

```typescript
async function gitInit(directory: string) {
  // In tests, refuse git init outside temp directories
  if (process.env.NODE_ENV === 'test') {
    const normalized = normalize(resolve(directory));
    const tmpDir = normalize(resolve(tmpdir()));

    if (!normalized.startsWith(tmpDir)) {
      throw new Error(
        `Refusing git init outside temp dir during tests: ${directory}`
      );
    }
  }
  // ... proceed
}
```

### 第 4 层：调试仪表
**目的：** 捕捉取证上下文

```typescript
async function gitInit(directory: string) {
  const stack = new Error().stack;
  logger.debug('About to git init', {
    directory,
    cwd: process.cwd(),
    stack,
  });
  // ... proceed
}
```

## 应用模式

当你发现一个 Bug：

1. **追踪数据流** - 坏值源自哪里？在哪里使用？
2. **映射所有检查点** - 列出数据通过的每个点
3. **在每一层添加验证** - 入口、业务、环境、调试
4. **测试每一层** - 尝试绕过第 1 层，验证第 2 层捕捉到它

## 来自会话的示例

Bug: 空的 `projectDir` 导致源代码中的 `git init`

**数据流：**
1. Test setup → empty string
2. `Project.create(name, '')`
3. `WorkspaceManager.createWorkspace('')`
4. `git init` runs in `process.cwd()`

**添加了四层：**
- Layer 1: `Project.create()` 验证非空/存在/可写
- Layer 2: `WorkspaceManager` 验证 projectDir 非空
- Layer 3: `WorktreeManager` 在测试中拒绝 tmpdir 之外的 git init
- Layer 4: git init 前的堆栈跟踪日志

**结果：** 所有 1847 个测试通过，Bug 无法重现

## 关键见解

所有四层都是必要的。在测试期间，每一层都捕捉到了其他层错过的 Bug：
- 不同的代码路径绕过了入口验证
- 模拟绕过了业务逻辑检查
- 不同平台上的边缘情况需要环境卫士
- 调试日志识别了结构性误用

**不要止步于一个验证点。** 在每一层添加检查。