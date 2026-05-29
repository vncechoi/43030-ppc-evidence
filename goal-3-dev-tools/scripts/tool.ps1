<# tool.ps1 — basic evidence capture helper (Goal 3) #>

Write-Output "=== DATE ==="
Get-Date
Write-Output ""

Write-Output "=== SYSTEM INFO ==="
Get-ComputerInfo | Select-Object CsName, WindowsVersion, OsBuildNumber
Write-Output ""

Write-Output "=== TOP PROCESSES (CPU) ==="
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 Name, CPU, Id
