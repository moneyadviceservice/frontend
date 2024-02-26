class CatchallController < ApplicationController
  def not_implemented
    return head :not_found if Rails.env.development?

    interactor.call do |error|
      return redirect_to error.location, status: error.status if error.redirect?
    end

    redirect_to_money_helper_url
  rescue Core::Repository::Base::RequestError => e
    redirect_to_money_helper_url
  end

  private

  def redirect_to_money_helper_url
    redirect_to money_helper_url("/404")
  end

  def money_helper_url(path)
    [ENV.fetch("MONEY_HELPER_URL", "https://www.moneyhelper.org.uk"), path].join("")
  end
  
  def interactor
    Core::RedirectReader.new(path)
  end

  def path
    if params[:format]
      params[:path] + '.' + params[:format]
    else
      params[:path]
    end
  end
end
