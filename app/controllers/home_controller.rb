class HomeController < ApplicationController

  decorates_assigned :directory_categories, with: CategoryDecorator

  def show

  end

  def display_menu_button_in_header?
    false
  end

  def display_skip_to_main_navigation?
    false
  end
end
