require 'core/interactors/category_reader'
require 'core/interactors/category_parents_reader'

class CategoriesController < ApplicationController
  decorates_assigned :category, with: CategoryDecorator
  decorates_assigned :breadcrumbs, with: CategoryDecorator

  def show
    @category = Core::CategoryReader.new(params[:id]).call do
      not_found
    end

    @breadcrumbs = Core::CategoryParentsReader.new(@category).call
  end
end
