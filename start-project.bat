@echo off
title Student Placement Management System
echo ==============================================
echo   Starting Student Placement Management System
echo ==============================================
echo.
cd /d "%~dp0backend"
echo Starting Backend Server on http://localhost:5000 ...
start http://localhost:5000
npm start
pause
