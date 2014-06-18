require 'core/interactors/newsletter/subscriber'

module Newsletter
  class SubscriptionsController < ApplicationController
    decorates_assigned :subscription, with: SubscriptionDecorator

    def create
      @subscription = Core::Newsletter::Subscriber.new(subscription_params).call

      respond_to do |format|
        format.js { render :show }

        format.html do
          if subscription.success?
            flash[:info] = subscription.success_message
          else
            flash[:error]  = subscription.error_message
          end

          redirect_to :back
        end
      end
    end

    private

    def subscription_params
      params.require(:subscription).permit(:email)
    end
  end
end
