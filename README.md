# DynaPsPscPyPy3-Ba

Status: Working.
<br> Work planned...
- Further, testing and refinement, though I can confirm it works with, powershell and python, scripts.

## Description
DynaPsPscPyPy3-Ba is an innovative batch script launcher designed to dynamically execute PowerShell (`.ps1`) and Python (`.py`) scripts. It is particularly useful for testing and development environments where numerous scripts need to be managed and executed efficiently. This launcher automatically detects scripts in its directory, allowing for a seamless and flexible script execution process. It's ideal for users who need a centralized and streamlined way to run multiple test scripts without manual intervention.

## Features:
- **Dynamic Script Detection**: Automatically identifies and lists `.ps1` and `.py` files in its directory.
- **Script Type Identification**: Labels each script as either a PowerShell or Python script for clear distinction.
- **User-Friendly Interface**: Offers an interactive menu for easy script selection and execution.
- **Execution Policy Handling**: Bypasses PowerShell execution policies for immediate script running.
- **Fallback Mechanism**: Defaults to Windows PowerShell if PowerShell Core is not detected.
- **Error Notification**: Informs the user if the required interpreter (PowerShell or Python) is unavailable.
- **Post-Execution Options**: Allows users to either return to the main menu or exit the program after script execution.
- **Window Resizing**: Choose between C60xL30, C50xL40, C70xL20, for optimal displays of scripts.

## Interface:
```

===================( DynaPsPscPyPy3-Ba )====================


                     Scripts Found: 3

                 1. PY: ascii.py
                 2. PY: main.py
                 3. PY: washup.py


Select Script=1-#, Refresh List=R, Quit Program=0:











```

## Usage
1. Place DynaPsPscPyPy3-Ba in a folder with the, `.ps1` and/or `.py`, scripts you wish to launch.
2. Run "DynaPsPscPyPy3-Ba.Bat".
3. From the displayed menu, choose a script to execute or refresh the script list.
4. Confirm execution when prompted.
5. After the script runs, choose to return to the menu or exit.

## Requirements
- Windows 7/8.1/10/11
- PowerShell (Windows PowerShell or PowerShell Core)
- Python interpreter (for Python scripts)
- A folder containing `.ps1` and/or `.py` scripts.

## Disclaimer
This program is provided "as is" without warranties or support. Users are responsible for the content they, download and use, as well as, any resulting damage to, hardware or sanity.
