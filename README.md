# PsPy-Runner
Status: Working - Revisited on 202409, much was overhauled. 

### DESCRIPTION
PsPy-Runner is an innovative batch script launcher designed to dynamically, find, present menu with, and launch, upon PowerShell (`.ps1`) and Python (`.py`), scripts in the same directory. It is particularly useful for testing and development environments where numerous scripts need to be managed and run efficiently. This launcher automatically detects scripts in its directory, allowing for a seamless and flexible script execution process. It's ideal for users who need a centralized and streamlined way to run multiple test scripts without manual intervention, but with appropriate logging for any error output.

### FEATURES
- **Script Management**: Dynamically detects and labels `.ps1` and `.py` files in the directory, simplifying script identification and execution.
- **Environment Detection**: Will detect Powershell Core, and will also detect and present all installed Python Versions.
- **Enhanced User Interface**: Offers an intuitive, interactive menu with dynamic numbered Menus and flashy Banner.
- **Window Refresh**: Maybe you want to throw a script into the folder, then refresh the list of files, you can do this.
- **Event Logging**: If there are any, errors or crashes, in your script, then they will be outputted to, `Errors.Log` or `Crashes.Log`.   

### INTERFACE
- The main menu...
```
========================================================================================================================
    PsPy-Runner
========================================================================================================================


    Scripts Found: 2

        1. PS: test_script.ps1
        2. PY: test_script.py


========================================================================================================================
Selection; Script Options = 1-2, Refresh List = R, Exit_Runner =X:


```
- Example usage (after pressing key it returns to menu)...
```
========================================================================================================================
    PsPy-Runner
========================================================================================================================

Launching PS Script: test_script.ps1
Attempting to run: ".\test_script.ps1"
Executing with PowerShell Core...

CPU Information:
  Physical cores: 12
  Total cores: 24
  Max Frequency: 3.8 GHz
  Current Frequency: 1.11 GHz
  CPU Usage: 1.56%

Memory Information:
  Total: 63.93 GB
  Available: 48.19 GB
  Used: 15.74 GB
  Percentage Used: 24.62%

Disk Information:
  Device: C:
    Total Size: 237.87 GB
    Used: 179.88 GB
    Free: 57.99 GB
    Percentage Used: 75.62%
 ...

Network Information:
  Hostname: DESKTOP-8UON8ODUaOS
  Interface: Hyper-V Virtual Ethernet Adapter
    IP Address: ############, #########################
    MAC Address: #################
  Interface: Remote NDIS based Internet Sharing Device
    IP Address: ##############, ########################
    MAC Address: ###################

OS Information:
  System: Microsoft Windows 10 Pro
  Version: 10.0.19041
  Architecture: 64-bit

Press Enter to exit...

```

## REQUIREMENTS
- Batch Support - The launcher is Windows Batch, ensure scripting host is enabled. 
- Pwsh/PowerShell - Either one will do, depends what your scripts are programmed towards.
- Python - Whatever version you need for the script, it should be installed to 1 of the 2 default install options.
- The, `.ps1` and/or `.py`, scripts, that you intend to test/run, or you can just run the examples, if ye want.

### USAGE
1. Locate `PsPy-Runner.Bat` and your `.ps1` or `.py` scripts in the same folder.
2. Launch the program by running `PsPy-Runner.Bat`.
4. Select a script from the menu to `PsPy-Runner.Bat`, or drop in new script to run and refresh the list.
5. After the script runs, you will be prompted to return to the menu by hitting enter.

### NOTATION
- Python scripts will ask for a python version you are working with the first time, then remember it for the session.
- For PowerShell and PowerShell Core, it must be on the system path in order to work.

## DISCLAIMER
This software is subject to the terms in License.Txt, covering usage, distribution, and modifications. For full details on your rights and obligations, refer to License.Txt.
