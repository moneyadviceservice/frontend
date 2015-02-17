class HomeController < ApplicationController
  def show
  end

  def display_menu_button_in_header?
    false
  end

  def display_skip_to_main_navigation?
    false
  end

  def contact_panels_homepage?
    true
  end
end
