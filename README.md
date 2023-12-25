# DynaPsPscPyPy3-Ba

## STATUS: 
Working, revisited & somewhat perfected. Further, testing and refinement possible.

## DESCRIPTION
DynaPsPscPyPy3-Ba is an innovative batch script launcher designed to dynamically execute PowerShell (`.ps1`) and Python (`.py`) scripts. It is particularly useful for testing and development environments where numerous scripts need to be managed and executed efficiently. This launcher automatically detects scripts in its directory, allowing for a seamless and flexible script execution process. It's ideal for users who need a centralized and streamlined way to run multiple test scripts without manual intervention.

## FEATURES
- **Script Management**: Dynamically detects and labels `.ps1` and `.py` files in the directory, simplifying script identification and execution.
- **Enhanced User Interface**: Offers an intuitive, interactive menu with window resizing options (C60xL30, C50xL40, C70xL20) for a better user experience.
- **Execution Support**: Seamlessly runs scripts, bypassing PowerShell execution policies, and includes fallback to Windows PowerShell if needed.
- **Efficient Error Handling**: Notifies users about missing interpreters and provides post-execution options for convenience. 

## INTERFACE
```

===================( DynaPsPscPyPy3-Ba )====================


                     Scripts Found: 3

                 1. PY: ascii.py
                 2. PY: main.py
                 3. PY: washup.py


Select, Script=1-#, Refresh=R, Window=W, Quit=X:








```

## USAGE
1. Locate DynaPsPscPyPy3-Ba and your .ps1 or .py scripts in the same folder..
2. Launch the program by running "DynaPsPscPyPy3-Ba.Bat".
3. Resize the window to your liking `w`.
4. Select a script from the menu to execute, or refresh the list if needed.
5. After the script runs, choose to return to the menu `m` or exit `x`.

## REQUIREMENTS
- Windows Batch Support
- Pwsh/PowerShell (As are compatible with scripts)
- Python3/Python (As are compatible with scripts)
- A folder containing `.ps1` and/or `.py` scripts.

## NOTATION
Whatever you are intending to use, Pwsh, Powershell, Python3, Python, it must be on the system path in order to work.

## DISCLAIMER
This program is provided "as is" without warranties or support. Users are responsible for the content they, download and use, as well as, any resulting damage to, hardware or sanity.
