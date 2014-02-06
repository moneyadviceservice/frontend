require_relative 'boot'

require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_model/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module Frontend
  class Application < Rails::Application

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Configure cookie session store.
    config.session_store :cookie_store, key: '_mas_session'

    # Configure the asset pipeline to include Bower components.
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')

    # Configure additional assets to precompile.
    config.assets.precompile += %w(styleguide.css basic.css fonts.css
                                   enhanced_fixed.css enhanced_responsive.css
                                   styleguide.js html_inspector.js html5shiv/dist/html5shiv.js in_head.js
                                   mas_analytics.js jquery-waypoints/waypoints.js jquery-tiny-pubsub/src/tiny-pubsub.js)

    # Configure Google Tag Manager ID
    config.google_tag_manager_id = 'GTM-WVFLH9'

    # Store the request_id in the current thread
    config.middleware.use "CaptureRequestIdMiddleware"

  end
end
