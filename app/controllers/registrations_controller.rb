class RegistrationsController < Devise::RegistrationsController
  private

  def after_sign_up_path_for(resource)
    root_path
  end

  def set_flash_message(key, kind, options = {})
    super

    flash[:success] = flash[:notice]
    flash[:notice] = nil
  end
end
