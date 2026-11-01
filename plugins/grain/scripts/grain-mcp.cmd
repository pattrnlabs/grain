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
>&2 echo Then verify the grain.cmd in GRAIN_HOME\bin (or USERPROFILE\.grain\bin) exists and its --help succeeds with a line starting Usage: grain followed by whitespace or end of line before reporting success.
exit /b 1

:check
set "candidate=%~1"
set "GRAIN_CANDIDATE=%candidate%"
powershell.exe -NoProfile -Command "if (-not (Test-Path -LiteralPath $env:GRAIN_CANDIDATE -PathType Leaf)) { exit 1 }; $command = [char]34 + $env:GRAIN_CANDIDATE + [char]34 + ' --help 2>nul'; $output = & $env:ComSpec /d /c $command; if ($LASTEXITCODE -ne 0 -or -not ($output -cmatch '^Usage: grain(\s|$)')) { exit 1 }" >nul
exit /b %ERRORLEVEL%

:launch
call "%candidate%" --stdio
exit /b %ERRORLEVEL%
