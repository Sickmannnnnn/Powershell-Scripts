# This script will display basic system information about the system

# Function to get system information
function Get-SystemInfo {
    $os = Get-CimInstance Win32_OperatingSystem                           #collects the powershell object 'Operating System' through the GetCim-Instance command, with the parameter specifying for the os
    $cpu = Get-CimInstance Win32_Processor                                #collects the powershell object 'Processor' through the GetCim-Instance command, with the parameter specifying for the processor
    $memory = Get-CimInstance Win32_PhysicalMemory                        #collects the powershell object 'Physical Memory' through the GetCim-Instance command, with the parameter specifying for the physical memory
    $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'C:'"   #collects the powershell object 'Logical Disk' through the GetCim-Instance command, with the parameter specifying for the logic disk, and another parameter specifying to only include information that is on the main drive

    [PSCustomObject]@{ #create a constructor for our custom object and define its attributes
        OperatingSystem = $os.Caption -as [string]      #collect the caption attribute from the os object. Casting is done to ensure compatable output
        Version = $os.Version -as [string]              #collect the version attribute from the os object
        Architecture = $os.OSArchitecture -as [string]  #collect the architecture attribute from the os object
        Manufacturer = $cpu.Manufacturer -as [string]   #collect the manufacturer attribute from the cpu object
        Model = $cpu.Name -as [string]                  #collect the name attribute from the cpu object
        Cores = $cpu.NumberOfCores -as [int]            #collect the core number attribute from the cpu object
        TotalMemoryGB = [math]::Round(($memory.Capacity | Measure-Object -Sum).Sum / 1GB, 2)   #sum the capacity attribute of the memory object and adds that sum as an attribute of memory using the Measure-Object command with the parameter Sum. It then takes the sum attribute back out using .Sum and converts this number from bytes to gigabytes by dividing it by 1GB, which is a variable representing the number of bytes in a gigabyte. Our new number is then rounded to 2 decimal places using the Round function
        FreeSpaceGB = [math]::Round(($disk.FreeSpace | Measure-Object -Sum).Sum / 1GB, 2)      #Refer to line 17
        TotalSpaceGB = [math]::Round(($disk.Size | Measure-Object -Sum).Sum / 1GB, 2)          #Refer to line 17
    }
}

# Call the function and display the results
echo "" | Get-SystemInfo

