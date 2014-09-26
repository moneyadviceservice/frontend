module Devise
  class Utils
    def self.purge_custom_messages(session)
      session.delete('authentication_sign_in_page_title')
      session.delete('authentication_registration_title')
    end
  end
end
