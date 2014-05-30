require 'core/interactors/searcher'

class SearchResultsController < ApplicationController
  decorates_assigned :search_results, with: SearchResultCollectionDecorator

  def index
    if params[:query].present?
      @search_results = Core::Searcher.new(params[:query], page: params[:page]).call

      if @search_results.items.present?
        if Feature.active?(:left_hand_nav)
          render 'search_results/index_with_results_v2'
        else
          render 'search_results/index_with_results'
        end
      else
        if Feature.active?(:left_hand_nav)
          render 'search_results/index_no_results_v2'
        else
          render 'search_results/index_no_results'
        end
      end
    end
  end

  private

  def display_search_box_in_header?
    false
  end
end
