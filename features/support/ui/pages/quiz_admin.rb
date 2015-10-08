require_relative '../page'

module UI::Pages
  class QuizAdmin < UI::Page
    set_url '{/locale}/tools/quiz/users/sign_in'

    element :email, "input[name='quiz_user[email]']"
    element :password, "input[name='quiz_user[password]']"
    element :submit, "input[value='Sign in']"
  end
end
