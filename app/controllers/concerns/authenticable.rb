module Authenticable
  class << self
    def required?
      return if development? || qa? || staging?
      Rails.env.production?
    end

    def username
      ENV['AUTH_USERNAME']
    end

    def password
      ENV['AUTH_PASSWORD']
    end

    def development?
      Rails.env.development?
    end

    def qa?
      ENV['MAS_ENVIRONMENT'] == 'qa'
    end

    def staging?
      ENV['MAS_ENVIRONMENT'] == 'staging'
    end

    def authenticate(username, password)
      self.username == username && self.password == password
    end
  end
end
