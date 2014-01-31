module Rack
  module Doge
    class End < BaseDoge
      # This middleware should run as late in the stack as possible.
      def call(env)
        measure_middleware_in_time(env)
        start_app_time(env)
        status, headers, response = @app.call(env)

        measure_app_time(env)
        start_middleware_out_time(env)

        [status, headers, response]
      end

      private

      def measure_middleware_in_time(env)
        if (middleware_in_start = (env["RACK_IN_START"] || 0).to_i) > 0
          ENV["RACK_IN_TIME"] = (time_ms - middleware_in_start).to_s + "ms"
        end
      end

      def start_app_time(env)
        @app_start = time_ms
      end

      def measure_app_time(env)
        if @app_start.presence
          ENV["APP_TIME"] = (time_ms - @app_start).to_s + "ms"
        end
      end

      def start_middleware_out_time(env)
        env["RACK_OUT_START"] = time_ms
      end
    end
  end
end