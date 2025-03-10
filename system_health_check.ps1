# System Health Check Script for IT Support
Write-Host "Starting System Health Check..." -ForegroundColor Green

# Check Disk Space
$disk = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used -ne $null }
$disk | Format-Table Name, @{Label="Used(GB)"; Expression={[math]::round($_.Used/1GB,2)}}, @{Label="Free(GB)"; Expression={[math]::round($_.Free/1GB,2)}}

# Check CPU Usage
$cpu = Get-WmiObject Win32_Processor | Select-Object LoadPercentage
Write-Host "Current CPU Usage: $($cpu.LoadPercentage)%" -ForegroundColor Yellow

# Check Windows Update Status
$update = Get-WmiObject -Query "Select * from Win32_QuickFixEngineering"
Write-Host "Last Windows Update Installed: $($update[-1].InstalledOn)" -ForegroundColor Cyan

# Check Antivirus Status (Defender)
$antivirus = Get-MpComputerStatus | Select-Object AMRunningMode
Write-Host "Antivirus Status: $($antivirus.AMRunningMode)" -ForegroundColor Green

Write-Host "System Health Check Completed!" -ForegroundColor Green
