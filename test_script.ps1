# Function to get CPU information
function Get-CPUInfo {
    $cpuInfo = Get-WmiObject Win32_Processor
    Write-Host "`nCPU Information:"
    Write-Host "  Physical cores: $($cpuInfo.NumberOfCores)"
    Write-Host "  Total cores: $($cpuInfo.NumberOfLogicalProcessors)"
    Write-Host "  Max Frequency: $([math]::Round($cpuInfo.MaxClockSpeed / 1000.0, 2)) GHz"
    Write-Host "  Current Frequency: $([math]::Round((Get-Counter "\Processor Information(_Total)\% Processor Performance").CounterSamples.CookedValue / 100.0, 2)) GHz"
    Write-Host "  CPU Usage: $([math]::Round((Get-Counter "\Processor(_Total)\% Processor Time").CounterSamples.CookedValue, 2))%"
}

# Function to get memory information
function Get-MemoryInfo {
    $memoryInfo = Get-WmiObject Win32_OperatingSystem
    $totalMemory = [math]::Round($memoryInfo.TotalVisibleMemorySize / 1MB, 2)
    $freeMemory = [math]::Round($memoryInfo.FreePhysicalMemory / 1MB, 2)
    $usedMemory = $totalMemory - $freeMemory
    $memoryPercentUsed = [math]::Round(($usedMemory / $totalMemory) * 100, 2)
    Write-Host "`nMemory Information:"
    Write-Host "  Total: $totalMemory GB"
    Write-Host "  Available: $freeMemory GB"
    Write-Host "  Used: $usedMemory GB"
    Write-Host "  Percentage Used: $memoryPercentUsed%"
}

# Function to get disk information
function Get-DiskInfo {
    $diskInfo = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3"
    Write-Host "`nDisk Information:"
    foreach ($disk in $diskInfo) {
        $totalSize = [math]::Round($disk.Size / 1GB, 2)
        $freeSpace = [math]::Round($disk.FreeSpace / 1GB, 2)
        $usedSpace = $totalSize - $freeSpace
        $percentUsed = [math]::Round(($usedSpace / $totalSize) * 100, 2)
        Write-Host "  Device: $($disk.DeviceID)"
        Write-Host "    Total Size: $totalSize GB"
        Write-Host "    Used: $usedSpace GB"
        Write-Host "    Free: $freeSpace GB"
        Write-Host "    Percentage Used: $percentUsed%"
    }
}

# Function to get network information
function Get-NetworkInfo {
    $networkInfo = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }
    Write-Host "`nNetwork Information:"
    Write-Host "  Hostname: $(hostname)"
    foreach ($adapter in $networkInfo) {
        Write-Host "  Interface: $($adapter.Description)"
        Write-Host "    IP Address: $($adapter.IPAddress -join ', ')"
        Write-Host "    MAC Address: $($adapter.MACAddress)"
    }
}

# Function to get OS information
function Get-OSInfo {
    $osInfo = Get-WmiObject Win32_OperatingSystem
    Write-Host "`nOS Information:"
    Write-Host "  System: $($osInfo.Caption)"
    Write-Host "  Version: $($osInfo.Version)"
    Write-Host "  Architecture: $($osInfo.OSArchitecture)"
}

# Main function to call all the above functions
function Main {
    Get-CPUInfo
    Get-MemoryInfo
    Get-DiskInfo
    Get-NetworkInfo
    Get-OSInfo
    Write-Host "`nPress Enter to exit..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}

# Call the main function
Main