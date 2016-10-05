Rails.application.configure do

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both thread web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like
  # nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Serve static assets
  config.serve_static_assets = true

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.0'

  # Use a unique asset prefix so as not to clash with other backends
  config.assets.prefix = '/a'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and
  # use secure cookies.
  # config.force_ssl = true

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)
  Logger::Syslog.send :include, ActiveRecord::SessionStore::Extension::LoggerSilencer
  config.logger = ActiveSupport::TaggedLogging.new(Logger::Syslog.new("frontend", Syslog::LOG_LOCAL6).tap {|log| log.level = Logger::INFO})

  # Use a different cache store in production.
  config.cache_store = :memory_store, { expires_in: 1.hour }

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  config.action_controller.asset_host = ENV['FRONTEND_ASSET_HOST_URL']

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder
  # are already added.
  # config.assets.precompile += %w( search.js )

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Configure active record session store.
  config.session_store :active_record_store

  config.action_mailer.default_url_options = {:host => "#{'qa.test.' if ENV['MAS_ENVIRONMENT'] == 'qa'}moneyadviceservice.org.uk"}

  # Custom configuration options for feedback settings
  config.feedback_delivery_method = :sendmail
  config.raise_feedback_delivery_errors = true
  config.article_feedback_email   = 'content.feedback@moneyadviceservice.org.uk'
  config.technical_feedback_email = 'bugs@moneyadviceservice.org.uk'
end
