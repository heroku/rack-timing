module Rack
  module Doge
    module Notify
      def should_notify?
        if defined?(ActiveSupport::Notifications)
          ActiveSupport::Notifications.notifier.listening?(@instrument_name)
        end
      end

      def notify(data)
        ActiveSupport::Notifications.instrument(@instrument_name, data)
      end
    end
  end
end
