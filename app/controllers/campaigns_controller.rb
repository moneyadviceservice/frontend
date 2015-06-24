class CampaignsController < ApplicationController
  decorates_assigned :campaign, with: CampaignPage::CampaignDecorator

  include SuppressMenuButton

  def show
    if template_exists?("/campaigns/#{params[:id].underscore}")
      render template: "/campaigns/#{params[:id].underscore}", layout: '_unconstrained'
    else
      @campaign = Template.new.build_campaign(params[:id])
      render :show
    end
  end
end
