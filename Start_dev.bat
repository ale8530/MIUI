@ECHO OFF 
REM Versione release
SET NUM1=4
SET NUM2=0
SET NUM3=0

REM Settare titolo
title MIUI Recovery Tool %NUM1%.%NUM2%.%NUM3%

REM Settare colore layout
color 0b
REM Directory esecuzione 
SET CURRENTDIR="%~d0\MIUI_Recovery_Tool\Start.exe"

IF NOT EXIST "%CURRENTDIR%" (
goto blockesecution
) else (
goto directory )

REM Directory secondarie
:directory
SET RECOVERY="%~dp0/recovery"
SET DRIVER="%~dp0/driver_adb"
SET BOOT="%~dp0/boot"
SET ROM="%~dp0/rom"
SET LOG="%~dp0/log"
SET WORKINGDIR="%~dp0/workingdir"
SET SYSTEMDAT="%~dp0/systemnewdat_extract"
SET FASTBOOTROM="%~dp0/fastboot_rom"
SET IMAGES="%~dp0/workingdir/images"
SET FASTBOOT="%~dp0/tools/fastboot.exe"
SET FASTBOOTEDL="%~dp0/tools/fastboot_edl.exe"
SET TOOLS="%~dp0/tools"
SET ADB="%~dp0/tools/adb.exe"
SET WGET="%~dp0/tools/wget"
SET FIND="%SystemRoot%\system32\findstr.exe"
SET XCOPY="%SystemRoot%\system32\xcopy.exe"
SET CMD="%SystemRoot%\system32\cmd.exe"
SET POWERSHELL="%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe"

REM Crea Directory se non esistono
IF NOT EXIST "%RECOVERY%" (mkdir %RECOVERY%)
IF NOT EXIST "%BOOT%" (mkdir %BOOT%)
IF NOT EXIST "%LOG%" (mkdir %LOG%)
IF NOT EXIST "%ROM%" (mkdir %ROM%)
IF NOT EXIST "%FASTBOOTROM%" (mkdir %FASTBOOTROM%)
IF NOT EXIST "%SYSTEMDAT%" (mkdir %SYSTEMDAT%)


REM HOME
:home
mode con:cols=81 lines=28
cls

echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo    TERMINALI:
echo.
echo.
echo   A. Installare Twrp o boot.img con rom miui.it
echo   B. Extra    
echo   C. Ripristino via FASTBOOT (NO MiFlash)
echo.       
echo                                                       yyyyyyyyyyyyyyo     syyy
echo                                                       NNNNNNNNNNNNNNNNy   dNNN
echo                                                       NNNmooooooosyNNNNo  dNNN
echo                                                       NNNd  ossso  yNNNs  dNNN
echo                                                       NNNd  oNNNy  sNNNs  dNNN
echo                                                       NNNd  oNNNy  sNNNs  dNNN
echo                                                       NNNd  oNNNy  sNNNs  dNNN
echo                                                       NNNd  oNNNy  sNNNs  dNNN
echo   0. Uscita                                           NNNd  oNNNy  sNNNs  dNNN
echo.          
echo.                          
set/p menu= Scegli l'opzione desiderata: 
if "%menu%"=="A" goto checkyourdeviceflash
if "%menu%"=="a" goto checkyourdeviceflash
if "%menu%"=="B" goto extra_home
if "%menu%"=="b" goto extra_home
if "%menu%"=="C" goto fastboot_home
if "%menu%"=="c" goto fastboot_home
if "%menu%"=="100" goto startcmd
if "%menu%"=="0" exit


:startcmd
cls

echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Hai avviato il prompt dei comandi per eseguire il flash manuale.
echo.
echo la sintassi da eseguire e' la seguente:
echo.
echo Per le Recovery:
echo tools\fastboot flash recovery recovery\twrp_xxx.img
echo tools\fastboot boot recovery\twrp_xxx.img
echo.
echo Per le boot.img:
echo tools\fastboot flash boot boot\boot_xxx.img
echo.
echo Per chiudere dei comandi manuali eseguire il comando "exit"
echo.
Call %CMD%
pause
goto home

:blockforandroid7
echo.
echo Funzione al momento disabilitata in attesa del rilascio di Android 7
echo.
pause
goto home


:error1
echo LOG ERRORI:
echo.
%FIND% /m "MIUI_Recovery_Tool//recovery/" %LOG%\download_log>NUL
if %errorlevel%==0 (
echo TWRP trovata!
) else (
echo TWRP non trovata!
)
echo.
pause
goto home

:error2
echo LOG ERRORI:
echo.
%FIND% /m "Miui_Recovery_Tool//recovery" %LOG%\download_log>NUL
if %errorlevel%==0 (
echo TWRP trovata!
) else (
echo TWRP non trovata!
)
echo.
%FIND% /m "MIUI_Recovery_Tool//boot/" %LOG%\download_log>NUL
if %errorlevel%==0 (
echo Boot.img trovato!
) else (
echo Boot.img non trovato!
)
echo.
pause
goto home

:aries
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi 2/2S:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_aries
:start_aries
:aries_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_aries.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_aries.img" (
goto flash_aries ) ELSE ( goto dl_recovery_aries )
echo.
pause
goto home
:dl_recovery_aries
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_aries.img
IF NOT EXIST "%RECOVERY%/twrp_aries.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_aries
:flash_aries
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_aries.img
%FASTBOOT% boot %RECOVERY%\twrp_aries.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:cancro
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi 3W/4W:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_cancro
:start_cancro
:cancro_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_cancro.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_cancro.img" (
goto flash_cancro ) ELSE ( goto dl_recovery_cancro )
echo.
pause
goto home
:dl_recovery_cancro
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_cancro.img
IF NOT EXIST "%RECOVERY%/twrp_cancro.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_cancro
:flash_cancro
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_cancro.img
%FASTBOOT% boot %RECOVERY%\twrp_cancro.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:libra
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi 4c:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_libra
:start_libra
:libra_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_libra.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_libra.img" (
goto flash_libra ) ELSE ( goto dl_recovery_libra )
echo.
pause
goto home
:dl_recovery_libra
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_libra.img
IF NOT EXIST "%RECOVERY%/twrp_libra.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_libra
:flash_libra
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_libra.img
%FASTBOOT% boot %RECOVERY%\twrp_libra.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:aqua
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi 4S:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_aqua
:start_aqua
:aqua_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_aqua.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_aqua.img" (
goto flash_aqua ) ELSE ( goto dl_recovery_aqua )
echo.
pause
goto home
:dl_recovery_aqua
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_aqua.img
IF NOT EXIST "%RECOVERY%/twrp_aqua.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_aqua
:flash_aqua
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_aqua.img
%FASTBOOT% boot %RECOVERY%\twrp_aqua.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:ferrari
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi 4i:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_ferrari
:start_ferrari
:ferrari_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_ferrari.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_ferrari.img" (
goto flash_ferrari ) ELSE ( goto dl_recovery_ferrari )
echo.
pause
goto home
:dl_recovery_ferrari
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_ferrari.img
IF NOT EXIST "%RECOVERY%/twrp_ferrari.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_ferrari
:flash_ferrari
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_ferrari.img
%FASTBOOT% boot %RECOVERY%\twrp_ferrari.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:gemini
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi 5:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_gemini
:start_gemini
:gemini_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_gemini.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_gemini.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_gemini.img" (goto checkbootgemini) ELSE (goto dl_recovery_gemini)
:checkbootgemini
IF EXIST "%BOOT%/boot_gemini.img" (goto flash_gemini)  ELSE  (goto dl_boot_gemini) 
:dl_recovery_gemini
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_gemini.img
IF NOT EXIST "%RECOVERY%/twrp_gemini.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootgemini
:dl_boot_gemini
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_gemini.img
IF NOT EXIST "%BOOT%/boot_gemini.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootgemini
:flash_gemini
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_gemini.img
%FASTBOOT% flash boot %BOOT%\boot_gemini.img
%FASTBOOT% boot %RECOVERY%\twrp_gemini.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:capricorn
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi 5s:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_capricorn
:start_capricorn
:capricorn_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_capricorn.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_capricorn.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_capricorn.img" (goto checkbootcapricorn) ELSE (goto dl_recovery_capricorn)
:checkbootcapricorn
IF EXIST "%BOOT%/boot_capricorn.img" (goto flash_capricorn)  ELSE  (goto dl_boot_capricorn) 
:dl_recovery_capricorn
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_capricorn.img
IF NOT EXIST "%RECOVERY%/twrp_capricorn.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootcapricorn
:dl_boot_capricorn
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_capricorn.img
IF NOT EXIST "%BOOT%/boot_capricorn.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootcapricorn
:flash_capricorn
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_capricorn.img
%FASTBOOT% flash boot %BOOT%\boot_capricorn.img
%FASTBOOT% boot %RECOVERY%\twrp_capricorn.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:natrium
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi 5s Plus:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_natrium
:start_natrium
:natrium_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_natrium.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_natrium.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_natrium.img" (goto checkbootnatrium) ELSE (goto dl_recovery_natrium)
:checkbootnatrium
IF EXIST "%BOOT%/boot_natrium.img" (goto flash_natrium)  ELSE  (goto dl_boot_natrium) 
:dl_recovery_natrium
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_natrium.img
IF NOT EXIST "%RECOVERY%/twrp_natrium.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootnatrium
:dl_boot_natrium
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_natrium.img
IF NOT EXIST "%BOOT%/boot_natrium.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootnatrium
:flash_natrium
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_natrium.img
%FASTBOOT% flash boot %BOOT%\boot_natrium.img
%FASTBOOT% boot %RECOVERY%\twrp_natrium.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:song
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi 5c:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_song
:start_song
:song_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_song.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_song.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_song.img" (goto checkbootsong) ELSE (goto dl_recovery_song)
:checkbootsong
IF EXIST "%BOOT%/boot_song.img" (goto flash_song)  ELSE  (goto dl_boot_song) 
:dl_recovery_song
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_song.img
IF NOT EXIST "%RECOVERY%/twrp_song.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootsong
:dl_boot_song
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_song.img
IF NOT EXIST "%BOOT%/boot_song.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootsong
:flash_song
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_song.img
%FASTBOOT% flash boot %BOOT%\boot_song.img
%FASTBOOT% boot %RECOVERY%\twrp_song.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:virgo
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi Note:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_virgo
:start_virgo
:virgo_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_virgo.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_virgo.img" (
goto flash_virgo ) ELSE ( goto dl_recovery_virgo )
echo.
pause
goto home
:dl_recovery_virgo
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_virgo.img
IF NOT EXIST "%RECOVERY%/twrp_virgo.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_virgo
:flash_virgo
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_virgo.img
%FASTBOOT% boot %RECOVERY%\twrp_virgo.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:scorpio
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi Note 2:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_scorpio
:start_scorpio
:scorpio_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_scorpio.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_scorpio.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_scorpio.img" (goto checkbootscorpio) ELSE (goto dl_recovery_scorpio)
:checkbootscorpio
IF EXIST "%BOOT%/boot_scorpio.img" (goto flash_scorpio)  ELSE  (goto dl_boot_scorpio) 
:dl_recovery_scorpio
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_scorpio.img
IF NOT EXIST "%RECOVERY%/twrp_scorpio.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootscorpio
:dl_boot_scorpio
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_scorpio.img
IF NOT EXIST "%BOOT%/boot_scorpio.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootscorpio
:flash_scorpio
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_scorpio.img
%FASTBOOT% flash boot %BOOT%\boot_scorpio.img
%FASTBOOT% boot %RECOVERY%\twrp_scorpio.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:leo
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi Note Pro:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_leo
:start_leo
:leo_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_leo.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_leo.img" (
goto flash_leo ) ELSE ( goto dl_recovery_leo )
echo.
pause
goto home
:dl_recovery_leo
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_leo.img
IF NOT EXIST "%RECOVERY%/twrp_leo.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_leo
:flash_leo
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_leo.img
%FASTBOOT% boot %RECOVERY%\twrp_leo.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:hydrogen
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi Max:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_hydrogen
:start_hydrogen
:hydrogen_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_hydrogen.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_hydrogen.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_hydrogen.img" (goto checkboothydrogen) ELSE (goto dl_recovery_hydrogen)
:checkboothydrogen
IF EXIST "%BOOT%/boot_hydrogen.img" (goto flash_hydrogen)  ELSE  (goto dl_boot_hydrogen) 
:dl_recovery_hydrogen
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_hydrogen.img
IF NOT EXIST "%RECOVERY%/twrp_hydrogen.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkboothydrogen
:dl_boot_hydrogen
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_hydrogen.img
IF NOT EXIST "%BOOT%/boot_hydrogen.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkboothydrogen
:flash_hydrogen
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_hydrogen.img
%FASTBOOT% flash boot %BOOT%\boot_hydrogen.img
%FASTBOOT% boot %RECOVERY%\twrp_hydrogen.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:helium
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi Max Pro:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_helium
:start_helium
:helium_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_helium.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_helium.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_helium.img" (goto checkboothelium) ELSE (goto dl_recovery_helium)
:checkboothelium
IF EXIST "%BOOT%/boot_helium.img" (goto flash_helium)  ELSE  (goto dl_boot_helium) 
:dl_recovery_helium
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_helium.img
IF NOT EXIST "%RECOVERY%/twrp_helium.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkboothelium
:dl_boot_helium
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_helium.img
IF NOT EXIST "%BOOT%/boot_helium.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkboothelium
:flash_helium
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_helium.img
%FASTBOOT% flash boot %BOOT%\boot_helium.img
%FASTBOOT% boot %RECOVERY%\twrp_helium.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:lithium
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi Mix:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_lithium
:start_lithium
:lithium_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_lithium.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_lithium.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_lithium.img" (goto checkbootlithium) ELSE (goto dl_recovery_lithium)
:checkbootlithium
IF EXIST "%BOOT%/boot_lithium.img" (goto flash_lithium)  ELSE  (goto dl_boot_lithium) 
:dl_recovery_lithium
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_lithium.img
IF NOT EXIST "%RECOVERY%/twrp_lithium.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootlithium
:dl_boot_lithium
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_lithium.img
IF NOT EXIST "%BOOT%/boot_lithium.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootlithium
:flash_lithium
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_lithium.img
%FASTBOOT% flash boot %BOOT%\boot_lithium.img
%FASTBOOT% boot %RECOVERY%\twrp_lithium.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:HM2013023
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi 1:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_HM2013023
:start_HM2013023
:HM2013023_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_HM2013023.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_HM2013023.img" (
goto flash_HM2013023) ELSE ( goto dl_recovery_HM2013023)
echo.
pause
goto home
:dl_recovery_HM2013023
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_HM2013023.img
IF NOT EXIST "%RECOVERY%/twrp_HM2013023.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_HM2013023
:flash_HM2013023
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_HM2013023.img
echo.
echo Flash recovery completato!
echo.
echo Tieni premuti per 10s i tasti Power+Volume alto per avviare
echo.
pause
goto home

