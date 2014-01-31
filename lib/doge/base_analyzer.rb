require 'doge/notify'
module Rack
  module Doge
    class BaseDoge
      include Notify

      def initialize(app, logger = nil)
        @logger  = logger
        @app     = app
        @metrics = {}
        @instrument_name = "rack.doge"
        @logger  = ::Logger.new($stdout) if @logger.nil?
        # @logger.formatter = L2MetFormatter.new
      end

      protected

      def time_ms
        (Time.now.to_f * 1000.0).round
      end

      def report(env)
        common_info = {thread_id: Thread.current.object_id, process_id: Process.pid, request_id: (env["action_dispatch.request_id"] || "")}
        notify(@metrics.merge()) if should_notify?
        @logger.info "at=info " + common_info(env).merge(@metrics).map { |k, v| "#{k}=#{v}"}.join(" ")
      end
    end
  end
end