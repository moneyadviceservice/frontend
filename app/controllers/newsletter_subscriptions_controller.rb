class NewsletterSubscriptionsController < ApplicationController
  def create
    @success = Core::NewsletterSubscriptionCreator.new(subscription_params).call
    if @success
      flash[:success] = I18n.t('newsletter_subscriptions.success')
    else
      flash[:error] = I18n.t('newsletter_subscriptions.error')
    end

    respond_to do |format|
      format.js   { flash.discard and render :show }
      format.html { redirect_to :back }
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:email)
  end
end
