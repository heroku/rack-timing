module Rack
  module Doge
    class DogeRailtie < Rails::Railtie
      initializer "doge_railtie.configure_rails_initialization" do |app|
        app.middleware.insert 0, Rack::Doge::Start
        app.middleware.use Rack::Doge::End
      end
    end
  end
end