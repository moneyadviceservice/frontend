class CampaignsController < ApplicationController
  def show
    render params[:id]
  rescue ActionView::MissingTemplate
    raise ActionController::RoutingError.new("Page: #{params[:id]}, does not exist")
  end
end
