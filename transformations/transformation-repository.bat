@echo off

REM ============================================================
REM TRANSFORMATION PENTAHO - EXECUÇÃO VIA REPOSITÓRIO
REM ============================================================

REM Caminho do Pentaho Data Integration
set PDI_HOME=C:\data-integration

REM Nome do repositório Pentaho
set PENTAHO_REPOSITORY=REP_KETTLE_NAME 

REM Nome da Transformation
set TRANSFORMATION_NAME=TRANSFORMATION_NAME

REM Diretório da Transformation dentro do repositório
set TRANSFORMATION_DIRECTORY=/CAMINHO_TRANSFORMATION

REM Credenciais do repositório
set PENTAHO_USER=NOME_USUARIO
set PENTAHO_PASSWORD=SENHA_USUARIO

REM Caminho do arquivo de log
set LOG_FILE=C:\CAMINHO_LOG\LOG_NAME.log


REM ============================================================
REM EXECUÇÃO DA TRANSFORMATION
REM ============================================================

"%PDI_HOME%\pan.bat" ^
 /rep:"%PENTAHO_REPOSITORY%" ^
 /trans:"%TRANSFORMATION_NAME%" ^
 /dir:"%TRANSFORMATION_DIRECTORY%" ^
 /user:"%PENTAHO_USER%" ^
 /pass:"%PENTAHO_PASSWORD%" ^
 /level:Basic ^
 > "%LOG_FILE%" 2>&1


REM ============================================================
REM RETORNO DO CÓDIGO DE EXECUÇÃO
REM ============================================================

exit /b %ERRORLEVEL%