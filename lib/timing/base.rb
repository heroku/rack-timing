require 'timing/notify'
module Rack
  module Timing
    class Base
      include Notify

      def initialize(app, logger = nil)
        @logger  = logger
        @app     = app
        @instrument_name = "rack.timing"
        @logger  = ::Logger.new($stdout) if @logger.nil?
        # @logger.formatter = L2MetFormatter.new
      end

      protected

      def time_ms
        (Time.now.to_f * 1000.0).round
      end

    end
  end
end