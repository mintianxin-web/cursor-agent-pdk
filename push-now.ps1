# 快速推送脚本 - 引导式操作
Write-Host ""
Write-Host "🚀 GitHub 推送助手" -ForegroundColor Cyan
Write-Host ("=" * 50) -ForegroundColor Cyan
Write-Host ""

# 检查当前状态
Write-Host "📋 当前配置:" -ForegroundColor Yellow
Write-Host "  仓库: cursor-agent-pdk" -ForegroundColor White
Write-Host "  用户: mintianxin-web" -ForegroundColor White
Write-Host "  邮箱: 12345678+mintianxin-web@users.noreply.github.com" -ForegroundColor White
Write-Host ""

# 检查是否有未提交的更改
$status = git status --short
if ($status) {
    Write-Host "⚠️  发现未提交的更改:" -ForegroundColor Yellow
    Write-Host $status
    Write-Host ""
    $response = Read-Host "是否先提交这些更改? (y/n)"
    if ($response -eq "y") {
        git add .
        $commitMsg = Read-Host "输入提交信息 (直接回车使用默认)"
        if (-not $commitMsg) { $commitMsg = "Update files" }
        git commit -m $commitMsg
        Write-Host "✅ 已提交更改" -ForegroundColor Green
        Write-Host ""
    }
}

# 显示提交历史
Write-Host "📦 准备推送的提交:" -ForegroundColor Yellow
git log --oneline -5
Write-Host ""

# 身份验证选项
Write-Host "🔐 身份验证方式:" -ForegroundColor Yellow
Write-Host "  1. 使用 Personal Access Token (推荐)" -ForegroundColor White
Write-Host "  2. 使用 Windows 凭据管理器 (已配置)" -ForegroundColor White
Write-Host "  3. 使用 SSH (如果已配置 SSH 密钥)" -ForegroundColor White
Write-Host ""

$method = Read-Host "选择方式 (1/2/3，直接回车使用方式2)"

if ($method -eq "1") {
    Write-Host ""
    Write-Host "📝 获取 Personal Access Token:" -ForegroundColor Cyan
    Write-Host "  1. 访问: https://github.com/settings/tokens" -ForegroundColor White
    Write-Host "  2. 点击 'Generate new token' -> 'Generate new token (classic)'" -ForegroundColor White
    Write-Host "  3. 勾选 'repo' 权限" -ForegroundColor White
    Write-Host "  4. 生成并复制 Token" -ForegroundColor White
    Write-Host ""
    
    $token = Read-Host "粘贴你的 Personal Access Token (输入时不会显示)"
    
    if ($token) {
        Write-Host ""
        Write-Host "🔧 配置临时凭据..." -ForegroundColor Yellow
        $remoteUrl = "https://mintianxin-web:$token@github.com/mintianxin-web/cursor-agent-pdk.git"
        git remote set-url origin $remoteUrl
        Write-Host "✅ 已配置" -ForegroundColor Green
        Write-Host ""
    }
} elseif ($method -eq "3") {
    Write-Host ""
    Write-Host "🔧 切换到 SSH..." -ForegroundColor Yellow
    git remote set-url origin git@github.com:mintianxin-web/cursor-agent-pdk.git
    Write-Host "✅ 已切换到 SSH" -ForegroundColor Green
    Write-Host ""
}

# 尝试推送
Write-Host "📤 正在推送到 GitHub..." -ForegroundColor Yellow
Write-Host ""

try {
    $output = git push -u origin main 2>&1
    $exitCode = $LASTEXITCODE
    
    if ($exitCode -eq 0) {
        Write-Host ""
        Write-Host "✅ 推送成功!" -ForegroundColor Green
        Write-Host ""
        Write-Host "🎉 你的项目已发布到:" -ForegroundColor Cyan
        Write-Host "   https://github.com/mintianxin-web/cursor-agent-pdk" -ForegroundColor White
        Write-Host ""
        
        # 如果使用方法1，恢复普通URL
        if ($method -eq "1" -and $token) {
            Write-Host "🔒 恢复安全的远程 URL..." -ForegroundColor Yellow
            git remote set-url origin https://github.com/mintianxin-web/cursor-agent-pdk.git
            Write-Host "✅ 已恢复" -ForegroundColor Green
            Write-Host ""
            Write-Host "💡 提示: Token 已保存到 Windows 凭据管理器，下次推送不需要再输入" -ForegroundColor Cyan
        }
        
        Write-Host "下一步建议:" -ForegroundColor Yellow
        Write-Host "  • 访问仓库页面查看文件" -ForegroundColor White
        Write-Host "  • 添加 Topics: cursor-ide, ai-prompts, project-management" -ForegroundColor White
        Write-Host "  • 创建 Release (可选)" -ForegroundColor White
    } else {
        Write-Host ""
        Write-Host "❌ 推送失败" -ForegroundColor Red
        Write-Host ""
        Write-Host "错误信息:" -ForegroundColor Yellow
        Write-Host $output -ForegroundColor Red
        Write-Host ""
        Write-Host "💡 解决方案:" -ForegroundColor Yellow
        Write-Host "  • 如果提示身份验证失败，请使用方法1配置 Token" -ForegroundColor White
        Write-Host "  • 如果提示仓库不存在，请确认仓库名称: cursor-agent-pdk" -ForegroundColor White
        Write-Host "  • 查看详细指南: AUTH_GUIDE.md" -ForegroundColor White
    }
} catch {
    Write-Host ""
    Write-Host "❌ 发生错误: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "请查看 AUTH_GUIDE.md 获取详细帮助" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "按任意键退出..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
