@echo off

REM ============================================================
REM JOB PENTAHO - EXECUÇÃO DE ARQUIVO LOCAL
REM ============================================================

REM Caminho do Pentaho Data Integration
set PDI_HOME=C:\data-integration

REM Caminho completo do arquivo .KJB
set JOB_FILE=C:\CAMINHO_JOB\JOB_NAME.kjb

REM Caminho do arquivo de log
set LOG_FILE=C:\CAMINHO_LOG\LOG_NAME.log


REM ============================================================
REM EXECUÇÃO DO JOB
REM ============================================================

"%PDI_HOME%\kitchen.bat" ^
 /file:"%JOB_FILE%" ^
 /level:Basic ^
 > "%LOG_FILE%" 2>&1


REM ============================================================
REM RETORNO DO CÓDIGO DE EXECUÇÃO
REM ============================================================

exit /b %ERRORLEVEL%