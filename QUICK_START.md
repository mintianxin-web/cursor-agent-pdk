# 🚀 快速开始指南

## 新项目自动上传到 GitHub 的完整方案

基于本次经验，我们创建了一套自动化方案，帮助你在新项目中快速设置并推送到 GitHub。

## 方案概述

### 核心工具

1. **auto-github-setup.ps1** - 自动化设置脚本
2. **README_TEMPLATE.md** - 中文 README 模板
3. **.gitignore** - 通用 Git 忽略配置

### 工作流程

```
新项目 → 运行脚本 → 自动配置 → 推送到 GitHub
```

## 使用方法

### 步骤 1：准备新项目

创建你的项目文件夹并进入：

\`\`\`powershell
mkdir my-new-project
cd my-new-project
\`\`\`

### 步骤 2：运行自动化脚本

\`\`\`powershell
# 从 cursor-agent-pdk 复制脚本
cp ..\cursor-agent-pdk\auto-github-setup.ps1 .

# 运行脚本
.\auto-github-setup.ps1 -RepoName "my-new-project" -GitHubUsername "mintianxin-web"
\`\`\`

脚本会自动：
- ✅ 初始化 Git 仓库
- ✅ 创建 .gitignore
- ✅ 创建 README.md 模板
- ✅ 配置 Git 用户信息
- ✅ 添加并提交文件
- ✅ 设置远程仓库
- ✅ 可选：直接推送到 GitHub

### 步骤 3：填写项目信息

编辑 `README.md`，按照"是什么、为什么、怎么用"的框架填写：

\`\`\`markdown
## 是什么？
[描述项目是什么]

## 为什么？
[说明为什么需要这个项目]

## 怎么用？
[详细的使用说明]
\`\`\`

### 步骤 4：推送到 GitHub

#### 方法 A：使用脚本自动推送

运行脚本时选择选项 1，输入 GitHub Token 即可自动推送。

#### 方法 B：手动推送

1. 在 GitHub 创建仓库：https://github.com/new
2. 运行推送命令：
   \`\`\`powershell
   git push -u origin main
   \`\`\`
3. 输入 GitHub Token（不是密码）

## README 编写规范

### 框架要求

所有 README 必须包含三个核心部分：

1. **是什么？** - 项目介绍
   - 核心功能
   - 适用场景
   - 技术栈

2. **为什么？** - 项目价值
   - 解决的问题
   - 优势特点
   - 应用价值

3. **怎么用？** - 使用指南
   - 快速开始
   - 详细使用
   - 配置说明

### 编写原则

- ✅ **实用导向**：重点说明实际应用和使用方法
- ✅ **简洁明了**：避免冗长的技术细节
- ✅ **中文优先**：项目介绍使用中文
- ✅ **代码示例**：提供可运行的代码示例
- ✅ **避免过度类比**：只在必要时使用技术类比

### 模板使用

直接使用 `README_TEMPLATE.md` 作为起点：

\`\`\`powershell
cp README_TEMPLATE.md README.md
# 然后编辑填写内容
\`\`\`

## 最佳实践

### 1. 项目初始化检查清单

- [ ] Git 仓库已初始化
- [ ] .gitignore 已配置
- [ ] README.md 已填写（是什么、为什么、怎么用）
- [ ] 代码已提交
- [ ] GitHub 仓库已创建
- [ ] 代码已推送

### 2. README 质量检查

- [ ] 包含"是什么、为什么、怎么用"三个部分
- [ ] 有清晰的快速开始指南
- [ ] 提供代码示例
- [ ] 说明项目结构和依赖
- [ ] 包含常见问题解答

### 3. 安全注意事项

- ✅ 使用环境变量管理敏感信息
- ✅ .gitignore 包含 .env 文件
- ✅ 不在代码中硬编码 API 密钥
- ✅ GitHub Token 使用后及时撤销

## 常见问题

**Q: 脚本运行失败怎么办？**
A: 检查 PowerShell 执行策略：`Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`

**Q: 如何获取 GitHub Token？**
A: 访问 https://github.com/settings/tokens，创建新 Token，勾选 `repo` 权限

**Q: 推送时提示权限错误？**
A: 确保 Token 属于正确的 GitHub 账号，且有仓库的写入权限

**Q: 如何更新已存在的仓库？**
A: 脚本会自动检测并合并远程更改，如有冲突会提示手动解决

## 进阶技巧

### 自定义脚本

你可以修改 `auto-github-setup.ps1` 来：
- 添加项目特定的初始化步骤
- 自动安装依赖
- 运行测试
- 创建 GitHub Actions 工作流

### 批量创建项目

创建项目模板，然后批量初始化：

\`\`\`powershell
# 创建项目模板
$projects = @("project1", "project2", "project3")
foreach ($project in $projects) {
    mkdir $project
    cd $project
    ..\auto-github-setup.ps1 -RepoName $project -GitHubUsername "mintianxin-web"
    cd ..
}
\`\`\`

---

**使用这套方案，新项目从创建到 GitHub 发布只需几分钟！** ⚡
