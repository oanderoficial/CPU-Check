# CPU-Check
Informações de qual foi o processo que mais consumiu CPU e Memória, durante 7 dias.

``` ps1 
$StartDate = (Get-Date).AddDays(-7)
$Processes = Get-Process | Where-Object { $_.StartTime -gt $StartDate }

$CpuUsage = $Processes | Sort-Object CPU -Descending | Select-Object -First 1
$MemUsage = $Processes | Sort-Object WS -Descending | Select-Object -First 1

Write-Host "Maior consumo de CPU: $($CpuUsage.ProcessName) - $($CpuUsage.CPU) %"
Write-Host "Maior consumo de memÃ³ria: $($MemUsage.ProcessName) - $($MemUsage.WorkingSet/1MB) MB"

$LogPath = "$($MyInvocation.MyCommand.Path).log"
$LogPath ="Maior consumo de CPU e memoria durante 7 Dias.log"
$LogData = "Data da execuÃ§Ã£o: $(Get-Date)`nMaior consumo de CPU em 7 dias: $($CpuUsage.ProcessName) - $($CpuUsage.CPU) %`nMaior consumo de memÃ³ria em 7 dias: $($MemUsage.ProcessName) - $($MemUsage.WorkingSet/1MB) MB`n"

Add-Content -Path $LogPath -Value $LogData
```
