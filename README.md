# Pentaho BAT Templates

Repositório de scripts `.BAT` reutilizáveis para execução de Jobs e Transformations do Pentaho Data Integration (PDI).

Os scripts deste repositório podem ser utilizados diretamente em servidores Windows e chamados posteriormente por ferramentas de orquestração, como Apache Airflow.

---

# Objetivo

Centralizar modelos de scripts `.BAT` utilizados para executar processos do Pentaho Data Integration.

Principais cenários suportados:

* Execução de Jobs `.kjb`
* Execução de Transformations `.ktr`
* Projetos armazenados em arquivos físicos
* Projetos armazenados em repositórios Pentaho
* Geração de arquivos de log
* Retorno de códigos de execução
* Integração com Apache Airflow

---

# Estrutura do repositório

```text
pentaho-bat-templates/
│
├── README.md
│
├── jobs/
│   ├── job-file.bat
│   └── job-repository.bat
│
└── transformations/
    ├── transformation-file.bat
    └── transformation-repository.bat
```

---

# Tipos de execução do Pentaho

O Pentaho Data Integration possui dois principais executáveis utilizados para processos ETL.

| Processo       | Extensão | Executável    |
| -------------- | -------- | ------------- |
| Job            | `.kjb`   | `kitchen.bat` |
| Transformation | `.ktr`   | `pan.bat`     |

## Kitchen

O `Kitchen` é utilizado para executar Jobs Pentaho.

Exemplo:

```bat
kitchen.bat /file:"C:\Projetos\MeuJob.kjb"
```

## Pan

O `Pan` é utilizado para executar Transformations Pentaho.

Exemplo:

```bat
pan.bat /file:"C:\Projetos\MinhaTransformation.ktr"
```

---

# 1. Job armazenado em arquivo

Arquivo:

```text
jobs/job-file.bat
```

Código:

```bat
@echo off

C:\caminho_pentaho\kitchen.bat ^
 /file:"C:\caminho_job\job_name.kjb" ^
 /level:Basic ^
 > "C:\caminho_log\log_name.log" 2>&1

exit /b %ERRORLEVEL%
```

## Como funciona

### `@echo off`

Desativa a exibição dos comandos executados no terminal.

Isso mantém a saída do script mais limpa.

---

### `C:\caminho_job\kitchen.bat`

Caminho para o executável do Kitchen instalado junto com o Pentaho Data Integration.

O `Kitchen` é responsável por executar arquivos de Job `.kjb`.

---

### `/file`

Indica que o Job será executado diretamente a partir de um arquivo físico.

Exemplo:

```text
/file:"C:\caminho_job\job_name.kjb"
```

---

### `/level:Basic`

Define o nível de detalhamento do log gerado durante a execução.

Alguns níveis utilizados no Pentaho:

```text
Nothing
Error
Minimal
Basic
Detailed
Debug
Rowlevel
```

O nível `Basic` é recomendado para a maioria dos processos de produção.

---

### `> "C:\caminho_log\log_name.log"`

Redireciona a saída normal do processo para um arquivo de log.

---

### `2>&1`

Redireciona também as mensagens de erro para o mesmo arquivo de log.

Dessa forma, a saída normal e os erros ficam centralizados no mesmo arquivo.

---

### `exit /b %ERRORLEVEL%`

Retorna o código final da execução do Pentaho.

Isso é especialmente importante quando o `.BAT` é executado pelo Apache Airflow.

Se o processo retornar sucesso, o script normalmente retorna:

```text
0
```

Se ocorrer erro:

```text
Código diferente de 0
```

O Airflow pode utilizar esse retorno para identificar se a execução da tarefa foi concluída com sucesso ou falhou.

---

# 2. Job armazenado em repositório Pentaho

Arquivo:

```text
jobs/job-repository.bat
```

Código:

```bat
@echo off

C:\data-integration\kitchen.bat ^
 /rep:"REP_KETTLE_TJCE" ^
 /job:"JOB_NAME" ^
 /dir:/CAMINHO_JOB ^
 /user:"NOME_USUARIO" ^
 /pass:"SENHA_USUARIO" ^
 /level:Basic ^
 > "C:\CAMINHO_LOG\LOG_NAME.log" 2>&1

exit /b %ERRORLEVEL%
```

## Como funciona

### `/rep`

Indica o nome do repositório Pentaho configurado.

Exemplo:

```text
/rep:"REP_KETTLE_TJCE"
```

O nome deve corresponder ao repositório previamente configurado no ambiente Pentaho.

---

### `/job`

Indica o nome do Job que será executado.

Exemplo:

```text
/job:"JOB_NAME"
```

Não é necessário informar a extensão `.kjb`.

---

### `/dir`

Indica o diretório onde o Job está armazenado dentro do repositório Pentaho.

Exemplo:

```text
/dir:/CAMINHO_JOB
```

---

### `/user`

Define o usuário utilizado para autenticação no repositório.

Exemplo:

```text
/user:"NOME_USUARIO"
```

---

### `/pass`

Define a senha utilizada para autenticação no repositório.

Exemplo:

```text
/pass:"SENHA_USUARIO"
```

> ⚠️ Recomenda-se não salvar senhas diretamente no repositório Git.

