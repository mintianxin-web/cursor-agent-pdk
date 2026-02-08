# ============================================
# Cursor 项目自动 GitHub 推送脚本
# 用途：快速设置 Git 仓库并推送到 GitHub
# ============================================

param(
    [Parameter(Mandatory=$true)]
    [string]$RepoName,
    
    [Parameter(Mandatory=$true)]
    [string]$GitHubUsername,
    
    [Parameter(Mandatory=$false)]
    [string]$Description = "",
    
    [Parameter(Mandatory=$false)]
    [switch]$Private = $false
)

Write-Host ""
Write-Host "🚀 Cursor 项目 GitHub 自动设置工具" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

# 检查是否在项目目录
if (-not (Test-Path ".git")) {
    Write-Host "📦 初始化 Git 仓库..." -ForegroundColor Yellow
    git init
    git branch -M main
    Write-Host "✅ Git 仓库已初始化" -ForegroundColor Green
} else {
    Write-Host "✅ Git 仓库已存在" -ForegroundColor Green
}

# 检查 .gitignore
if (-not (Test-Path ".gitignore")) {
    Write-Host "📝 创建 .gitignore..." -ForegroundColor Yellow
    @"
# 环境变量和密钥
.env
.env.local
.env.*.local
*.key
api_keys.txt
secrets.txt

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
venv/
.venv/
env/

# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.pnpm-debug.log*

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# 系统文件
.DS_Store
Thumbs.db
desktop.ini

# 日志文件
*.log
logs/

# 临时文件
*.tmp
*.temp
.cache/
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8
    Write-Host "✅ .gitignore 已创建" -ForegroundColor Green
}

