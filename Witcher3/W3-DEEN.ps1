function W3-DEEN {
#.SYNOPSIS
# W3STRINGS decoding/encoding automated utility for The Witcher 3.
# ARBITRARY VERSION NUMBER:  4.0.1
# AUTHOR:  Tyler McCann (@tylerdotrar)
#
#.DESCRIPTION
# This script is essentially aimed at making the W3STRINGS encoding / 
# decoding process easier and more intuitive.  
#
# The only two prerequisites are that you download the W3STRINGS tool
# and change the value of the $W3STRINGS variable to the absolute path 
# of the 'w3strings.exe' executable on your specific system.
#
# If you're not familiar with the W3STRINGS tool, I highly recommend
# checking out the CDPR forum page explaining how to use it (links below).
#
#.LINK
# https://github.com/tylerdotrar
# https://www.nexusmods.com/witcher3/mods/4738
# https://forums.cdprojektred.com/index.php?threads/utility-strings-encoder-for-adding-new-strings-new-ids-and-keys-as-standalone-w3strings-file.62959/
# https://www.nexusmods.com/witcher3/mods/1055


    ### Set the W3STRINGS variable to the absolute path of the W3STRINGS executable on your system.
    $W3STRINGS = "X:\[i] Mods\The Witcher 3\[i] Tools\W3strings\w3strings.exe"


    # Script title.
    $Original = $Host.UI.RawUI.WindowTitle
    $Host.UI.RawUI.WindowTitle = “DEEN ── W3strings Decoding/Encoding Utility (v4.0.1)"


    # Visual formatting / bloopers.
    function Banner {
        Write-Host "
   ──────────╔╗───────────────╔═╗          ╔╗           ╔═╗──────────╔╗───
 ─────╔═══╗ ╔╝╚╗─────────────╔╝╔╝╔═══╦═══╗ ║║ ╔═══╦═╗ ╔╗╚╗╚╗─────────║║─────
 ╔╗╔╗╔╣╔═╗╠═╩╗╔╬═╦╦══╔══╦══╗╔╝╔╝ ╚╗╔╗║╔══╝ ║║ ║╔══╣║╚╗║║ ╚╗╚╗╔══╦══╦═╝╠══╦═╗
 ║╚╝╚╝╠╝╔╝║══╣║║╔╬╣╔╗║╔╗║══╣║║║   ║║║║╚══╗ ║║ ║╚══╣╔╗╚╝║  ║║║║╔═╣╔╗║╔╗║║═╣╔╝
 ╚╗╔╗╔╬╗╚╗╠══║╚╣║║║║║║╚╝╠══║║║║   ║║║║╔══╝ ║║ ║╔══╣║╚╗║║  ║║║║╚═╣╚╝║╚╝║║═╣║
  ╚╝╚╝║╚═╝╠══╩═╩╝╚╩╝╚╩═╗╠══╝╚╗╚╗ ╔╝╚╝║╚══╗ ║║ ║╚══╣║ ║║║ ╔╝╔╝╚══╩══╩══╩══╩╝
 ─────╚═══╝──────────╔═╝║────╚╗╚╗╚═══╩═══╝ ║║ ╚═══╩╝ ╚═╝╔╝╔╝────────────────
   ──────────────────╚══╝─────╚═╝          ╚╝           ╚═╝───────────────
" -ForegroundColor Yellow
 }
    function Invalid-Sleep {
        Write-Host "`n Incorrect value. Please enter a valid choice.`n" -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
    $pasta = "
 |==================================| WARNING: |=================================|
  What the fuck did you just fucking say about me, you little bitch? I'll 
  have you know I graduated top of my class in the Navy Seals, and I've been 
  involved in numerous secret raids on Al-Quaeda, and I have over 300 
  confirmed kills. I am trained in gorilla warfare and I'm the top sniper in 
  the entire US armed forces. You are nothing to me but just another target. I 
  will wipe you the fuck out with precision the likes of which has never been 
  seen before on this Earth, mark my fucking words. You think you can get away 
  with saying that shit to me over the Internet? Think again, fucker. As we 
  speak I am contacting my secret network of spies across the USA and your IP 
  is being traced right now so you better prepare for the storm, maggot. The 
  storm that wipes out the pathetic little thing you call your life. You're 
  fucking dead, kid. I can be anywhere, anytime, and I can kill you in over 
  seven hundred ways, and that's just with my bare hands. Not only am I 
  extensively trained in unarmed combat, but I have access to the entire 
  arsenal of the United States Marine Corps and I will use it to its full 
  extent to wipe your miserable ass off the face of the continent, you little 
  shit. If only you could have known what unholy retribution your little 
  'clever' comment was about to bring down upon you, maybe you would have held 
  your fucking tongue. But you couldn't, you didn't, and now you're paying the 
  price, you goddamn idiot. I will shit fury all over you and you will drown 
  in it. You're fucking dead, kiddo.
|==================================| WARNING: |=================================|
"
    

    # Internal Functions
    function W3-Encode {

        Write-Host ""
        while ($TRUE) {
            
            Write-Host " Would you like to:" -ForegroundColor Yellow
            Write-Host "   [1] Encode a Single File   (Absolute)`n   [2] Encode Multiple Files  (Recursive)`n   [3] Go Back"
            Write-Host "`n Choice: " -NoNewLine -ForegroundColor Yellow ; $RecurseQ = Read-Host

            if ($RecurseQ -eq 1) {

                Write-Host ""
                while ($True) {

                    Write-Host " Please enter the ABSOLUTE PATH of the specific `'.csv`' file you want to encode."
                    Write-Host " Value: " -NoNewline -ForegroundColor Yellow ; $Target = Read-Host

                    if (($Target -like "*.csv") -and (Test-Path -LiteralPath "$Target")) {
                        Write-Host ""
                        $FormatTarget = $Target
                        break
                    }
                    elseif ( (Test-Path -LiteralPath "$Target") -and !($Target -like "*.csv" ) ) { # Start new
                        Write-Host "`n The value entered is not a '.csv' file. Please enter a valid choice.`n" -ForegroundColor Yellow
                        Start-Sleep -Milliseconds 500
                    }
                    elseif ( !(Test-Path -LiteralPath "$Target") -and ($Target -like "*.csv" ) ) {
                        Write-Host "`n The '.csv' file entered does not exist. Please enter a valid choice.`n" -ForegroundColor Yellow
                        Start-Sleep -Milliseconds 500
                    } # End new
                    else {
                        Invalid-Sleep
                    }
                }
                break
            }
            elseif ($RecurseQ -eq 2) {

                Write-Host ""
                while ($TRUE) {

                    Write-Host " Please enter the ABSOLUTE PATH of the DIRECTORY you wish to parse through for `'.csv`' files."
                    Write-Host " Value: " -NoNewline -ForegroundColor Yellow ; $TargetDir = Read-Host

                    if (Test-Path -LiteralPath "$TargetDir") {
                        $Targets = @() #V3
                        $Targets += (Get-ChildItem "*.csv"-LiteralPath "$TargetDir" -Recurse).FullName #V3 changed '=' to '+='
                        $FormatTarget = $TargetDir + '\..\*.csv'
                        break
                    }
                    else {
                        #Invalid-Sleep
                        Write-Host "`n The absolute path entered does not exist. Please enter a valid choice.`n" -ForegroundColor Yellow
                        Start-Sleep -Milliseconds 500
                    }
                }
                Write-Host ""
                break       
            }
            elseif ($RecurseQ -eq 3) {
                Write-Host ""
                break
            }
            else { Invalid-Sleep }  
        }

        if ($RecurseQ -eq 3) { break }

        # VERSION 3 STARTS HERE
        if ($RecurseQ -eq 1) {
            $IDspace = (Get-Content -LiteralPath $Target | Select-String -Pattern "211\d{4}" | % { $_.Matches } | Select-Object -First 1 ).value
            $IDspace = (echo $IDspace).replace("211","")
            Write-Host " The detected ID-space for the file is:"
        }
        elseif ($RecurseQ -eq 2) {
            $IDspace = (Get-Content -LiteralPath $Targets[0] | Select-String -Pattern "211\d{4}" | % { $_.Matches } | Select-Object -First 1 ).value
            $IDspace = (echo $IDspace).replace("211","")
            Write-Host " The detected ID-space for the file(s) in the selected directory is:"
        }

        Write-Host "   $IDspace`n" -ForegroundColor Yellow

        while ($TRUE) {

            Write-Host " Would you like to:" -ForegroundColor Yellow
            Write-Host "   [1] Use this ID-space`n   [2] Manually enter an ID-space`n   [3] Force ignore ID-space check"
            Write-Host "`n Choice: " -NoNewLine -ForegroundColor Yellow ; $V3tempQ = Read-Host

            if (($V3tempQ -eq 1) -or ($V3tempQ -eq 2) -or ($V3tempQ -eq 3)) {
                Write-Host ""
                break
            }
            else { Invalid-Sleep }
        }
        # VERSION 3 ENDS HERE

        if ($V3tempQ -eq "2") { #V3

            while ($TRUE) {

                Write-Host " Please enter a valid FOUR-DIGIT number for the ID-space."
                Write-Host " Note: if you enter a number that's four-digits, but NOT the proper ID-space for the file(s), encoding will fail." -ForegroundColor Red
                Write-Host "`n Value: " -NoNewline -ForegroundColor Yellow ; $IDspace = Read-Host

                if ($IDspace -match '^\d{4}$') {
                    Write-Host ""
                    break
                }
                else { Invalid-Sleep }
            } 
        } # V3

        while ($TRUE) {
            
            Write-Host " Would you like to choose a custom output directory?" -ForegroundColor Yellow
            Write-Host "   [1] Yes`n   [2] No"
            Write-Host "`n Choice: " -NoNewLine -ForegroundColor Yellow ; $OutputQ = Read-Host

            if ($OutputQ -eq 1) {

                Write-Host " Please enter the ABSOLUTE PATH of the DIRECTORY you wish to parse through for `'.csv`' files."
                Write-Host " Value: " -NoNewline -ForegroundColor Yellow ; $TargetDir = Read-Host

                $ReqOutput = Read-Host "`n Please enter your desired OUTPUT DIRECTORY.`n Value"

                if ($RecurseQ -eq 1) {

                    $ReqFile=(Get-ChildItem -LiteralPath $Target).Name
                    $OutputDir = $ReqOutput + "\" + $ReqFile
                    $Target = [Management.Automation.WildcardPattern]::Escape($Target)

                    if (Test-Path -LiteralPath "$ReqOutput") {
                        Copy-Item -Path $Target -Destination $OutputDir
                    }
                    else {
                        New-Item -Path "$ReqOutput" -ItemType Directory | Out-Null
                        Copy-Item -Path $Target -Destination $OutputDir
                    }
                }
                elseif ($RecurseQ -eq 2) {

                    $NewTarget = @()
                    foreach ($item in $Targets) {

                        $ReqTarget = $item -ireplace [regex]::Escape($TargetDir),$ReqOutput
                        $ReqName = (Get-ChildItem -LiteralPath "$item").Name
                        $ReqNameFinal = ($ReqTarget).Replace($ReqName,"")
                        $ReqPath = $ReqNameFinal -replace ".$"
                        $NewTarget += $ReqTarget
                        $item = [Management.Automation.WildcardPattern]::Escape($item)

                        if (Test-Path -LiteralPath "$ReqPath") {
                            Copy-Item -Path $item -Destination $ReqTarget
                        }
                        else {
                            New-Item -Path $ReqPath -ItemType Directory | Out-Null
                            Copy-Item -Path $item -Destination $ReqTarget
                        }
                    }
                }
                break
            }
            elseif ($OutputQ -eq 2) {

                if ($RecurseQ -eq 1) {
                    $ReqNameFull = (Get-ChildItem -LiteralPath "$Target").Fullname
                    $ReqName = (Get-ChildItem -LiteralPath "$Target").Name
                    $ReqNameFinal = ($ReqNameFull).Replace($ReqName,"")
                    $TempPath = $ReqNameFinal -replace ".$"
                }
                elseif ($RecurseQ -eq "2") { $TempPath = $TargetDir }
                break
            }
            else { Invalid-Sleep }

        }

        Write-Host "`n [START FUNCTION]" -ForegroundColor Green
        Write-Host "`n Pseudo-command being run:"
        if ($V3tempQ -eq 3) { Write-Host "   $W3STRINGS --encode `"$FormatTarget`" --force-ignore-id-space-check-i-know-what-i-am-doing" -ForegroundColor Yellow }
        else { Write-Host "   $W3STRINGS --encode `"$FormatTarget`" --id-space `"$IDspace`"" -ForegroundColor Yellow }
        
        $encoding = "Success"

        if ($RecurseQ -eq 1) {

            if ($OutputQ -eq 1) {
                
                Write-Host "`n Redirecting output to:"
                Write-Host "   $ReqOutput" -ForegroundColor Yellow
                Write-Host "`n Encoding ..."
                
                if ($V3tempQ) { Start-Process -FilePath $W3STRINGS -ArgumentList "--encode","`"$OutputDir`"","--force-ignore-id-space-check-i-know-what-i-am-doing" }
                else { Start-Process -FilePath $W3STRINGS -ArgumentList "--encode","`"$OutputDir`"","--id-space","$IDspace" }
                
                Start-Sleep -Milliseconds 500
                $TestDir = $OutputDir + ".w3strings"
                if (Test-Path -LiteralPath "$TestDir"){
                    Write-host "   DONE" -ForegroundColor Yellow
                    Write-Host "`n Removing the copied `'.csv`' file(s) ..."
                    Start-Sleep -Milliseconds 500
                    Get-ChildItem -LiteralPath "$ReqOutput" "*.csv" -Recurse | foreach { Remove-Item -LiteralPath $_.FullName}
                    Write-Host "   DONE" -ForegroundColor Yellow
                }
                else {
                    Write-Host "   FAILED" -ForegroundColor Red
                    $encoding = "Failed"
                }
            }

            elseif ($OutputQ -eq 2) {

                Write-Host "`n Encoding ..."

                if ($V3tempQ) { Start-Process -FilePath $W3STRINGS -ArgumentList "--encode","`"$Target`"","--force-ignore-id-space-check-i-know-what-i-am-doing" }
                else { Start-Process -FilePath $W3STRINGS -ArgumentList "--encode","`"$Target`"","--id-space","$IDspace" }

                Start-Sleep -Milliseconds 500
                $TestDir = $Target + ".w3strings"

                if (Test-Path -LiteralPath "$TestDir"){ Write-host "   DONE" -ForegroundColor Yellow }
                else {
                    Write-Host "   FAILED" -ForegroundColor Red
                    $encoding = "Failed"
                }
            }
        }

        elseif ($RecurseQ -eq 2) {

            if ($OutputQ -eq 1) {

                Write-Host "`n Redirecting output to:"
                Write-Host "   $ReqOutput" -ForegroundColor Yellow
                Write-Host "`n Encoding ..."

                $TestTargets = @()
                foreach ($thing in $NewTarget) {
                    Start-Process -FilePath $W3STRINGS -ArgumentList "--encode","`"$thing`"","--id-space","$IDspace"
                    $TestTargets += $thing + ".w3strings"
                }
                Start-Sleep -Milliseconds 500

                $increment = 0
                foreach ($dude in $TestTargets) {
                    if (-not (Test-Path -LiteralPath "$dude")) {
                        $increment += 1
                    }
                }

                if ($increment -eq 0) {
                    Write-host "   DONE" -ForegroundColor Yellow
                    Write-Host "`n Removing the copied `'.csv`' file(s) ..."
                    Start-Sleep -Milliseconds 500
                    Get-ChildItem -LiteralPath "$ReqOutput" "*.csv" -Recurse | foreach { Remove-Item -LiteralPath $_.FullName}
                    Write-host "   DONE" -ForegroundColor Yellow
                }

                else {
                    Write-Host "   FAILED" -ForegroundColor Red
                    $encoding = "Failed"
                }

            }

            elseif ($OutputQ -eq 2) {

                Write-Host "`n Encoding ..."
                $TestTargets = @()

                foreach ($i in $Targets) {
                    Start-Process -FilePath $W3STRINGS -ArgumentList "--encode","`"$i`"","--id-space","$IDspace"
                    $TestTargets += $i + ".w3strings"
                }
                Start-Sleep -Milliseconds 500

                $increment = 0
                foreach ($dude in $TestTargets) {
                    if (-not (Test-Path -LiteralPath "$dude")) {
                        $increment += 1 }
                }

                if ($increment -eq 0) { Write-Host "   DONE" -ForegroundColor Yellow }
                else {
                    Write-Host "   FAILED" -ForegroundColor Red
                    $encoding = "Failed"
                }
             }
        }    

        if ($encoding -eq "Success") {

            Write-Host ""
            while ($TRUE) {

                Write-Host " Would you like to remove the generated `'.w3strings.ws`' file(s)?" -ForegroundColor Yellow
                Write-Host "   [1] Yes`n   [2] No"
                Write-Host "`n Choice: " -NoNewLine -ForegroundColor Yellow ; $RemoveQ = Read-Host

                if ($RemoveQ -eq 1) {

                    Write-Host "`n Removing the generated `'.w3strings.ws`' file(s) ..." 
                    if ($ReqPath) { Get-ChildItem -LiteralPath $ReqOutput "*.w3strings.ws" -Recurse | foreach { Remove-Item -LiteralPath $_.FullName} }
                    else { Get-ChildItem -LiteralPath $TempPath "*.w3strings.ws" -Recurse | foreach { Remove-Item -LiteralPath $_.FullName} }
                    
                    Start-Sleep -Milliseconds 500
                    Write-Host "   DONE" -ForegroundColor Yellow
                    break
                }
                elseif ($RemoveQ -eq 2) { break }
                else { Invalid-Sleep }
            }

            Write-Host ""
            while ($TRUE) {
                

                Write-Host " Would you like to rename the encoded file(s) to the proper format?" -ForegroundColor Yellow
                Write-Host " Example: `"en.w3strings.csv.w3strings`"  -->  `"en.w3strings`"`n   [1] Yes`n   [2] No"
                Write-host "`n Choice: " -NoNewline -ForegroundColor Yellow ; $RenameQ = Read-Host

                if ($RenameQ -eq 1) {

                    Write-Host "`n Renaming the generated `'.w3strings`' file(s) ..."
                    if ($OutputQ -eq "1") {
                        Get-ChildItem -LiteralPath $ReqOutput "*.w3strings" -Recurse | foreach { Rename-Item -LiteralPath $_.FullName -NewName $_.Name.replace(".w3strings.csv","")}
                    }

                    elseif ($OutputQ -eq 2) { 
                        Get-ChildItem -LiteralPath $TempPath "*.w3strings" -Recurse | foreach { Rename-Item -LiteralPath $_.FullName -NewName $_.Name.replace(".w3strings.csv","")}
                    }

                    Start-Sleep -Milliseconds 500
                    Write-Host "   DONE" -ForegroundColor Yellow
                    break
                }
                elseif ($RenameQ -eq 2) { break }
                else { Invalid-Sleep }
            } 
        }

        Write-Host "`n [END FUNCTION]`n" -ForegroundColor Green
    }
    function W3-Decode {

        Write-Host ""
        while ($TRUE) {
            
            Write-Host " Would you like to:" -ForegroundColor Yellow
            Write-Host "   [1] Decode a Single File   (Absolute)`n   [2] Decode Multiple Files  (Recursive)`n   [3] Go Back"
            Write-Host "`n Choice: " -NoNewLine -ForegroundColor Yellow ; $RecurseQ = Read-Host

            if ($RecurseQ -eq 1) {

                Write-Host ""
                while ($True) {

                    Write-Host " Please enter the ABSOLUTE PATH of the specific `'.w3strings`' file you want to decode."
                    Write-Host " Value: " -NoNewline -ForegroundColor Yellow ; $Target = Read-Host

                    if (($Target -like "*.w3strings") -and (Test-Path -LiteralPath "$Target")) {
                        Write-Host ""
                        $FormatTarget = $Target
                        break
                    }
                    elseif ( (Test-Path -LiteralPath "$Target") -and !($Target -like "*.w3strings" ) ) {
                        Write-Host "`n The value entered is not a '.w3strings' file. Please enter a valid choice.`n" -ForegroundColor Yellow
                        Start-Sleep -Milliseconds 500
                    }
                    elseif ( !(Test-Path -LiteralPath "$Target") -and ($Target -like "*.w3strings" ) ) {
                        Write-Host "`n The '.w3strings' file entered does not exist. Please enter a valid choice.`n" -ForegroundColor Yellow
                        Start-Sleep -Milliseconds 500
                    }
                    else {
                        Invalid-Sleep
                    }
                }
                break
            }

            elseif ($RecurseQ -eq 2) {

                Write-Host ""
                while ($TRUE) {
                    
                    Write-Host " Please enter the ABSOLUTE PATH of the DIRECTORY you wish to parse through for `'.w3strings`' files."
                    Write-Host " Value: " -NoNewline -ForegroundColor Yellow ; $TargetDir = Read-Host

                    if (Test-Path -LiteralPath "$TargetDir") {
                        $Targets = (Get-ChildItem "*.w3strings"-LiteralPath "$TargetDir" -Recurse).FullName
                        $FormatTarget = $TargetDir + '\..\*.w3strings'
                        break
                    }
                    else {
                        Write-Host "`n The absolute path entered does not exist. Please enter a valid choice.`n" -ForegroundColor Yellow
                        Start-Sleep -Milliseconds 500
                    }
                }
                Write-Host ""
                break       
            }

            elseif ($RecurseQ -eq 3) {
                Write-Host ""
                break
            }
            else { Invalid-Sleep }  
        }

        if ($RecurseQ -eq 3) { break }

        while ($TRUE) {
            
            Write-Host " Would you like to choose a custom output directory?" -ForegroundColor Yellow
            Write-Host "   [1] Yes`n   [2] No"
            Write-Host "`n Choice: " -NoNewLine -ForegroundColor Yellow ; $OutputQ = Read-Host

            if ($OutputQ -eq 1) {
                
                Write-Host "`n Please enter your desired OUTPUT DIRECTORY."
                Write-Host " Value: " -NoNewline -ForegroundColor Yellow ; $ReqOutput = Read-Host

                if ($RecurseQ -eq 1) {

                    $ReqFile=(Get-ChildItem -LiteralPath $Target).Name
                    $OutputDir = $ReqOutput + "\" + $ReqFile
                    $Target = [Management.Automation.WildcardPattern]::Escape($Target)

                    if (Test-Path -LiteralPath "$ReqOutput") {
                        Copy-Item -Path $Target -Destination $OutputDir
                    }
                    else {
                        New-Item -Path "$ReqOutput" -ItemType Directory | Out-Null
                        Copy-Item -Path $Target -Destination $OutputDir
                    }
                }
                elseif ($RecurseQ -eq 2) {

                    $NewTarget = @()
                    foreach ($item in $Targets) {
                        $ReqTarget = $item -ireplace [regex]::Escape($TargetDir),$ReqOutput
                        $ReqName = (Get-ChildItem -LiteralPath "$item").Name
                        $ReqNameFinal = ($ReqTarget).Replace($ReqName,"")
                        $ReqPath = $ReqNameFinal -replace ".$"
                        $NewTarget += $ReqTarget
                        $item = [Management.Automation.WildcardPattern]::Escape($item)

                        if (Test-Path -LiteralPath "$ReqPath") {
                            Copy-Item -Path $item -Destination $ReqTarget
                        }
                        else {
                            New-Item -Path $ReqPath -ItemType Directory | Out-Null
                            Copy-Item -Path $item -Destination $ReqTarget
                        }
                    }
                }
                break
            }
            elseif ($OutputQ -eq 2) {

                if ($RecurseQ -eq 1) {

                    $ReqNameFull = (Get-ChildItem -LiteralPath "$Target").Fullname
                    $ReqName = (Get-ChildItem -LiteralPath "$Target").Name
                    $ReqNameFinal = ($ReqNameFull).Replace($ReqName,"")
                    $TempPath = $ReqNameFinal -replace ".$"
                }
                elseif ($RecurseQ -eq 2) { $TempPath = $TargetDir }

                break
            }
            else { Invalid-Sleep }
        }

        Write-Host "`n [START FUNCTION]" -ForegroundColor Green
        Write-Host "`n Pseudo-command being run:"
        Write-Host "   $W3STRINGS --decode `"$FormatTarget`"" -ForegroundColor Yellow

        if ($RecurseQ -eq 1) {

            if ($OutputQ -eq 1) {
                Write-Host "`n Redirecting output to:"
                Write-Host "   $ReqOutput" -ForegroundColor Yellow
                Write-Host "`n Decoding ..."

                Start-Process -FilePath $W3STRINGS -ArgumentList "--decode","`"$OutputDir`""
                Start-Sleep -Milliseconds 500
                $TestDir = $OutputDir + ".csv"

                if (Test-Path -LiteralPath "$TestDir"){
                    Write-host "   DONE" -ForegroundColor Yellow
                    Write-Host "`n Removing the copied `'.w3strings`' file(s) ..."
                    Start-Sleep -Milliseconds 500
                    Get-ChildItem -LiteralPath "$ReqOutput" "*.w3strings" -Recurse | foreach { Remove-Item -LiteralPath $_.FullName}
                    Write-Host "   DONE" -ForegroundColor Yellow
                }
                else {
                    Write-Host "   FAILED" -ForegroundColor Red
                }
            }
            elseif ($OutputQ -eq 2) {

                Write-Host "`n Decoding ..."
                Start-Process -FilePath $W3STRINGS -ArgumentList "--decode","`"$Target`"" 2>$NULL
                Start-Sleep -Milliseconds 500

                $TestDir = $Target + ".csv"
                if (Test-Path -LiteralPath "$TestDir"){
                    Write-host "   DONE" -ForegroundColor Yellow
                }
                else { Write-Host "   FAILED" -ForegroundColor Red }
             }
        }
        elseif ($RecurseQ -eq 2) {

            if ($OutputQ -eq 1) {

                Write-Host "`n Redirecting output to:"
                Write-Host "   $ReqOutput" -ForegroundColor Yellow
                Write-Host "`n Decoding ..."

                $TestTargets = @()
                foreach ($thing in $NewTarget) {
                    Start-Process -FilePath $W3STRINGS -ArgumentList "--decode","`"$thing`""
                    $TestTargets += $thing + ".csv"
                }
                Start-Sleep -Milliseconds 500

                $increment = 0
                foreach ($dude in $TestTargets) {
                    if (-not (Test-Path -LiteralPath "$dude")) {
                        $increment += 1 }
                    }
                if ($increment -eq 0) {
                    Write-host "   DONE" -ForegroundColor Yellow
                    Write-Host "`n Removing the copied `'.w3strings`' file(s) ..."
                    Start-Sleep -Milliseconds 500
                    Get-ChildItem -LiteralPath "$ReqOutput" "*.w3strings" -Recurse | foreach { Remove-Item -LiteralPath $_.FullName}
                    Write-host "   DONE" -ForegroundColor Yellow
                }
                else {
                    Write-Host "   FAILED" -ForegroundColor Red
                }
            }

            elseif ($OutputQ -eq 2) {
                Write-Host "`n Decoding ..."
                $TestTargets = @()
                foreach ($i in $Targets) {
                    Start-Process -FilePath $W3STRINGS -ArgumentList "--decode","`"$i`""
                    $TestTargets += $i + ".csv"
                }
                Start-Sleep -Milliseconds 500
                $increment = 0
                foreach ($dude in $TestTargets) {
                    if (-not (Test-Path -LiteralPath "$dude")) {
                        $increment += 1 }
                }
                if ($increment -eq 0) {
                      Write-Host "   DONE" -ForegroundColor Yellow          
                }
                else {
                    Write-Host "   FAILED" -ForegroundColor Red
                }
            }
        }

        Write-Host "`n [END FUNCTION]`n" -ForegroundColor Green
    }


    $MainMenu = $TRUE
    while ($MainMenu) {

        # Main functionality
        while ($TRUE) {
            
            Clear-Host
            Banner

            Write-Host " Would you like to:" -ForegroundColor Yellow
            Write-Host "   [1] Encode`n   [2] Decode`n   [3] Exit"
            Write-Host "`n Choice: " -NoNewLine -ForegroundColor Yellow ; $Decision1 = Read-Host

            if ($Decision1 -eq 1) {
                W3-Encode
                break
            }

            elseif ($Decision1 -eq 2) {
                W3-Decode
                break
            }

            elseif ($Decision1 -eq 3) {
                $MainMenu = $FALSE
                break
            }

            else { Invalid-Sleep }
        }

        # Exit or start over
        if ( ($Decision1 -eq 1) -or ($Decision1 -eq 2) ) {

            while ($TRUE) {
                
                Write-Host " Would you like to:" -ForegroundColor Yellow
                Write-Host "   [1] Start over`n   [2] Exit"
                Write-Host "`n Choice: " -NoNewLine -ForegroundColor Yellow ; $Decision2 = Read-Host

                if ($Decision2 -eq 1) { break }

                elseif ($Decision2 -eq 2) {
                    $MainMenu = $FALSE
                    break
                }

                elseif ($decision2 -eq "fuck you") {
	                Write-Host $pasta -ForegroundColor Red
                    Start-Sleep -Milliseconds 500
                }

                else { Invalid-Sleep }
            }
        }
    }

    # Return Original Window Title
    $Host.UI.RawUI.WindowTitle = $Original
    Clear-Host
}

W3-DEEN