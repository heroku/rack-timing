module Rack
  module Doge
    class Start < BaseDoge
      # This middleware should run as early in the stack as possible.

      def call(env)
        start_middleware_in_time(env)
        measure_routing_time(env)

        status, headers, response = @app.call(env)

        measure_middleware_out_time(env)
        @metrics[:rack_in] = ENV["RACK_IN_TIME"]
        @metrics[:app] = ENV["APP_TIME"]

        report(env)

        [status, headers, response]
      end

      private

      def measure_routing_time(env)
        if (request_start = (env["HTTP_X_REQUEST_START"] || 0).to_i) > 0
          @metrics[:pre_request] = (time_ms - request_start).to_s + "ms"
        else
          @metrics[:pre_request] = "0ms"
        end
      end

      def start_middleware_in_time(env)
        env["RACK_IN_START"] = time_ms
      end

      def measure_middleware_out_time(env)
        if (middleware_out_start = (env["RACK_OUT_START"] || 0).to_i) > 0
          @metrics[:rack_out] = (time_ms - middleware_out_start).to_s + "ms"
        end
      end

      def measure_queue_depth(env)
        if defined? Raindrops::Linux.tcp_listener_stats
          stats = Raindrops::Linux.tcp_listener_stats([ '0.0.0.0:'+ENV['PORT'] ])['0.0.0.0:'+ENV['PORT']]
          @metrics[:before][:active_requests] = stats.active
          @metrics[:before][:queued_requests] = stats.queued
        end
      end
    end
  end
end