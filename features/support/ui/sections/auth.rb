require_relative '../section'

module UI::Sections
  class Auth < UI::Section
    element :sign_out, "input[value='Sign out']"
  end
end
