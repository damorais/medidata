# README

## Configurando o RSpec

Instalar o rpec:

gem install rspec

Incluir no Gemfile:

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.8'
end

e, depois, na linha de comando, para configurar no projeto:

rspec --init

Para executar:

bin/rake spec

## Configurando o Cucumber

Adicionar a dependência a gem cucumber-rails

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
end

Instalar a gem
bin/bundle install

Configura uma versão inicial do cucumber para o projeto

rails generate cucumber:install