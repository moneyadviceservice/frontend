class CatchallController < ApplicationController
  def not_implemented
    # return render nothing: true if Rails.env.test? && request.host == 'www.moneyhelper.org.uk'

    interactor.call do |error|
      return redirect_to error.location, status: error.status if error.redirect?
    end

    redirect_to_money_helper_url
  rescue Core::Repository::Base::RequestError => e
    redirect_to_money_helper_url
  end

  private

  def integration_test?
    Rails.env.test? && defined?(Cucumber::Rails)
  end

  def observable_redirect_to(url)
    if integration_test?
      render :text => "If this wasn't an integration test, you'd be redirected to: #{url}"
    else
      redirect_to url
    end
  end

  def redirect_to_money_helper_url
    observable_redirect_to money_helper_url("/#{locale}/404")
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
