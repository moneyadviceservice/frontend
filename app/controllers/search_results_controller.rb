require 'core/interactors/searcher'

class SearchResultsController < ApplicationController

  def index
    if params[:query].present?
      @search_results = Core::Searcher.new(params[:query]).call
    end
  end
end
