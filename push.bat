@echo off
chcp 65001 >nul
title Vision UI 自动推送工具
color 0A

echo ========================================
echo   Vision UI Dashboard 自动推送工具
echo ========================================
echo.
echo 当前目录: %cd%
echo.

:: 检查是否在 Git 仓库中
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误：当前目录不是 Git 仓库！
    echo 请在项目根目录运行此脚本。
    pause
    exit /b
)

:: 检查是否有修改
git status --porcelain >nul
if errorlevel 1 (
    echo ❌ 无法获取 Git 状态
    pause
    exit /b
)

:: 显示修改的文件
echo 📝 以下文件有修改：
git status --short
echo.

:: 询问提交说明
set /p msg="请输入提交说明（直接回车使用默认）: "
if "%msg%"=="" set msg=更新项目代码

echo.
echo ⏳ 正在添加文件...
git add .

echo ⏳ 正在提交...
git commit -m "%msg%"

if errorlevel 1 (
    echo ❌ 提交失败！可能没有需要提交的修改。
    pause
    exit /b
)

echo ⏳ 正在推送到远程...
git push

if errorlevel 1 (
    echo ❌ 推送失败！请检查网络连接。
    pause
    exit /b
)

echo.
echo ========================================
echo   ✅ 推送成功！
echo   提交说明: %msg%
echo ========================================
pause