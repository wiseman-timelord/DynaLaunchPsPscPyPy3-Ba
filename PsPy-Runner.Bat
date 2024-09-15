:: Initialization
@echo off
setlocal enabledelayedexpansion

:: Global Variables
set "ScriptDirectory=%~dp0"
set "ScriptDirectory=%ScriptDirectory:~0,-1%"
set "selectedScript="
set "selectedFile="
set "selectedType="
set "PYTHON_EXE_TO_USE="

:: Check Admin
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Error: Admin Required!
    echo Right Click, then Run As Administrator.
    timeout /t 3 >nul
    goto :end_of_script
)
goto :startup_sequence

:: Display Banner
:displayBanner
cls
echo ========================================================================================================================
echo     PsPy-Runner
echo ========================================================================================================================
echo.
timeout /t 1 /nobreak >nul
goto :eof

:: Display Separator
:displaySeparator
echo.
echo ========================================================================================================================
goto :eof

:: Startup Sequence
:startup_sequence
cd /d "%ScriptDirectory%"
call :displayBanner
echo Status: Administrator
timeout /t 1 /nobreak >nul
cd /d "%ScriptDirectory%"
echo Working Dir: %ScriptDirectory%
timeout /t 1 /nobreak >nul

:: Error and Crash Logs
echo Removing Old Logs...
if exist "%ScriptDirectory%Errors.Log" del "%ScriptDirectory%Errors.Log"
if exist "%ScriptDirectory%Crashes.Log" del "%ScriptDirectory%Crashes.Log"
set "ErrorLog=%ScriptDirectory%Errors.Log"
set "CrashLog=%ScriptDirectory%Crashes.Log"
echo Old Logs Deleted.
timeout /t 1 /nobreak >nul

:: Startup Done
goto :main_menu

:: List scripts
:generateMenu
set i=0
for %%f in (".\*.ps1") do (
    set /a i+=1
    set "scriptName[!i!]=PS: %%~nxf"
)
for %%f in (".\*.py") do (
    set /a i+=1
    set "scriptName[!i!]=PY: %%~nxf"
)
if %i%==0 (
    echo No .Ps1/.Py Scripts Found!
    timeout /t 3 /nobreak >nul
    goto end_of_script
)
goto :eof

:: Main Menu
:main_menu
call :displayBanner
call :generateMenu
echo.
echo     Scripts Found: %i%
echo.
for /l %%x in (1,1,%i%) do (
    echo         %%x. !scriptName[%%x]!
)
echo.
call :displaySeparator
set /p choice=Selection; Script Options (1-%i%), Refresh List (R), Exit_Runner (X): 

if /i "%choice%"=="x" goto end_of_script
if /i "%choice%"=="r" goto generateMenu

:: Validate choice
if "%choice%" geq "1" if "%choice%" leq "%i%" (
    set "selectedScript=!scriptName[%choice%]!"
    set "scriptFile=!selectedScript:~4!"
    set "scriptType=!selectedScript:~0,2!"
    echo Launching !scriptType! Script: !scriptFile!
	timeout /t 2 /nobreak >nul
	call :displayBanner

    if "!scriptType!"=="PS" (
        call :runPSScript ".\!scriptFile!"
    ) else if "!scriptType!"=="PY" (
        call :selectPythonVersion
        call :runPyScript ".\!scriptFile!"
    )

    if errorlevel 1 (
        echo [%date% %time%] Script crashed with error code %errorlevel% >> "%CrashLog%"
		timeout /t 3 /nobreak >nul
		
    )
    pause
    goto :main_menu
) else (
    echo Invalid choice.
    timeout /t 2 /nobreak >nul
    goto :main_menu
)

:: Functions to launch scripts
:runPSScript
echo Attempting to run: "%~1"
where pwsh >nul 2>&1
if %errorlevel% equ 0 (
    echo Executing with PowerShell Core...
    timeout /t 1 /nobreak >nul
    pwsh -NoProfile -ExecutionPolicy Bypass -File ".\!scriptFile!"
) else (
    echo Missing: pwsh.exe.
    echo Falling back to Windows PowerShell...
    timeout /t 2 /nobreak >nul
    where powershell >nul 2>&1
    if %errorlevel% equ 0 (
        echo Executing with Built-in PowerShell...
        timeout /t 2 /nobreak >nul
        powershell -NoProfile -ExecutionPolicy Bypass -File ".\!scriptFile!"
    ) else (
        echo Missing: PowerShell Core and Windows PowerShell!
    )
)
if %errorlevel% neq 0 (
    echo Error: PowerShell script Execution.
    timeout /t 3 /nobreak >nul
    echo Exit code: %errorlevel%
)
goto :eof

:: Function to select Python version
:selectPythonVersion
if defined PYTHON_EXE_TO_USE (
    echo Using Python %PYTHON_EXE_TO_USE%.
	timeout /t 1 /nobreak >nul
    goto :eof
)
:promptPythonVersion
set /p pythonVersion=Python Version for the Session? (eg, 311 = Python v3.11): 
:searchPythonVersion
echo Searching for %pythonVersion%...
for %%d in ("C:\Program Files\Python%pythonVersion%" "%LocalAppData%\Programs\Python\Python%pythonVersion%") do (
    if exist "%%~d\python.exe" (
        set "PYTHON_EXE_TO_USE=%%~d\python.exe"
        echo Found Python%PYTHON_EXE_TO_USE%
		timeout /t 1 /nobreak >nul
        goto :eof
    )
)
echo Missing: Python%pythonVersion%!
timeout /t 3 /nobreak >nul
goto :promptPythonVersion

:: Run the Python script
:runPyScript
if not defined PYTHON_EXE_TO_USE (
    echo No Python version selected.
    timeout /t 3 /nobreak >nul
    goto :eof
)
echo Running "%~1" with %PYTHON_EXE_TO_USE%...
%PYTHON_EXE_TO_USE% "%~1" 2>> "%ErrorLog%"
echo ...Python Script Ended.
timeout /t 2 /nobreak >nul
goto :main_menu

:: Exit
:end_of_script
call :displayBanner
echo Exit Process Initiated.
timeout /t 5 /nobreak >nul
exit /b