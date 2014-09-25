module SessionsHelper
  def authentication_sign_in_page_title
    session['authentication_sign_in_page_title'] || I18n.t("authentication.sign_in_page.title")
  end

  def authentication_registration_title
    session['authentication_registration_title'] || I18n.t("authentication.registration.title")
  end
end
