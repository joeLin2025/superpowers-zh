# 测试反模式 (Testing Anti-Patterns)

**在以下情况加载此参考：** 编写或更改测试，添加模拟，或想向生产代码添加仅用于测试的方法时。

## 概述

测试必须验证真实行为，而不是模拟行为。模拟是隔离的手段，而不是被测试的对象。

**核心原则：** 测试代码做什么，而不是模拟做什么。

**遵循严格的 TDD 可防止这些反模式。**

## 铁律

```
1. NEVER test mock behavior (绝不测试模拟行为)
2. NEVER add test-only methods to production classes (绝不向生产类添加仅用于测试的方法)
3. NEVER mock without understanding dependencies (绝不在不理解依赖的情况下模拟)
```

## 反模式 1：测试模拟行为

**违规：**
```typescript
// ❌ BAD: Testing that the mock exists
test('renders sidebar', () => {
  render(<Page />);
  expect(screen.getByTestId('sidebar-mock')).toBeInTheDocument();
});
```

**为什么这是错误的：**
- 你正在验证模拟工作，而不是组件工作
- 当模拟存在时测试通过，不存在时失败
- 关于真实行为什么也没告诉你

**你的人类伙伴的纠正：** “我们在测试模拟的行为吗？”

**修复：**
```typescript
// ✅ GOOD: Test real component or don't mock it
test('renders sidebar', () => {
  render(<Page />);  // Don't mock sidebar
  expect(screen.getByRole('navigation')).toBeInTheDocument();
});

// OR if sidebar must be mocked for isolation:
// Don't assert on the mock - test Page's behavior with sidebar present
```

### 门控功能

```
在断言任何模拟元素之前：
  问：“我在测试真实的组件行为还是仅仅是模拟的存在？”

  如果是测试模拟存在：
    停止 - 删除断言或取消模拟组件

  改为测试真实行为
```

## 反模式 2：生产中的仅测试方法

**违规：**
```typescript
// ❌ BAD: destroy() only used in tests
class Session {
  async destroy() {  // Looks like production API!
    await this._workspaceManager?.destroyWorkspace(this.id);
    // ... cleanup
  }
}

// In tests
afterEach(() => session.destroy());
```

**为什么这是错误的：**
- 生产类被仅用于测试的代码污染
- 如果在生产中意外调用会很危险
- 违反 YAGNI 和关注点分离
- 混淆对象生命周期与实体生命周期

**修复：**
```typescript
// ✅ GOOD: Test utilities handle test cleanup
// Session has no destroy() - it's stateless in production

// In test-utils/
export async function cleanupSession(session: Session) {
  const workspace = session.getWorkspaceInfo();
  if (workspace) {
    await workspaceManager.destroyWorkspace(workspace.id);
  }
}

// In tests
afterEach(() => cleanupSession(session));
```

### 门控功能

```
在向生产类添加任何方法之前：
  问：“这是否仅由测试使用？”

  如果是：
    停止 - 不要添加它
    将其放入测试实用程序中

  问：“此类是否拥有此资源的生命周期？”

  如果否：
    停止 - 此方法的类错误
```

## 反模式 3：在不理解的情况下模拟

**违规：**
```typescript
// ❌ BAD: Mock breaks test logic
test('detects duplicate server', () => {
  // Mock prevents config write that test depends on!
  vi.mock('ToolCatalog', () => ({
    discoverAndCacheTools: vi.fn().mockResolvedValue(undefined)
  }));

  await addServer(config);
  await addServer(config);  // Should throw - but won't!
});
```

**为什么这是错误的：**
- 模拟的方法有测试依赖的副作用（写入配置）
- 为了“安全”过度模拟破坏了实际行为
- 测试因错误原因通过或神秘失败

**修复：**
```typescript
// ✅ GOOD: Mock at correct level
test('detects duplicate server', () => {
  // Mock the slow part, preserve behavior test needs
  vi.mock('MCPServerManager'); // Just mock slow server startup

  await addServer(config);  // Config written
  await addServer(config);  // Duplicate detected ✓
});
```

### 门控功能

