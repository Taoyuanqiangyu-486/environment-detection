@echo off
echo 正在推送...
git add .
git commit -m "更新项目代码"
git push
echo ✅ 完成！
pause