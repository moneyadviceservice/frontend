class PasswordsController < Devise::PasswordsController
  def new
    head :not_implemented
  end
end
