Clear-Host
Write-Host ""
Write-Host ""
Write-Host "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
Write-Host "Tool für HP Bios Configuration Utility"
Write-Host "---------------------------------------"
Write-Host ""
Write-Host "Version 0.0.1 | by Pascal Käsler"
Write-Host "---------------------------------------"
Write-Host ""
Write-Host ""
Write-Host "Warte auf Benutzereingabe..."
Read-Host "Drücken Sie Enter, um fortzufahren"
Clear-Host
Write-Host ""
Write-Host "Bitte den Laufwerksbuchstaben mit Doppelpunkt des Datenträgers angeben."
Write-Host ""
Write-Host ""
Write-Host ""
$Volume = Read-Host "Eingabe des Buchstaben"
Clear-Host


# Allgemeine Variablen
$IO = "IO"
$Programm = "Programm"
$QuelleSg = "C:\Settings.txt"
$QuellePw = "C:\Password.bin"
$Quelle = "C:\"
# Pfadezusammensetzungen
$FilePath = Join-Path -Path $Volume -ChildPath "$IO\"
$ProgrammPath = Join-Path -Path $Volume -ChildPath "$Programm\BIOSConfigUtility64.exe"
$ProgrammPathz = Join-Path -Path $Volume -ChildPath "$Programm\HpqPswd64.exe"

#Debug Stuff 
    #$FilePath
    #$ProgrammPath
    #$Volume
    #$Quelle
    #$QuelleSg
    #$QuellePw

Start-Sleep -Seconds 3
Clear-Host
Write-Host ""
Write-Host "-----------------------------"
Write-Host "~~~~~~~~~~~*Menü*~~~~~~~~~~~~"
Write-Host "-----------------------------"
Write-Host ""
Write-Host "1 - Get Konfig of Bios"
Write-Host ""
Write-Host "2 - Set Konfig to Bios"
Write-Host ""
Write-Host "3 - Set Password"
Write-Host ""
Write-Host ""
Write-Host "Ausgewählter Datenträger: $Volume"
Write-Host ""
Write-Host ""

$Action = Read-Host "Wählen sie"

switch ($Action) {
	"1" { Write-Host "Import der Settings wurde gestartet."
          $arguments = '/Get:"C:\Settings.txt"'
          Start-Process -FilePath $ProgrammPath -ArgumentList $arguments
          Start-Sleep -Seconds 5
		  Copy-Item -Path $QuelleSg -Destination $FilePath
		  Remove-Item -Path $QuelleSg -Force
}
	"2" { Write-Host "Export der Settings wurde gestartet"
           Copy-Item -Path $FilePath\Settings.txt -Destination $Quelle
           Copy-Item -Path $FilePath\Password.bin -Destination $Quelle
           Start-Sleep -Seconds 3
           $arguments = '/cspwdfile:"C:\Password.bin /Set:"C:\Settings.txt" /Verbose'
           Start-Process -FilePath $ProgrammPath -ArgumentList $arguments
           Start-Sleep -Seconds 15
           Remove-Item -Path $QuelleSg
           Remove-Item -Path $QuellePw
}
	default { Write-Host "Das war falsch! Probiers nochmal." }
	}