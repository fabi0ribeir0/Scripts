@echo off & setlocal
set batchPath=%~dp0
powershell.exe -noexit -file "%batchPath%bkpDataBase-CRM.ps1"
exit