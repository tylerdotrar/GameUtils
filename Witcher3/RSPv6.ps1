
# ARBITRARY VERSION NUMBER:  6
# AUTHOR:  PuppyUnicorn  aka Good Kid McEatAss  aka tyler.rar

<# DESCRIPTION:
This script recursively searches through specified filetypes in the selected 
directory for whatever string the user inputs.  Both the filetypes and strings
are case insensitive.  

To setup, just change the directory variables ($dir1, $dir3p2, etc) to the 
proper directories on your computer.  If you are only using this for modding
on The Witcher 3, then technically $dir1 is the only variable you need to 
change -- however I've found this script to be much more useful than expected,
so I personally recommend setting up all directories.

Also, yes, I am aware that Notepad++ has the same functionality.  However I still
made this for fun because I enjoy PowerShell and thought maybe someone would like
to use this.

To run this script, right click on "RSPv6.ps1" and choose "Run with PowerShell"
 
To run this script inside PowerShell ISE, you will need to run this command as an
Administrator first:

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

This command will allow the the currently logged on user to run scripts.
#>

<# DEFAULT FILE PATHS.  
Edit these paths to your system's preference (ending with a \ ).

Note: you should only have to edit $dir1 and $dir2 -- all of the $dir3 variables are
just for those with a second drive. Modify that one accordingly. 
#>

$dir1 = "X:\[i] Games\Steam\steamapps\common\The Witcher 3\" 
$dir2 = "C:\"
$dir3 = "X:\" # Optional for those with a second drive on their system.

$dir1p1 = $dir1 + "content\" # Shouldn't have to modify this.
$dir1p2 = $dir1 + "mods\" # ''

$dir2p1 = $dir2 + "Program Files\" # ''
$dir2p2 = $dir2 + "Program Files (x86)\" # ''
$dir2p3 = $dir2 + "Users\" # ''.
$dir2p4 = $dir2 + "Windows\" # ''

$dir3p1 = $dir3 + "[i] Games\" # Modify these directories accordingly (optional).
$dir3p2 = $dir3 + "ModCreation\" # ''
$dir3p3 = $dir3 + "WitcherResources\" # ''

# Script title.
$host.ui.RawUI.WindowTitle = “RSPv6 -- Recursive String Parser"

# Visual formatting / bloopers.
$line = "========================================================================="
$lineW = "|==================================| WARNING: |=================================|"
$pasta = "  What the fuck did you just fucking say about me, you little bitch? I'll 
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
  in it. You're fucking dead, kiddo."

# Functions contained in this script.
function Old-RSPBanner {
    Write-Host ""
    Write-Host " =========================================================================="
    Write-Host "|==========================================================================|"
    Write-Host "|============|						      |============|"
    Write-Host "|============|           RECURSIVE STRING PARSER V4.1	      |============|"
    Write-Host "|============|						      |============|"
    Write-Host "|==========================================================================|"
    Write-Host " ==========================================================================`n"
}
function New-RSPBannerV5 {
    Write-Host "
 ╔═══╗─────────────────────╔═══╗╔╗──────────╔═══╗─────────────╔╗──╔╦═══╗─╔╗
 ║╔═╗║─────────────────────║╔═╗╠╝╚╗─────────║╔═╗║─────────────║╚╗╔╝║╔══╝╔╝║
 ║╚═╝╠══╦══╦╗╔╦═╦══╦╦╗╔╦══╗║╚══╬╗╔╬═╦╦═╗╔══╗║╚═╝╠══╦═╦══╦══╦═╗╚╗║║╔╣╚══╗╚╗║
 ║╔╗╔╣║═╣╔═╣║║║╔╣══╬╣╚╝║║═╣╚══╗║║║║╔╬╣╔╗╣╔╗║║╔══╣╔╗║╔╣══╣║═╣╔╝─║╚╝║╚══╗║─║║
 ║║║╚╣║═╣╚═╣╚╝║║╠══║╠╗╔╣║═╣║╚═╝║║╚╣║║║║║║╚╝║║║──║╔╗║║╠══║║═╣║──╚╗╔╝╔══╝╠╦╝╚╗
 ╚╝╚═╩══╩══╩══╩╝╚══╩╝╚╝╚══╝╚═══╝╚═╩╝╚╩╝╚╩═╗║╚╝──╚╝╚╩╝╚══╩══╩╝───╚╝─╚═══╩╩══╝
 ───────────────────────────────────────╔═╝║
 ───────────────────────────────────────╚══╝
 " -ForegroundColor Yellow
}
function New-RSPBannerV6 {
    Write-Host "
    ─────────────────────────────────────────────────────────────────
 ╔═══╗─────────────────────╔═══╗╔╗──────────╔═══╗─────────────╔╗  ╔╦═══╗
 ║╔═╗║─────────────────────║╔═╗╠╝╚╗─────────║╔═╗║─────────────║╚╗╔╝║╔══╝
 ║╚═╝╠══╦══╦╗╔╦═╦══╦╦╗╔╦══╗║╚══╬╗╔╬═╦╦══╔══╗║╚═╝╠══╦═╦══╦══╦═╗╚╗║║╔╣╚══╗
 ║╔╗╔╣║═╣╔═╣║║║╔╣══╬╣╚╝║║═╣╚══╗║║║║╔╬╣╔╗║╔╗║║╔══╣╔╗║╔╣══╣║═╣╔╝ ║╚╝║║╔═╗║
 ║║║╚╣║═╣╚═╣╚╝║║╠══║╠╗╔╣║═╣║╚═╝║║╚╣║║║║║║╚╝║║║  ║╔╗║║╠══║║═╣║  ╚╗╔╝║╚═╝║
 ╚╝╚═╩══╩══╩══╩╝╚══╩╝╚╝╚══╝╚═══╝╚═╩╝╚╩╝╚╩═╗║╚╝  ╚╝╚╩╝╚══╩══╩╝   ╚╝ ╚═══╝
  ──────────────────────────────────────╔═╝║───────────────────────────
    ────────────────────────────────────╚══╝─────────────────────────
 " -ForegroundColor Yellow
}

