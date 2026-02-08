# GitHub 发布指南

## ⚙️ 第一步：配置 Git 用户信息（必需）

在提交代码之前，需要先配置 Git 用户信息。在 PowerShell 中运行：

```powershell
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

或者仅为当前仓库配置（推荐）：

```powershell
cd d:\Code_Projects\Your_project_manager
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

配置完成后，运行提交命令：

```powershell
git commit -m "Initial commit: Cursor AI Rules & Prompts Collection"
```

## 📦 已准备的文件

以下文件已准备好并提交到 Git：

- ✅ `.cursorrules` - 主规则文件
- ✅ `README.md` - 项目说明文档
- ✅ `.gitignore` - Git 忽略配置
- ✅ `cursor_prompts/` - 所有提示模板文件

## 🚀 发布到 GitHub 的步骤

### 1. 在 GitHub 上创建新仓库

1. 访问 https://github.com/new
2. 填写仓库信息：
   - **Repository name**: `cursor-ai-rules` (或你喜欢的名称)
   - **Description**: "Cursor AI Rules & Prompts Collection for Technical Project Management"
   - **Visibility**: Public (推荐) 或 Private
   - **不要**勾选 "Initialize this repository with a README" (我们已经有了)

### 2. 连接本地仓库到 GitHub

在 PowerShell 中运行以下命令（将 `YOUR_USERNAME` 替换为你的 GitHub 用户名）：

```powershell
cd d:\Code_Projects\Your_project_manager
git remote add origin https://github.com/YOUR_USERNAME/cursor-ai-rules.git
git branch -M main
git push -u origin main
```

### 3. 或者使用 SSH（如果已配置 SSH 密钥）

```powershell
git remote add origin git@github.com:YOUR_USERNAME/cursor-ai-rules.git
git branch -M main
git push -u origin main
```

## 📝 发布后的操作建议

### 添加标签（可选）

```powershell
git tag -a v1.0.0 -m "Initial release: Cursor AI Rules Collection"
git push origin v1.0.0
```

### 创建 Release（可选）

1. 在 GitHub 仓库页面，点击 "Releases"
2. 点击 "Create a new release"
3. 选择标签 `v1.0.0`
4. 填写 Release 标题和描述
5. 点击 "Publish release"

## 🔒 安全提醒

- ✅ `.env.txt` 和敏感文件已在 `.gitignore` 中，不会被提交
- ✅ 所有 API 密钥相关的文件都会被忽略
- ⚠️ 发布前请再次确认没有敏感信息泄露

## 📋 发布清单

- [x] Git 仓库已初始化
- [x] 所有规则文件已整理
- [x] README.md 已创建
- [x] .gitignore 已配置
- [x] 代码已提交到本地仓库
- [ ] 在 GitHub 创建新仓库
- [ ] 连接远程仓库
- [ ] 推送到 GitHub
- [ ] 创建 Release（可选）

## 🎯 下一步

执行上述步骤后，你的规则集就会发布到 GitHub 了！其他人可以通过以下方式使用：

```bash
# 克隆仓库
git clone https://github.com/YOUR_USERNAME/cursor-ai-rules.git

# 或直接下载文件
```
