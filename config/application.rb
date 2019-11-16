require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dism
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Engadir todos os ficheiros de configuración do directorio locales
    config.i18n.load_path += Dir[Rails.root.join('config','locales','**','*.{rb,yml}')]

    #TODO revisar estas configuracións
    # Permitted locales available for the application
    #I18n.available_locales = [:en, :es_ES, :gl]
     
    # Set default locale to something other than :en
    #I18n.default_locale = :gl
  end
end
