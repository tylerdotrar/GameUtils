# Toggle Elden Ring Mods
function Elden-Mods ([switch]$Status, [switch]$Enable, [switch]$Disable) {

    $ModsEnabled  = ($PSCommandPath).Replace('Elden-Mods.ps1','dinput8.dll')
    $ModsDisabled = ($PSCommandPath).Replace('Elden-Mods.ps1','mods\dinput8.dll')
    
    $AreEnabled  = Test-Path -LiteralPath $ModsEnabled
    $AreDisabled = Test-Path -LiteralPath $ModsDisabled
	
	if ($Status) {
        
        Write-Host "ELDEN RING Directory : " -ForegroundColor Yellow -NoNewline ; $PSCommandPath.Replace('\Elden-Mods.ps1','')
        Write-Host "Current Mod Status   : " -ForegroundColor Yellow -NoNewline

        if ($AreEnabled)      { Write-Host 'MODS ARE ENABLED ' -ForegroundColor Green }
        elseif ($AreDisabled) { Write-Host 'MODS ARE DISABLED ' -ForegroundColor Red  }

        return
	}
    if ($Enable) {
        
        if ($AreEnabled) { Write-Host 'Mod support is already enabled.' -ForegroundColor Yellow }
        elseif ($AreDisabled) {
            Move-Item -LiteralPath $ModsDisabled $ModsEnabled
            Write-Host 'MODS ARE NOW ENABLED ' -ForegroundColor Green -NoNewline
            Write-Host '-- Run the game in offline mode due to Anti-Cheat.'
        }
        else { Write-host "ERROR! Required 'dinput8.dll' not found." -ForegroundColor Yellow }

        return
    }
    if ($Disable) {
        
        if ($AreDisabled) { Write-Host 'Mod support is already disabled.' -ForegroundColor Yellow }
        elseif ($AreEnabled) {
            Move-Item -LiteralPath $ModsEnabled $ModsDisabled
            Write-Host 'MODS ARE NOW DISABLED ' -ForegroundColor Red -NoNewline
            Write-Host '-- Free to run the game normally.'
        }
        else { Write-host "ERROR! Required 'dinput8.dll' not found." -ForegroundColor Yellow }

        return
    }
}