:armani
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi 1s:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_armani
:start_armani
:armani_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_armani.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_armani.img" (
goto flash_armani) ELSE ( goto dl_recovery_armani)
echo.
pause
goto home
:dl_recovery_armani
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_armani.img
IF NOT EXIST "%RECOVERY%/twrp_armani.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_armani
:flash_armani
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_armani.img
%FASTBOOT% boot %RECOVERY%\twrp_armani.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:HM2014811
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi 2 (4.4):
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_HM2014811
:start_HM2014811
:HM2014811_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_HM2014811.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_HM2014811.img" (
goto flash_HM2014811) ELSE ( goto dl_recovery_HM2014811)
echo.
pause
goto home
:dl_recovery_HM2014811
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_HM2014811.img
IF NOT EXIST "%RECOVERY%/twrp_HM2014811.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_HM2014811
:flash_HM2014811
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_HM2014811.img
%FASTBOOT% boot %RECOVERY%\twrp_HM2014811.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:HM2014813
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi 2 Pro (4.4):
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_HM2014813
:start_HM2014813
:HM2014813_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_HM2014813.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_HM2014813.img" (
goto flash_HM2014813) ELSE ( goto dl_recovery_HM2014813)
echo.
pause
goto home
:dl_recovery_HM2014813
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_HM2014813.img
IF NOT EXIST "%RECOVERY%/twrp_HM2014813.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_HM2014813
:flash_HM2014813
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_HM2014813.img
%FASTBOOT% boot %RECOVERY%\twrp_HM2014813.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:wt88047
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi 2 (5.1):
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_wt88047
:start_wt88047
:wt88047_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_wt88047.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_wt88047.img" (
goto flash_wt88047) ELSE ( goto dl_recovery_wt88047)
echo.
pause
goto home
:dl_recovery_wt88047
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_wt88047.img
IF NOT EXIST "%RECOVERY%/twrp_wt88047.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_wt88047
:flash_wt88047
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_wt88047.img
%FASTBOOT% boot %RECOVERY%\twrp_wt88047.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:wt86047
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi 2 Pro (5.1):
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_wt86047
:start_wt86047
:wt86047_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_wt86047.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_wt86047.img" (
goto flash_wt86047) ELSE ( goto dl_recovery_wt86047)
echo.
pause
goto home
:dl_recovery_wt86047
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_wt86047.img
IF NOT EXIST "%RECOVERY%/twrp_wt86047.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_wt86047
:flash_wt86047
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_wt86047.img
%FASTBOOT% boot %RECOVERY%\twrp_wt86047.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:ido
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi 3/3 Pro:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_ido
:start_ido
:ido_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_ido.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_ido.img" (
goto flash_ido) ELSE ( goto dl_recovery_ido)
echo.
pause
goto home
:dl_recovery_ido
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_ido.img
IF NOT EXIST "%RECOVERY%/twrp_ido.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_ido
:flash_ido
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_ido.img
%FASTBOOT% boot %RECOVERY%\twrp_ido.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:land
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi 3x/3s:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_land
:start_land
:land_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_land.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_land.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_land.img" (goto checkbootland) ELSE (goto dl_recovery_land)
:checkbootland
IF EXIST "%BOOT%/boot_land.img" (goto flash_land)  ELSE  (goto dl_boot_land) 
:dl_recovery_land
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_land.img
IF NOT EXIST "%RECOVERY%/twrp_land.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootland
:dl_boot_land
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_land.img
IF NOT EXIST "%BOOT%/boot_land.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootland
:flash_land
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_land.img
%FASTBOOT% flash boot %BOOT%\boot_land.img
%FASTBOOT% boot %RECOVERY%\twrp_land.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:prada
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi 4:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_prada
:start_prada
:prada_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_prada.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_prada.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_prada.img" (goto checkbootprada) ELSE (goto dl_recovery_prada)
:checkbootprada
IF EXIST "%BOOT%/boot_prada.img" (goto flash_prada)  ELSE  (goto dl_boot_prada) 
:dl_recovery_prada
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_prada.img
IF NOT EXIST "%RECOVERY%/twrp_prada.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootprada
:dl_boot_prada
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_prada.img
IF NOT EXIST "%BOOT%/boot_prada.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootprada
:flash_prada
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_prada.img
%FASTBOOT% flash boot %BOOT%\boot_prada.img
%FASTBOOT% boot %RECOVERY%\twrp_prada.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:rolex
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi 4A:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_rolex
:start_rolex
:rolex_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_rolex.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_rolex.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_rolex.img" (goto checkbootrolex) ELSE (goto dl_recovery_rolex)
:checkbootrolex
IF EXIST "%BOOT%/boot_rolex.img" (goto flash_rolex)  ELSE  (goto dl_boot_rolex) 
:dl_recovery_rolex
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_rolex.img
IF NOT EXIST "%RECOVERY%/twrp_rolex.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootrolex
:dl_boot_rolex
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_rolex.img
IF NOT EXIST "%BOOT%/boot_rolex.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootrolex
:flash_rolex
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_rolex.img
%FASTBOOT% flash boot %BOOT%\boot_rolex.img
%FASTBOOT% boot %RECOVERY%\twrp_rolex.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:markw
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi 4 Prime:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_markw
:start_markw
:markw_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_markw.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_markw.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_markw.img" (goto checkbootmarkw) ELSE (goto dl_recovery_markw)
:checkbootmarkw
IF EXIST "%BOOT%/boot_markw.img" (goto flash_markw)  ELSE  (goto dl_boot_markw) 
:dl_recovery_markw
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_markw.img
IF NOT EXIST "%RECOVERY%/twrp_markw.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootmarkw
:dl_boot_markw
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_markw.img
IF NOT EXIST "%BOOT%/boot_markw.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootmarkw
:flash_markw
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_markw.img
%FASTBOOT% flash boot %BOOT%\boot_markw.img
%FASTBOOT% boot %RECOVERY%\twrp_markw.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:santoni
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi 4X:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_santoni
:start_santoni
:santoni_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_santoni.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_santoni.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_santoni.img" (goto checkbootsantoni) ELSE (goto dl_recovery_santoni)
:checkbootsantoni
IF EXIST "%BOOT%/boot_santoni.img" (goto flash_santoni)  ELSE  (goto dl_boot_santoni) 
:dl_recovery_santoni
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_santoni.img
IF NOT EXIST "%RECOVERY%/twrp_santoni.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootsantoni
:dl_boot_santoni
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_santoni.img
IF NOT EXIST "%BOOT%/boot_santoni.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootsantoni
:flash_santoni
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_santoni.img
%FASTBOOT% flash boot %BOOT%\boot_santoni.img
%FASTBOOT% boot %RECOVERY%\twrp_santoni.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:lcsh92_wet_jb9
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi Note 3G:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_lcsh92_wet_jb9
:start_lcsh92_wet_jb9
:lcsh92_wet_jb9_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_lcsh92_wet_jb9.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_lcsh92_wet_jb9.img" (
goto flash_lcsh92_wet_jb9) ELSE ( goto dl_recovery_lcsh92_wet_jb9)
echo.
pause
goto home
:dl_recovery_lcsh92_wet_jb9
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_lcsh92_wet_jb9.img
IF NOT EXIST "%RECOVERY%/twrp_lcsh92_wet_jb9.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_lcsh92_wet_jb9
:flash_lcsh92_wet_jb9
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_lcsh92_wet_jb9.img
echo.
echo Flash recovery completato!
echo.
echo Tieni premuti per 10s i tasti Power+Volume alto per avviare
echo.
pause
goto home

