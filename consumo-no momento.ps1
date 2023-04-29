[Console]::InputEncoding = [System.Text.Encoding]::GetEncoding('Windows-1252')

Clear-Host
Write-Host "---------------------------------------------"
Write-Host "SCRIPT V 0.1.0 - ANDERSON B SILVA - ANDESI3:"
Write-Host "Processos com maior consumo de CPU e memoria:"
Write-Host "---------------------------------------------"

Get-Process | Sort-Object -Property CPU,WorkingSet -Descending | Select-Object -First 10 | Format-Table Name,Id,PriorityClass,CPU,WorkingSet -AutoSize

$logFilePath = "$PSScriptRoot\processos.log"
Write-Host "Salvando log em: $logFilePath"

# Verifica se o arquivo existe
if(Test-Path -Path $logFilePath){
    Write-Host "Arquivo de log existente encontrado. Será substituído."
}

# Tenta gravar o arquivo
try {
    Get-Process | Sort-Object -Property CPU,WorkingSet -Descending | Select-Object -First 10 | Format-Table Name,Id,PriorityClass,CPU,WorkingSet | Out-File -FilePath $logFilePath -Encoding "UTF8"
    Write-Host "Log salvo com sucesso."
}
catch {
    Write-Host "Erro ao salvar o arquivo de log. Detalhes do erro:"
    Write-Host $_.Exception.Message
}

Read-Host -Prompt "Pressione Enter para continuar..."
