require_relative 'boot'

require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_model/railtie'
require 'active_record/railtie'
require 'sprockets/railtie'

require_relative '../lib/core_ext'

Bundler.require(*Rails.groups(assets: %w(development test)))

module Frontend
  class Application < Rails::Application

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Configure cookie session store.
    config.session_store :cookie_store, key: '_mas_session'

    # Configure Google Tag Manager ID
    config.google_tag_manager_id = 'GTM-WVFLH9'

    # Configure Crazy Egg script URL
    config.crazy_egg_url = '//dnn506yrbagrg.cloudfront.net/pages/scripts/0018/4438.js'

    # Use Rack middleware to capture X-Request-ID header
    config.middleware.use 'CaptureRequestId'

    # Use Rack middleware to respond to requests probing for a implemented route
    config.middleware.use 'RouteProbe'

    # Convert HEAD requests to GET and return an empty body
    config.middleware.use 'OverrideHead'

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'car_campaigns', '*.yml').to_s]
  end
end
