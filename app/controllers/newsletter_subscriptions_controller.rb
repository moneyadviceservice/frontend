class NewsletterSubscriptionsController < ApplicationController
  #def dismiss
  #  cookies['_cookie_dismiss_newsletter'] = { value: 'hide', expires: 1.month.from_now }
  #  render :nothing => true
  #end

  def create
    if !categories.include? subscription_params[:category]
      return
    end
    category = subscription_params[:category].to_sym

    @success = Core::NewsletterSubscriptionCreator.new(subscription_params[:email]).call

    if @success
      set_cookie
      session[:newsletter_subscribed] = true
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

  def subscription_params
    params.require(:subscription).permit(:email, :ga_categoryid, :category)
  end

  def categories
    ['footer', 'sticky', 'in_article']
  end

  def set_cookie
    cookies.permanent['display_sticky_newsletter_form_cookie'] = 'hide'
  end
end
