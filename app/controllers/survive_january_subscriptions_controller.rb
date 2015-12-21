class SurviveJanuarySubscriptionsController < ApplicationController
  def create
    if !categories.include? subscription_params[:category]
      return
    end
    category = subscription_params[:category].to_sym

    @success = Core::SurviveJanuarySubscriptionCreator.new(subscription_params[:email]).call

    if @success
      flash[:success] = I18n.t('newsletter_subscriptions.success')
    else
      flash[:error] = I18n.t('newsletter_subscriptions.error')
    end

    respond_to do |format|
      format.js   { flash.discard and render category }
      format.html { redirect_to :back }
    end
  end

  private

  def categories
    ['footer', 'sticky', 'in_article']
  end

  def subscription_params
    params.require(:subscription).permit(:email, :ga_categoryid, :category)
  end
end