Uma abordagem melhor é utilizar uma variável de ambiente:

```bat
/pass:"%PENTAHO_PASSWORD%"
```

Exemplo de configuração no Windows:

```bat
set PENTAHO_PASSWORD=SUA_SENHA
```

---

# 3. Transformation armazenada em arquivo

Arquivo:

```text
transformations/transformation-file.bat
```

Código:

```bat
@echo off

C:\caminho_pentaho\pan.bat ^
 /file:"C:\CAMINHO_TRANSFORMATION\TRANSFORMATION_NAME.ktr" ^
 /level:Basic ^
 > "C:\CAMINHO_LOG\LOG_NAME.log" 2>&1

exit /b %ERRORLEVEL%
```

## Quando utilizar

Utilize esse modelo quando for necessário executar diretamente uma Transformation `.ktr` armazenada em um arquivo físico.

Exemplo:

```text
C:\Projetos\Transformations\Carga_Dados.ktr
```

---

# 4. Transformation armazenada em repositório Pentaho

Arquivo:

```text
transformations/transformation-repository.bat
```

Código:

```bat
@echo off

C:\caminho_pentaho\pan.bat ^
 /rep:"REP_KETTLE_NAME" ^
 /trans:"TRANSFORMATION_NAME" ^
 /dir:/CAMINHO_TRANSFORMATION ^
 /user:"NOME_USUARIO" ^
 /pass:"%PENTAHO_PASSWORD%" ^
 /level:Basic ^
 > "C:\CAMINHO_LOG\LOG_NAME.log" 2>&1

exit /b %ERRORLEVEL%
```

## Quando utilizar

Utilize esse modelo quando a Transformation estiver armazenada dentro de um repositório Pentaho.

O parâmetro utilizado para identificar a Transformation é:

```text
/trans
```

Exemplo:

```text
/trans:"TRANSFORMATION_NAME"
```

---

# Logs

Todos os scripts deste repositório possuem redirecionamento de logs.

Exemplo:

```bat
> "C:\CAMINHO_LOG\LOG_NAME.log" 2>&1
```

Isso significa:

```text
> arquivo.log
```

Redireciona a saída normal para o arquivo.

```text
2>&1
```

Redireciona também os erros para o mesmo arquivo.

Exemplo de resultado:

```text
C:\Logs\Carga_Dados.log
```

---

# Execução através do Apache Airflow

Os scripts `.BAT` podem ser chamados dentro de uma DAG do Apache Airflow.

Fluxo:

```text
Apache Airflow
      ↓
DAG
      ↓
Task
      ↓
Chamada do .BAT
      ↓
Kitchen / Pan
      ↓
Pentaho
      ↓
Job ou Transformation
      ↓
Logs
```

Exemplo conceitual:

```python
BashOperator(
    task_id="executar_pentaho",
    bash_command="cmd.exe /c C:\\scripts\\jobs\\job-file.bat"
)
```

O retorno do `.BAT` será importante para que o Airflow identifique o resultado da execução.

Por esse motivo, os scripts utilizam:

```bat
exit /b %ERRORLEVEL%
```

---

# Qual modelo utilizar?

## Job `.kjb` armazenado no servidor

Utilizar:

```text
kitchen.bat
```

Com:

```text
/file
```

---

## Job armazenado no repositório Pentaho

Utilizar:

```text
kitchen.bat
```

Com:

```text
/rep
/job
/dir
```

---

## Transformation `.ktr` armazenada no servidor

Utilizar:

```text
pan.bat
```

Com:

```text
/file
```

---

## Transformation armazenada no repositório Pentaho

Utilizar:

```text
pan.bat
```

Com:

```text
/rep
/trans
/dir
```

---

# Boas práticas

* Não salvar senhas diretamente no GitHub.
* Utilizar variáveis de ambiente para credenciais.
* Utilizar `/level:Basic` para execução em produção.
* Utilizar `/level:Detailed` ou `/level:Debug` apenas durante investigações.
* Sempre utilizar `exit /b %ERRORLEVEL%`.
* Centralizar os arquivos de log.
* Utilizar nomes descritivos para os arquivos `.BAT`.
* Manter o repositório com modelos genéricos, substituindo informações específicas por placeholders.
* Versionar alterações utilizando Git e GitHub.
* Manter os arquivos específicos de cada ambiente separados dos templates genéricos.

---

# Exemplo de variáveis de ambiente

```bat
set PENTAHO_USER=NOME_USUARIO
set PENTAHO_PASSWORD=SENHA_USUARIO
```

Utilização:

```bat
/user:"%PENTAHO_USER%"
/pass:"%PENTAHO_PASSWORD%"
```

---

# Tecnologias

* Pentaho Data Integration
* Kettle
* Kitchen
* Pan
* Windows Batch
* Apache Airflow
* Git
* GitHub

---

# Objetivo futuro

Este repositório poderá ser expandido com:

* Templates com parâmetros de entrada
* Variáveis de ambiente
* Scripts para múltiplos ambientes
* Desenvolvimento
* Homologação
* Produção
* Scripts de limpeza de logs
* Scripts com timestamp no nome do log
* Integração com Apache Airflow
* Scripts PowerShell
* Execução de processos Pentaho através de Docker
* Monitoramento de execução
