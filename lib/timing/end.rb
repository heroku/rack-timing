module Rack
  module Timing
    class End < Base
      # This middleware should run as late in the stack as possible.
      def call(env)
        env["RACK_IN_END"] = time_ms
        status, headers, response = @app.call(env)
        env["RACK_OUT_START"] = time_ms
        [status, headers, response]
      end
    end
  end
end