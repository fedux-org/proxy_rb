# frozen_string_literal: true
module ProxyRb
  # This wraps the current runtime configuration of proxy_rb.
  # If an option is changed, it notifies the event queue.
  #
  # This class is not meant for direct use - ConfigWrapper.new - by normal
  # users.
  #
  # @private
  class ConfigurationWrapper
    private

    attr_reader :config, :event_bus

    public

    # Create proxy
    #
    # @param [Config] config
    #   An proxy_rb config object.
    #
    # @param [#notify] event_bus
    #   The event queue which should be notified.
    def initialize(config, event_bus)
      @config = config
      @event_bus = event_bus
    end

    # Proxy all methods
    #
    # If one method ends with "=", e.g. ":option1=", then notify the event
    # queue, that the user changes the value of "option1"
    #
    # rubocop:disable Style/MethodMissing
    def method_missing(name, *args, &block)
      event_bus.notify Events::ChangedConfiguration.new(changed: { name: name.to_s.gsub(/=$/, ''), value: args.first }) if name.to_s.end_with? '='

      config.send(name, *args, &block)
    end
    # rubocop:enable Style/MethodMissing

    # Pass on respond_to?-calls
    def respond_to_missing?(name, _include_private)
      config.respond_to? name
    end

    # Compare two configs
    #
    # The comparism is done based on their values. No hooks are compared.
    #
    # Somehow `#respond_to_missing?`, `method_missing?` and `respond_to?` don't
    # help here.
    def ==(other)
      config == other
    end

    # Pass on respond_to?-calls
    def respond_to?(m)
      config.respond_to? m
    end
  end
end