:dior
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi Note 4g:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_dior
:start_dior
:dior_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_dior.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_dior.img" (
goto flash_dior) ELSE ( goto dl_recovery_dior)
echo.
pause
goto home
:dl_recovery_dior
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_dior.img
IF NOT EXIST "%RECOVERY%/twrp_dior.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_dior
:flash_dior
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_dior.img
%FASTBOOT% boot %RECOVERY%\twrp_dior.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:gucci
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi Note 1S:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_gucci
:start_gucci
:gucci_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_gucci.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_gucci.img" (
goto flash_gucci) ELSE ( goto dl_recovery_gucci)
echo.
pause
goto home
:dl_recovery_gucci
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_gucci.img
IF NOT EXIST "%RECOVERY%/twrp_gucci.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_gucci
:flash_gucci
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_gucci.img
%FASTBOOT% boot %RECOVERY%\twrp_gucci.img
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:hermes
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi Note 2:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_hermes
:start_hermes
:hermes_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_hermes.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_hermes.img" (
goto flash_hermes) ELSE ( goto dl_recovery_hermes)
echo.
pause
goto home
:dl_recovery_hermes
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_hermes.img
IF NOT EXIST "%RECOVERY%/twrp_hermes.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_hermes
:flash_hermes
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_hermes.img
echo.
echo Flash recovery completato!
echo.
echo Tieni premuti per 10s i tasti Power+Volume alto per avviare
echo.
pause
goto home

:hermes
cls
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
echo.
IF EXIST "%RECOVERY%/twrp_hermes.img" (
goto flash_hermes ) ELSE ( goto dl_recovery_hermes )
echo.
pause
goto home


:dl_recovery_hermes
echo.
echo.
echo Il Tool sta scaricando la Recovery per il tuo terminale:
echo.
echo.
%WGET% -P %RECOVERY% -i http://www.miui.it/download/recovery/twrp_hermes.img
IF NOT EXIST "%RECOVERY%/twrp_hermes.img" (goto error)
echo.
echo.
echo Download completato!
echo.
goto flash_hermes


:flash_hermes
echo.
echo Flash su Redmi Note 2 inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_hermes.img
echo.
echo Flash recovery completato!
echo.
echo  Tieni premuti per 10s i tasti Power+Volume alto per avviare
echo.
pause
goto home

:hennessy
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi Note 3:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_hennessy
:start_hennessy
:hennessy_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_hennessy.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_hennessy.img" (
goto flash_hennessy) ELSE ( goto dl_recovery_hennessy)
echo.
pause
goto home
:dl_recovery_hennessy
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_hennessy.img
IF NOT EXIST "%RECOVERY%/twrp_hennessy.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_hennessy
:flash_hennessy
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_hennessy.img
echo.
echo Flash recovery completato!
echo.
echo Tieni premuti per 10s i tasti Power+Volume alto per avviare
echo.
pause
goto home

:kenzo
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi Note 3 Pro:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_kenzo
:start_kenzo
:kenzo_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_kenzo.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_kenzo.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_kenzo.img" (goto checkbootkenzo) ELSE (goto dl_recovery_kenzo)
:checkbootkenzo
IF EXIST "%BOOT%/boot_kenzo.img" (goto flash_kenzo)  ELSE  (goto dl_boot_kenzo) 
:dl_recovery_kenzo
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_kenzo.img
IF NOT EXIST "%RECOVERY%/twrp_kenzo.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootkenzo
:dl_boot_kenzo
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_kenzo.img
IF NOT EXIST "%BOOT%/boot_kenzo.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootkenzo
:flash_kenzo
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_kenzo.img
%FASTBOOT% flash boot %BOOT%\boot_kenzo.img
%FASTBOOT% boot %RECOVERY%\twrp_kenzo.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:kate
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi Note 3 Pro SE:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_kate
:start_kate
:kate_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_kate.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_kate.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_kate.img" (goto checkbootkate) ELSE (goto dl_recovery_kate)
:checkbootkate
IF EXIST "%BOOT%/boot_kate.img" (goto flash_kate)  ELSE  (goto dl_boot_kate) 
:dl_recovery_kate
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_kate.img
IF NOT EXIST "%RECOVERY%/twrp_kate.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootkate
:dl_boot_kate
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_kate.img
IF NOT EXIST "%BOOT%/boot_kate.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootkate
:flash_kate
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_kate.img
%FASTBOOT% flash boot %BOOT%\boot_kate.img
%FASTBOOT% boot %RECOVERY%\twrp_kate.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:nikel
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi Note 4:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_nikel
:start_nikel
:nikel_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_nikel.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_nikel.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_nikel.img" (goto checkbootnikel) ELSE (goto dl_recovery_nikel)
:checkbootnikel
IF EXIST "%BOOT%/boot_nikel.img" (goto flash_nikel)  ELSE  (goto dl_boot_nikel) 
:dl_recovery_nikel
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_nikel.img
IF NOT EXIST "%RECOVERY%/twrp_nikel.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootnikel
:dl_boot_nikel
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_nikel.img
IF NOT EXIST "%BOOT%/boot_nikel.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootnikel
:flash_nikel
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_nikel.img
%FASTBOOT% flash boot %BOOT%\boot_nikel.img
%FASTBOOT% boot %RECOVERY%\twrp_nikel.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home


:mido
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi Note 4X :
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_mido
:start_mido
:mido_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_mido.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_mido.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_mido.img" (goto checkbootmido) ELSE (goto dl_recovery_mido)
:checkbootmido
IF EXIST "%BOOT%/boot_mido.img" (goto flash_mido)  ELSE  (goto dl_boot_mido) 
:dl_recovery_mido
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_mido.img
IF NOT EXIST "%RECOVERY%/twrp_mido.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootmido
:dl_boot_mido
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_mido.img
IF NOT EXIST "%BOOT%/boot_mido.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootmido
:flash_mido
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_mido.img
%FASTBOOT% flash boot %BOOT%\boot_mido.img
%FASTBOOT% boot %RECOVERY%\twrp_mido.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:omega
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Redmi Pro:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_omega
:start_omega
:omega_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_omega.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_omega.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_omega.img" (goto checkbootomega) ELSE (goto dl_recovery_omega)
:checkbootomega
IF EXIST "%BOOT%/boot_omega.img" (goto flash_omega)  ELSE  (goto dl_boot_omega) 
:dl_recovery_omega
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_omega.img
IF NOT EXIST "%RECOVERY%/twrp_omega.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootomega
:dl_boot_omega
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_omega.img
IF NOT EXIST "%BOOT%/boot_omega.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootomega
:flash_omega
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_omega.img
%FASTBOOT% flash boot %BOOT%\boot_omega.img
%FASTBOOT% boot %RECOVERY%\twrp_omega.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home

:mocha
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo MiPad 1:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_mocha
:start_mocha
:mocha_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_mocha.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_mocha.img" (
goto flash_mocha) ELSE ( goto dl_recovery_mocha)
echo.
pause
goto home
:dl_recovery_mocha
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_mocha.img
IF NOT EXIST "%RECOVERY%/twrp_mocha.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_mocha
:flash_mocha
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_mocha.img
echo.
echo Flash recovery completato!
echo.
echo Tieni premuti per 10s i tasti Power+Volume alto per avviare
echo.
pause
goto home

:latte
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo MiPad 2:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_latte
:start_latte
:latte_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_latte.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_latte.img" (
goto flash_latte) ELSE ( goto dl_recovery_latte)
echo.
pause
goto home
:dl_recovery_latte
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_latte.img
IF NOT EXIST "%RECOVERY%/twrp_latte.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_latte
:flash_latte
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_latte.img
%FASTBOOT% oem reboot recovery
echo.
echo Flash recovery completato!
echo.
echo Riavvio dispositivo in corso...
echo.
pause
goto home

