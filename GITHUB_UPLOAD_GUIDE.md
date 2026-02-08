# GitHub 自动上传指南 - 经验总结

> **基于 cursor-agent-pdk 项目的实际经验总结**

本文档记录了在自动上传项目到 GitHub 过程中遇到的所有问题、解决方案和最佳实践，帮助你在下一个项目中更高效地完成上传。

---

## 📋 目录

1. [项目要求规范](#项目要求规范)
2. [常见错误与解决方案](#常见错误与解决方案)
3. [最佳实践流程](#最佳实践流程)
4. [自动化脚本使用](#自动化脚本使用)
5. [检查清单](#检查清单)

---

## 🎯 项目要求规范

### 1. 项目介绍（README.md）要求

#### 必须使用中文
- ✅ 项目介绍、说明、使用指南全部使用中文
- ✅ 代码示例和命令可以使用英文
- ✅ 技术术语保持英文（如 Git、GitHub、README 等）

#### 必须遵循"是什么、为什么、怎么用"框架

```markdown
## 是什么？

[用简洁明了的语言描述项目是什么]
- 核心功能：[列出主要功能]
- 适用场景：[什么情况下使用]
- 技术栈：[使用的技术]

## 为什么？

[说明项目的价值和解决的问题]
- **解决的问题**：[具体问题描述]
- **优势特点**：[相比其他方案的优点]
- **应用价值**：[实际应用场景和价值]

## 怎么用？

### 快速开始

[详细的安装和使用步骤]

### 详细使用

[更详细的使用说明]
```

#### 编写原则
- ✅ **实用导向**：重点说明实际应用和使用方法
- ✅ **简洁明了**：避免冗长的技术细节
- ✅ **代码示例**：提供可运行的代码示例
- ✅ **避免过度类比**：只在必要时使用技术类比

### 2. 提交信息要求

#### 必须使用英文
- ✅ 所有 Git 提交信息（commit message）必须使用英文
- ✅ 避免使用中文，防止在 GitHub 上显示乱码
- ✅ 提交信息要简洁明了

#### 提交信息格式建议
```
简短描述（50字符以内）

如果需要，可以添加详细说明
- 第一点
- 第二点
```

#### 示例
- ✅ `Initial commit`
- ✅ `Add documentation`
- ✅ `Update README with Chinese content`
- ✅ `Fix bug in authentication`
- ❌ `添加文档`（中文，会乱码）
- ❌ `更新README文件，添加中文说明，包括使用指南和示例代码`（太长）

### 3. 作者信息要求

#### 统一作者信息
- ✅ 所有提交必须使用统一的作者信息
- ✅ 使用 GitHub 用户名作为 Git 用户名
- ✅ 使用 GitHub no-reply 邮箱格式：`<数字>+<用户名>@users.noreply.github.com`

#### 配置方法
```powershell
# 设置 Git 用户信息
git config user.name "your-github-username"
git config user.email "12345678+your-github-username@users.noreply.github.com"

# 或者全局设置
git config --global user.name "your-github-username"
git config --global user.email "12345678+your-github-username@users.noreply.github.com"
```

#### 检查作者信息
```powershell
# 检查所有提交的作者
git log --format="%an|%ae" --all | Sort-Object -Unique

# 确保所有提交都是同一个作者
```

### 4. 文件命名要求

#### 使用英文文件名
- ✅ 所有文件名使用英文
- ✅ 使用小写字母和连字符（kebab-case）
- ✅ 避免使用中文文件名

#### 示例
- ✅ `README.md`
- ✅ `auto-github-setup.ps1`
- ✅ `cursor_prompts/01_spec_architect.md`
- ❌ `说明文档.md`（中文）
- ❌ `README模板.md`（中文）

---

## ⚠️ 常见错误与解决方案

### 错误 1: 提交信息显示乱码

#### 问题描述
在 GitHub 上查看提交历史时，提交信息显示为乱码（如：`娣诲姞浣跨敤鎬荤粨鏂囨。`）

#### 原因
- 提交信息使用了中文
- Windows Git 编码设置问题
- Git 历史中已有乱码提交

#### 解决方案

**预防措施：**
```powershell
# 始终使用英文提交信息
git commit -m "Add documentation"
# 而不是
git commit -m "添加文档"
```

**修复已有乱码：**
```bash
# 使用 Git Bash 执行
export FILTER_BRANCH_SQUELCH_WARNING=1
git filter-branch -f --msg-filter '
if [ "$GIT_COMMIT" = "乱码提交的哈希值" ]; then
    echo "正确的英文提交信息"
else
    cat
fi
' -- --all

# 清理
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now
```

### 错误 2: 出现不相关的 Contributor

#### 问题描述
GitHub 的 Contributors 列表中出现了其他用户（如：shubh2294）

#### 原因
- 初始提交使用了不同的邮箱地址
- GitHub 根据邮箱关联用户账号
- 使用了其他账号的邮箱

#### 解决方案

**预防措施：**
```powershell
# 在项目开始前就设置正确的作者信息
git config user.name "your-github-username"
git config user.email "12345678+your-github-username@users.noreply.github.com"

# 然后再进行第一次提交
git commit -m "Initial commit"
```

**修复已有问题：**
```bash
# 使用 Git Bash 修复初始提交的作者信息
export FILTER_BRANCH_SQUELCH_WARNING=1
git filter-branch -f --env-filter '
if [ "$GIT_COMMIT" = "初始提交的哈希值" ]; then
    export GIT_AUTHOR_NAME="your-github-username"
    export GIT_AUTHOR_EMAIL="12345678+your-github-username@users.noreply.github.com"
    export GIT_COMMITTER_NAME="your-github-username"
    export GIT_COMMITTER_EMAIL="12345678+your-github-username@users.noreply.github.com"
fi
' -- --all
```

### 错误 3: 文件提交信息不符合文件内容

#### 问题描述
GitHub 文件列表中，多个文件显示相同的提交信息，但信息不符合文件内容

#### 原因
- 多个文件在同一个提交中被添加/修改
- 提交信息过于通用，没有针对性

#### 解决方案

**预防措施：**
- 为不同类型的文件创建单独的提交
- 使用更具体的提交信息

**示例：**
```powershell
# 好的做法：分别提交
git add .cursorrules cursor_prompts/ scratchpad.md
git commit -m "Add Cursor rules and prompt templates"

git add README.md README_TEMPLATE.md
git commit -m "Add project documentation"

git add auto-github-setup.ps1
git commit -m "Add GitHub auto-setup script"

# 不好的做法：一次性提交所有文件
git add .
git commit -m "Add files"  # 太通用
```

**修复已有问题：**
- 如果文件已经在同一提交中，可以接受通用但准确的提交信息
- 或者使用 `git filter-branch` 修改提交信息（复杂，不推荐）

### 错误 4: 提交了敏感信息（Token/密钥）

#### 问题描述
GitHub 检测到提交中包含 Personal Access Token 或其他敏感信息

#### 原因
- 在代码或文档中硬编码了 Token
- 忘记添加到 `.gitignore`

#### 解决方案

**预防措施：**
```powershell
# 1. 创建 .gitignore
@"
.env
.env.local
*.key
api_keys.txt
secrets.txt
ghp_*
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8

# 2. 使用环境变量
# 不要这样做：
# $token = "ghp_xxxxxxxxxxxx"

# 应该这样做：
$token = $env:GITHUB_TOKEN
# 或从文件读取（文件已在 .gitignore 中）
```

**修复已有问题：**
```bash
# 1. 立即撤销暴露的 Token
# 访问：https://github.com/settings/tokens
# 删除暴露的 Token

# 2. 从 Git 历史中移除文件
export FILTER_BRANCH_SQUELCH_WARNING=1
git filter-branch -f --index-filter "git rm --cached --ignore-unmatch 包含敏感信息的文件" --prune-empty -- --all

# 3. 清理
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# 4. 强制推送
git push origin main --force
```

### 错误 5: 项目文件过多，不够干净

#### 问题描述
GitHub 仓库中包含了很多不必要的文件（备份文件、临时文件、帮助文档等）

#### 原因
- 没有及时清理临时文件
- 提交了 `.txt` 备份文件
- 提交了调试用的帮助文档

#### 解决方案

**预防措施：**
```powershell
# 1. 完善 .gitignore
@"
# 备份文件
*.txt
*.bak
*.backup

# 临时文件
*.tmp
*.temp
*.log

# 帮助文档（如果只是临时使用）
*_GUIDE.md
*_STEPS.md
*_SUMMARY.md
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8

# 2. 提交前检查
git status
# 确保只提交需要的文件
```

**清理已有项目：**
```powershell
# 1. 删除不需要的文件
git rm --cached 不需要的文件

# 2. 提交清理
git commit -m "Clean up: remove unnecessary files"

# 3. 推送
git push origin main
```

---

## 🚀 最佳实践流程

### 新项目上传 GitHub 的标准流程

#### 步骤 1: 项目初始化

```powershell
# 1. 创建项目目录
mkdir my-new-project
cd my-new-project

# 2. 初始化 Git
git init
git branch -M main

# 3. 配置作者信息（重要！）
git config user.name "your-github-username"
git config user.email "12345678+your-github-username@users.noreply.github.com"
```

#### 步骤 2: 创建必要文件

```powershell
# 1. 创建 .gitignore
# （使用上面的模板）

# 2. 创建 README.md（中文，遵循"是什么、为什么、怎么用"框架）
# （使用 README_TEMPLATE.md 作为模板）

# 3. 添加项目文件
git add .
```

#### 步骤 3: 提交代码

```powershell
# 使用英文提交信息
git commit -m "Initial commit"

# 或者更具体
git commit -m "Add project files: rules, templates, and documentation"
```

#### 步骤 4: 创建 GitHub 仓库

1. 访问：https://github.com/new
2. 填写仓库信息：
   - Repository name: `your-project-name`
   - Description: 简短的项目描述
   - Visibility: Public 或 Private
   - **不要**勾选任何初始化选项
3. 点击 "Create repository"

#### 步骤 5: 连接并推送

```powershell
# 1. 添加远程仓库
git remote add origin https://github.com/your-username/your-project-name.git

# 2. 获取 Personal Access Token
# 访问：https://github.com/settings/tokens
# 创建新 Token，勾选 `repo` 权限

# 3. 推送（需要 Token）
git push -u origin main
# 用户名：your-github-username
# 密码：粘贴 Token（不是 GitHub 密码）
```

#### 步骤 6: 验证

1. 访问 GitHub 仓库页面
2. 检查：
   - ✅ Contributors 只有你一个人
   - ✅ 提交信息都是英文，没有乱码
   - ✅ 文件列表干净，没有不必要的文件
   - ✅ README.md 显示正确的中文内容

---

## 🤖 自动化脚本使用

### 使用 auto-github-setup.ps1

项目已包含自动化脚本 `auto-github-setup.ps1`，可以自动完成大部分工作：

```powershell
# 运行脚本
.\auto-github-setup.ps1 -RepoName "my-project" -GitHubUsername "your-username"

# 脚本会自动：
# 1. 初始化 Git 仓库
# 2. 创建 .gitignore
# 3. 创建 README.md 模板
# 4. 配置 Git 用户信息
# 5. 添加并提交文件
# 6. 设置远程仓库
# 7. 可选：直接推送到 GitHub
```

---

## ✅ 检查清单

在推送前，请确认：

### 作者信息
- [ ] Git 用户名设置为 GitHub 用户名
- [ ] Git 邮箱使用 no-reply 格式
- [ ] 所有历史提交的作者信息统一

### 提交信息
- [ ] 所有提交信息使用英文
- [ ] 提交信息简洁明了（50字符以内）
- [ ] 没有乱码提交

### 文件
- [ ] 所有文件名使用英文
- [ ] 没有提交敏感信息（Token、密钥等）
- [ ] `.gitignore` 已配置
- [ ] 没有不必要的备份文件

### README.md
- [ ] 使用中文编写
- [ ] 遵循"是什么、为什么、怎么用"框架
- [ ] 包含快速开始指南
- [ ] 包含代码示例

### 项目结构
- [ ] 只包含必要的文件
- [ ] 文件组织清晰
- [ ] 没有临时文件或调试文件

---

## 📝 快速参考

### Git 配置命令

```powershell
# 设置用户信息
git config user.name "your-github-username"
git config user.email "12345678+your-github-username@users.noreply.github.com"

# 检查配置
git config user.name
git config user.email

# 检查所有提交的作者
git log --format="%an|%ae" --all | Sort-Object -Unique
```

### 常用 Git 命令

```powershell
# 初始化仓库
git init
git branch -M main

# 添加文件
git add .
git add 特定文件

# 提交（使用英文）
git commit -m "Your commit message in English"

# 查看状态
git status
git log --oneline

# 连接远程仓库
git remote add origin https://github.com/username/repo.git

# 推送
git push -u origin main
```

### 修复命令

```bash
# 修复提交信息（使用 Git Bash）
export FILTER_BRANCH_SQUELCH_WARNING=1
git filter-branch -f --msg-filter '...' -- --all

# 修复作者信息（使用 Git Bash）
export FILTER_BRANCH_SQUELCH_WARNING=1
git filter-branch -f --env-filter '...' -- --all

# 清理 Git 历史
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

---

## 🎓 经验总结

### 最重要的经验

1. **从一开始就正确配置作者信息** - 避免后续修复的麻烦
2. **始终使用英文提交信息** - 防止乱码问题
3. **提交前检查文件** - 避免提交敏感信息和不必要文件
4. **使用 .gitignore** - 自动排除不需要的文件
5. **遵循 README 模板** - 确保文档质量

### 避免的常见错误

- ❌ 使用中文提交信息
- ❌ 使用错误的邮箱地址
- ❌ 提交敏感信息（Token、密钥）
- ❌ 提交备份文件和临时文件
- ❌ 一次性提交所有文件而不分类

---

## 📚 相关资源

- [GitHub Personal Access Tokens](https://github.com/settings/tokens)
- [Git 官方文档](https://git-scm.com/doc)
- [GitHub 文档](https://docs.github.com/)
- [README 模板](./README_TEMPLATE.md)
- [自动化设置脚本](./auto-github-setup.ps1)

---

**记住：预防胜于修复！在项目开始时就遵循这些规范，可以避免大部分问题。** 🎯
