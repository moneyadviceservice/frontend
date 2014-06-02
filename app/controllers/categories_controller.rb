require 'core/interactors/category_reader'
require 'core/interactors/category_parents_reader'

class CategoriesController < ApplicationController
  decorates_assigned :category, with: CategoryDecorator
  decorates_assigned :category_hierarchy, with: CategoryDecorator

  include Navigation

  def show
    @category = Core::CategoryReader.new(params[:id]).call do
      not_found
    end

    @category_hierarchy = Core::CategoryParentsReader.new(@category).call

    if Feature.active?(:left_hand_nav)
      render :show_v2
    else
      # (@category.categories.compact.map(&:id) + @category.parent_category_ids).each do |category|
      #   active_category @category
      # end

      render :show
    end
  end
end
