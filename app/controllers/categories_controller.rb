require 'core/interactors/category_reader'

class CategoriesController < ApplicationController
  decorates_assigned :category, with: CategoryDecorator

  def show
    @category = Core::CategoryReader.new(params[:id]).call do
      not_found
    end
  end
end
