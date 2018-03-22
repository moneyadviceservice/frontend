require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'features/cassettes'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
  c.ignore_request do |req|
    # Don't mock the call that Poltergeist polls while waiting for
    # Phantomjs to load (http://localhost:<random port>/__identify__)
    req.uri =~ /\/__identify__$|newrelic/
  end

  c.around_http_request do |request|
    uri = URI(request.uri)
    cassette_name = if ENV['MAS_CMS_URL'] =~ /#{uri.host}/
      "/CMS/#{request.method}#{uri.path}#{uri.query}"
    elsif uri.host =~ /algolia/
      query = JSON.parse(request.body)['params']#.match(/query=([a-zA-Z]*)/)[1]
      "/algolia/#{request.method}#{uri.path}#{uri.query}/#{query}"
    end

    if uri.host =~ /algolia/
      VCR.use_cassette(cassette_name, match_requests_on: [:body], &request)
    elsif VCR.current_cassette && VCR.current_cassette.name == cassette_name
      request.proceed
    else
      VCR.use_cassette(cassette_name, &request)
    end
  end

  c.filter_sensitive_data('<GOOGLE_API_KEY>') { ENV['GOOGLE_API_KEY'] }
  c.filter_sensitive_data('<GOOGLE_API_CX_EN>') { ENV['GOOGLE_API_CX_EN'] }
  c.filter_sensitive_data('<GOOGLE_API_CX_CY>') { ENV['GOOGLE_API_CX_CY'] }
  c.filter_sensitive_data('<API_KEY>') { ENV['ALGOLIA_API_KEY'] }
  c.filter_sensitive_data('<APP_ID>') { ENV['ALGOLIA_APP_ID'] }
end