:latte
cls
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
echo.
IF EXIST "%RECOVERY%/twrp_latte.img" (
goto flash_latte ) ELSE ( goto dl_recovery_latte )
echo.
pause
goto home


:dl_recovery_latte
echo.
echo.
echo Il Tool sta scaricando la Recovery per il tuo terminale:
echo.
echo.
%WGET% -P %RECOVERY% -i http://www.miui.it/download/recovery/twrp_latte.img
IF NOT EXIST "%RECOVERY%/twrp_latte.img" (goto error)
echo.
echo.
echo Download completato!
echo.
goto flash_latte


:flash_latte
echo.
echo Flash su Mi Pad 2 inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_latte.img
%FASTBOOT% oem reboot recovery
echo.
echo Flash recovery completato!
echo.
echo  Riavvio dispositivo in corso...
echo.
pause
goto home


:cappu
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Mi Pad 3:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_cappu
:start_cappu
:cappu_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_cappu.img
)
IF EXIST "%BOOT%\boot.img" (
echo.
echo Utilizzo boot.img estratto dalla ROM
REN %BOOT%\boot.img boot_cappu.img
echo.
)
IF EXIST "%ROM%/boot.img" (del %ROM%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_cappu.img" (goto checkbootcappu) ELSE (goto dl_recovery_cappu)
:checkbootcappu
IF EXIST "%BOOT%/boot_cappu.img" (goto flash_cappu)  ELSE  (goto dl_boot_cappu) 
:dl_recovery_cappu
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_cappu.img
IF NOT EXIST "%RECOVERY%/twrp_cappu.img" (goto error1)
echo.
echo Download completato!
echo.
goto checkbootcappu
:dl_boot_cappu
echo Scaricamento boot.img in corso, attendere...
echo.
%WGET% -P %BOOT% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/boot/boot_cappu.img
IF NOT EXIST "%BOOT%/boot_cappu.img" (goto error2)
echo.
echo Download completato!
echo.
goto checkbootcappu
:flash_cappu
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_cappu.img
%FASTBOOT% flash boot %BOOT%\boot_cappu.img
%FASTBOOT% boot %RECOVERY%\twrp_cappu.img
echo.
echo Flash recovery e boot effettuato!
echo.
echo Riavvio dispositivo in corso...
echo.
echo Per visualizzare la memoria interna devi effettuare un "FORMAT DATA" sulla TWRP e ricaricare la rom di miui.it sul proprio dispositivo!
echo.
pause
goto home


:hammerhead
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo Google Nexus 5:
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
echo.
echo Attenzione: Per utilizzare questa funzione devi essere in modalita' FASTBOOT!
echo.
pause
goto start_hammerhead
:start_hammerhead
:hammerhead_automatic
IF EXIST "%RECOVERY%\twrp.img" (
echo.
echo Utilizzo TWRP estratto dalla ROM
REN %RECOVERY%\twrp.img twrp_hammerhead.img
echo.
)
IF EXIST "%BOOT%/boot.img" (del %BOOT%\boot.img)
IF EXIST "%ROM%/build.prop" (del %ROM%\build.prop)
IF EXIST "%RECOVERY%/twrp_hammerhead.img" (
goto flash_hammerhead) ELSE ( goto dl_recovery_hammerhead)
echo.
pause
goto home
:dl_recovery_hammerhead
echo.
echo Scaricamento TWRP in corso, attendere...
echo.
%WGET% -P %RECOVERY% -a %LOG%/download_log --show-progress -i http://www.miui.it/download/recovery/twrp_hammerhead.img
IF NOT EXIST "%RECOVERY%/twrp_hammerhead.img" (goto error1)
echo.
echo Download completato!
echo.
goto flash_hammerhead
:flash_hammerhead
echo Flash inizializzato...
echo.
%FASTBOOT% flash recovery %RECOVERY%\twrp_hammerhead.img
echo.
echo Flash recovery completato!
echo.
echo Seleziona 'Recovery' dal menu del fastboot per applicare la nuova TWRP!
echo.
pause
goto home


REM EXTRA
:extra_home
mode con:cols=81 lines=31
cls

echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.       
echo          EXTRA:
echo          A. Scarica driver ADB 
echo          B. Verifica configurazione ADB
echo          C. Riavviare il proprio dispositivo in modalita' FASTBOOT (NO MTK)
echo          D. Riavviare il proprio dispositivo dalla modalita' FASTBOOT (NO MTK)
echo          E. Riavviare il proprio dispositivo in modalita' RECOVERY
echo          F. Riavviare il proprio dispositivo dalla modalita' RECOVERY
echo          G. Pushare la "rom.zip" sul proprio dispositivo (Solo RECOVERY)
echo          H. Riavviare il dispositivo in modalita' EDL (NO MTK)        
echo          I. Verifica configurazione FASTBOOT
echo          L. Logcat
echo          M. Estrai ROM con il nuovo formato system.new.dat
echo          N. Verifica lo stato del tuo BOOTLOADER
echo.                   
echo          T. FAQ (www.miui.it/forum)           
echo          0. Torna alla schermata principale
echo.                                                       
echo.   
echo.     
echo.                                  
set/p menu= Seleziona l'opzione desiderata: 
if "%menu%"=="A" goto adbdownload
if "%menu%"=="a" goto adbdownload
if "%menu%"=="B" goto adbverify
if "%menu%"=="b" goto adbverify
if "%menu%"=="C" goto adbreboot
if "%menu%"=="c" goto adbreboot
if "%menu%"=="D" goto fastbootreboot
if "%menu%"=="d" goto fastbootreboot
if "%menu%"=="E" goto adbrecovery
if "%menu%"=="e" goto adbrecovery
if "%menu%"=="F" goto adbsystem
if "%menu%"=="f" goto adbsystem
if "%menu%"=="G" goto adbpushzip
if "%menu%"=="g" goto adbpushzip
if "%menu%"=="H" goto edl-mode
if "%menu%"=="h" goto edl-mode
if "%menu%"=="i" goto fastbootverify
if "%menu%"=="I" goto fastbootverify
if "%menu%"=="l" goto adblogcat
if "%menu%"=="L" goto adblogcat
if "%menu%"=="m" goto _system.dat
if "%menu%"=="M" goto _system.dat
if "%menu%"=="n" goto fastbootoem
if "%menu%"=="N" goto fastbootoem
if "%menu%"=="T" goto FAQ
if "%menu%"=="t" goto FAQ
if "%menu%"=="0" goto home


:adbdownload
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Download Driver ADB in corso...
echo.
%WGET% -P %DRIVER% -a %LOG%/download_log --show-progress -i http://adbdriver.com/upload/adbdriver.zip
%TOOLS%\\7za x %DRIVER%/adbdriver.zip -o%DRIVER%
del %DRIVER%\adbdriver.zip
echo.
echo Driver ADB scaricati e decompressi nella cartella del TOOL!
echo.
echo.
echo Come vuoi avviare l'installazione dei driver ADB?
echo.
echo.
echo Digita "1" se vuoi procedere all'installazione con avvio automatico
echo Digita "2" se vuoi procedere all'installazione con avvio manuale
echo.
echo.
set/p adb_install=Digita un numero:
if "%adb_install%"=="0" goto adb_error
if "%adb_install%"=="1" goto adb_install1
if "%adb_install%"=="2" goto adb_install2
if "%adb_install%"=="3" goto adb_error
if "%adb_install%"=="4" goto adb_error
if "%adb_install%"=="5" goto adb_error
if "%adb_install%"=="6" goto adb_error
if "%adb_install%"=="7" goto adb_error
if "%adb_install%"=="8" goto adb_error
if "%adb_install%"=="9" goto adb_error

:adb_error
echo.
echo Hai sbagliato la digitazione del numero riprova grazie! 
echo.
set/p adb_install=Digita un numero:
if "%adb_install%"=="1" goto adb_install1
if "%adb_install%"=="2" goto adb_install2
echo.
pause
goto extra_home


:adb_install1
echo.
echo Avvio installazione automatica dei driver ADB! 
start driver_adb/ADBDriverInstaller.exe
echo.
echo.
pause
goto extra_home


:adb_install2
echo.
echo Avvia manualmente l'installazione con il programma ADBDriverInstaller.exe che troverai all'interno del TOOL cartella /driver_adb
echo.
echo.
pause
goto extra_home


:adbverify
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Test collegamento ADB in corso...
echo.
%ADB% devices
echo.
echo Se visualizzi un numero il tuo dispositivo e' configurato correttamente!
echo.
pause
goto extra_home

:adbreboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Riavvio dispositivo nella modalita' FASTBOOT in corso...
echo.
%ADB% reboot bootloader
echo.
pause
goto extra_home

:fastbootreboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Riavvio dispositivo dalla modalita' FASTBOOT in corso...
echo.
%FASTBOOT% reboot
echo.
pause
goto extra_home

:adbrecovery
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Riavvio dispositivo in modalita' RECOVERY in corso...
echo.
%ADB% reboot recovery
echo.
pause
goto extra_home

:adbsystem
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Riavvio dispositivo dalla modalita' RECOVERY in corso...
echo.
%ADB% reboot
echo.
pause
goto extra_home


:adbpushzip
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Invio file "rom.zip" sul proprio dispositivo...
echo.
%ADB% push %ROM%\rom.zip /sdcard
echo.
echo Il file "rom.zip" e' stato eliminato dalla cartella /rom
del %ROM%\rom.zip
echo.
pause
goto extra_home

:edl-mode
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Stai per riavviare il tuo dispositivo in modalita' EDL 
echo.
echo Prima di procedere devi verificare che il tuo dispositivo sia compatibile per maggiori informazioni premi il tasto "I".
echo.
echo Dopo aver letto tutte le informazioni, scegli cosa fare.
echo.
echo Premi "1" se vuoi effettuare un Unbrick Totale (FASTBOOT MODE)
echo Premi "2" se vuoi effettuare Flash normale (ADB MODE)
echo Premi "3" per annullare
echo.
echo Come vuoi procedere? 
echo.
set/p edl_menu=Digita l'opzione desiderata:
if "%edl_menu%"=="1" goto edl_fastbootmode_start
if "%edl_menu%"=="2" goto edl_adbmode_start
if "%edl_menu%"=="3" goto extra_home
if "%edl_menu%"=="I" start "" http://www.miui.it/forum/index.php?threads/guida-cosa-e-la-edl-mode.18864/
if "%edl_menu%"=="i" start "" http://www.miui.it/forum/index.php?threads/guida-cosa-e-la-edl-mode.18864/

:edl_fastbootmode_start
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT.
echo.
echo Una volta collegato premi "S" per procedere o "N" per annullare
echo.
set/p fastbootmode=Digita l'opzione desiderata:
if "%fastbootmode%"=="S" goto fastbootmode_start
if "%fastbootmode%"=="s" goto fastbootmode_start
if "%fastbootmode%"=="N" goto extra_home 
if "%fastbootmode%"=="n" goto extra_home

:fastbootmode_start
echo.
echo Riavvio modalita' EDL avviata...
echo.
%FASTBOOTEDL% reboot-edl
echo.
echo Se tutto e' andato buon fine , il terminale entrera' in modalita' Download Mode!
echo.
echo Per aiutarti nell'installazione ti consigliamo di premere il tasto "A" e sarai indirizzato alla pagina di miui.it/forum
echo.
echo Credits emuzychenko en.miui.com
echo.
set/p info=Premi "A" per info installazione o "INVIO" per continuare:
if "%info%"=="A" start "" http://www.miui.it/forum/index.php?threads/guida-cosa-e-la-edl-mode.18864/
if "%info%"=="a" start "" http://www.miui.it/forum/index.php?threads/guida-cosa-e-la-edl-mode.18864/
echo.
goto extra_home

:edl_adbmode_start
echo.
echo Accendi il tuo dispositivo e collegalo al tuo PC,assicurandoti di aver verificato precedentemente i driver ADB.
echo.
echo Una volta collegato premi "S" per procedere o "N" per annullare
echo.
set/p adbmode=Digita l'opzione desiderata:
if "%adbmode%"=="S" goto adbmode_start
if "%adbmode%"=="s" goto adbmode_start
if "%adbmode%"=="N" goto extra_home
if "%adbmode%"=="n" goto extra_home

:adbmode_start
echo.
echo Riavvio modalita' EDL avviata...
echo.
%ADB% reboot edl
echo.
echo Se tutto e' andato buon fine , il terminale entrera' in modalita' Download Mode!
echo.
echo Per aiutarti nell'installazione ti consigliamo di premere il tasto "A" e sarai indirizzato alla pagina di miui.it/forum
echo.
echo Credits Muz_paray en.miui.com
echo.
set/p info=Premi "A" per info installazione o "INVIO" per continuare:
if "%info%"=="A" start "" http://www.miui.it/forum/index.php?threads/guida-cosa-e-la-edl-mode.18864/
if "%info%"=="a" start "" http://www.miui.it/forum/index.php?threads/guida-cosa-e-la-edl-mode.18864/
echo.
goto extra_home

:fastbootverify
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Test collegamento FASTBOOT in corso...
echo.
%FASTBOOT% devices
echo.
echo Se visualizzi un numero il tuo dispositivo e' configurato correttamente!
echo.
pause
goto extra_home

:adblogcat
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo La funzione logcat puo' essere utilizzata solo a dispositivo acceso e con attivo il "DEBUG USB" nelle opzioni sviluppatore
echo.
pause 
IF EXIST "%LOG%/logcat" (
goto dellogcat ) ELSE ( goto startlogcat )
echo.
:dellogcat
echo.
echo Verifica ed eliminazione file logcat precedente....
del %LOG%\logcat
goto startlogcat 
:startlogcat
echo.
echo Creazione logcat in corso...
echo.
%ADB% logcat -d > %LOG%/logcat
echo Troverai il tuo logcat nella cartella /log
echo.
pause
goto extra_home


:errorextractsystemdat
echo.
echo Il programma non puo' proseguire la sua esecuzione per la mancanza del file ".zip" nella cartella /rom
echo.
pause
goto extra_home

:_system.dat
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Per estrarre il contenuto del nuovo system.new.dat devi copiare la rom miui.it o cinese all'interno della cartella /rom
echo.
pause
IF EXIST "%SYSTEMDAT%\system" (
    rmdir %SYSTEMDAT%\system /s /q
)>NUL
IF EXIST "%SYSTEMDAT%\system_statfile.txt" (
    del %SYSTEMDAT%\system_statfile.txt
)>NUL
IF EXIST "%ROM%/*.zip" (goto unzipromzip) ELSE (goto errorextractsystemdat)
:unzipromzip
IF EXIST "%LOG%/systemnewdat_log" (del %LOG%\systemnewdat_log)
IF EXIST "%SYSTEMDAT%\system" (rmdir %SYSTEMDAT%\system)
echo.
echo Scompattamento file ".zip" in corso...
IF NOT EXIST "%WORKINGDIR%" (mkdir %WORKINGDIR%) 
echo.
%TOOLS%\\7za x %ROM%/*.zip -o%WORKINGDIR%
goto extractsystemdat
:extractsystemdat
echo Attendere, inizio conversione in "system.new.img"...
echo.
echo Ci vorra' qualche minuto...
echo.
%TOOLS%\sdat2img %WORKINGDIR%\system.transfer.list %WORKINGDIR%\system.new.dat %WORKINGDIR%\system.new.img >> %LOG%/systemnewdat_log
echo Attendere, scompattamento "system.new.img"...
echo.
echo Ci vorra' qualche minuto...
echo.
%TOOLS%\Imgextractor.exe %WORKINGDIR%\system.new.img %SYSTEMDAT%\system -i >> %LOG%/systemnewdat_log
rmdir %WORKINGDIR% /s /q>NUL
del %SYSTEMDAT%\system_statfile.txt
echo Fatto. Puoi trovare il contenuto estratto nella cartella /systemnewdat_extract
echo.
echo I file superflui sono stati eliminati tranne la rom originale ".zip"
echo.
echo Si ringrazia xpirt e Alexey71 di XDA per aver fornito questi strumenti.
echo.
pause
goto home

:fastbootoem
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo La funzione che stai per utilizzare ti permette di verificare lo stato del tuo bootloader, per far funzionare questa feature devi mettere il dispositivo in modalita' FASTBOOT
echo.
echo Che processore monta il tuo dispositivo?
echo.
echo Digita "1" Se hai un processore QUALCOMM 
echo Digita "2" Se hai un processore MEDIATEK
echo.
echo.
set/p device_info=Digita un numero:
if "%device_info%"=="1" goto device_info_qualcomm
if "%device_info%"=="2" goto device_info_mediatek
:device_info_qualcomm
echo.
%FASTBOOT% oem device-info
echo.
echo Se hai la stringa "Device unlocked: true" il dispositivo e' sbloccato
echo Se hai la stringa "Device unlocked: false" il dispositivo non e' sbloccato
echo.
pause
goto extra_home
:device_info_mediatek
echo.
%FASTBOOT% getvar all
echo.
echo Se hai la stringa "unlocked: yes" il dispositivo e' sbloccato
echo Se hai la stringa "unlocked: no" il dispositivo non e' sbloccato
echo.
pause
goto extra_home

:FAQ
start "" http://www.miui.it/forum/index.php?threads/tool-miui-recovery-tool-by-miui-it.18681/
pause
goto extra_home

REM FASTBOOT
:fastboot_home
mode con:cols=81 lines=39
cls

echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo    TERMINALI FASTBOOT:
echo.
echo.
echo    1. Mi 2/2S                 18. Redmi 3/Pro            35. Mi Pad 3
echo    2. Mi 3W/4W                19. Redmi 3s/3x    
echo    3. Mi 4c                   20. Redmi 4
echo    4. Mi 4s                   21. Redmi 4A
echo    5. Mi 4i                   22. Redmi 4 Prime
echo    6. Mi 5                    23. Redmi 4X
echo    7. Mi 5s                   24. Redmi Note 4g
echo    8. Mi 5s Plus              25. Redmi Note 1s
echo    9. Mi Note                 26. Redmi Note 2
echo   10. Mi Note 2               27. Redmi Note 3
echo   11. Mi Note Pro             28. Redmi Note 3 Pro
echo   12. Mi Max                  29. Redmi Note 3 Pro SE
echo   13. Mi Max Pro              30. Redmi Note 4 
echo   14. Mi Mix                  31. Redmi Note 4X  
echo   15. Redmi 1S                32. Redmi Pro
echo   16. Redmi 2 (4.4)/(5.1)     33. Mi Pad       
echo   17. Redmi 2 Pro(4.4)/(5.1)  34. Mi Pad 2   
echo.  
echo.
echo.
echo   0.Torna alla schermata principale           
echo.                                                                                                           
echo.
set/p menu= Scegli l'opzione desiderata: 
if "%menu%"=="1" goto aries_fastboot
if "%menu%"=="2" goto cancro_fastboot
if "%menu%"=="3" goto libra_fastboot
if "%menu%"=="4" goto aqua_fastboot
if "%menu%"=="5" goto ferrari_fastboot
if "%menu%"=="6" goto gemini_fastboot
if "%menu%"=="7" goto capricorn_fastboot
if "%menu%"=="8" goto natrium_fastboot
if "%menu%"=="9" goto virgo_fastboot
if "%menu%"=="10" goto scorpio_fastboot
if "%menu%"=="11" goto leo_fastboot
if "%menu%"=="12" goto hydrogen_fastboot
if "%menu%"=="13" goto helium_fastboot
if "%menu%"=="14" goto lithium_fastboot
if "%menu%"=="15" goto armani_fastboot
if "%menu%"=="16" goto HM2014811_fastboot
if "%menu%"=="17" goto HM2014813_fastboot
if "%menu%"=="18" goto ido_fastboot
if "%menu%"=="19" goto land_fastboot
if "%menu%"=="20" goto prada_fastboot 
if "%menu%"=="21" goto rolex_fastboot
if "%menu%"=="22" goto markw_fastboot
if "%menu%"=="23" goto santoni_fastboot 
if "%menu%"=="24" goto dior_fastboot
if "%menu%"=="25" goto gucci_fastboot
if "%menu%"=="26" goto hermes_fastboot
if "%menu%"=="27" goto hennessy_fastboot
if "%menu%"=="28" goto kenzo_fastboot 
if "%menu%"=="29" goto kate_fastboot
if "%menu%"=="30" goto nikel_fastboot
if "%menu%"=="31" goto mido_fastboot
if "%menu%"=="32" goto omega_fastboot
if "%menu%"=="33" goto mocha_fastboot
if "%menu%"=="34" goto latte_fastboot
if "%menu%"=="35" goto cappu_fastboot
if "%menu%"=="0" goto home

:aries_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:aries_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto aries_S
if "%option%"=="s" goto aries_S
if "%option%"=="N" goto aries_N
if "%option%"=="n" goto aries_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto aries_restart


:aries_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_aries
) else (
goto checktgz_aries)
:checktgz_aries
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_aries)
:extracttar_aries
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_aries
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_aries
echo.
echo Stai per avviare il ripristino del Mi 2/2S...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_except_storage"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_except_storage.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:aries_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:cancro_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:cancro_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto cancro_S
if "%option%"=="s" goto cancro_S
if "%option%"=="N" goto cancro_N
if "%option%"=="n" goto cancro_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto cancro_restart

:cancro_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_cancro
) else (
goto checktgz_cancro)
:checktgz_cancro
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_cancro)
:extracttar_cancro
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_cancro
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_cancro
echo.
echo Stai per avviare il ripristino del Mi 3/4W...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_except_storage"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_except_storage.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:cancro_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:libra_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:libra_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto libra_S
if "%option%"=="s" goto libra_S
if "%option%"=="N" goto libra_N
if "%option%"=="n" goto libra_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto libra_restart

:libra_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_libra
) else (
goto checktgz_libra)
:checktgz_libra
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_libra)
:extracttar_libra
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_libra
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_libra
echo.
echo Stai per avviare il ripristino del Mi 4c...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:libra_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:aqua_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:aries_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto aqua_S
if "%option%"=="s" goto aqua_S
if "%option%"=="N" goto aqua_N
if "%option%"=="n" goto aqua_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto aqua_restart

:aqua_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_aqua
) else (
goto checktgz_aqua)
:checktgz_aqua
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_aqua)
:extracttar_aqua
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_aqua
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_aqua
echo.
echo Stai per avviare il ripristino del Mi 4s...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:aqua_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:ferrari_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:ferrari_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto ferrari_S
if "%option%"=="s" goto ferrari_S
if "%option%"=="N" goto ferrari_N
if "%option%"=="n" goto ferrari_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto ferrari_restart

:ferrari_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_ferrari
) else (
goto checktgz_ferrari)
:checktgz_ferrari
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_ferrari)
:extracttar_ferrari
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_ferrari
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_ferrari
echo.
echo Stai per avviare il ripristino del Mi 4i...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:ferrari_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:gemini_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:gemini_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto gemini_S
if "%option%"=="s" goto gemini_S
if "%option%"=="N" goto gemini_N
if "%option%"=="n" goto gemini_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto gemini_restart

:gemini_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_gemini
) else (
goto checktgz_gemini)
:checktgz_gemini
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_gemini)
:extracttar_gemini
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_gemini
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_gemini
echo.
echo Stai per avviare il ripristino del Mi 5...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo Se premi "4" avvierai l'opzione "flash_all_lock_crc"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
if "%option%"=="4" CALL %FASTBOOTROM%\flash_all_lock_crc.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:gemini_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:capricorn_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:capricorn_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto capricorn_S
if "%option%"=="s" goto capricorn_S
if "%option%"=="N" goto capricorn_N
if "%option%"=="n" goto capricorn_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto capricorn_restart

:capricorn_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_capricorn
) else (
goto checktgz_capricorn)
:checktgz_capricorn
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_capricorn)
:extracttar_capricorn
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_capricorn
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_capricorn
echo.
echo Stai per avviare il ripristino del Mi 5s...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo Se premi "4" avvierai l'opzione "flash_all_lock_crc"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
if "%option%"=="4" CALL %FASTBOOTROM%\flash_all_lock_crc.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:capricorn_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:natrium_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:natrium_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto natrium_S
if "%option%"=="s" goto natrium_S
if "%option%"=="N" goto natrium_N
if "%option%"=="n" goto natrium_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto natrium_restart

:natrium_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_natrium
) else (
goto checktgz_natrium)
:checktgz_natrium
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_natrium)
:extracttar_natrium
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_natrium
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_natrium
echo.
echo Stai per avviare il ripristino del Mi 5s Plus...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo Se premi "4" avvierai l'opzione "flash_all_lock_crc"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
if "%option%"=="4" CALL %FASTBOOTROM%\flash_all_lock_crc.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:natrium_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:virgo_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:virgo_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto virgo_S
if "%option%"=="s" goto virgo_S
if "%option%"=="N" goto virgo_N
if "%option%"=="n" goto virgo_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto virgo_restart

:virgo_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_virgo
) else (
goto checktgz_virgo)
:checktgz_virgo
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_virgo)
:extracttar_virgo
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_virgo
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_virgo
echo.
echo Stai per avviare il ripristino del Mi Note...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_except_storage"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_except_storage.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:virgo_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:scorpio_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:scorpio_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto scorpio_S
if "%option%"=="s" goto scorpio_S
if "%option%"=="N" goto scorpio_N
if "%option%"=="n" goto scorpio_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto scorpio_restart

:scorpio_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_scorpio
) else (
goto checktgz_scorpio)
:checktgz_scorpio
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_scorpio)
:extracttar_scorpio
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_scorpio
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_scorpio
echo.
echo Stai per avviare il ripristino del Mi Note 2...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo Se premi "4" avvierai l'opzione "flash_all_lock_crc"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
if "%option%"=="4" CALL %FASTBOOTROM%\flash_all_lock_crc.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:scorpio_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:leo_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:leo_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto leo_S
if "%option%"=="s" goto leo_S
if "%option%"=="N" goto leo_N
if "%option%"=="n" goto leo_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto leo_restart

:leo_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_leo
) else (
goto checktgz_leo)
:checktgz_leo
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_leo)
:extracttar_leo
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_leo
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_leo
echo.
echo Stai per avviare il ripristino del Mi Note Pro...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:leo_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:hydrogen_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:hydrogen_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto hydrogen_S
if "%option%"=="s" goto hydrogen_S
if "%option%"=="N" goto hydrogen_N
if "%option%"=="n" goto hydrogen_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto hydrogen_restart

:hydrogen_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_hydrogen
) else (
goto checktgz_hydrogen)
:checktgz_hydrogen
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_hydrogen)
:extracttar_hydrogen
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_hydrogen
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_hydrogen
echo.
echo Stai per avviare il ripristino del Mi Max...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo Se premi "4" avvierai l'opzione "flash_all_lock_crc"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
if "%option%"=="4" CALL %FASTBOOTROM%\flash_all_lock_crc.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:hydrogen_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:helium_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:helium_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto helium_S
if "%option%"=="s" goto helium_S
if "%option%"=="N" goto helium_N
if "%option%"=="n" goto helium_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto helium_restart

:helium_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_helium
) else (
goto checktgz_helium)
:checktgz_helium
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_helium)
:extracttar_helium
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_helium
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_helium
echo.
echo Stai per avviare il ripristino del Mi Max Pro...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo Se premi "4" avvierai l'opzione "flash_all_lock_crc"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
if "%option%"=="4" CALL %FASTBOOTROM%\flash_all_lock_crc.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:helium_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:lithium_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:lithium_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto lithium_S
if "%option%"=="s" goto lithium_S
if "%option%"=="N" goto lithium_N
if "%option%"=="n" goto lithium_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto lithium_restart

:lithium_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_lithium
) else (
goto checktgz_lithium)
:checktgz_lithium
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_lithium)
:extracttar_lithium
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_lithium
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_lithium
echo.
echo Stai per avviare il ripristino del Mi Mix...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo Se premi "4" avvierai l'opzione "flash_all_lock_crc"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
if "%option%"=="4" CALL %FASTBOOTROM%\flash_all_lock_crc.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:lithium_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:armani_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:armani_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto armani_S
if "%option%"=="s" goto armani_S
if "%option%"=="N" goto armani_N
if "%option%"=="n" goto armani_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto armani_restart

:armani_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_armani
) else (
goto checktgz_armani)
:checktgz_armani
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_armani)
:extracttar_armani
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_armani
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_armani
echo.
echo Stai per avviare il ripristino del Redmi 1s...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_except_storage"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_except_storage.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:armani_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:HM2014811_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:HM2014811_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto HM2014811_S
if "%option%"=="s" goto HM2014811_S
if "%option%"=="N" goto HM2014811_N
if "%option%"=="n" goto HM2014811_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto HM2014811_restart

:HM2014811_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_HM2014811
) else (
goto checktgz_HM2014811)
:checktgz_HM2014811
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_HM2014811)
:extracttar_HM2014811
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_HM2014811
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_HM2014811
echo.
echo Stai per avviare il ripristino del Redmi 2...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_except_storage"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_except_storage.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:HM2014811_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home


:HM2014813_fastboot
cls
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:HM2014813_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto HM2014813_S
if "%option%"=="s" goto HM2014813_S
if "%option%"=="N" goto HM2014813_N
if "%option%"=="n" goto HM2014813_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto HM2014813_restart

:HM2014813_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_HM2014813
) else (
goto checktgz_HM2014813)
:checktgz_HM2014813
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_HM2014813)
:extracttar_HM2014813
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_HM2014813
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_HM2014813
echo.
echo Stai per avviare il ripristino del Redmi 2 Pro...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_except_storage"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_except_storage.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:HM2014813_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:ido_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:ido_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto ido_S
if "%option%"=="s" goto ido_S
if "%option%"=="N" goto ido_N
if "%option%"=="n" goto ido_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto ido_restart

:ido_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_ido
) else (
goto checktgz_ido)
:checktgz_ido
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_ido)
:extracttar_ido
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_ido
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_ido
echo.
echo Stai per avviare il ripristino del Redmi 3/Pro...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:ido_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:land_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:land_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto land_S
if "%option%"=="s" goto land_S
if "%option%"=="N" goto land_N
if "%option%"=="n" goto land_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto land_restart

:land_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_land
) else (
goto checktgz_land)
:checktgz_land
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_land)
:extracttar_land
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_land
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_land
echo.
echo Stai per avviare il ripristino del Redmi 3s/3x...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:land_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:prada_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:prada_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto prada_S
if "%option%"=="s" goto prada_S
if "%option%"=="N" goto prada_N
if "%option%"=="n" goto prada_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto prada_restart

:prada_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_prada
) else (
goto checktgz_prada)
:checktgz_prada
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_prada)
:extracttar_prada
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_prada
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_prada
echo.
echo Stai per avviare il ripristino del Redmi 4...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:prada_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:rolex_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:rolex_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto rolex_S
if "%option%"=="s" goto rolex_S
if "%option%"=="N" goto rolex_N
if "%option%"=="n" goto rolex_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto rolex_restart

:rolex_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_rolex
) else (
goto checktgz_rolex)
:checktgz_rolex
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_rolex)
:extracttar_rolex
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_rolex
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_rolex
echo.
echo Stai per avviare il ripristino del Redmi 4A...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:rolex_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:markw_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:markw_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto markw_S
if "%option%"=="s" goto markw_S
if "%option%"=="N" goto markw_N
if "%option%"=="n" goto markw_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto markw_restart

:markw_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_markw
) else (
goto checktgz_markw)
:checktgz_markw
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_markw)
:extracttar_markw
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_markw
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_markw
echo.
echo Stai per avviare il ripristino del Redmi 4 Prime...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:markw_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:santoni_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:santoni_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto santoni_S
if "%option%"=="s" goto santoni_S
if "%option%"=="N" goto santoni_N
if "%option%"=="n" goto santoni_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto santoni_restart

:santoni_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_santoni
) else (
goto checktgz_santoni)
:checktgz_santoni
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_santoni)
:extracttar_santoni
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_santoni
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_santoni
echo.
echo Stai per avviare il ripristino del Redmi 4X...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:santoni_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:dior_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:dior_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto dior_S
if "%option%"=="s" goto dior_S
if "%option%"=="N" goto dior_N
if "%option%"=="n" goto dior_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto dior_restart

:dior_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_dior
) else (
goto checktgz_dior)
:checktgz_dior
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_dior)
:extracttar_dior
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_dior
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_dior
echo.
echo Stai per avviare il ripristino del Redmi Note 4g...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_except_storage"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_except_storage.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:dior_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:gucci_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:gucci_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto gucci_S
if "%option%"=="s" goto gucci_S
if "%option%"=="N" goto gucci_N
if "%option%"=="n" goto gucci_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto gucci_restart

:gucci_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_gucci
) else (
goto checktgz_gucci)
:checktgz_gucci
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_gucci)
:extracttar_gucci
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_gucci
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_gucci
echo.
echo Stai per avviare il ripristino del Redmi Note 1s...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:gucci_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:hermes_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:hermes_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto hermes_S
if "%option%"=="s" goto hermes_S
if "%option%"=="N" goto hermes_N
if "%option%"=="n" goto hermes_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto hermes_restart

:hermes_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_hermes
) else (
goto checktgz_hermes)
:checktgz_hermes
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_hermes)
:extracttar_hermes
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_hermes
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_hermes
echo.
echo Stai per avviare il ripristino del Redmi Note 2...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:hermes_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:hennessy_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:hennessy_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto hennessy_S
if "%option%"=="s" goto hennessy_S
if "%option%"=="N" goto hennessy_N
if "%option%"=="n" goto hennessy_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto hennessy_restart

:hennessy_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_hennessy
) else (
goto checktgz_hennessy)
:checktgz_hennessy
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_hennessy)
:extracttar_hennessy
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_hennessy
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_hennessy
echo.
echo Stai per avviare il ripristino del Redmi Note 3...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:hennessy_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:kenzo_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:kenzo_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto kenzo_S
if "%option%"=="s" goto kenzo_S
if "%option%"=="N" goto kenzo_N
if "%option%"=="n" goto kenzo_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto kenzo_restart

:kenzo_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_kenzo
) else (
goto checktgz_kenzo)
:checktgz_kenzo
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_kenzo)
:extracttar_kenzo
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_kenzo
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_kenzo
echo.
echo Stai per avviare il ripristino del Redmi Note 3 Pro...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:kenzo_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:kate_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:kate_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto kate_S
if "%option%"=="s" goto kate_S
if "%option%"=="N" goto kate_N
if "%option%"=="n" goto kate_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto kate_restart

:kate_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_kate
) else (
goto checktgz_kate)
:checktgz_kate
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_kate)
:extracttar_kate
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_kate
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_kate
echo.
echo Stai per avviare il ripristino del Redmi Note 3 Pro Special Edition...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:kate_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:nikel_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:nikel_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto nikel_S
if "%option%"=="s" goto nikel_S
if "%option%"=="N" goto nikel_N
if "%option%"=="n" goto nikel_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto nikel_restart

:nikel_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_nikel
) else (
goto checktgz_nikel)
:checktgz_nikel
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_nikel)
:extracttar_nikel
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_nikel
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_nikel
echo.
echo Stai per avviare il ripristino del Redmi Note 4...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:nikel_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:mido_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:mido_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto mido_S
if "%option%"=="s" goto mido_S
if "%option%"=="N" goto mido_N
if "%option%"=="n" goto mido_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto mido_restart

:mido_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_mido
) else (
goto checktgz_mido)
:checktgz_mido
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_mido)
:extracttar_mido
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_mido
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_mido
echo.
echo Stai per avviare il ripristino del Redmi Note 4X...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo Se premi "4" avvierai l'opzione "flash_factory"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
if "%option%"=="4" CALL %FASTBOOTROM%\flash_factory.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:mido_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:omega_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:omega_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto omega_S
if "%option%"=="s" goto omega_S
if "%option%"=="N" goto omega_N
if "%option%"=="n" goto omega_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto omega_restart

:omega_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_omega
) else (
goto checktgz_omega)
:checktgz_omega
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_omega)
:extracttar_omega
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_omega
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_omega
echo.
echo Stai per avviare il ripristino del Redmi Pro...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_lock"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_lock.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:omega_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:mocha_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:mocha_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto mocha_S
if "%option%"=="s" goto mocha_S
if "%option%"=="N" goto mocha_N
if "%option%"=="n" goto mocha_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto mocha_restart

:mocha_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_mocha
) else (
goto checktgz_mocha)
:checktgz_mocha
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_mocha)
:extracttar_mocha
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_mocha
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_mocha
echo.
echo Stai per avviare il ripristino del Mi Pad...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_except_storage"
echo Se premi "4" avvierai l'opzione "nvflash_all"
echo Se premi "5" avvierai l'opzione "nvflash_all_except_data"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_except_storage.bat
if "%option%"=="4" CALL %FASTBOOTROM%\nvflash_all.bat
if "%option%"=="5" CALL %FASTBOOTROM%\nvflash_all_except_data.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:mocha_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home


:latte_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:latte_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto latte_S
if "%option%"=="s" goto latte_S
if "%option%"=="N" goto latte_N
if "%option%"=="n" goto latte_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto latte_restart

:latte_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_latte
) else (
goto checktgz_latte)
:checktgz_latte
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_latte)
:extracttar_latte
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_latte
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_latte
echo.
echo Stai per avviare il ripristino del Mi Pad 2...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:latte_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home

:cappu_fastboot
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Devi prima scaricare l'ultima ROM FASTBOOT disponibile per il tuo terminale premi il tasto "I" per aprire la pagina
echo.
echo Una volta scaricato, inserisci il file nella cartella /fastboot_rom
echo.
echo Collega il tuo dispositivo al PC in modalita' FASTBOOT
echo.
echo Stai per procedere al ripristino tramite la ROM FASTBOOT
echo.
echo Se premi "S" procederai al flash
echo Se Premi "N" annullerai il flash
:cappu_restart
echo.
set/p option=Digita l'operazione desiderata:
if "%option%"=="S" goto cappu_S
if "%option%"=="s" goto cappu_S
if "%option%"=="N" goto cappu_N
if "%option%"=="n" goto cappu_N
if "%option%"=="I" start "" http://en.miui.com/a-234.html
if "%option%"=="i" start "" http://en.miui.com/a-234.html
goto cappu_restart

:cappu_S
echo.
IF EXIST "%FASTBOOTROM%\*.tar" (
goto extracttar_cappu
) else (
goto checktgz_cappu)
:checktgz_cappu
IF EXIST "%FASTBOOTROM%\*.tgz" (
echo.
echo Estrazione in corso, richiedera' qualche minuto...
%TOOLS%\\7za e %FASTBOOTROM%\*.tgz -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.tar" ( goto extracttar_cappu)
:extracttar_cappu
%TOOLS%\\7za e %WORKINGDIR%\*.tar -o%WORKINGDIR%
echo.
echo Si sta procedendo alla modifica dei file...
mkdir %FASTBOOTROM%/images>NUL
IF EXIST "%WORKINGDIR%\*.tar" ( del %WORKINGDIR%\*.tar )>NUL
IF EXIST "%WORKINGDIR%\*.bat" ( move %WORKINGDIR%\*.bat %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.sh" ( move %WORKINGDIR%\*.sh %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\*.py" ( move %WORKINGDIR%\*.py %FASTBOOTROM% )>NUL
IF EXIST "%WORKINGDIR%\misc.txt" ( move %WORKINGDIR%\misc.txt %FASTBOOTROM% )>NUL
%XCOPY% /s %WORKINGDIR% %FASTBOOTROM%\images>NUL
rmdir %WORKINGDIR% /s /q>NUL
IF EXIST "%FASTBOOTROM%\*.tgz" (del %FASTBOOTROM%\*.tgz)>NUL
IF EXIST "%FASTBOOTROM%\*.tar" (del %FASTBOOTROM%\*.tar)>NUL
copy %TOOLS%\fart.exe %FASTBOOTROM%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat ~dp0 FASTBOOTROM%%\>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat fastboot %%FASTBOOT%%>NUL
%FASTBOOTROM%\fart %FASTBOOTROM%\*.bat findstr %%FIND%%>NUL
goto start_cappu
) else (
echo Il TOOL non e' in grado di eseguire questa funzionalita' perche' non hai inserito la rom fastboot dentro la cartella /fastboot_rom
echo.
pause
goto home)
:start_cappu
echo.
echo Stai per avviare il ripristino del Mi Pad 3...
echo.
echo Scegli l'opzione che ti interessa:
echo.
echo Se premi "1" avvierai l'opzione "flash_all"
echo Se premi "2" avvierai l'opzione "flash_all_except_data_storage"
echo Se premi "3" avvierai l'opzione "flash_all_crc"
echo.
set/p option=Scegli un numero:
if "%option%"=="1" CALL %FASTBOOTROM%\flash_all.bat
if "%option%"=="2" CALL %FASTBOOTROM%\flash_all_except_data_storage.bat
if "%option%"=="3" CALL %FASTBOOTROM%\flash_all_crc.bat
echo.
echo Riavvio dispositivo in corso...
echo.
echo I file estratti sono stati cancellati in automatico!
rmdir %FASTBOOTROM% /s /q>NUL
mkdir %FASTBOOTROM%>NUL
echo.
pause
goto fastboot_home

:cappu_N
echo.
echo Hai deciso di annullare il ripristino totale!
echo.
pause
goto fastboot_home



:blockesecutionfeature
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo Il TOOL non puo' essere eseguire questa feature perche' la nuova interfaccia non e' ancora pronta
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
pause
goto home

:checkyourdeviceflash
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Questa funzione permette di eseguire il flash dei file utilizzando solamente la rom miui.it del proprio dispositivo
echo.
echo Una volta scaricata devi metterla nella cartella /ROM
echo.
echo ATTENZIONE: Per utilizzare questa funziona devi collegare il dispositivo in modalita' FASTBOOT
echo.
pause
goto startflash
:startflash
IF EXIST "%LOG%/download_log" (del %LOG%\download_log)
IF EXIST "%LOG%/systemnewdat_log" (del %LOG%\systemnewdat_log)
IF EXIST "%RECOVERY%/*.img" (del %RECOVERY%\*.img)
IF EXIST "%BOOT%/*.img" (del %BOOT%\*.img)
cls
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo Rilevamento file .zip in corso...
echo.
IF EXIST "%ROM%\*.zip" (
goto extractzip
) else (
echo Non e' stato inserito nessun file zip)
echo.
pause
goto home
:extractzip
echo File .zip rivelato!
echo.
echo Estrazione file .zip in corso...
IF NOT EXIST "%WORKINGDIR%" (mkdir %WORKINGDIR%) 
%TOOLS%\\7za x %ROM%/*.zip -o%WORKINGDIR%
IF EXIST "%WORKINGDIR%\*.dat" (
goto extractsystemdat2
) else (
echo.
goto deletefiles)
:deletefiles
echo Eliminazione file superflui in corso...
IF EXIST "%WORKINGDIR%\system\build.prop" (move %WORKINGDIR%\system\build.prop %ROM%)>NUL
IF EXIST "%WORKINGDIR%\boot.img" (move %WORKINGDIR%\boot.img %BOOT%)>NUL
IF EXIST "%WORKINGDIR%\recovery\twrp.img" (move %WORKINGDIR%\recovery\twrp.img %RECOVERY%)>NUL
rmdir %WORKINGDIR% /s /q>NUL
goto checkdevice
echo.
:extractsystemdat2
echo.
echo Attendere, inizio conversione in "system.new.img"...
echo.
echo Ci vorra' qualche minuto...
echo.
%TOOLS%\sdat2img %WORKINGDIR%\system.transfer.list %WORKINGDIR%\system.new.dat %WORKINGDIR%\system.new.img >> %LOG%/systemnewdat_log
echo Attendere, scompattamento "system.new.img"...
echo.
echo Ci vorra' qualche minuto...
echo.
%TOOLS%\Imgextractor.exe %WORKINGDIR%\system.new.img %WORKINGDIR%\system -i >> %LOG%/systemnewdat_log
goto deletefiles
:checkdevice
echo.
%FIND% /m "ro.product.device=aries" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi2\2s rilevato!
goto aries_automatic
)
%FIND% /m "ro.product.device=cancro" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi3W\4W rilevato!
goto cancro_automatic
)
%FIND% /m "ro.product.device=libra" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi 4c rilevato!
goto libra_automatic
)
%FIND% /m "ro.product.device=aqua" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi 4s rilevato!
goto aqua_automatic
)
%FIND% /m "ro.product.device=ferrari" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi 4i!
goto aries_automatic
)
%FIND% /m "ro.product.device=gemini" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi5 rilevato!
goto gemini_automatic
)
%FIND% /m "ro.product.device=capricorn" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi 5s rilevato!
goto capricorn_automatic
)
%FIND% /m "ro.product.device=natrium" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi 5s Plus rilevato!
goto natrium_automatic
)
%FIND% /m "ro.product.device=song" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi 5c rilevato!
goto song_automatic
)
%FIND% /m "ro.product.device=virgo" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi Note rilevato!
goto virgo_automatic
)
%FIND% /m "ro.product.device=scorpio" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi Note 2 rilevato!
goto scorpio_automatic
)
%FIND% /m "ro.product.device=leo" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi Note Pro rilevato!
goto leo_automatic
)
%FIND% /m "ro.product.device=hydrogen" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi Max rilevato!
goto hydrogen_automatic
)
%FIND% /m "ro.product.device=helium" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi Max Pro rilevato!
goto helium_automatic
)
%FIND% /m "ro.product.device=lithium" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi Mix rilevato!
goto lithium_automatic
)
%FIND% /m "ro.product.device=HM2013023" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi 1 rilevato!
goto HM2013023_automatic
)
%FIND% /m "ro.product.device=armani" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi 1s rilevato!
goto armani_automatic
)
%FIND% /m "ro.product.device=HM2014811" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi 2 4.4 rilevato!
goto HM2014811_automatic
)
%FIND% /m "ro.product.device=HM2014813" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi 2 Pro 4.4 rilevato!
goto HM2014813_automatic
)
%FIND% /m "ro.product.device=wt88047" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi 2 5.1 rilevato!
goto wt88047_automatic
)
%FIND% /m "ro.product.device=wt86047" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi 2 Pro 5.1 rilevato!
goto wt86047_automatic
)
%FIND% /m "ro.product.device=ido" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi 3/3 Pro rilevato!
goto ido_automatic
)
%FIND% /m "ro.product.device=land" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi 3s/3x Pro rilevato!
goto ido_automatic
)
%FIND% /m "ro.product.device=prada" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi 4 rilevato!
goto prada_automatic
)
%FIND% /m "ro.product.device=rolex" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi 4A rilevato!
goto rolex_automatic
)
%FIND% /m "ro.product.device=markw" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi 4 Pro rilevato!
goto markw_automatic
)
%FIND% /m "ro.product.device=santoni" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi 4X rilevato!
goto santoni_automatic
)
%FIND% /m "ro.product.device=lcsh92_wet_jb9" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi Note 3G rilevato!
goto lcsh92_wet_jb9_automatic
)
%FIND% /m "ro.product.device=dior" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi Note 4G rilevato!
goto dior_automatic
)
%FIND% /m "ro.product.device=gucci" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi Note 1s rilevato!
goto gucci_automatic
)
%FIND% /m "ro.product.device=hermes" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi Note 2 rilevato!
goto hermes_automatic
)
%FIND% /m "ro.product.device=hennessy" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi Note 3 rilevato!
goto hennessy_automatic
)
%FIND% /m "ro.product.device=kenzo" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi Note 3 Pro rilevato!
goto kenzo_automatic
)
%FIND% /m "ro.product.device=kate" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi Note 3 Pro SE rilevato!
goto kate_automatic
)
%FIND% /m "ro.product.device=nikel" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi Note 4 rilevato!
goto nikel_automatic
)
%FIND% /m "ro.product.device=mido" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi Note 4X rilevato!
goto mido_automatic
)
%FIND% /m "ro.product.device=omega" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Redmi Pro rilevato!
goto omega_automatic
)
%FIND% /m "ro.product.device=mocha" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi Pad rilevato!
goto mocha_automatic
)
%FIND% /m "ro.product.device=latte" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi Pad 2 rilevato!
goto latte_automatic
)
%FIND% /m "ro.product.device=cappu" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Mi Pad 3 rilevato!
goto cappu_automatic
)
%FIND% /m "ro.product.device=hammerhead" %ROM%\build.prop>NUL
if %errorlevel%==0 (
echo Google Nexus 5 rilevato!
goto hammerhead_automatic
)
echo Dispositivo non supportato!
IF EXIST "%ROM%\build.prop" (del %ROM%\build.prop)>NUL
echo.
pause
goto home

:blockesecution
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo x                                                                              x
echo x                              MIUI Recovery Tool                              x
echo x                                     by                                       x
echo x                                 www.miui.it                                  x
echo x                                                                              x
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo Il TOOL non puo' essere eseguito perche' non si trova nella sua directory, si prega di estrarlo in C:\MIUI_Recovery_Tool, se non hai il drive C:\, puoi cambiarlo in base alle esigenze del tuo sistema ad esempio D:\MIUI_Recovery_Tool
echo.
echo.
echo.
echo. 
echo.
echo.
echo.
echo.
echo Se vuoi vedere come configurarlo premi il tasto "I" per le informazioni oppure premi "E" per uscire
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set/p option=Scegli un opzione:
if "%option%"=="I" start "" http://www.miui.it/forum/index.php?threads/tool-miui-recovery-tool-by-miui-it.18681/
if "%option%"=="i" start "" http://www.miui.it/forum/index.php?threads/tool-miui-recovery-tool-by-miui-it.18681/
if "%option%"=="E" exit
if "%option%"=="e" exit
