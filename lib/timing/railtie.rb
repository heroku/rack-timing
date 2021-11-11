module Rack
  module Timing
    class TimingRailtie < Rails::Railtie
      initializer "timing_railtie.configure_rails_initialization" do |app|
        app.middleware.insert 0, Rack::Timing::Start, Rails.logger
        app.middleware.insert 0, Rack::Timing::Reporter, Rails.logger
        app.middleware.use Rack::Timing::End, Rails.logger
      end
    end
  end
end