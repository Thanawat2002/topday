@REM Clear Terminal
@echo off
call :SetColor & setlocal
cls
echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo. & echo.

@REM Set Everything
set TagDebug = %color%[7m DEBUG %color%[0m
set TagNEWQ=%color%[105;1m NEW Q SECURE %color%[0m

@REM @ Fx & Resorce
set SvFx="C:\Users\resta\Desktop\topday\Fivem Artifact"
set SvResource="C:\Users\resta\Desktop\topday\resources"
@REM @ Settings
set CfgSv="C:\Users\resta\Desktop\topday\server.cfg"
set CfgPermission="C:\Users\resta\Desktop\topday\permission.cfg"
set CfgResource="C:\Users\resta\Desktop\topday\resources.cfg"
@REM @ Resource

@REM Echo Information
echo %TagNEWQ%%color%[92m " Export forn Thanawat Yodsong => discord:[ New Q.#8070 ] " %color%[0m & echo %TagNEWQ%%color%[92m " Obfuscated by Thanawat Yodsond "
echo.& echo.%TagNEWQ% %color%[92;1m :D Developing...  %color%[0m & echo.& echo.& echo.& TIMEOUT 2 > NUL

@REM Echo start server developing
cd /c %SvResource% > NUL
%SvFx%\FXServer +set citizen_dir %SvFx%\citizen\ %* +exec %CfgPermission% +exec %CfgSv% +exec %CfgResource% +svgui +resmon 1

@REM Color set
:SetColor
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
	set color=%%b
	exit /B 0
)