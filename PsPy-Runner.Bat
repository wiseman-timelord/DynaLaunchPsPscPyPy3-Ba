:: Initialization
@echo off
setlocal enabledelayedexpansion

:: Global Variables
set "ScriptDirectory=%~dp0"
set "ScriptDirectory=%ScriptDirectory:~0,-1%"
set "selectedScript="
set "selectedFile="
set "selectedType="

:: Check Admin
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Error: Admin Required!
    echo Right Click, then Run As Administrator.
    timeout /t 3 >nul
    goto :end_of_script
)
goto :startup_sequence

:: Display banner function
:displayBanner
cls
echo ========================================================================================================================
echo     PsPy-Runner
echo ========================================================================================================================
echo.
timeout /t 1 /nobreak >nul
goto :eof

:: Startup Sequence
:startup_sequence
cd /d "%ScriptDirectory%"
call :displayBanner
echo Status: Admin
timeout /t 1 /nobreak >nul
cd /d "%ScriptDirectory%"
echo Working Dir: %ScriptDirectory%
timeout /t 1 /nobreak >nul

:: Error and Crash Logs
echo Removing Old Logs...
if exist "%ScriptDirectory%Errors.Log" del "%ScriptDirectory%Errors.Log"
if exist "%ScriptDirectory%Crashes.Log" del "%ScriptDirectory%Crashes.Log"
echo Old Logs Deleted.
set "ErrorLog=%ScriptDirectory%Errors.Log"
set "CrashLog=%ScriptDirectory%Crashes.Log"

:: Startup Done
goto :menu

:: Main Menu
:menu
call :displayBanner
call :generateMenu
echo     Scripts Found: %i%
echo.
for /l %%x in (1,1,%i%) do (
    echo         %%x. !scriptName[%%x]!
)
echo.

:: User choice
echo ========================================================================================================================
set /p choice=Selection; Script Options (1-%i%), Refresh List (R), Exit_Runner (X): 
if /i "%choice%"=="x" goto end_of_script
if /i "%choice%"=="r" goto generateMenu

:: Validate choice
if "%choice%" geq "1" if "%choice%" leq "%i%" (
    set "selectedScript=!scriptName[%choice%]!"
    set "scriptFile=!selectedScript:~4!"
    set "scriptType=!selectedScript:~0,2!"

    call :displayBanner
    echo Launching !scriptType! Script: !scriptFile!
    timeout /t 2 /nobreak >nul

    if "!scriptType!"=="PS" (
        call :runPSScript ".\!scriptFile!"
    ) else if "!scriptType!"=="PY" (
        call :selectPythonVersion
        call :runPyScript ".\!scriptFile!"
    )

    if errorlevel 1 (
        echo [%date% %time%] Script crashed with error code %errorlevel% >> "%CrashLog%"
    )

    echo Script Exited.
    pause
    goto :menu
) else (
    echo Invalid choice.
    timeout /t 2 /nobreak >nul
    goto :menu
)

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

:: Functions to launch scripts
:runPSScript
echo Attempting to run: "%~1"
if not exist "%~1" (
    echo Error: Script file not found.
    echo Path: "%~1"
    goto :eof
)
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
    echo Error occurred while executing PowerShell script.
    timeout /t 3 /nobreak >nul
    echo Exit code: %errorlevel%
)
goto :eof

:runPyScript
if not defined PYTHON_EXE_TO_USE (
    echo No Python version selected.
    timeout /t 3 /nobreak >nul
    goto :eof
)
echo Attempting to run: "%~1" with !PYTHON_EXE_TO_USE!
!PYTHON_EXE_TO_USE! "%~1" 2>> "%ErrorLog%"
exit /b %errorlevel%

:: Function to select Python version
:selectPythonVersion
call :displayBanner
call :listPythonVersions
echo.
set /p choice=Selection; Python Options (1-%i%), Back to Menu (M): 
if /i "%choice%"=="m" goto :menu

:: Validate choice
if "%choice%" geq "1" if "%choice%" leq "%i%" (
    set "PYTHON_EXE_TO_USE=!pythonPath[%choice%]!"
    echo Selected Python version: !PYTHON_EXE_TO_USE!
    timeout /t 2 /nobreak >nul
) else (
    echo Invalid choice.
    timeout /t 2 /nobreak >nul
    goto :selectPythonVersion
)
goto :eof

:: Function to list available Python versions
:listPythonVersions
set i=0
for /l %%v in (35,1,45) do (
    for %%d in ("C:\Program Files\Python%%v\" "%LocalAppData%\Programs\Python\Python%%v\") do (
        if exist "%%~d\python.exe" (
            set /a i+=1
            set "pythonPath[!i!]=%%~d\python.exe"
            echo         !i!. Python%%v\python.exe
        )
    )
)
if %i%==0 (
    echo No Python versions found.
    timeout /t 3 /nobreak >nul
    goto :menu
)
goto :eof

:: Exit
:end_of_script
call :displayBanner
echo Exit Process Initiated.
timeout /t 5 /nobreak >nul
exit /b