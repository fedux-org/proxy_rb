# frozen_string_literal: true
require 'logger'

# Main
module ProxyRb
  @debug_mode = false
  @logger     = Logger.new($stderr)

  ANNOUNCERS = %i(
    proxy
    proxy_user
    resource
    resource_user
    http_response_headers
    status_code
  ).freeze

  class << self
    protected

    attr_accessor :debug_mode

    public

    attr_reader :logger

    # What kind of information can be announce while debugging
    def debug_mode_enabled?
      debug_mode == true
    end

    def enable_debug_mode
      self.debug_mode = true
      %w(pry byebug).each { |l| require l }
    end

    def require_files_matching_pattern(pattern)
      root = File.expand_path('../', __FILE__)
      path = File.join(root, pattern)
      Dir.glob(path).each { |f| require_relative f }
    end
  end
end
