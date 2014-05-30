require 'core/interactors/category_reader'
require 'core/interactors/category_parents_reader'

class CategoriesController < ApplicationController
  decorates_assigned :category, with: CategoryDecorator
  decorates_assigned :category_hierarchy, with: CategoryDecorator

  def show
    @category = Core::CategoryReader.new(params[:id]).call do
      not_found
    end

    @category_hierarchy = Core::CategoryParentsReader.new(@category).call

    render Feature.active?(:left_hand_nav) ? :show_v2 : :show
  end
end
