require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ngnews
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.time_zone = "Europe/Moscow"
    config.active_record.default_timezone = "Europe/Moscow"
    config.asset_host = "http://127.0.0.1:3000"
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    config.i18n.default_locale = :ru
    # config.time_zone = "Central Time (US & Canada)"
    # Configuration for the application, engines, and railties goes here.
    # config.eager_load_paths << Rails.root.join("extras")
    config.exceptions_app = self.routes

    config.to_prepare do

      # Or to configure mailer layout
      Devise::Mailer.layout "mailer" # email.haml or email.erb
      Devise::Mailer.helper EmailHelper
    end

    config.active_job.queue_adapter = :sidekiq
    config.generators do |g|
      g.system_tests = nil
      g.assets false
      g.test_framework(
        :rspec,
        fixtures: false,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
      )
    end
  end
end
