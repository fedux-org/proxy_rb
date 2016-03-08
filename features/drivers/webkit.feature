Feature: Choose webkit driver to sent requests to proxy

  Background:
    Given I use a fixture named "proxy-config"
    And I look for executables in "bin" within the current directory
    And I use a simple proxy
    And I use a simple web server

  Scenario: Successful request with default configuration
    Given a spec file named "test_spec.rb" with:
    """
    require 'spec_helper'

    RSpec.describe 'HTTP Proxy Infrastructure', type: :http_proxy do
      subject { 'localhost:8080' }
      context 'when working proxy chain' do
        before { visit 'http://localhost:8000' }

        it { expect(request).to be_successful }
      end
    end
    """
    And I run `http_proxy` in background
    And I run `http_server` in background
    When I run `rspec`
    Then the specs should all pass

  Scenario: Successful request with explicitly configured driver
    Given a spec file named "test_spec.rb" with:
    """
    require 'spec_helper'
    require 'proxy_rb/drivers/webkit_driver'

    ProxyRb.configure do |config|
      config.driver = ProxyRb::Drivers::WebkitDriver.new
    end

    RSpec.describe 'HTTP Proxy Infrastructure', type: :http_proxy do
      subject { 'localhost:8080' }
      context 'when working proxy chain' do
        before { visit 'http://localhost:8000' }

        it { expect(request).to be_successful }
      end
    end
    """
    And I run `http_proxy` in background
    And I run `http_server` in background
    When I run `rspec`
    Then the specs should all pass


  Scenario: Proxy is not reachable
    Given a spec file named "test_spec.rb" with:
    """
    require 'spec_helper'
    require 'proxy_rb/drivers/webkit_driver'

    ProxyRb.configure do |config|
      config.driver = ProxyRb::Drivers::WebkitDriver.new
    end

    RSpec.describe 'HTTP Proxy Infrastructure', type: :http_proxy do
      subject { 'localhost:8080' }

      context 'when working proxy chain' do
        it { expect{ visit 'http://localhost:8000' }.to raise_error  ProxyRb::ResourceNotDownloadableError }
      end
    end
    """
    And I run `http_server` in background
    When I run `rspec`
    Then the specs should all pass

  Scenario: Web server is not reachable
    Given a spec file named "test_spec.rb" with:
    """
    require 'spec_helper'
    require 'proxy_rb/drivers/webkit_driver'

    ProxyRb.configure do |config|
      config.driver = ProxyRb::Drivers::WebkitDriver.new
    end

    RSpec.describe 'HTTP Proxy Infrastructure', type: :http_proxy do
      subject { 'localhost:8080' }

      context 'when working proxy chain' do
        it { expect{ visit 'http://localhost:8000' }.not_to raise_error }
      end
    end
    """
    And I run `http_proxy` in background
    When I run `rspec`
    Then the specs should all pass

