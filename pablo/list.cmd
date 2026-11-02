@echo off
chcp 65001 >nul

:: Comprobar si el primer argumento existe y contiene SOLO dígitos
echo "%~1"| findstr /r "^\"[0-9][0-9]*\"$" >nul

if errorlevel 1 (
    :: Si no hay argumento o no es un número entero válido, equivale al listado total
    echo %cd%
    powershell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; function Show-Tree ($path, $indent='') { Get-ChildItem $path -Force | ForEach-Object { Write-Host ($indent + '├─ ' + $_.Name); if ($_.PSIsContainer) { Show-Tree $_.FullName ($indent + '│   ') } } }; Show-Tree ."
) else (
    :: Si el argumento es un número, se limita la profundidad usando un contador
    echo %cd%
    powershell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; function Show-Tree ($path, $maxDepth, $currentDepth=0, $indent='') { Get-ChildItem $path -Force | ForEach-Object { Write-Host ($indent + '├─ ' + $_.Name); if ($_.PSIsContainer -and ($currentDepth -lt $maxDepth)) { Show-Tree $_.FullName $maxDepth ($currentDepth + 1) ($indent + '│   ') } } }; Show-Tree . %~1"
)

exit /b 0
