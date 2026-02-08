# GitHub 推送脚本
# 使用方法：在创建 GitHub 仓库后运行此脚本

Write-Host "🚀 Cursor AI Rules - GitHub 推送脚本" -ForegroundColor Cyan
Write-Host ""

# 检查是否在正确的目录
if (-not (Test-Path ".cursorrules")) {
    Write-Host "❌ 错误: 请在项目根目录运行此脚本" -ForegroundColor Red
    exit 1
}

# 检查 Git 状态
Write-Host "📋 检查 Git 状态..." -ForegroundColor Yellow
$status = git status --short
if ($status) {
    Write-Host "⚠️  发现未提交的更改:" -ForegroundColor Yellow
    Write-Host $status
    $response = Read-Host "是否先提交这些更改? (y/n)"
    if ($response -eq "y") {
        git add .
        $commitMsg = Read-Host "输入提交信息 (默认: Update files)"
        if (-not $commitMsg) { $commitMsg = "Update files" }
        git commit -m $commitMsg
    }
}

# 检查远程仓库
Write-Host ""
Write-Host "🔍 检查远程仓库配置..." -ForegroundColor Yellow
$remote = git remote get-url origin 2>$null
if ($remote) {
    Write-Host "✅ 远程仓库: $remote" -ForegroundColor Green
} else {
    Write-Host "⚠️  未找到远程仓库，正在添加..." -ForegroundColor Yellow
    git remote add origin https://github.com/mintianxin-web/cursor-ai-rules.git
    Write-Host "✅ 已添加远程仓库" -ForegroundColor Green
}

# 确认仓库已创建
Write-Host ""
Write-Host "⚠️  重要提示:" -ForegroundColor Yellow
Write-Host "请确保已在 GitHub 创建了仓库: https://github.com/mintianxin-web/cursor-ai-rules" -ForegroundColor White
Write-Host ""
$confirm = Read-Host "仓库已创建? (y/n)"
if ($confirm -ne "y") {
    Write-Host ""
    Write-Host "📝 请先访问以下链接创建仓库:" -ForegroundColor Cyan
    Write-Host "   https://github.com/new" -ForegroundColor White
    Write-Host ""
    Write-Host "仓库名称: cursor-ai-rules" -ForegroundColor White
    Write-Host "描述: Transform your Cursor IDE into a powerful project management system" -ForegroundColor White
    Write-Host "可见性: Public (推荐)" -ForegroundColor White
    Write-Host ""
    Write-Host "创建完成后，再次运行此脚本。" -ForegroundColor Yellow
    exit 0
}

# 推送代码
Write-Host ""
Write-Host "📤 正在推送到 GitHub..." -ForegroundColor Yellow
Write-Host ""

try {
    git push -u origin main
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ 推送成功!" -ForegroundColor Green
        Write-Host ""
        Write-Host "🎉 你的项目已发布到:" -ForegroundColor Cyan
        Write-Host "   https://github.com/mintianxin-web/cursor-ai-rules" -ForegroundColor White
        Write-Host ""
        Write-Host "下一步建议:" -ForegroundColor Yellow
        Write-Host "1. 访问仓库页面添加 Topics (cursor-ide, ai-prompts, etc.)" -ForegroundColor White
        Write-Host "2. 创建 Release: git tag -a v1.0.0 -m 'Initial release'" -ForegroundColor White
        Write-Host "3. 分享给其他开发者!" -ForegroundColor White
    } else {
        Write-Host ""
        Write-Host "❌ 推送失败" -ForegroundColor Red
        Write-Host ""
        Write-Host "可能的原因:" -ForegroundColor Yellow
        Write-Host "1. 仓库尚未创建 - 请先访问 https://github.com/new 创建" -ForegroundColor White
        Write-Host "2. 身份验证失败 - 需要使用 Personal Access Token" -ForegroundColor White
        Write-Host "3. 网络问题 - 请检查网络连接" -ForegroundColor White
        Write-Host ""
        Write-Host "详细说明请查看: PUBLISH_STEPS.md" -ForegroundColor Cyan
    }
} catch {
    Write-Host ""
    Write-Host "❌ 推送时发生错误: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "请查看 PUBLISH_STEPS.md 获取详细帮助" -ForegroundColor Yellow
}
