module SessionsHelper
  def authentication_sign_in_page_title
    session['authentication_sign_in_page_title'] || I18n.t("authentication.sign_in_page.title")
  end
end
