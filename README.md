# f-ckit-spyrix

f-ckit-spyrix is a PowerShell script designed to detect, remove, and clean up traces of Spyrix monitoring software from a system. Spyrix is a spyware that can be used for monitoring and surveillance but can also be installed maliciously or without user consent. This script helps you identify and clean Spyrix-related executables, kill any associated processes, run uninstallers, and remove Spyrix folders.

## Features

- Detects Spyrix spyware (spm.exe, spkl.exe, sem.exe).
- Kills any running Spyrix processes to prevent interference with the uninstallation.
- Runs uninstallers for Spyrix components if available.
- Deletes Spyrix-related folders like Security Monitor.
    
## Usage

### Method 1: Run the script directly from PowerShell

1. Open PowerShell as Administrator:
    - Right-click Windows PowerShell and select Run as Administrator.

2. Run the following command to download and run the script directly from the web:

    ```powershell
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://alessandromrc.github.io/f-ckit-spyrix/f-ckit.ps1'))
    ```

    This command temporarily bypasses the script execution policy, downloads the script, and runs it immediately.

3. Follow the on-screen instructions:
    - The script will search for Spyrix-related files, kill any running processes, run uninstallers, and delete associated folders.

### Method 2: Download and Run the Script Locally

1. Download the Script:
    - Visit the URL: [Spyrix Cleaner Script](https://alessandromrc.github.io/f-ckit-spyrix/f-ckit.ps1).
    - Save it as f-ckit.ps1 to a location of your choice.

2. Set Execution Policy to Allow Scripts:
    - Open PowerShell as Administrator.
    - Run the following command:

    ```powershell
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
    ```

3. Run the Script:
    - Navigate to the directory where you saved f-ckit.ps1. For example, if it's on your Desktop, run:

    ```powershell
    cd 'C:\Users\YourUsername\Desktop'
    .\f-ckit.ps1
    ```

4. Follow the on-screen instructions:
    - The script will scan your system for Spyrix-related executables, kill running processes, run uninstallers, and remove folders associated with Spyrix.

## Troubleshooting
- Execution Policy Errors:
    - If you encounter errors regarding execution policies, you can use the Set-ExecutionPolicy command shown above to temporarily allow scripts to run in your session.

## License

This project is released into the public domain under the [Unlicense](http://unlicense.org/).

