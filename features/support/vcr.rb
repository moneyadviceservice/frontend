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

    elsif uri.host =~ /googleapis.com/
      params = CGI.parse(uri.query)
      params['key'] = ['GOOGLE_API_KEY']
      params['cx'].first.gsub!(/#{ENV['GOOGLE_API_CX_EN']}/, 'GOOGLE_API_CX_EN')
      params['cx'].first.gsub!(/#{ENV['GOOGLE_API_CX_CY']}/, 'GOOGLE_API_CX_CY')

      "/GOOGLE_SEARCH/#{request.method}/#{params.to_query}"

    else
      "/#{uri.host}/#{request.method}#{uri.path}#{uri.query}"
    end

    if VCR.current_cassette && VCR.current_cassette.name == cassette_name
      request.proceed
    else
      VCR.use_cassette(cassette_name, &request)
    end
  end

  c.filter_sensitive_data('<GOOGLE_API_KEY>') { ENV['GOOGLE_API_KEY'] }
  c.filter_sensitive_data('<GOOGLE_API_CX_EN>') { ENV['GOOGLE_API_CX_EN'] }
  c.filter_sensitive_data('<GOOGLE_API_CX_CY>') { ENV['GOOGLE_API_CX_CY'] }
end
