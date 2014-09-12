class CampaignsController < ApplicationController
  decorates_assigned :campaign, with: CampaignPage::CampaignDecorator

  def show
    if template_exists?("/campaigns/#{params[:id].underscore}")
      render template: "/campaigns/#{params[:id].underscore}"
    else
      @campaign = Template.new.build_campaign(params[:id])
      render :show
    end
  end

  def display_menu_button_in_header?
    false
  end
end
