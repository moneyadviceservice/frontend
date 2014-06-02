require 'core/interactors/breadcrumbs_reader'
require 'core/interactors/category_reader'

class CategoriesController < ApplicationController
  decorates_assigned :category, with: CategoryDecorator
  decorates_assigned :breadcrumbs, with: BreadcrumbDecorator

  def show
    @category = Core::CategoryReader.new(params[:id]).call do
      not_found
    end

    @breadcrumbs = Core::BreadcrumbsReader.new(params[:id], category_tree).call do
      Core::CategoryParentsReader.new(@category).call
    end
  end
end
