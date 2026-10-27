@echo off
setlocal DisableDelayedExpansion

if defined GRAIN_BIN (
  call :check "%GRAIN_BIN%"
  if not errorlevel 1 goto launch
)

if defined GRAIN_HOME (
  call :check "%GRAIN_HOME%\bin\grain.cmd"
  if not errorlevel 1 goto launch
)

call :check "%USERPROFILE%\.grain\bin\grain.cmd"
if not errorlevel 1 goto launch

for /f "delims=" %%G in ('where.exe grain 2^>nul') do (
  call :check "%%G"
  if not errorlevel 1 (
    set "candidate=%%G"
    goto launch
  )
)

>&2 echo Grain is not installed. Ask the person whether to install it. If they say yes, run: irm https://grain.tools/install.ps1 ^| iex
exit /b 1

:check
set "candidate=%~1"
set "identity="
set "GRAIN_CANDIDATE=%candidate%"
for /f "delims=" %%L in ('powershell.exe -NoProfile -Command "if (Test-Path -LiteralPath $env:GRAIN_CANDIDATE) { $command = [char]34 + $env:GRAIN_CANDIDATE + [char]34 + ' --help 2>nul'; $output = & $env:ComSpec /d /c $command; $code = $LASTEXITCODE; $output | Select-Object -First 1; exit $code } else { exit 1 }"') do if not defined identity set "identity=%%L"
set "probeExit=%ERRORLEVEL%"
if not "%probeExit%"=="0" goto invalid
if not defined identity goto invalid
set "identityValid="
for /f "tokens=1,2" %%A in ("%identity%") do if "%%A %%B"=="Usage: grain" set "identityValid=1"
if not defined identityValid exit /b 1
exit /b 0

:invalid
exit /b 1

:launch
call "%candidate%" --stdio
exit /b %ERRORLEVEL%
