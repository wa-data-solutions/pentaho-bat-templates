@echo off

REM ============================================================
REM TRANSFORMATION PENTAHO - EXECUÇÃO DE ARQUIVO LOCAL
REM ============================================================

REM Caminho do Pentaho Data Integration
set PDI_HOME=C:\data-integration

REM Caminho completo do arquivo .KTR
set TRANSFORMATION_FILE=C:\CAMINHO_TRANSFORMATION\TRANSFORMATION_NAME.ktr

REM Caminho do arquivo de log
set LOG_FILE=C:\CAMINHO_LOG\LOG_NAME.log


REM ============================================================
REM EXECUÇÃO DA TRANSFORMATION
REM ============================================================

"%PDI_HOME%\pan.bat" ^
 /file:"%TRANSFORMATION_FILE%" ^
 /level:Basic ^
 > "%LOG_FILE%" 2>&1


REM ============================================================
REM RETORNO DO CÓDIGO DE EXECUÇÃO
REM ============================================================

exit /b %ERRORLEVEL%