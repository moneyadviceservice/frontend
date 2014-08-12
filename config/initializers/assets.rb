require 'asset_pipeline/processors/js_hint'
require 'asset_pipeline/processors/css_lint'

Rails.application.configure do

  config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')

  config.assets.register_postprocessor('application/javascript', AssetPipeline::Processors::JsHint)
  config.assets.register_postprocessor('text/css', AssetPipeline::Processors::CssLint)

  # Fonts
  config.assets.precompile << /\.(?:png|svg|eot|woff|ttf)$/

  # Application Stylesheets
  config.assets.precompile += %w(enhanced_fixed.css
                                  enhanced_responsive.css
                                  dough/assets/stylesheets/basic.css
                                  dough/assets/stylesheets/font_files.css
                                  dough/assets/stylesheets/font_base64.css
                                  styleguide/styleguide_fixed.css
                                  styleguide/styleguide_responsive.css)

  # Application JavaScript
  config.assets.precompile += %w(components/Toggler.js
                                   html_inspector.js
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
                                   translations/en.js
                                   dough/assets/js/lib/*.js
                                   dough/assets/js/components/*.js)

  # Vendor JavaScript
  config.assets.precompile += %w(html5shiv/dist/html5shiv.js
                                   jquery/dist/jquery.js
                                   jquery-waypoints/waypoints.js
                                   jquery-ujs/src/rails.js
                                   eventsWithPromises/src/eventsWithPromises.js
                                   rsvp/rsvp.amd.js
                                   requirejs/require.js
                                   modernizer-flexbox-cssclasses.js)
end

