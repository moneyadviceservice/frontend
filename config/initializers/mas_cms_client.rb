Mas::Cms::Client.config do |c|
  c.timeout =  ENV['FRONTEND_HTTP_REQUEST_TIMEOUT'].to_i
  c.open_timeout =  ENV['FRONTEND_HTTP_REQUEST_TIMEOUT'].to_i
  c.api_token =  ENV['MAS_CMS_API_TOKEN']
  c.host =  ENV['MAS_CMS_URL']
  c.retries = 1
end
