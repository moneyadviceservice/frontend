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

  validates_with Validators::Email, attributes: [:email]

  before_save :fake_send_confirmation_email


  def fake_send_confirmation_email
    #Temporary fix to trick Devise into thinking an email confirmation is sent to the user so they can sign in desktop site.
    self.confirmation_sent_at = DateTime.now
  end
end