# 检查 README.md
if (-not (Test-Path "README.md")) {
    Write-Host "📝 创建 README.md 模板..." -ForegroundColor Yellow
    $readmeContent = @"
# $RepoName

## 是什么？

[在这里描述项目是什么，它的核心功能和目标]

## 为什么？

[在这里说明为什么需要这个项目，解决了什么问题，有什么价值]

## 怎么用？

### 安装

\`\`\`bash
# 安装步骤
\`\`\`

### 使用方法

\`\`\`bash
# 使用示例
\`\`\`

### 配置

[配置说明]

## 项目结构

\`\`\`
.
├── README.md
└── ...
\`\`\`

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT License
"@
    $readmeContent | Out-File -FilePath "README.md" -Encoding UTF8
    Write-Host "✅ README.md 模板已创建" -ForegroundColor Green
}

# 配置 Git 用户信息
Write-Host ""
Write-Host "⚙️  配置 Git 用户信息..." -ForegroundColor Yellow
$currentUser = git config user.name
$currentEmail = git config user.email

if (-not $currentUser) {
    $userName = Read-Host "请输入 Git 用户名（直接回车使用 GitHub 用户名）"
    if (-not $userName) { $userName = $GitHubUsername }
    git config user.name $userName
    Write-Host "✅ 用户名已设置: $userName" -ForegroundColor Green
} else {
    Write-Host "✅ 用户名: $currentUser" -ForegroundColor Green
}

if (-not $currentEmail) {
    $userEmail = Read-Host "请输入 Git 邮箱（直接回车使用 GitHub no-reply 邮箱）"
    if (-not $userEmail) { 
        $userEmail = "$GitHubUsername@users.noreply.github.com"
    }
    git config user.email $userEmail
    Write-Host "✅ 邮箱已设置: $userEmail" -ForegroundColor Green
} else {
    Write-Host "✅ 邮箱: $currentEmail" -ForegroundColor Green
}

# 添加文件
Write-Host ""
Write-Host "📤 添加文件到 Git..." -ForegroundColor Yellow
git add .
$status = git status --short
if ($status) {
    Write-Host "发现以下更改:" -ForegroundColor Cyan
    Write-Host $status
    Write-Host ""
    $commitMsg = Read-Host "输入提交信息（直接回车使用默认）"
    if (-not $commitMsg) { $commitMsg = "Initial commit" }
    git commit -m $commitMsg
    Write-Host "✅ 文件已提交" -ForegroundColor Green
} else {
    Write-Host "ℹ️  没有需要提交的更改" -ForegroundColor Cyan
}

# 设置远程仓库
Write-Host ""
Write-Host "🔗 配置远程仓库..." -ForegroundColor Yellow
$remoteUrl = "https://github.com/$GitHubUsername/$RepoName.git"

# 检查远程仓库是否存在
$existingRemote = git remote get-url origin 2>$null
if ($existingRemote) {
    Write-Host "⚠️  远程仓库已存在: $existingRemote" -ForegroundColor Yellow
    $change = Read-Host "是否更改远程仓库地址? (y/n)"
    if ($change -eq "y") {
        git remote set-url origin $remoteUrl
        Write-Host "✅ 远程仓库已更新" -ForegroundColor Green
    }
} else {
    git remote add origin $remoteUrl
    Write-Host "✅ 远程仓库已添加: $remoteUrl" -ForegroundColor Green
}

# 推送选项
Write-Host ""
Write-Host "📋 推送选项:" -ForegroundColor Yellow
Write-Host "  1. 现在推送（需要 GitHub Token）" -ForegroundColor White
Write-Host "  2. 稍后手动推送" -ForegroundColor White
Write-Host "  3. 使用 GitHub CLI 推送（如果已安装）" -ForegroundColor White
Write-Host ""

$pushOption = Read-Host "选择选项 (1/2/3，直接回车跳过)"

if ($pushOption -eq "1") {
    Write-Host ""
    Write-Host "🔐 需要 GitHub Personal Access Token" -ForegroundColor Yellow
    Write-Host "获取 Token: https://github.com/settings/tokens" -ForegroundColor Cyan
    Write-Host ""
    $token = Read-Host "粘贴你的 Token（输入时不会显示）" -AsSecureString
    $tokenPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($token))
    
    if ($tokenPlain) {
        Write-Host ""
        Write-Host "📤 正在推送..." -ForegroundColor Yellow
        git remote set-url origin "https://$GitHubUsername`:$tokenPlain@github.com/$GitHubUsername/$RepoName.git"
        
        # 检查远程分支
        $remoteExists = git ls-remote --heads origin main 2>$null
        if ($remoteExists) {
            Write-Host "⚠️  远程仓库已有内容，先拉取..." -ForegroundColor Yellow
            git pull origin main --allow-unrelated-histories --no-edit 2>&1 | Out-Null
            if ($LASTEXITCODE -ne 0) {
                Write-Host "⚠️  有合并冲突，请手动解决后推送" -ForegroundColor Yellow
            }
        }
        
        git push -u origin main
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "✅ 推送成功!" -ForegroundColor Green
            Write-Host "🌐 仓库地址: https://github.com/$GitHubUsername/$RepoName" -ForegroundColor Cyan
            # 恢复普通 URL
            git remote set-url origin $remoteUrl
        } else {
            Write-Host ""
            Write-Host "❌ 推送失败，请检查 Token 权限和网络连接" -ForegroundColor Red
        }
    }
} elseif ($pushOption -eq "3") {
    $ghExists = Get-Command gh -ErrorAction SilentlyContinue
    if ($ghExists) {
        Write-Host ""
        Write-Host "📤 使用 GitHub CLI 创建仓库并推送..." -ForegroundColor Yellow
        $visibility = if ($Private) { "private" } else { "public" }
        gh repo create $RepoName --$visibility --source=. --remote=origin --push
    } else {
        Write-Host "❌ GitHub CLI 未安装，请访问 https://cli.github.com/ 安装" -ForegroundColor Red
    }
} else {
    Write-Host ""
    Write-Host "📝 手动推送步骤:" -ForegroundColor Yellow
    Write-Host "  1. 在 GitHub 创建仓库: https://github.com/new" -ForegroundColor White
    Write-Host "  2. 仓库名称: $RepoName" -ForegroundColor White
    Write-Host "  3. 运行: git push -u origin main" -ForegroundColor White
}

Write-Host ""
Write-Host "✨ 设置完成！" -ForegroundColor Green
Write-Host ""
