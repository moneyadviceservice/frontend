class HomeBetaController < ApplicationController

  def show
    @resource = interactor.call
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

  def interactor
    Core::HomePageReader.new('the-money-advice-service')
  end
end
