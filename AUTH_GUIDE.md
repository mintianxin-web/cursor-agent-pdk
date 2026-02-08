# 🔐 GitHub 身份验证指南

## 问题
GitHub 已不再支持使用密码推送代码，需要使用 **Personal Access Token (PAT)**。

## ✅ 快速解决方案

### 步骤 1: 获取 Personal Access Token

1. **访问 Token 设置页面**：
   ```
   https://github.com/settings/tokens
   ```
   或者：
   - 点击 GitHub 右上角头像
   - 选择 **Settings**
   - 左侧菜单选择 **Developer settings**
   - 选择 **Personal access tokens** → **Tokens (classic)**

2. **创建新 Token**：
   - 点击 **"Generate new token"** → **"Generate new token (classic)"**
   - **Note（备注）**: 填写 `cursor-agent-pdk-push`（任意名称）
   - **Expiration（过期时间）**: 选择 90 days 或更长
   - **Scopes（权限）**: ⚠️ **重要** - 勾选 `repo`（完整仓库权限）
   - 滚动到底部，点击 **"Generate token"**

3. **复制 Token**：
   - ⚠️ **重要**: Token 只显示一次，立即复制并保存！
   - 格式类似：`ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

### 步骤 2: 使用 Token 推送

在 PowerShell 中运行：

```powershell
cd d:\Code_Projects\Your_project_manager
git push -u origin main
```

当提示输入凭据时：
- **Username（用户名）**: `mintianxin-web`
- **Password（密码）**: 粘贴刚才复制的 **Personal Access Token**（不是 GitHub 密码！）

## 🔄 方法二：使用 Git Credential Manager（推荐，一次配置）

### Windows 用户（推荐）

1. **安装 Git Credential Manager**（通常 Git for Windows 已包含）

2. **配置凭据**：
   ```powershell
   # 设置凭据助手
   git config --global credential.helper manager-core
   
   # 推送时会弹出 Windows 凭据管理器窗口
   git push -u origin main
   ```

3. **在弹出窗口中**：
   - 用户名：`mintianxin-web`
   - 密码：粘贴 Personal Access Token
   - 勾选 "记住我的凭据"

以后推送就不需要再输入了！

## 🔄 方法三：在 URL 中嵌入 Token（临时方案）

⚠️ **不推荐用于长期使用**，但可以快速测试：

```powershell
cd d:\Code_Projects\Your_project_manager

# 将 YOUR_TOKEN 替换为实际的 Token
git remote set-url origin https://mintianxin-web:YOUR_TOKEN@github.com/mintianxin-web/cursor-agent-pdk.git

# 然后推送
git push -u origin main

# ⚠️ 推送完成后，建议改回普通 URL（避免 Token 泄露）
git remote set-url origin https://github.com/mintianxin-web/cursor-agent-pdk.git
```

## 🔄 方法四：使用 SSH（最安全，推荐长期使用）

### 1. 检查是否已有 SSH 密钥

```powershell
ls ~/.ssh/id_*.pub
```

如果有文件（如 `id_rsa.pub` 或 `id_ed25519.pub`），跳到步骤 3。

### 2. 生成新的 SSH 密钥

```powershell
ssh-keygen -t ed25519 -C "12345678+mintianxin-web@users.noreply.github.com"
```

- 按 Enter 使用默认路径
- 可以设置密码短语（可选，但推荐）

### 3. 复制公钥

```powershell
cat ~/.ssh/id_ed25519.pub
```

复制输出的内容（以 `ssh-ed25519` 开头）

### 4. 添加到 GitHub

1. 访问：https://github.com/settings/keys
2. 点击 **"New SSH key"**
3. **Title**: `My Windows PC`（任意名称）
4. **Key**: 粘贴刚才复制的公钥
5. 点击 **"Add SSH key"**

### 5. 更改远程地址为 SSH

```powershell
cd d:\Code_Projects\Your_project_manager
git remote set-url origin git@github.com:mintianxin-web/cursor-agent-pdk.git
git push -u origin main
```

## ✅ 验证推送成功

推送成功后，访问：
**https://github.com/mintianxin-web/cursor-agent-pdk**

你应该能看到所有文件：
- ✅ `.cursorrules`
- ✅ `README.md`
- ✅ `scratchpad.md`
- ✅ `cursor_prompts/` 文件夹
- ✅ `.gitignore`

## 🆘 常见问题

### Q: 提示 "remote: Invalid username or password"
**A**: 确保使用的是 Personal Access Token，不是 GitHub 密码。

### Q: 提示 "repository not found"
**A**: 检查仓库名称是否正确：`cursor-agent-pdk`

### Q: Token 在哪里查看？
**A**: Token 创建后只显示一次。如果丢失，需要重新创建。

### Q: 如何撤销 Token？
**A**: 访问 https://github.com/settings/tokens，找到对应 Token，点击删除。

## 📋 当前状态

- ✅ Git 用户已配置：`mintianxin-web`
- ✅ 邮箱已配置：`12345678+mintianxin-web@users.noreply.github.com`
- ✅ 远程仓库已设置：`https://github.com/mintianxin-web/cursor-agent-pdk.git`
- ✅ 所有文件已提交
- ⏳ **等待**: 身份验证后即可推送

---

**推荐使用方法二（Git Credential Manager）或方法四（SSH）**，一次配置，长期使用！🚀
