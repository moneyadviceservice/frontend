class PagesController < ApplicationController
  def show
    render safe_page
  rescue ActionView::MissingTemplate
    raise ActionController::RoutingError.new("Page: #{safe_page}, does not exist")
  end

  private

  def safe_page
    params[:id].gsub(/[^a-zA-Z0-9]/,'')
  end
end
