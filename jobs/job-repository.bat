@echo off

REM ============================================================
REM JOB PENTAHO - EXECUÇÃO VIA REPOSITÓRIO
REM ============================================================

REM Caminho do Pentaho Data Integration
set PDI_HOME=C:\data-integration

REM Nome do repositório Pentaho
set PENTAHO_REPOSITORY=REP_KETTLE_NAME

REM Nome do Job
set JOB_NAME=JOB_NAME

REM Diretório do Job dentro do repositório
set JOB_DIRECTORY=/CAMINHO_JOB

REM Credenciais do repositório
set PENTAHO_USER=NOME_USUARIO
set PENTAHO_PASSWORD=SENHA_USUARIO

REM Caminho do arquivo de log
set LOG_FILE=C:\CAMINHO_LOG\LOG_NAME.log


REM ============================================================
REM EXECUÇÃO DO JOB
REM ============================================================

"%PDI_HOME%\kitchen.bat" ^
 /rep:"%PENTAHO_REPOSITORY%" ^
 /job:"%JOB_NAME%" ^
 /dir:"%JOB_DIRECTORY%" ^
 /user:"%PENTAHO_USER%" ^
 /pass:"%PENTAHO_PASSWORD%" ^
 /level:Basic ^
 > "%LOG_FILE%" 2>&1


REM ============================================================
REM RETORNO DO CÓDIGO DE EXECUÇÃO
REM ============================================================

exit /b %ERRORLEVEL%