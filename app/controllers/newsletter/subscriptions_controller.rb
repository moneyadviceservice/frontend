require 'core/interactors/newsletter/subscriber'

module Newsletter
  class SubscriptionsController < ApplicationController
    decorates_assigned :subscription, with: SubscriptionDecorator

    def create
      @subscription = Core::Newsletter::Subscriber.new(subscription_params).call

      respond_to do |format|
        format.js { render :show }
        format.html { redirect_to :back, flash: { @subscription.status => subscription.message } }
      end
    end

    private

    def subscription_params
      params.require(:subscription).permit(:email)
    end
  end
end
