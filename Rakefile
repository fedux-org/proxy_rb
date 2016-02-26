#!/usr/bin/env rake

# require 'bundler'
# Bundler.require :default, :test, :development

require 'filegen'
require 'fedux_org_stdlib/rake_tasks'

require 'coveralls/rake/task'
Coveralls::RakeTask.new

task default: :test

desc 'Run test suite'
task :test do
  Rake::Task['test:before'].execute

  begin
    # %w(test:rubocop test:rspec test:cucumber test:after).each { |t| Rake::Task[t].execute }
    %w(test:rubocop test:rspec test:after).each { |t| Rake::Task[t].execute }
  ensure
    Rake::Task['test:after'].execute
  end
end

namespace :test do
  desc 'Test with coveralls'
  task coveralls: %w(test coveralls:push)

  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  desc 'Run rspec'
  task :rspec do
    sh 'bundle exec rspec'
  end

  desc 'Run cucumber'
  task :cucumber do
    sh 'bundle exec cucumber -p all'
  end

  desc 'Setup test environment'
  task :before do
    @web_server = Process.spawn 'rackup -p 65535 script/config.ru'
  end

  desc 'Teardown test environment'
  task :after do
    sh "kill -9 #{@web_server}"
  end
end
