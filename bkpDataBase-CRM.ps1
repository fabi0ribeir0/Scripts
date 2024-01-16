$ativyPath = "\\10.120.21.211\backup"
$bkpPath = "Z:\BKPFULL"
$bkpDestination = "D:\Compactar\"
$rclonePath = "C:\rclone\rclone.exe"
$config = "progress --retries-sleep 1m --retries 30"
$apiKey = "umsry2z8hmlpo90"
$crmPath = "CRM:/BackUp_Ativy/"
$logPath = "D:\Logbkp\Log.txt"
$data = Get-date -DisplayHint Date

If (!(Test-Path Z:))
{
    $map = new-object -ComObject WScript.Network
    $map.MapNetworkDrive("Z:", $ativyPath, $true, "ativy\medicalway_adm", "/ri{qVtikDN*")
}

&"$rclonepath" copy "$bkpPath" $bkpDestination --progress --retries-sleep 1m --retries 30

$rcloneResult = &"$rclonePath" check "$bkpPath" "$bkpDestination" --size-only 2>&1
										
if($LASTEXITCODE -ne 0 -or $rcloneResult -match "ERROR") 
{
    Invoke-WebRequest -uri "https://alertzy.app/send?accountKey=umsry2z8hmlpo90&title=BKP&message=ERRO"

    $errorInfo = "`nErro encontrado:`n$rcloneResult"
    Add-Content -Path "D:\Logbkp\Log.txt" -Value $errorInfo
}
else 
{
    &"$rclonepath" copy "$bkpDestination" $crmPath --progress --retries-sleep 1m --retries 30
    Add-Content -Path "D:\Logbkp\Log.txt" -Value "`nBKP Completo $data"
}

Exit