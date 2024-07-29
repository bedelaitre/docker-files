@echo off
setlocal enabledelayedexpansion

rem R�pertoire de base
set baseDir=O:\__BuildFolder

rem Parcourt tous les sous-r�pertoires
for /r "%baseDir%" %%d in (.) do (
    rem V�rifie l'existence de BuildAndPush.bat dans le sous-r�pertoire actuel
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
