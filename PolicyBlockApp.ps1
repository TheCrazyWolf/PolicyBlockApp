# Получить список всех SID из HKEY_USERS, исключая специальные учетные записи
$SIDs = Get-ChildItem "Registry::HKEY_USERS" | Where-Object {
    $_.Name -notmatch "^(S-1-5-(18|19|20)|\.DEFAULT)$"
}

# Применить параметры для каждого SID
foreach ($SID in $SIDs) {
    $baseKey = "Registry::HKEY_USERS\$($SID.PSChildName)\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
    New-Item -Path $baseKey -Force | Out-Null
    Set-ItemProperty -Path $baseKey -Name "DisallowRun" -Value 1

    $disallowRunKey = "$baseKey\DisallowRun"
    New-Item -Path $disallowRunKey -Force | Out-Null
    Set-ItemProperty -Path $disallowRunKey -Name "Roblox1" -Value "RobloxPlayerBeta.exe"
    Set-ItemProperty -Path $disallowRunKey -Name "Roblox2" -Value "RobloxStudioInstaller.exe"
    Set-ItemProperty -Path $disallowRunKey -Name "Roblox3" -Value "RobloxPlayerLauncher.exe"
    Set-ItemProperty -Path $disallowRunKey -Name "Roblox4" -Value "RobloxStudioBeta.exe"
    Set-ItemProperty -Path $disallowRunKey -Name "TLauncher" -Value "tl.exe"
}