module Rack
  module Timing
    class Reporter < Base
      def call(env)
        @metrics = {}

        status, headers, response = @app.call(env)

        measure_pre_request_time(env)
        measure("measure#rack_in", :rack_in_start, :rack_in_end, env)
        measure("measure#app", :rack_in_end, :rack_out_start, env)
        measure("measure#rack_out", :rack_out_start, :rack_out_end, env)

        @metrics = {
          thread_id: Thread.current.object_id,
          process_id: Process.pid,
          request_id: (env["action_dispatch.request_id"] || ""),
          path: env['REQUEST_PATH']
        }.merge(@metrics)

        notify(@metrics) if should_notify?
        @logger.info "at=info " + @metrics.map { |k, v| "#{k}=#{v}"}.join(" ")

        [status, headers, response]
      end

      private

      def measure(measurement, start_time, end_time, env)
        starting = env[start_time.to_s.upcase].to_i
        ending   = env[end_time.to_s.upcase].to_i
        if starting > 0 && ending > 0
          @metrics[measurement] = (ending - starting).to_s + "ms"
        end
      end

      def measure_pre_request_time(env)
        if (request_start = (env["HTTP_X_REQUEST_START"] || 0).to_i) > 0
          @metrics["measure#pre_request"] = (env["RACK_IN_START"] - request_start).to_s + "ms"
        else
          @metrics["measure#pre_request"] = "0ms"
        end
      end

    end
  end
end