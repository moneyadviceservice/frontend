module SessionsHelper
  def authentication_sign_in_title
    I18n.t(session['authentication_sign_in_title'],
           default: I18n.t('authentication.sign_in_page.title'))
  end

  def authentication_registration_title
    I18n.t(session['authentication_registration_title'],
           default: I18n.t('authentication.registration.title'))
  end
end
