@echo off
setlocal
set "axiom_bash=%ProgramFiles%\Git\bin\bash.exe"
if not exist "%axiom_bash%" set "axiom_bash=%LocalAppData%\Programs\Git\bin\bash.exe"
if not exist "%axiom_bash%" (
    echo Git Bash was not found. Install Git for Windows. 1>&2
    exit /b 1
)
if not defined ODIN_COMMAND (
    where odin.exe >nul 2>&1
    if errorlevel 1 (
        for /d %%D in ("%USERPROFILE%\Tools\Odin-*") do if exist "%%~D\dist\odin.exe" set "ODIN_COMMAND=%%~D/dist/odin.exe"
    )
)
pushd "%~dp0"
"%axiom_bash%" --noprofile --norc ./build.sh %*
set "axiom_exit=%ERRORLEVEL%"
popd
exit /b %axiom_exit%
