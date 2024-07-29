@echo off
setlocal enabledelayedexpansion

rem Répertoire de base
set baseDir=O:\__BuildFolder

rem Parcourt tous les sous-répertoires
for /r "%baseDir%" %%d in (.) do (
    rem Vérifie l'existence de BuildAndPush.bat dans le sous-répertoire actuel
    if exist "%%d\BuildAndPush.bat" (
        echo Execution de BuildAndPush.bat dans %%d
        pushd "%%d"
        call BuildAndPush.bat
        popd
    )
)

endlocal
echo Termine
pause
