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
echo Executor by malte27

echo [1] Execute Lua

echo [2] Inject DLL

echo.
set /p input=Choose an option: 
if "%input%"=="1" goto select_lua
if "%input%"=="2" goto select_dll

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

:select_dll
cls
echo Geben Sie den Pfad zur DLL-Datei ein:
set /p dllFile=Pfad: 
if not exist "%dllFile%" (
    echo Datei nicht gefunden!
    pause
    goto menu
)

goto select_game_dll

:select_game
cls
echo [1] Manuell Spielpfad eingeben

echo [2] Alle offenen Spiele anzeigen
set /p gameOption=Wahl: 
if "%gameOption%"=="1" goto manual_game
if "%gameOption%"=="2" goto list_games

goto select_game

:select_game_dll
cls
echo [1] Manuell Spielpfad eingeben

echo [2] Alle offenen Spiele anzeigen
set /p gameOption=Wahl: 
if "%gameOption%"=="1" goto manual_game_dll
if "%gameOption%"=="2" goto list_games_dll

goto select_game_dll

:manual_game
echo Geben Sie den Pfad zum Spiel ein:
set /p gamePath=Pfad: 
if not exist "%gamePath%" (
    echo Spiel nicht gefunden!
    pause
    goto menu
)

goto execute_lua

:manual_game_dll
echo Geben Sie den Pfad zum Spiel ein:
set /p gamePath=Pfad: 
if not exist "%gamePath%" (
    echo Spiel nicht gefunden!
    pause
    goto menu
)

goto inject_dll

:list_games
tasklist /FI "IMAGENAME ne explorer.exe" | findstr ".exe"
echo Geben Sie den Namen des Spiels ein (mit .exe):
set /p gamePath=Name: 
if not exist "%gamePath%" (
    echo Spiel nicht gefunden!
    pause
    goto menu
)

goto execute_lua

:list_games_dll
tasklist /FI "IMAGENAME ne explorer.exe" | findstr ".exe"
echo Geben Sie den Namen des Spiels ein (mit .exe):
set /p gamePath=Name: 
if not exist "%gamePath%" (
    echo Spiel nicht gefunden!
    pause
    goto menu
)

goto inject_dll

:execute_lua
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

:inject_dll
cls
echo Injecting DLL...
:: Beispielhafter DLL Injector - Ersetze durch echten Injector
rundll32 "%dllFile%",DllMain 2> "%logFile%"
if %errorlevel%==0 (
    color 0A
    echo DLL injected successfully!
) else (
    color 0C
    echo Failed to inject DLL. Please check log.
)
pause
goto menu