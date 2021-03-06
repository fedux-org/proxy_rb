# frozen_string_literal: true
source 'https://rubygems.org'

# Specify your gem's dependencies in local_pac.gemspec
gemspec

# Required
gem 'poltergeist'
gem 'selenium-webdriver', '~>2.53'
gem 'cucumber', require: false
gem 'rspec', require: false

group :debug do
  gem 'pry'
  gem 'byebug'

  gem 'pry-doc', require: false
  gem 'pry-stack_explorer', require: false
  gem 'pry-byebug', require: false
end

group :development, :test do
  # Password store
  gem 'vault'

  # Set env during development/test
  gem 'dotenv'

  gem 'aruba', '~> 0.14.1', require: false
  gem 'awesome_print', require: 'ap'
  gem 'bundler', '~> 1.3', require: false
  gem 'command_exec', require: false
  gem 'coveralls', require: false
  gem 'erubis'
  gem 'filegen'
  gem 'foreman', require: false
  gem 'fuubar', require: false
  gem 'github-markup'
  gem 'inch', require: false
  gem 'launchy', require: false
  gem 'license_finder'
  gem 'rack'
  gem 'rake', '~> 10.0', require: false
  gem 'rubocop', require: false
  gem 'simplecov', require: false
  gem 'sinatra', require: 'sinatra/base'
  gem 'tmrb', require: false
  gem 'travis-lint', require: false
  gem 'versionomy', require: false
  gem 'yard', require: false
  gem 'webmock', require: false
  gem 'rack-test', require: false
end

group :profile do
  gem 'ruby-prof'
end

group :runtimes do
  group :therubyracer do
    gem 'therubyracer', require: 'v8'
  end

  group :therubyrhino do
    gem 'therubyrhino', require: 'rhino'
  end
end