```
在模拟任何方法之前：
  停止 - 暂时不要模拟

  1. 问：“真实方法有哪些副作用？”
  2. 问：“此测试是否依赖于任何这些副作用？”
  3. 问：“我是否完全理解此测试需要什么？”

  如果依赖于副作用：
    在较低级别模拟（实际缓慢/外部操作）
    或使用保留必要行为的测试替身
    而不是测试依赖的高级方法

  如果不确定测试依赖什么：
    首先使用真实实施运行测试
    观察实际需要发生什么
    然后在正确的级别添加最少模拟

  危险信号：
    - “为了安全起见，我会模拟这个”
    - “这可能会很慢，最好模拟它”
    - 在不理解依赖链的情况下模拟
```

## 反模式 4：不完整的模拟

**违规：**
```typescript
// ❌ BAD: Partial mock - only fields you think you need
const mockResponse = {
  status: 'success',
  data: { userId: '123', name: 'Alice' }
  // Missing: metadata that downstream code uses
};

// Later: breaks when code accesses response.metadata.requestId
```

**为什么这是错误的：**
- **部分模拟隐藏结构假设** - 你只模拟了你知道的字段
- **下游代码可能依赖于你未包含的字段** - 沉默失败
- **测试通过但集成失败** - 模拟不完整，真实 API 完整
- **错误的信心** - 测试证明不了真实行为

**铁律：** 模拟真实存在的**完整**数据结构，而不仅仅是你的直接测试使用的字段。

**修复：**
```typescript
// ✅ GOOD: Mirror real API completeness
const mockResponse = {
  status: 'success',
  data: { userId: '123', name: 'Alice' },
  metadata: { requestId: 'req-789', timestamp: 1234567890 }
  // All fields real API returns
};
```

### 门控功能

```
在创建模拟响应之前：
  检查：“真实 API 响应包含哪些字段？”

  行动：
    1. 检查来自文档/示例的实际 API 响应
    2. 包含系统可能在下游消费的所有字段
    3. 验证模拟完全匹配真实响应模式

  关键：
    如果你正在创建一个模拟，你必须理解整个结构
    当代码依赖于省略的字段时，部分模拟会静默失败

  如果不确定：包含所有记录的字段
```

## 反模式 5：集成测试作为事后想法

**违规：**
```
✅ 实施完成
❌ 未编写测试
"Ready for testing"
```

**为什么这是错误的：**
- 测试是实施的一部分，不是可选的后续
- TDD 会捕捉到这一点
- 没有测试就不能声称完成

**修复：**
```
TDD 循环：
1. 编写失败测试
2. 实施以通过
3. 重构
4. 然后声称完成
```

## 当模拟变得太复杂时

**警告信号：**
- 模拟设置比测试逻辑长
- 为了让测试通过而模拟一切
- 模拟缺少真实组件有的方法
- 当模拟改变时测试中断

**你的人类伙伴的问题：** “我们这里需要使用模拟吗？”

**考虑：** 使用真实组件的集成测试通常比复杂的模拟更简单

## TDD 防止这些反模式

**为什么 TDD 有帮助：**
1. **先写测试** → 强迫你思考实际上在测试什么
2. **看着它失败** → 确认测试测试真实行为，而非模拟
3. **最少实施** → 没有仅用于测试的方法混入
4. **真实依赖** → 在模拟之前你看到测试实际需要什么

**如果你在测试模拟行为，你违反了 TDD** - 你在没有先看着测试对照真实代码失败的情况下添加了模拟。

## 快速参考

| 反模式 | 修复 |
|--------------|-----|
| 断言模拟元素 | 测试真实组件或取消模拟 |
| 生产中的仅测试方法 | 移至测试实用程序 |
| 不理解就模拟 | 先理解依赖，最少模拟 |
| 不完整的模拟 | 完全镜像真实 API |
| 测试作为事后想法 | TDD - 先测试 |
| 过度复杂的模拟 | 考虑集成测试 |

## 危险信号

- 断言检查 `*-mock` test IDs
- 仅在测试文件中调用的方法
- 模拟设置 >50% 的测试
- 移除模拟时测试失败
- 无法解释为何需要模拟
- “仅仅为了安全”而模拟

## 结论

**模拟是隔离的工具，不是被测试的对象。**

如果 TDD 揭示你在测试模拟行为，你就错了。

修复：测试真实行为或质疑为什么你要模拟。