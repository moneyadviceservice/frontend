class CampaignsController < ApplicationController
  decorates_assigned :campaign, with: CampaignPage::CampaignDecorator

  def show
    @campaign = Template.new.build_campaign(params[:id])
  end

  def display_menu_button_in_header?
    false
  end
end
