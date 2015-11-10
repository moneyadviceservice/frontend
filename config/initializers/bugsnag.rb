Bugsnag.configure do |config|
  config.api_key = ENV["RESPONSIVE_BUG_SNAG_KEY"] unless (ENV['MAS_ENVIRONMENT'] == 'qa')
end
