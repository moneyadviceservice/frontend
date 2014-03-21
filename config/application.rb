require_relative 'boot'

require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_model/railtie'
require 'active_record/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups(assets: %w(development test)))

module Frontend
  class Application < Rails::Application

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Configure cookie session store.
    config.session_store :cookie_store, key: '_mas_session'

    # Configure the asset pipeline to include Bower components.
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')

    # Configure additional application CSS assets to precompile.
    config.assets.precompile += %w(basic.css
                                  enhanced_fixed.css
                                  enhanced_responsive.css
                                  fonts.css
                                  styleguide.css)

    # Configure additional application JS assets to precompile.
    config.assets.precompile += %w(html_inspector.js
                                  supports.js
                                  translations/en.js
                                  translations/cy.js
                                  modules/mas_analytics.js
                                  modules/mas_collapsable.js
                                  modules/mas_log.js
                                  styleguide.js)

    # Configure additional vendor JS assets to precompile.
    config.assets.precompile += %w(html5shiv/dist/html5shiv.js
                                   jquery/dist/jquery.js
                                   jquery-waypoints/waypoints.js
                                   jquery-tiny-pubsub/src/tiny-pubsub.js
                                   jquery-ujs/src/rails.js
                                   requirejs/require.js)

    # Configure Google Tag Manager ID
    config.google_tag_manager_id = 'GTM-WVFLH9'

    # Use Rack middleware to capture X-Request-ID header
    config.middleware.use 'CaptureRequestId'

    # Use Rack middleware to respond to requests probing for a implemented route
    config.middleware.use 'RouteProbe'

  end
end

Capybara.server do |app, port|

  if Konacha.mode == :runner
    require 'rack/handler/thin'
    Rack::Handler::Thin.run(app, Port: port)
  else
    Capybara.run_default_server(app, port)
  end
end if defined?(Capybara)
