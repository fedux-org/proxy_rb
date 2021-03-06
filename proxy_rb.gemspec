# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'proxy_rb/version'

Gem::Specification.new do |spec|
  spec.name          = 'proxy_rb'
  spec.version       = ProxyRb::VERSION
  spec.authors       = ['Max Meyer']
  spec.email         = ['dev@fedux.org']
  spec.licenses      = ['MIT']

  spec.summary       = 'This gem makes testing your proxy easy.'
  spec.homepage      = 'https://github.com/fedux-org/proxy_rb'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'

  spec.add_runtime_dependency 'capybara'
  spec.add_runtime_dependency 'capybara-webkit'

  spec.add_runtime_dependency 'addressable'
  spec.add_runtime_dependency 'contracts'
  spec.add_runtime_dependency 'excon'
  spec.add_runtime_dependency 'thor'

  spec.required_ruby_version = '~> 2.3'
end
