# Display basic system information using PowerShell

# Function to get system information
function Get-SystemInfo {
    $os = Get-CimInstance Win32_OperatingSystem
    $cpu = Get-CimInstance Win32_Processor
    $memory = Get-CimInstance Win32_PhysicalMemory
    $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'C:'"

    [PSCustomObject]@{
        OperatingSystem = $os.Caption -as [string]
        Version = $os.Version -as [string]
        Architecture = $os.OSArchitecture -as [string]
        Manufacturer = $cpu.Manufacturer -as [string]
        Model = $cpu.Name -as [string]
        Cores = $cpu.NumberOfCores -as [int]
        TotalMemoryGB = [math]::Round(($memory.Capacity | Measure-Object -Sum).Sum / 1GB, 2)
        FreeSpaceGB = [math]::Round(($disk.FreeSpace | Measure-Object -Sum).Sum / 1GB, 2)
        TotalSpaceGB = [math]::Round(($disk.Size | Measure-Object -Sum).Sum / 1GB, 2)
    }
}

# Call the function and display the results
echo "" | Get-SystemInfo

