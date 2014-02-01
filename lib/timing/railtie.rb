module Rack
  module Timing
    class TimingRailtie < Rails::Railtie
      initializer "timing_railtie.configure_rails_initialization" do |app|
        app.middleware.insert 0, Rack::Timing::Start
        app.middleware.insert 0, Rack::Timing::Reporter
        app.middleware.use Rack::Timing::End
      end
    end
  end
end