# Cursor AI 规则与提示词集合

> **让 Cursor IDE 成为你的智能项目管理和开发助手**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/mintianxin-web/cursor-agent-pdk.svg?style=social)](https://github.com/mintianxin-web/cursor-agent-pdk)

## 是什么？

这是一个**完整的 Cursor IDE 规则和提示词集合**，帮助你更高效地使用 AI 辅助编程。它包含：

- **工作流规则**：自动化的项目生命周期管理，从需求分析到代码部署
- **智能模式切换**：根据任务类型自动选择最适合的工作模式
- **安全保护机制**：防止误操作（如提交敏感信息、误删文件）
- **专用提示词模板**：针对不同开发阶段的优化提示词

### 核心功能

- ✅ **自动模式识别**：根据任务自动选择标准模式、STDD 模式或写作模式
- ✅ **状态机工作流**：清晰的项目开发流程，从需求到部署
- ✅ **安全第一**：内置 API 密钥保护、文件删除确认等安全机制
- ✅ **即用型提示词**：4 个专业提示词模板，覆盖项目全生命周期

## 为什么？

### 解决的问题

1. **开发效率低**：每次都要手动配置 Cursor 规则，重复劳动
2. **项目结构混乱**：缺乏统一的工作流程和规范
3. **安全隐患**：容易误提交 API 密钥等敏感信息
4. **AI 使用不当**：不知道如何编写有效的提示词

### 优势特点

- **开箱即用**：复制文件即可使用，无需复杂配置
- **智能自动化**：AI 自动识别任务类型并切换工作模式
- **安全可靠**：多层安全保护，避免常见错误
- **持续改进**：基于实际项目经验总结的最佳实践

### 适用场景

- 🎯 **个人项目开发**：快速启动新项目，规范开发流程
- 🏢 **团队协作**：统一团队开发规范，提高协作效率
- 📚 **学习实践**：学习如何更好地使用 AI 辅助编程
- 🚀 **快速原型**：快速验证想法，加速产品迭代

## 怎么用？

### 快速开始（30 秒）

\`\`\`bash
# 1. 克隆仓库
git clone https://github.com/mintianxin-web/cursor-agent-pdk.git

# 2. 复制到你的项目
cd your-project
cp cursor-agent-pdk/.cursorrules .
cp -r cursor-agent-pdk/cursor_prompts .

# 3. 完成！Cursor IDE 会自动加载规则
\`\`\`

### 详细使用指南

#### 1. 基础配置

将以下文件复制到你的项目根目录：

- `.cursorrules` - 主规则文件（必需）
- `cursor_prompts/` - 提示词模板文件夹（可选）

#### 2. 开始新项目

当你对 Cursor 说 "新项目..." 或 "开始目标..." 时，系统会：

1. **自动识别任务类型**
   - 简单/静态任务 → 标准模式
   - 逻辑/数据/可靠性任务 → STDD 模式
   - 写作/邮件任务 → 写作模式

2. **引导需求分析**
   - 提取完整的功能需求
   - 确定技术选型
   - 检查资源和权限

3. **执行开发流程**
   - 分步骤实现功能
   - 自动生成测试用例
   - 代码审查和安全检查

#### 3. 工作模式说明

| 模式 | 触发条件 | 适用场景 |
|------|---------|---------|
| **标准模式** | 简单/静态任务 | 快速脚本、静态网站、简单工具 |
| **STDD 模式** | 逻辑/数据/可靠性任务 | 复杂应用、数据库操作、API 开发 |
| **写作模式** | 写作/邮件任务 | 文档编写、邮件撰写、内容创作 |

#### 4. 提示词模板使用

项目包含 4 个专业提示词模板：

- **01_spec_architect.md** - 需求分析师：提取和整理项目需求
- **02_stdd_architect.md** - 架构顾问：技术选型和架构设计
- **03_tone_stylist.md** - 写作助手：匹配你的写作风格
- **04_code_reviewer.md** - 代码审查：安全检查和质量控制

在 Cursor 中引用：`@01_spec_architect.md` 或 `@02_stdd_architect.md`

### 项目结构

\`\`\`
cursor-agent-pdk/
├── .cursorrules              # 主规则文件（工作区级别）
├── scratchpad.md             # 项目记忆和状态追踪
├── cursor_prompts/           # 提示词模板
│   ├── 01_spec_architect.md    # 需求分析提示词
│   ├── 02_stdd_architect.md    # 架构设计提示词
│   ├── 03_tone_stylist.md      # 写作风格提示词
│   └── 04_code_reviewer.md     # 代码审查提示词
├── auto-github-setup.ps1     # GitHub 自动设置脚本
├── README_TEMPLATE.md         # README 模板
└── README.md                  # 本文件
\`\`\`

### 使用示例

#### 示例 1：启动新项目

\`\`\`
你：新项目：构建一个任务管理工具

AI：⚡ 自动识别：检测到逻辑/数据任务。切换到 STDD 模式。阶段 1 启动。

📋 阶段 A1：需求发现
- 领域：工具/仪表板
- 访问：本地使用还是公开网页？
- 数据：需要持久化数据库吗？
- 预算：有 Vercel/OpenAI 账户吗？
\`\`\`

#### 示例 2：代码审查

\`\`\`
你：@04_code_reviewer.md 请审查这段代码

AI：✅ LVS 检查通过。安全检查通过（使用环境变量）。逻辑有效。
\`\`\`

### 安全特性

- 🔒 **API 密钥保护**：自动检测并阻止硬编码的 API 密钥
- 🛡️ **文件删除保护**：删除文件前需要明确确认
- 📝 **环境变量管理**：自动使用 `.env` 文件管理敏感信息
- ✅ **自动 .gitignore**：敏感文件自动排除在版本控制外

### 高级功能

#### 自定义规则

你可以修改 `.cursorrules` 文件来适应你的项目需求：

- 调整工作流程
- 添加自定义检查
- 修改提示词模板引用

#### 集成到现有项目

如果你的项目已经有 `.cursorrules`，可以：

1. 合并规则内容
2. 保留项目特定的配置
3. 添加新的提示词模板

## 常见问题

**Q: 这个工具适合所有类型的项目吗？**
A: 是的，适用于大多数软件开发项目。你可以根据项目特点调整规则。

**Q: 会影响现有的 Cursor 配置吗？**
A: 不会。这些规则是叠加的，不会覆盖 Cursor 的默认行为。

**Q: 如何禁用某些功能？**
A: 编辑 `.cursorrules` 文件，注释掉不需要的规则部分。

**Q: 支持哪些编程语言？**
A: 规则本身是语言无关的，适用于 Python、JavaScript、TypeScript 等所有语言。

**Q: 如何更新到最新版本？**
A: 定期从仓库拉取更新，或手动复制更新的文件。

## 贡献指南

欢迎提交 Issue 和 Pull Request！

1. Fork 本项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 相关资源

- [Cursor IDE 官方文档](https://docs.cursor.com/)
- [GitHub 仓库](https://github.com/mintianxin-web/cursor-agent-pdk)
- [问题反馈](https://github.com/mintianxin-web/cursor-agent-pdk/issues)

## 许可证

MIT License

---

**让 AI 成为你的编程伙伴，而不是替代品。** 🚀
