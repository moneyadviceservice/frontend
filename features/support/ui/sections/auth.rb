require_relative '../section'

module UI::Sections
  class Auth < UI::Section
    element :sign_out, "input[value='Sign out']"
    element :money_helper_sign_out, "li.authentication__item.authentication__item--last > a"
  end
end
