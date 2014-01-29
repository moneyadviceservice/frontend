require 'active_resource'

class ActiveResource::Base
  class << self
    def find_with_request_id(*arguments)
      request_id = CurrentRequestId.get
      headers['X-Request-Id'] = request_id if request_id
      find_without_request_id(*arguments)
    end

    alias_method_chain :find, :request_id
  end
end