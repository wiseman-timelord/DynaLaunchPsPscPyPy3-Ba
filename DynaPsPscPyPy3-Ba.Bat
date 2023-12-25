@echo off

:: Initialization
mode con cols=60 lines=35
color 0E  :: Yellow text
title DynaPsPscPyPy3-Ba
echo.
echo DynaPsPscPyPy3-Ba Started...
timeout /t 2 /nobreak >nul

:: Function to list scripts
:generateMenu
set i=0
setlocal EnableDelayedExpansion
for %%f in (*.ps1, *.py) do (
    set /a i+=1
    if "%%~xf"==".ps1" (
        set "scriptName[!i!]=PS: %%~nxf"
    ) else if "%%~xf"==".py" (
        set "scriptName[!i!]=PY: %%~nxf"
    )
)

if %i%==0 (
    echo No .Ps1/.Py Scripts Found!
    timeout /t 2 /nobreak >nul
    goto end
)

:: Main Menu
:menu
cls
echo.
echo ===================( DynaPsPscPyPy3-Ba )====================
echo.
echo                      Scripts Found: %i%
echo.

for /l %%x in (1,1,%i%) do (
    echo                  %%x. !scriptName[%%x]!
)

echo.
echo.

:: User choice
set /p choice=                 Select Script=1-#, Refresh List=R, Quit Program=0: 
if /i "%choice%"=="0" goto end
if /i "%choice%"=="R" goto generateMenu

:: Validate choice
set "selectedScript=!scriptName[%choice%]!"
if "!selectedScript!"=="" (
    echo Invalid choice. Try again.
    pause
    goto menu
)

:: Extracting script file name and type from the selection
set "scriptFile=!selectedScript:~4!"
set "scriptType=!selectedScript:~0,2!"

:: Confirmation before executing
echo.
echo                  You selected: !scriptFile!
set /p confirm=                 Are you sure you want to run this script? [Y/N]: 
if /i not "%confirm%"=="Y" goto menu

:: Determine script type and execute
echo.
if "!scriptType!"=="PS" (
    echo                  Launching PowerShell Script...
    pwsh.exe -NoProfile -ExecutionPolicy Bypass -File "!scriptFile!" || echo                  PowerShell Core not found, falling back to Windows PowerShell...
) else if "!scriptType!"=="PY" (
    echo                  Launching Python Script...
    python "!scriptFile!" || echo                  Python is not available.
)

echo.
echo ...Script Exited.
pause

:: Return to menu or exit
echo.
set /p exitChoice=                 Return to Menu (M) or Exit (E) [M/E]? 
if /i "%exitChoice%"=="M" goto menu
goto end

:end
echo.
echo ...Launcher Script Finished.
echo.
pause
