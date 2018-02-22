class HomeController < ApplicationController
  def show
    @resource = resource
  end

  def display_skip_to_main_navigation?
    false
  end

  def contact_panels_homepage?
    true
  end

  def show_floating_chat?
    true
  end

  private

  def resource
    Mas::Cms::HomePage.find(
      'the-money-advice-service',
      locale: params[:locale],
      cached: true
    )
  end
end
