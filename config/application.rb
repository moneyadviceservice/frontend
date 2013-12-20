require_relative 'boot'

require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module Frontend
  class Application < Rails::Application

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Configure secret key used to verify the integrity of signed cookies.
    config.secret_key_base   = 'abc123'

    # Configure cookie session store.
    config.session_store :cookie_store, key: '_mas_session'

  end
end
