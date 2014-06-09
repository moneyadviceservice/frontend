class HomeController < ApplicationController
  layout 'unconstrained'

  decorates_assigned :directory_categories, with: CategoryDecorator

  def show
    if Feature.active?(:dynamic_directory)
      @directory_categories = Core::CategoryTreeReader.new.call
    end
  end

  def display_menu_button_in_header?
    false
  end
end