function Invalid-Sleep {
    Write-Host "`n Incorrect value. Please enter a valid choice.`n" -ForegroundColor Yellow
    Start-Sleep -Milliseconds 500
}
function Use-StringParser {
$Loop = "1"
while ($Loop -eq "1") {
    while ($TRUE) {
        $decision = Read-Host " Would you like to: `n   [1] Use the default Witcher 3 directory `n   [2] Use the `'$dir2`' drive `n   [3] Use the `'$dir3`' drive `n   [4] Enter a custom directory `n`n Choice"
        if ($decision -eq "1") {
            Write-Host ""
            while ($TRUE) {
            $decision1p1 = Read-Host " Would you like to use: `n   [1] `'..\The Witcher 3\`' `n   [2] `'..\The Witcher 3\content\`' `n   [3] `'..\The Witcher 3\mods\`' `n`n Choice"
            if ($decision1p1 -eq "1") {
                $directory = "$dir1"
                break
                }
            elseif ($decision1p1 -eq "2"){
                $directory = "$dir1p1"
                break
                }
            elseif ($decision1p1 -eq "3"){
                $directory = "$dir1p2"
                break
                }
            else {
                Invalid-Sleep
                }
            }
            Write-Host ""
            break
            }
        elseif ($decision -eq "2") {
            Write-Host ""
            while ($TRUE) {
            $decision2p1 = Read-Host " Would you like to use: `n   [1] `'$dir2`'`n   [2] `'$dir2p1`'`n   [3] `'$dir2p2`'`n   [4] `'$dir2p3`'`n   [5] `'$dir2p4`'`n`n Choice"
            if ($decision2p1 -eq "1") {
                $directory = "$dir2"
                break
                }
            elseif ($decision2p1 -eq "2"){
                $directory = "$dir2p1"
                break
                }
            elseif ($decision2p1 -eq "3"){
                $directory = "$dir2p2"
                break
                }
            elseif ($decision2p1 -eq "4"){
                $directory = "$dir2p3"
                break
                }
            elseif ($decision2p1 -eq "5"){
                $directory = $dir2p4
                break
                }
            else {
                Invalid-Sleep
                }
            }
            Write-Host ""
            break
            }
        elseif ($decision -eq "3") {
            Write-Host ""
            while ($TRUE) {
            $decision3p1 = Read-Host " Would you like to use: `n   [1] `'$dir3`'`n   [2] `'$dir3p1`'`n   [3] `'$dir3p2`'`n   [4] `'$dir3p3`'`n`n Choice"
            if ($decision3p1 -eq "1") {
                $directory = "$dir3"
                break
                }
            elseif ($decision3p1 -eq "2"){
                $directory = "$dir3p1"
                break
                }
            elseif ($decision3p1 -eq "3"){
                $directory = "$dir3p2"
                break
                }
            elseif ($decision3p1 -eq "4"){
                $directory = "$dir3p3"
                break
                }
            else {
                Invalid-Sleep
                }
            }
            Write-Host ""
            break
            }
        elseif ($decision -eq "4") {
            Write-Host ""
            while ($True) { # V6 START
                $directory = Read-Host " Please enter the ABSOLUTE PATH of the DIRECTORY you wish to search through.`n Value"
                if (Test-Path -LiteralPath "$directory") {
                    Write-Host ""
                    break }
                else {
                    Write-Host "`n The directory you entered does not exist. Please enter a new value.`n" -ForegroundColor Yellow
                    Start-Sleep -Milliseconds 500
                }

            } # V6 END
            break
            }
        else {
            Invalid-Sleep 
            }
        }

    $string = Read-Host " Please enter the STRING you wish to search for.`n Value"
    if ($decision -eq "1") {
        Write-Host "`n Please enter the FILE TYPE you wish wish to parse through."
        Write-Host " Note: 'ws' is the default for Witcher 3 scripts." -ForegroundColor Yellow
        $ftype = Read-Host " Value"
        }
    else {
        $ftype = Read-Host "`n Please enter the FILE TYPE you wish to parse through.`n Value"
        }
    
    if ($ftype -like ".*") {
        $filetype = $ftype
        }
    else {
        $filetype = ".$ftype"
        }
    
    $output = (Get-ChildItem "*$filetype" -LiteralPath $directory -recurse |  Select-String -Pattern "$string" -List | Select Path) 2> $null
    
    Write-Host "`n$line"
    Write-Host " The following `'$filetype`' file(s) contain the string `'$string`':" -ForegroundColor Yellow
    Write-Host ""
    
    $targetcount = 0
    foreach ($i in $output) {
        $targetcount += 1
        if ($decision -eq "1") {
            $tget = ("$i" -Split 'common')[-1]
            $target = ".." + "$tget"
            }
        else {
	        $target = ("$i" -Split 'Path=')[-1]
            }
	    $targetv2 = ("$target" -Split '}')[0]
	    Write-Host "  $targetv2"
	    }
 
    if ($targetcount -eq "0") { #V6
    Write-Host "`n Total file count: $targetcount" -ForegroundColor Red
    }
    else { # V6
    Write-Host "`n Total file count: $targetcount" -ForegroundColor Yellow
    }
    Write-Host "$line`n"
    Start-Sleep -Milliseconds 500

    # V3 STARTS HERE
    if ($targetcount -ne "0") { # V6
    while ($TRUE) {
        $decision3 = Read-Host " View the line(s) that matched `'$string`'?`n   [1] Yes `n   [2] No`n`n Choice"
        if ($decision3 -eq "1") {
            Write-Host "`n$line`n"
            foreach ($e in $output) {
                $eee = ("$e" -Split 'Path=')[-1]
	            $path = ("$eee" -Split '}')[0]
                $filename = ("$path" -Split "\\")[-1]
                Write-Host "Filename:  `'$filename`'" -ForegroundColor Yellow
		        # The foreach here replaces all the tabs with spaces, making the output easier to read.
                Get-Content -LiteralPath $path | foreach {$_ -Replace ("`t", " ")} | Select-String -Pattern $string | Format-Table -Property LineNumber, Line -Wrap
                }
            Write-Host "$line"
            break
            }
        elseif ($decision3 -eq "2") {
            break
            }
        else {
            Invalid-Sleep
            }
        }
    Write-Host ""
    Start-Sleep -Milliseconds 500
    } # v6

    # V3 ENDS HERE


    while ($TRUE) {
        $decision2 = Read-Host " Would you like to: `n   [1] Start over`n   [2] Exit`n`n Choice"
        if ($decision2 -eq "1") {
            Write-Host ""
            Start-Sleep -Milliseconds 500
            break
            }
        elseif ($decision2 -eq "2") {
            Write-Host ""
            $Loop = "0"
            break
            }
        elseif ($decision2 -eq "fuck you") {
            Write-Host "`n$lineW`n" -ForegroundColor Red # V6
	        Write-Host "$pasta" -ForegroundColor Red # V6
	        Write-Host "`n$lineW`n" -ForegroundColor Red # V6
            Start-Sleep -Milliseconds 500
            }
        else {
            Invalid-Sleep 
            }
        }
    }
}

# The actual functions being used when you run the script.
New-RSPBannerV6
Use-StringParser
