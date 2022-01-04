require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PlanetOfVitamins
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Remove HTML <div> blocks on notifications
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag.html_safe }

    # Whitelist locales avialable (English, Russian, Deutsche)
    # config.i18n.available_locales = [:en, :ru, :de]
    # Set default locale :en (English)
    config.i18n.default_locale = :ru

    # The default locale loading mechanism in Rails does not load locale files
    # in nested dictionaries, like we have here. So, for this to work, we must
    # explicitly tell Rails to look further:
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

  end
end
