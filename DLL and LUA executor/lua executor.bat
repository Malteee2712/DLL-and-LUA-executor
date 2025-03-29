@echo off
chcp 65001 >nul
color 07
setlocal EnableDelayedExpansion

:: Ordner für Logs erstellen
set "logDir=%USERPROFILE%\Desktop\DLL and LUA executor"
if not exist "%logDir%" mkdir "%logDir%"
set "logFile=%logDir%\log.txt"

:menu
cls
echo Lua Executor by malte27

echo [1] Start

echo.
set /p input=Choose an option: 
if "%input%"=="1" goto select_lua

goto menu

:select_lua
cls
echo Geben Sie den Pfad zur Lua-Datei ein:
set /p luaFile=Pfad: 
if not exist "%luaFile%" (
    echo Datei nicht gefunden!
    pause
    goto menu
)

goto select_game

:select_game
cls
echo [1] Manuell Spielpfad eingeben

echo [2] Alle offenen Spiele anzeigen
set /p gameOption=Wahl: 
if "%gameOption%"=="1" goto manual_game
if "%gameOption%"=="2" goto list_games

goto select_game

:manual_game
echo Geben Sie den Pfad zum Spiel ein:
set /p gamePath=Pfad: 
if not exist "%gamePath%" (
    echo Spiel nicht gefunden!
    pause
    goto menu
)

goto execute

:list_games
tasklist /FI "IMAGENAME ne explorer.exe" | findstr ".exe"
echo Geben Sie den Namen des Spiels ein (mit .exe):
set /p gamePath=Name: 
if not exist "%gamePath%" (
    echo Spiel nicht gefunden!
    pause
    goto menu
)

goto execute

:execute
cls
echo Executing Lua script...
:: Beispielhafte Execution, muss durch echten Lua-Executor ersetzt werden
lua "%luaFile%" 2> "%logFile%"
if %errorlevel%==0 (
    color 0A
    echo Executed successfully!
) else (
    color 0C
    echo Failed to execute. Please check log.
)
pause
goto menu
