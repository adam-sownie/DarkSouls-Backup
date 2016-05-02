$ErrorActionPreference = "Stop"
$backupDir = (Join-Path $env:UserProfile Documents\dks_bk)
$darkSoulsDir = (Join-Path $env:AppData "DarkSoulsIII")
$backupNumber = 5

if(!(Test-Path $backupDir)) {
  New-Item $backupDir -Type Directory

  for($i = $backupNumber; $i -gt 0; $i--) {
    New-Item (Join-Path $backupDir $i) -Type Directory
  }
}

Remove-Item -Path (Join-Path $backupDir $backupNumber) -Recurse -Force

for($i = $backupNumber; $i -gt 1; $i--) {
  Rename-Item -Path (Join-Path $backupDir ($i - 1)) -NewName (Join-Path $backupDir $i)
}

Copy-Item $darkSoulsDir (Join-Path $backupDir 1) -Recurse

Write-Host ("DarkSouls save data was backed up to " + $backupDir) -ForeGroundColor "Green"
