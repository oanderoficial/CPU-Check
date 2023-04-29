$StartDate = (Get-Date).AddDays(-7)
$Processes = Get-Process | Where-Object { $_.StartTime -gt $StartDate }

$CpuUsage = $Processes | Sort-Object CPU -Descending | Select-Object -First 1
$MemUsage = $Processes | Sort-Object WS -Descending | Select-Object -First 1

Write-Host "Maior consumo de CPU: $($CpuUsage.ProcessName) - $($CpuUsage.CPU) %"
Write-Host "Maior consumo de memória: $($MemUsage.ProcessName) - $($MemUsage.WorkingSet/1MB) MB"

$LogPath = "$($MyInvocation.MyCommand.Path).log"
$LogPath ="Maior consumo de CPU e memoria durante 7 Dias.log"
$LogData = "Data da execução: $(Get-Date)`nMaior consumo de CPU em 7 dias: $($CpuUsage.ProcessName) - $($CpuUsage.CPU) %`nMaior consumo de memória em 7 dias: $($MemUsage.ProcessName) - $($MemUsage.WorkingSet/1MB) MB`n"

Add-Content -Path $LogPath -Value $LogData
