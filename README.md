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