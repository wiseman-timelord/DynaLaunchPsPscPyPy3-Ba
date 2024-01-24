# PsPyRunner-Ba

### STATUS: 
Working. It has been re-visited twice, and is somewhat perfected.

### DESCRIPTION
PsPyRunner-Ba is an innovative batch script launcher designed to dynamically, find, present menu with, and launch, upon PowerShell (`.ps1`) and Python (`.py`), scripts in the same directory. It is particularly useful for testing and development environments where numerous scripts need to be managed and PsPyRunnerd efficiently, and there is currently no batch launcher written. This launcher automatically detects scripts in its directory, allowing for a seamless and flexible script execution process. It's ideal for users who need a centralized and streamlined way to run multiple test scripts without manual intervention. "But I know how to launch a powershell/python file, why would I use this?", well it saves, time and effort, and, you can, keep your own launcher batch vanilla or create your own program specific launcer later.

### FEATURES
- **Script Management**: Dynamically detects and labels `.ps1` and `.py` files in the directory, simplifying script identification and execution.
- **Enhanced User Interface**: Offers an intuitive, interactive menu with window resizing options (C60xL30, C50xL40, C70xL20) for a better user experience.
- **Execution Support**: Seamlessly runs scripts, bypassing execution policies, and prioritizes PWSH/Python3 over PowerShell/Python, if you have them or falling back as required.
- **Window Resizing**: By pressing `w` on the menu. users can resize the window to some sensible sizes.
- **Admin Rights**: By pressing `a` on the menu, users can launch scripts with admin rights.
- **Event Logging**: If there are any, errors or crashes, in your script, then they will be outputted to, `Errors.Log` or `Crashes.Log`.   

### INTERFACE
- The main menu...
```

=====================( PsPyRunner-Ba )======================


                     Scripts Found: 1

              1. PS: test.ps1


Select, Script=1-#, Admin=A, Refresh=R, Window=W, Exit=X:








```
- Example usage (after pressing key it returns to menu)...
```

Launching PS Script: test.ps1

==== Monitoring Panel ====
Transfer Rates:Inbound - 0 KB/sOutbound - 0 KB/s

..Script Exited.

Press any key to continue . . .







```

### USAGE
1. Locate PsPyRunner-Ba and your .ps1 or .py scripts in the same folder.
2. Launch the program by running "PsPyRunner-Ba.Bat".
3. As required, resize the window `w` and request Admin rights `a`.
4. Select a script from the menu to PsPyRunner, or refresh the list if needed.
5. After the script runs, choose to return to the menu `m` or exit `x`.

### REQUIREMENTS
- Windows Batch Support
- Pwsh/PowerShell (As are compatible with scripts)
- Python3/Python (As are compatible with scripts)
- A folder containing `.ps1` and/or `.py` scripts.

### NOTATION
-Whatever you are intending to use, Pwsh, Powershell, Python3, Python, it must be on the system path in order to work.
-Do not release my full batch in your release, the idea is you make a simpler batch launcher for your release.
-Keep PsPyRunner-Ba in a folder on its own alongside other folders containing scripts for developing, copy-paste it where needed.

## DISCLAIMER
This software is subject to the terms in License.Txt, covering usage, distribution, and modifications. For full details on your rights and obligations, refer to License.Txt.
