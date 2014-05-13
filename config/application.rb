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
    config.assets.precompile += %w(enhanced_fixed.css
                                  enhanced_responsive.css
                                  frontend-assets/stylesheets/basic.css
                                  frontend-assets/stylesheets/font_files.css
                                  frontend-assets/stylesheets/font_base64.css
                                  styleguide/styleguide_fixed.css
                                  styleguide/styleguide_responsive.css)

    # Include fonts when precompiling assets.
    config.assets.precompile << /\.(?:png|svg|eot|woff|ttf)$/

    # Configure additional application JS assets to precompile.
    config.assets.precompile += %w(components/Toggler.js
                                   html_inspector.js
                                   lib/MASModule.js
                                   lib/MicroEvent.js
                                   modules/common.js
                                   modules/globals.js
                                   modules/i18n.js
                                   modules/log.js
                                   modules/mas_collapsable.js
                                   modules/mas_pubsub.js
                                   modules/mas_scrollTracking.js
                                   styleguide.js
                                   supports.js
                                   translations/cy.js
                                   translations/en.js)

    # Configure additional vendor JS assets to precompile.
    config.assets.precompile += %w(optimizely.js
                                   html5shiv/dist/html5shiv.js
                                   jquery/dist/jquery.js
                                   jquery-waypoints/waypoints.js
                                   jquery-ujs/src/rails.js
                                   requirejs/require.js)

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
