require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Artsite
  class Application < Rails::Application
    config.load_defaults 7.2

    config.time_zone = "UTC"

    config.generators do |g|
      g.test_framework :minitest, fixture: true
      g.fixture_replacement :factory_bot, dir: "test/factories"
    end
  end
end
