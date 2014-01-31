module Rack
  module Doge
    class Start < BaseDoge
      # This rack should run as early in the stack as possible.

      def call(env)
        env["RACK_IN_START"] = time_ms
        status, headers, response = @app.call(env)
        env["RACK_OUT_END"] = time_ms
        [status, headers, response]
      end
    end
  end
end