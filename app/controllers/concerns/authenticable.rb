module Authenticable
  class << self
    def required?
      Rails.env.production?
    end

    def username
      ENV['AUTH_USERNAME']
    end

    def password
      ENV['AUTH_PASSWORD']
    end

    def authenticate(username, password)
      self.username == username && self.password == password
    end
  end
end
