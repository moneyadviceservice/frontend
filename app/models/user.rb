class User < ActiveRecord::Base
  devise :registerable,
         :database_authenticatable,
         :encryptable
         # :timeoutable,
         # :confirmable,
         # :invitable,
         # :recoverable,
         # :trackable,
         # :validatable,
         # :crm_authenticatable,
         # :lockable
end

