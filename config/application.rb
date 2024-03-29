require_relative 'boot'

require 'csv'
require 'action_mailer/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_model/railtie'
require 'active_record/railtie'
require 'sprockets/railtie'
require 'rack/rewrite'

require_relative '../lib/core_ext'
require_relative '../lib/tool_mount_point'
require_relative '../lib/engine_mount_point'
require_relative '../lib/landing_page_paths'

Bundler.require(*Rails.groups(assets: %w(development test)))

module Frontend
  class Application < Rails::Application
    config.rails_lts_options = { default: :compatible }

    config.session_store :active_record_store

    config.action_mailer.delivery_method = :mailjet
    config.filter_parameters += [:password]
    config.i18n.load_path    += Dir[Rails.root.join('config', 'locales', '**/*', '*.yml').to_s]

    config.google_tag_manager_id = 'GTM-WVFLH9'

    config.time_zone = 'Europe/London'
    config.chat_opening_hours = OpeningHours.new('8:00 AM', '6:00 PM')
    config.chat_opening_hours.update(:sat, '08:00 AM', '3:00 PM')
    config.chat_opening_hours.closed(:sun)

    config.pensions_opening_hours = OpeningHours.new('9:00 AM', '6:20 PM')
    config.pensions_opening_hours.closed(:sat)
    config.pensions_opening_hours.closed(:sun)

    config.middleware.use 'CaptureRequestId' # capture X-Request-ID header
    config.middleware.use 'OverrideHead' # convert HEAD requests to GET and return an empty body
    config.middleware.use 'RouteProbe' # respond to requests probing for a implemented route
    config.middleware.use 'VersionHeader' # add version of the running app to each response
    config.middleware.insert_after 'ActionDispatch::Static', 'PartnerToolsCookies'

    config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
      instance_eval IO.read(Rails.root.join('lib', 'legacy_maps_redirects.rb'))
      instance_eval IO.read(Rails.root.join('lib', 'legacy_redirects.rb'))
    end

    config.assets.initialize_on_precompile = true

    config.to_prepare do
      Devise::Mailer.layout 'email'
    end

    config.exceptions_app = self.routes

    # Explicitly declare the app root so that Devise 4.6.x correctly handles
    # authentication redirects
    config.relative_url_root = '/'
  end
end
