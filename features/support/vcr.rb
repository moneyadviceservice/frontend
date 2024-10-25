require 'vcr'
require 'dotenv/load'

VCR.configure do |c|
  c.cassette_library_dir = 'features/cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com', 'chromedriver.storage.googleapis.com'
  c.ignore_request do |req|
    # Don't mock the call that Poltergeist polls while waiting for
    # Phantomjs to load (http://localhost:<random port>/__identify__)
    req.uri =~ /\/__identify__$|newrelic/
  end

  c.around_http_request do |request|
    uri = URI(request.uri)
    cassette_name = if ENV['MAS_CMS_URL'] =~ /#{uri.host}/
      "/CMS/#{request.method}#{uri.path}#{uri.query}"
    end

    if VCR.current_cassette && VCR.current_cassette.name == cassette_name
      request.proceed
    else
      VCR.use_cassette(cassette_name, &request)
    end
  end

  c.filter_sensitive_data('<Password>') { ENV['CAR_COST_TOOL_CAP_PASSWORD'] }
end
