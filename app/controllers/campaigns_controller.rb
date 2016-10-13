class CampaignsController < ApplicationController
  decorates_assigned :campaign, with: CampaignPage::CampaignDecorator

  include SuppressMenuButton

  def display_skip_to_main_navigation?
    false
  end

  ::CampaignPage::Campaign::WHITELIST.each do |campaign_page|
    method_name = campaign_page.underscore
    class_eval "def #{method_name}; end"
  end

  def show
    @campaign = Template.new.build_campaign(params[:id])
    render :show
  end
end
