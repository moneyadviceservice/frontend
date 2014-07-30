class User < ActiveRecord::Base
  devise :registerable,
         :database_authenticatable
         # :timeoutable,
         # :confirmable,
         # :invitable,
         # :recoverable,
         # :trackable,
         # :validatable,
         # :encryptable,
         # :crm_authenticatable,
         # :lockable
end

