[![Build Status](https://travis-ci.org/damorais/medidata.svg?branch=master)](https://travis-ci.org/damorais/medidata)

[![Maintainability](https://api.codeclimate.com/v1/badges/2710724885117a3644ce/maintainability)](https://codeclimate.com/github/damorais/medidata/maintainability)

[![Test Coverage](https://api.codeclimate.com/v1/badges/2710724885117a3644ce/test_coverage)](https://codeclimate.com/github/damorais/medidata/test_coverage)

# MediData

Sistema para Registro de Informações Médicas.

Atualmente existe um problema em relação ao armazenamento de informações médicas de maneira centralizada e que possibilite o compartilhado com pessoas autorizadas pelo usuário. Geralmente cada laboratório ou hospital mantém os registros em sistemas próprios e muitas vezes a informação é perdida ao longo do tempo. O objetivo do projeto, portanto, é desenvolver um sistema de registro de informações médicas, que possibilite que o usuário armazene todas essas informações de forma centralizada e possa compartilhar essas informações com pessoas autorizadas (exemplo: médicos, enfermeiros, etc).

# Equipe do Projeto

Daniel Morais | Nº USP: 5365542 | @damorais

Diego Mauricio Tussi | Nº USP: 10834152 | @diegotussi

Marcelo Pavanello Martins | Nº USP: 10833418 | @MarceloPavanello

William T. Maruyama | Nº USP: 5874679 | @wtmaruyama



# Configuração do RSpec e Cucumber em um projeto Rails

Aqui, o passo-a-passo para a configuração básica do RSpec e do Cucumber em um projeto Rails. Esta é uma versão preliminar, então pode ser que tenha algum passo necessário que não foi coberto ou que seja melhor quando feito de outra forma (isto foi feito com base em tutoriais das respectivas ferramentas).

## Configurando o RSpec

1. Instalar o *RSpec*:

    ```bash
    gem install rspec
    ```

2. Incluir no *Gemfile* as dependências para o contexto de desenvolvimento e testes:

    ```ruby
    group :development, :test do
        gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
        gem 'rspec-rails', '~> 3.8'
    end
    ```

3. Configurar a estrutura do *RSpec* no projeto:

    ```bash
    rspec --init
    bin/rails generate rspec:install
    ```

Para executar:

```bash
bin/rake spec
```

## Configurando o Cucumber

1. Adicionar a dependência da gem *cucumber-rails* no *Gemfile*:

    ```ruby
    group :test do
        # Adds support for Capybara system testing and selenium driver
        gem 'capybara', '>= 2.15'
        gem 'selenium-webdriver'
        # Easy installation and use of chromedriver to run system tests with Chrome
        gem 'chromedriver-helper'
        gem 'cucumber-rails', require: false
        gem 'database_cleaner'
    end
    ```

2. Instalar a gem

    ```bash
    bin/bundle install
    ```

3. Configurar a estrutura do Cucumber no projeto:

```bash
bin/rails generate cucumber:install
```

Para executar:

```bash
bin/rake features
```

OBS: As modificações do *Gemfile* estão levando em conta o Gemfile gerado pelo *Rails*.

OBS2: O comando *features* é executado, mas dispara um aviso informando que a versão atual requer a execução com comando (e suas variações):

```bash
bin/rake cucumber
```

# Configuração do PostgreSQL

O Heroku, que será utilizado como ambiente de produção da aplicação, não permite a utilização do SQLite como SGBD (As razões são explicadas [aqui](https://devcenter.heroku.com/articles/sqlite3). Desta forma, o ideal é alterar o projeto para trabalhar com o PostgreSQL (apesar de, teoricamente não haver problemas em utilizar SGBDs diferentes em desenvolvimento e produção, a recomendação é que se use o mesmo SGBD em todos os ambientes). Para configurar o PostgreSQL para trabalhar com o Rails neste projeto, é preciso:

1. Instalar o PostgreSQL para seu sistema operacional. No Mac, dá para usar o Homebrew para isto:

    ```bash
    brew install postgresql   
    ``` 
    
No Ubuntu 18.04, podemos instalar o [PostgreSQL](https://www.postgresql.org/download/linux/ubuntu/) com o seguinte comando.
    
    ```bash
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install postgresql-10   
    ```
    
2. Criar uma nova instância do banco de dados e subir o serviço. Isto depende se você já não subiu o serviço automático. Eu prefiro deixar o processo manual, assim não fico com o SGBD rodando à toa na minha máquina:

    ```bash
    initdb --pgdata=pgsql/pgdata
    ```
    Nota: o *pgdata* é o caminho onde o arquivo de dados do PostgreSQL ficará armazenado (posso ter vários na minha máquina, por exemplo). Em cada *pgdata* posso ter um ou mais bancos de dados (no nosso caso, teremos os bds de desenvolvimento e testes, locais).

3. Iniciar o serviço utilizando este PGDATA:

    ```bash
     pg_ctl -D 'pgsql/pgdata' -l logfile start
    ```
    O parâmetro -D aponta para o *pgdata* que deverá ser usado para esta instância. O -l para o arquivo de dados de log que será usado (onde o Postgresql fará dumps de erros, etc). A propósito, o usuário master deste banco é o da conta de usuário do SO que está sendo usada. Como o BD será usado para desenvolvimento isto não é um problema, mas também é possível criar os usuários específicos do banco, caso se julgue necessário.

4. Crie um banco de dados para ver se está tudo ok:

    ```bash
    createdb meudbbacana
    ```

5. Acesse o banco de dados através do cliente do PostgreSQL:

    ```bash
    psql meudbbanaca
    ```
    Até aqui, estamos configurando apenas o *PostgreSQL*. Os passos a seguir serão sobre a configuração do Rails para usar o PostgreSQL.

6. No *Gemfile*, modificar a *gem*, de sqlite para pg:

    De:
    ```ruby
    # Use sqlite3 as the database for Active Record
    gem 'sqlite3'
    ```
    Para:
    ```ruby
    # Use postgresql as the database for Active Record
    gem 'pg', '>= 0.18', '< 2.0'
    ```
7. Alterar o *config/database.yml* para utilizar o *PostgreSQL* ao invés do *SQLite*:

    De:
    ```ruby
    default: &default
        adapter: sqlite3
        pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
        timeout: 5000

    development:
        <<: *default
        database: db/development.sqlite3

    test: &test
        <<: *default
        database: db/test.sqlite3

    production:
        <<: *default
        database: db/production.sqlite3

    cucumber:
        <<: *test
    ```
    Para:
    ```ruby
    default: &default
        adapter: postgresql
        encoding: unicode
        pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

    development:
        <<: *default
        database: medidata_development

    test:
        <<: *default
        database: medidata_test

    production:
    <<: *default
        database: medidata_production
        username: medidata
        password: <%= ENV['MEDIDATA_DATABASE_PASSWORD'] %>
    ```

    Obs: Comentários do arquivo omitidos (o *database.yml* contém mais texto sobre alguns detalhes do driver).

8. Executar as tarefas para criação do BD e configuração do projeto Rails:

    ```bash
    bin/rake db:migrate
    bin/rake db:setup
    ```
9. Para testar, foi criado um CRUD simples, através do *scaffold* do *Rails* para averiguar se está tudo ok:

    ```bash
    bin/rails generate scaffold User name:string
    bin/rake db:migrate
    ```

10. Executar o servidor e verificar se está tudo ok:

    ```bash
    bin/rails server
    ```
    E abrir a URL: [http://localhost:3000/Users]

11. Configurar o *.travis.yml* para fazer uso do *PostgreSQL* ao invés do *SQLite*:

    De:
    ```yml
    language: ruby
    rvm:
    - 2.5
    script:
    - bin/rake spec
    - bin/rake features
    ```

    Para:
    ```yml
    language: ruby
    rvm:
    - 2.5
    before_script:
    - psql -c 'create database medidata_test;' -U postgres
    script:
    - bin/rake spec
    - bin/rake features
    ```
    Preciso adicionar fazer esta alteração porque o *SQLite* pode ser executado em memória (o que ocorre com a configuração inicial feita para o Travis). O *PostgreSQL* precisa do banco físico (em arquivos).
