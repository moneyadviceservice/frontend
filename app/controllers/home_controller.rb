class HomeController < ApplicationController
  layout 'unconstrained'

  decorates_assigned :directory_categories, with: CategoryDecorator

  def show
    if Feature.active?(:dynamic_directory)
      @directory_categories = Core::CategoryNavigationReader.new.call
    end
  end
end
