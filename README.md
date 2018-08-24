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
