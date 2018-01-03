@echo off
setlocal

rem ----------------------------------------------------------------------------
rem behavior definition
rem ----------------------------------------------------------------------------

set TARGET_DRIVE=E:

rem ----------------------------------------------------------------------------
rem check arguments
rem ----------------------------------------------------------------------------

if "%~1"=="" (
    echo ! Too few arguments.
    exit 1
)

if not exist "%~1" (
    echo ! Specified path is not exists.
    echo path : "%~1"
    exit /b 1
)

if not exist "%~1\" (
    echo ! Specified path is not directory.
    echo path : "%~1"
    exit /b 1
)


rem ----------------------------------------------------------------------------
rem resolve path
rem ----------------------------------------------------------------------------

set COPY_SOURCE=%~1
set COPY_DEST=%TARGET_DRIVE%%~pnx1

echo * COPY_SOURCE="%COPY_SOURCE%"
echo * COPY_DEST="%COPY_DEST%"

rem ----------------------------------------------------------------------------
rem copy, delete, make junction
rem ----------------------------------------------------------------------------

robocopy "%COPY_SOURCE%" "%COPY_DEST%" /E /MOVE /COPY:DATSO /B /R:3 /W:3 /NP /XD "System Volume Information" /XJD
if errorlevel 8 (
    echo ! Failed to copy.
    exit /b 1
)

mklink /d "%COPY_SOURCE%" "%COPY_DEST%"

rem ----------------------------------------------------------------------------
rem normaly exit
rem ----------------------------------------------------------------------------

exit /b 0