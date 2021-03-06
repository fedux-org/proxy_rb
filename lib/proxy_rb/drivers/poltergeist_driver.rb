# frozen_string_literal: true
require 'capybara'

require 'proxy_rb/drivers/basic_driver'
require 'proxy_rb/errors'

begin
  require 'capybara/poltergeist'
rescue LoadError => e
  ProxyRb.logger.error %(Error loading `poltergeist`-gem: #{e.message}. Please add `gem poltergeist` to your `Gemfile`)
  exit 1
end

# ProxyRb
module ProxyRb
  # Drivers
  module Drivers
    # Driver for Poltergeist
    class PoltergeistDriver < BasicDriver
      # Register proxy
      #
      # @param [HttpProxy] proxy
      #   The HTTP proxy which should be used for fetching content
      def register(proxy)
        if proxy.empty?
          ::Capybara.current_driver = :poltergeist
          return
        end

        cli_parameters = []
        cli_parameters << "--proxy=#{proxy.url}" unless proxy.url.empty?
        cli_parameters << "--proxy-auth=#{proxy.credentials}" unless proxy.credentials.empty?

        options = {
          phantomjs_options: cli_parameters,
          js_errors: false,
          phantomjs_logger: $stderr
        }

        unless ::Capybara.drivers.key? proxy.to_ref
          ::Capybara.register_driver proxy.to_ref do |app|
            ::Capybara::Poltergeist::Driver.new(app, options)
          end
        end

        ::Capybara.current_driver = proxy.to_ref
      end

      def timeout_errors
        [::Capybara::Poltergeist::TimeoutError]
      end

      def failure_errors
        [::Capybara::Poltergeist::StatusFailError]
      end
    end
  end
end
