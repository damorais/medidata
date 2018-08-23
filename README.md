# MediData

[![Build Status](https://travis-ci.org/damorais/medidata.svg?branch=master)](https://travis-ci.org/damorais/medidata)

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