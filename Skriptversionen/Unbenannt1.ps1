Write-Host ""
Write-Host "Bitte den Laufwerksbuchstaben mit Doppelpunkt des Datenträgers angeben."
Write-Host ""
$Volume = Read-Host "Laufwerk"


$IO = "IO"
$Programm = "Programm"
$QuelleSg = "C:\Settings.txt"
$QuellePw = "C:\Password.bin"
$Quelle = "C:\"

$FilePath = Join-Path -Path $Volume -ChildPath "$IO\"
$ProgrammPath = Join-Path -Path $Volume -ChildPath "$Programm\BIOSConfigUtility64.exe"
$ProgrammPathz = Join-Path -Path $Volume -ChildPath "$Programm\HpqPswd64.exe"

#Debug 
#$PwFilePath
#$SgFilePath
#$ProgrammPath

Write-Host ""
Write-Host "1 - Import Settings from Bios"
Write-Host ""
Write-Host "2 - Export Settings to Bios"
Write-Host ""
Write-Host "3 - Import Full from Bios"
Write-Host ""
Write-Host "4 - Export Full to Bios"
Write-Host ""
Write-Host "Tipp: Full = Settings and Password"
Write-Host ""

$Action = Read-Host "Auswahl"

switch ($Action) {
	"1" { Write-Host "Import der Settings wurde gestartet."
          $arguments = '/Get:"C:\Settings.txt"'
          Start-Process -FilePath $ProgrammPath -ArgumentList $arguments
          Start-Sleep -Seconds 10
		  Copy-Item -Path $QuelleSg -Destination $FilePath
		  Remove-Item -Path $QuelleSg -Force
}
	"2" { Write-Host "Export der Settings wurde gestartet"
           Copy-Item -Path $FilePath\Settings.txt -Destination $Quelle
           Copy-Item -Path $FilePath\Password.bin -Destination $Quelle
           Start-Sleep -Seconds 3
           $arguments = '/cspwdfile:"C:\Password.bin /Set:"C:\Settings.txt" /Verbose'
           Start-Process -FilePath $ProgrammPath -ArgumentList $arguments
           Start-Sleep -Seconds 30
           Remove-Item -Path $QuelleSg
           Remove-Item -Path $QuellePw

}
	"3" { Write-Host "Full Export gestartet"
          $arguments = '/Get:"C:\Settings.txt"'
          $argumentz = '/cspwdfile:"C:\Password.bin"'
          Start-Process -FilePath $ProgrammPath -ArgumentList $arguments
          Start-Process -FilePath $ProgrammPathz -ArgumentList $argumentz
          Start-Sleep -Seconds 25
		  Copy-Item -Path $QuelleSg -Destination $FilePath
		  Copy-Item -Path $QuellePw -Destination $FilePath
          Start-Sleep -Seconds 15
	   	  Remove-Item -Path $QuelleSg
		  Remove-Item -Path $QuellePw		  
}
	"4" { Write-Host "Full Import gestartet" 
          Copy-Item -Path $FilePath\Settings.txt -Destination $Quelle
          Copy-Item -Path $FilePath\Password.bin -Destination $Quelle
          Start-Sleep -Seconds 10
          $arguments = '/Get:"C:\Settings.txt"'
          $argumentz = '/nspwdfile:"C:\Password.bin"'
          Start-Process -FilePath $ProgrammPath -ArgumentList $arguments
          Start-Process -FilePath $ProgrammPathz -ArgumentList $argumentz
          Start-Sleep -Seconds 60
          Remove-Item -Path $QuelleSg
          Remove-Item -Path $QuellePw
}
	default { Write-Host "Das war falsch! Probiers nochmal." }
	}