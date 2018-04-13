module Devise
  module Encryptable
    module Encryptors
      class Aes256 < Base
        class << self
          # Returns a Base64 encrypted password where pepper is used for the key,
          # and the initialization_vector is randomly generated and prepended onto
          # encoded ciphertext
          def digest(password, _stretches, salt, pepper)
            return password if password.blank?

            ::AES.encrypt(password, pepper, iv: salt)
          end
          alias encrypt digest

          # Returns a base64 encoded salt
          def salt(_stretches = 0)
            ::AES.iv(:base_64)
          end

          # Returns the plaintext password where pepper is used for the key,
          # and the initialization_vector is read from the Base64 encoded ciphertext
          def decrypt(encrypted_password, pepper)
            ::AES.decrypt(encrypted_password, pepper)
          end
        end
      end
    end
  end
end
