require 'core/interactors/category_reader'
require 'core/interactors/category_parents_reader'

class CategoriesController < ApplicationController
  decorates_assigned :category, with: CategoryDecorator
  decorates_assigned :category_hierarchy, with: CategoryDecorator

  def show
    @category = Core::CategoryReader.new(params[:id]).call do
      not_found
    end

    @category_hierarchy = Feature.active?(:breadcrumbs) ? build_category_parents : []
  end

  private

  def build_category_parents
    Core::CategoryParentsReader.new(@category).call
  end
end
