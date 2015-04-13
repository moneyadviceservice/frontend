require_relative 'boot'

require 'action_mailer/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_model/railtie'
require 'active_record/railtie'
require 'sprockets/railtie'

require_relative '../lib/core_ext'
require_relative '../lib/tool_mount_point'
require_relative '../lib/engine_mount_point'

Bundler.require(*Rails.groups(assets: %w(development test)))

module Frontend
  class Application < Rails::Application
    config.session_store :active_record_store

    config.action_mailer.delivery_method = :mailjet
    config.filter_parameters += [:password]
    config.i18n.load_path    += Dir[Rails.root.join('config', 'locales', '**/*', '*.yml').to_s]

    config.crazy_egg_url         = '//dnn506yrbagrg.cloudfront.net/pages/scripts/0018/4438.js'
    config.google_tag_manager_id = 'GTM-WVFLH9'

    config.time_zone = 'Europe/London'
    config.chat_opening_hours = OpeningHours.new('8:00 AM', '8:00 PM')
    config.chat_opening_hours.update(:sat, '09:00 AM', '1:00 PM')
    config.chat_opening_hours.closed(:sun)

    config.middleware.use 'CaptureRequestId' # capture X-Request-ID header
    config.middleware.use 'OverrideHead' # convert HEAD requests to GET and return an empty body
    config.middleware.use 'RouteProbe' # respond to requests probing for a implemented route
    config.middleware.use 'VersionHeader' # add version of the running app to each response

    config.assets.initialize_on_precompile = true

    config.to_prepare do
      Devise::Mailer.layout 'email'
    end
  end
end
