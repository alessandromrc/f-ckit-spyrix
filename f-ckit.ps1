$identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object System.Security.Principal.WindowsPrincipal($identity)

if (-not $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "`n[INFO] Requesting administrative privileges..."
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$baseFolder = "C:\ProgramData"
$spywareDetected = $false

function Run-Uninstaller($uninstallerPath) {
    Write-Host "[INFO] Running uninstaller: $uninstallerPath"
    Start-Process -FilePath $uninstallerPath -Wait -ErrorAction SilentlyContinue
    Write-Host "[SUCCESS] Uninstaller executed for: $uninstallerPath"
}

function Kill-SpywareProcess($spywareName) {
    Write-Host "[INFO] Checking if $spywareName is running..."
    $runningProcesses = Get-Process -Name $spywareName -ErrorAction SilentlyContinue
    if ($runningProcesses) {
        Write-Host "[WARNING] $spywareName is running. Terminating process..."
        $runningProcesses | Stop-Process -Force -ErrorAction SilentlyContinue
        Write-Host "[SUCCESS] $spywareName process terminated."
        return $true
    }
    return $false
}

Write-Host "[INFO] Searching for known Spyrix spyware (spm.exe, spkl.exe, sem.exe) in $baseFolder and subdirectories..."

Get-ChildItem -Path $baseFolder -Recurse -Filter "spm.exe" -ErrorAction SilentlyContinue | ForEach-Object {
    $uninstaller = Join-Path $_.DirectoryName "unins000.exe"
    if (Test-Path $uninstaller) {
        Run-Uninstaller $uninstaller
        $spywareDetected = $true
    }
}

Get-ChildItem -Path $baseFolder -Recurse -Filter "spkl.exe" -ErrorAction SilentlyContinue | ForEach-Object {
    $uninstaller = Join-Path $_.DirectoryName "unins000.exe"
    if (Test-Path $uninstaller) {
        Run-Uninstaller $uninstaller
        $spywareDetected = $true
    }
}

Get-ChildItem -Path $baseFolder -Recurse -Filter "sem.exe" -ErrorAction SilentlyContinue | ForEach-Object {
    $uninstaller = Join-Path $_.DirectoryName "unins000.exe"
    if (Test-Path $uninstaller) {
        Run-Uninstaller $uninstaller
        $spywareDetected = $true
    }
}

if (Test-Path "C:\ProgramData\Security Monitor") {
    Write-Host "[INFO] Folder 'Security Monitor' found. Verifying if Spyrix spyware processes are still active..."

    $spywareProcesses = @("spm", "spkl", "sem")
    $spywareRunning = $false

    foreach ($processName in $spywareProcesses) {
        $running = Kill-SpywareProcess $processName
        if ($running) {
            $spywareRunning = $true
        }
    }

    if (-not $spywareRunning) {
        Write-Host "[SUCCESS] No Spyrix spyware detected running. Deleting folder 'Security Monitor'..."
        Remove-Item -Path "C:\ProgramData\Security Monitor" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "[SUCCESS] Folder 'Security Monitor' and its contents successfully deleted."
        $spywareDetected = $true
    } else {
        Write-Host "[INFO] Folder 'Security Monitor' retained due to active Spyrix spyware."
    }
} else {
    Write-Host "[INFO] Folder 'Security Monitor' does not exist."
}

if ($spywareDetected) {
    Write-Host "`n[ALERT] Spyrix spyware has been detected and removed from your system."
    Write-Host "[INFO] For further protection, it is recommended to use Malwarebytes for a full system scan."
} else {
    Write-Host "`n[INFO] Your system appears to be clean from Spyrix spyware."
}

Write-Host "`nOperation completed. Press any key to exit..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
