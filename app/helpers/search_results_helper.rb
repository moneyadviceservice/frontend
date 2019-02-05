module SearchResultsHelper 
  private

  def display_search_box_in_header?
    false
  end

  def index_zero_page
    params[:page] ? (params[:page].to_i - 1) : 0
  end
end

